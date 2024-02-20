<?php

namespace App\Models\API;

use App\Models\Specific\Category;
use App\Models\Specific\Event;
use App\Models\Specific\Order;
use App\Models\Specific\TicketDesign;
use App\Models\Specific\Timetable;
use App\Models\Types\TicketAPIType;
use App\Models\Types\TimetableType;
use Illuminate\Support\Facades\Log;

class LermontovAPI extends TicketAPIModel implements TicketAPIInterface
{
    private $api = TicketAPIType::LERMONTOV;
    private $venue_id = 1;
    private $url = '89.218.23.234';
    private $port = '5578';
    private $timeout = 15;  //timeout in seconds
    private $service_id = '1';
    private $number_of_tries = 20;


    public function getEvents($date_from = NULL) {
        if (!$date_from) {
            $date_from = date('d.m.Y',time()).'-'.date('d.m.Y',strtotime('+3 months'));
        }
        $data = $this->socket("GetPlaybill&DateList=".$date_from);
        return $data->Posters;
    }


    public function syncEvents($date_from = null) {
        Timetable::where('datetime','>',date('Y-m-d H:i:s'))
            ->whereApi($this->api)
            ->update(['active' => 0]);
        Event::whereApi($this->api)
            ->update(['active' => 0]);
        $first_category = Category::first();
        $first_design = TicketDesign::first();
        $events = $this->getEvents($date_from);
        if(isset($events->Spectacle)) {
            foreach($events->Spectacle as $ev) {
                $id = $ev->ID;
                $title = (string)$ev->Name;
                $datetime = date('Y-m-d H:i:s',strtotime($ev->Date));
                $venue_id = $this->venue_id;
                $scheme_id = $ev->HallId == 3 ? 6 : 1;
                $event = Event::updateOrCreate([
                    'api'               => $this->api,
                    'api_id'            => $id
                ],[
                    'min_price'         => (int)$ev->MinPrice,
                    'max_price'         => (int)$ev->MaxPrice,
                    'title'             => $title,
                    'category_id'       => $first_category->id,
                    'ticket_design_id'  => $first_design->id,
                    'active'            => 1,
                ]);
                $timetable = Timetable::updateOrCreate([
                    'api'               => $this->api,
                    'api_id'            => $id,
                ],[
                    'datetime'          => $datetime,
                    'venue_id'          => $venue_id,
                    'venue_scheme_id'   => $scheme_id,
                    'event_id'          => $event->id,
                    'type'              => TimetableType::SECTIONS,
                    'active'            => 1,
                ]);
            }
        }
    }



    public function getTickets($timetable) {
        $data = $this->socket("SpectacleDetails&SpectacleId=".$timetable->api_id);
        $data = $data->Spectacle;
        $arr = array();
        foreach($data->Sections->Section as $d) {
            $class = new \stdClass();
            $id = (string)$d->ID;
            $total = (array)$d->Tickets->Available;
            $class->section_id = $this->APISectorToOur($id);
            $class->prices = [];
            $class->ticket_type = 'seats';
            $class->cnt = 0;
            $class->seats = [];
            if(isset($total[0])) {
                $class->total = $total[0];
                $seats = [];
                foreach($d->Seats->Place as $seat) {
                    $ticket = new \StdClass();
                    $attr = $seat->attributes();
                    $ticket->row = (int)$attr["Row"];
                    $ticket->seat = (int)$attr['Place'];
                    $ticket->pseudo_id = $class->section_id.'_'.$ticket->row.'_'.$ticket->seat;
//                    $ticket->fragment = 0;
//                    $ticket->type = (string)$attr['Type'];
                    $ticket->price = (int)$attr["Price"];
                    $ticket->status = (int)$attr['Status'];
                    if ($ticket->price > 0 && $ticket->status == 1) {
                        $seats[$ticket->pseudo_id] = $ticket;
                        array_push($class->prices, $ticket->price);
                        $class->cnt++;
                    }
                }
                $class->seats = $seats;
                $class->prices = array_values(array_unique($class->prices));
                sort($class->prices);
                $arr[$class->section_id] = $class;
            }
        }
        return $arr;
    }


    public function createOrder($timetable, $tickets, $order = null) {
        if(!$order) {
            return false;
        }
        $str = '';
        foreach($tickets as $t) {
            $str .= '[s='.$this->ourSectorToAPI($t['section_id']).';r='.$t['row'].';p='.$t['seat'].']';
        }
//        $query = "CreateReservation&EventId=".$event_id."&OrderId=".$orderId."&Places=".$str;
        $query = "OrderReservation&SpectacleId=".$timetable->api_id."&OrderId=".$order->id."&Places=".$str;
        $data = $this->socket($query);
        Log::error('Lermontov order id '.$order->id.' creation response');
        Log::error(http_build_query($data));
        if(!$data || !$data->CostSum || $data->CostSum != $order->price) {
            $order->delete();
            return false;
        }
        return true;
    }


