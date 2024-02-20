<?php


namespace App\Models\Reports;


use App\Models\Specific\OrderItem;
use App\Models\Specific\Timetable;
use Box\Spout\Writer\Common\Creator\WriterEntityFactory;
use Illuminate\Support\Facades\Auth;

class SalesListReport
{

    public $date_from;
    public $date_to;
    public $timetable_ids;
    public $event_ids;
    public $data;

    public function __construct($params)
    {
        $this->date_from = isset($params['date_from']) ? $params['date_from'] : null;
        $this->date_to = isset($params['date_to']) ? $params['date_to'] : null;
        $this->timetable_ids = isset($params['timetable_ids']) ? (is_array($params['timetable_ids']) ? $params['timetable_ids'] : [$params['timetable_ids']]) : [];
        $this->event_ids = isset($params['event_ids']) ? (is_array($params['event_ids']) ? $params['event_ids'] : [$params['event_ids']]) : [];
        $this->data = null;
    }

    public function generate() {

        $query = OrderItem::with('section')
            ->whereHas('order',function($q) {
                $q->where('paid', 1);
                if($this->date_from) {
                    $q->where('created_at','>=',$this->date_from.' 00:00:00');
                }
                if($this->date_to) {
                    $q->where('created_at','<=',$this->date_to.' 23:59:59');
                }
            })
            ->with('order.timetable');
//        if($user->role == 'organizator') {
//            $query->whereHas('order.timetable.event',function($qq) use($user) {
//                $qq->whereIn('id',$user->events()->pluck('id')->toArray());
//            });
//        } else {
//            $query->with('order.timetable.event');
//        }

        $query->with('order.timetable.event');
        if(count($this->timetable_ids) > 0) {
            $query->whereIn('timetable_id',$this->timetable_ids);
        }
        if(count($this->event_ids) > 0) {
            $event_timetable_ids = Timetable::whereIn('event_id',$this->event_ids)->pluck('id')->toArray();
            $query->whereIn('timetable_id', $event_timetable_ids);
//            $query->whereIn('event_id',$this->event_ids);
        }
        $query->orderBy('id','desc');
//        if($request->platform != 'all') {
//            $query->whereHas('order',function($q) use($request) {
//                $q->where('platform',$request->platform);
//            });
//        }
        $this->data = $query->get();
    }


    public function toExcel() {

        $filename = 'report_'.date('Y-m-d_H:i:s');

        ini_set("memory_limit", '1000M');
        set_time_limit(200);

        if ($this->data && count($this->data) > 0) {

            $writer = WriterEntityFactory::createXLSXWriter();
            $writer->openToBrowser($filename.'.xlsx');
            $intro_rows = [
                ['Отчет по продажам билетов'],
                ['Время выгрузки',(string)date('Y-m-d H:i:d')],
                ['Кем выгружено', Auth::id().' - '.Auth::user()->name],
                ['Заданные даты',$this->date_from.' - '.$this->date_to],
                ['Выбранные id событий',count($this->event_ids) > 0 ? implode(', ',$this->event_ids) : 'Все'],
                ['Выбранные id сеансов',count($this->timetable_ids) > 0 ? implode(', ',$this->timetable_ids) : 'Все'],
                [
                    'ID билета',
                    'ID заказа',
                    'ID сеанса',
                    'Наименование события',
                    'Дата сеанса',
                    'Сектор',
                    'Ряд',
                    'Место',
                    'Цена',
                    'Штрихкод',
                    'Email',
                    'Контактные данные',
                    'Телефон',
                    'Дата заказа',
                    'Тип продажи',
//                    'Платформа'
                ]
            ];
            foreach($intro_rows as $r) {
                $writer->addRow(WriterEntityFactory::createRowFromArray($r));
            }
            $total = 0;
            foreach($this->data as $d) {
                if($d->order) {
                    $row = [
                        'ID билета'             => $d->id,
                        'ID заказа'             => $d->order_id,
                        'ID сеанса'             => $d->order->timetable_id,
                        'Наименование события'  => $d->order->timetable->event->title,
                        'Дата сеанса'           => $d->order->timetable->datetime,
                        'Сектор'                => $d->section ? $d->section->title : 'Входной',
                        'Ряд'                   => $d->row ? $d->row : '-',
                        'Место'                 => $d->seat ? $d->seat : '-',
                        'Цена'                  => $d->price,
                        'Штрихкод'              => $d->barcode,
                        'Email'                 => $d->order->email,
                        'Контактные данные'     => $d->order->name,
                        'Телефон'               => $d->order->phone,
                        'Дата заказа'           => (string)$d->order->created_at,
                        'Тип продажи'           => $d->order->pay_system,
                    ];
                    $writer->addRow(WriterEntityFactory::createRowFromArray(array_values($row)));
                    $total += $d->price;
                }
            }
            $writer->addRow(WriterEntityFactory::createRowFromArray([]));
            $row = ['Итого', '', '', '', '', '', '', '', $total];
            $writer->addRow(WriterEntityFactory::createRowFromArray($row));
            $writer->close();
            exit;
        } else {
            return back()->withErrors('Продаж не было');
        }
    }
}
