<?php

namespace App\Models\PDF;

//use App\Models\Order;
//use App\Models\OrderItem;
//use Dompdf\Dompdf;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;
use Illuminate\Support\Facades\Auth;
//use Barryvdh\Snappy\Facades\SnappyPdf as PDF;
//use Barryvdh\DomPDF\Facade as PDF;
use Barryvdh\DomPDF\Facade\Pdf;

class PDFTicket {

    public $pdf;

    public function stream() {
        return $this->pdf->stream();
    }

    public function __construct($order, $save = false) {
        $tickets = $order->orderItems;
        $timetable = $order->timetable;
        $event = $timetable->event;
        $design = $event->ticketDesign;
        $venue = $timetable->venue;
        $user = Auth::user();

        $pdf = Pdf::loadView('pdfs.ticket', compact('tickets','order', 'user', 'event', 'timetable', 'design', 'venue'))
            ->setOption('margin-bottom', '0mm')
            ->setOption('margin-top', '0mm')
            ->setOption('margin-right', '0mm')
            ->setOption('margin-left', '0mm')
            ->setPaper('a4')
            ->setOption('isHtml5ParserEnabled', true)
            ->setOption('isRemoteEnabled', true)
            ->setOption('defaultFont', 'Arial')
            ->setOption('dpi', 96)
            ->setOption('fontHeightRatio', 1.3)
            ->setOption('isFontSubsettingEnabled', true)
            ->setOption('debugKeepTemp', true)
            ->setOption('isPhpEnabled', true)
            ->setOption('isHtml5ParserEnabled', true)
            ->setOption('isJavascriptEnabled', true);
        
        $this->pdf = $pdf;
    }

    public function getPdf()
    {
        return $this->pdf;
    }

}