    public function confirmOrder(Order $order) {
        $items = $order->orderItems;
        if (count($items) < 1) {
            return false;
        }
        $first = $items[0];
        if($first->barcode) {
            return true;
        }
//            $query = "ConfirmSale&OrderId=".$first->order_id;
        $query = "OrderPayment&OrderId=".$order->id;
        $data = $this->socket($query);
        Log::error('lermontov_confirm_response');
        Log::error(http_build_query($data));
        $count = 0;
        if (!isset($data->Result) || $data->Result != 'Ok') {
            return false;
//                new MailNotification(['Lermontov order payment failed: order number: '.$first->order_id]);
        }
        if(!isset($data->Tickets->Place) || count($data->Tickets->Place) < 1) {
            return false;
        }
        foreach($data->Tickets->Place as $place) {
//                Log::error('barcode');
//                Log::error($place->attributes()["Code"]);
//                try {
//                    Log::error('barcode again');
//                    Log::error((string)$place["Code"]);
//                } catch(\Exception  $e) {
//
//                }
            $barcode = $place->attributes()["Code"];
            if(!$barcode) {
                return false;
            }
            $items[$count]->update(['barcode' => $barcode]);
            $count++;
        }
        return true;
    }


    public function cancelOrder($id) {
//        $query = "DeleteOrder&OrderId=".$orderId;
        $query = "Cancellations&OrderId=".$id;
        $data = $this->socket($query);
        Log::error('Lermontov cancel order id '.$id.' response');
        Log::error(http_build_query($data));
        return $data->Result;
    }


    public function socket($query, $i = 0) {

        if( $curl = curl_init() ) {
            curl_setopt($curl, CURLOPT_URL, 'http://78.40.108.10/test/'.$query);
            curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($curl, CURLOPT_MAXREDIRS, 10);
            curl_setopt($curl, CURLOPT_AUTOREFERER, true);
            curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, FALSE);
            curl_setopt($curl, CURLOPT_FOLLOWLOCATION, TRUE);
            curl_setopt($curl, CURLOPT_HEADER, false);
            curl_setopt($curl, CURLINFO_HEADER_OUT, true);
            $out = curl_exec($curl);
            $xml = simplexml_load_string($out);
            curl_close($curl);
            return $xml;
        }

        if(!($sock = socket_create(AF_INET, SOCK_STREAM, 0)))
        {
            $errorcode = socket_last_error();
            $errormsg = socket_strerror($errorcode);

            die("Couldn't create socket: [$errorcode] $errormsg \n");
        }

        socket_set_block($sock) or die("Unable to set nonblock on socket\n");
        socket_clear_error($sock);
        if(!@socket_connect($sock , self::$url , self::$port))
        {
            $errorcode = socket_last_error();
            $errormsg = socket_strerror($errorcode);
            if ($errorcode == 111 || $errorcode == 110) {
                if($i < self::$number_of_tries) {
                    sleep(2);
                    socket_close($sock);
                    $i++;
                    return self::socket($query, $i);
                }
                if($i >= self::$number_of_tries) {
//                    new MailNotification(['Lermontov socket query failed: query: '.$query]);
                }

            }
            die("Could not connect: [$errorcode] $errormsg \n");
        }


        $service_id = self::$service_id;
        $params = "&Token=".$service_id."&Encoding=Windows-1251&QueryName=".$query;
        $params = self::makeLength($params);
        $message = $params;

        if( ! socket_send ( $sock , $message , strlen($message) , 0))
        {
            $errorcode = socket_last_error();
            $errormsg = socket_strerror($errorcode);

            die("Could not send data: [$errorcode] $errormsg \n");
        }

        if(socket_recv ( $sock , $buf , 10000000 , MSG_WAITALL ) === FALSE)
        {
            $errorcode = socket_last_error();
            $errormsg = socket_strerror($errorcode);

            die("Could not receive data: [$errorcode] $errormsg \n");
        }

        $xml = simplexml_load_string($buf,'SimpleXMLElement', LIBXML_NOCDATA);
        socket_close($sock);
        return $xml;
    }


    public static function makeLength($params) {
        $len = strlen($params);
        $sym_len = strlen((string)$len);
        $default = '0000000000';
        $default = substr($default, 0, -$sym_len) . $len;
        return  $default. $params;
    }


    public function ourSectorToAPI($our_id) {
        return array_search($our_id, $this->ourSectorsToAPI());
    }


    public function APISectorToOur($sector_id) {
        $arr = $this->ourSectorsToAPI();
        return $arr[$sector_id];
    }


    public function ourSectorsToAPI() {
        return [
            1 => 29, // партер
            2 => 30, // амфитеатр
            4 => 33, // малый зал А
            5 => 35, // малый зал Б
            6 => 36, // малый зал C
            7 => 34, // малый зал D
        ];
    }
}
