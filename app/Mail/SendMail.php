<?php

namespace App\Mail;

use App\Models\Specific\Order;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class SendMail extends Mailable
{
    use Queueable, SerializesModels;

    public $order;
    public $pdf;
    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct(Order $order, $pdf)
    {
        $this->order = $order;
        $this->pdf = $pdf;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        $timetable = $this->order->timetable;
        $venue = $timetable->venue;
        $event = $timetable->event;
        return $this->subject('Your ticket')->view('emails.tickets')
            ->with([
                'name' => $this->order->name,
                'venue' => $venue,
                'title' => $event->title,
                'date' => date('d.m.Y', strtotime($timetable->datetime)) . ' в ' . date('H:i', strtotime($timetable->datetime))
            ])
            ->attachData($this->pdf->output(), 'ticket.pdf');
    }
}
