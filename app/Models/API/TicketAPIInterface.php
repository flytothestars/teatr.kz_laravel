<?php


namespace App\Models\API;

use App\Models\Specific\Order;

interface TicketAPIInterface {

    public function getEvents($date_from = null);

    public function syncEvents($date_from = null);

    public function getTickets($timetable_id);

    public function createOrder($timetable, $tickets, $order = null);

    public function confirmOrder(Order $order);

    public function cancelOrder($id);
}