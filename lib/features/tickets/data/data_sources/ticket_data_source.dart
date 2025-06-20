
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/ticket.dart';

class TicketDataSource {
  Future<List<Ticket>> getTickets() async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));
    return [
      Ticket(id: '1', title: 'Concert A', date: '2025-07-01', status: 'Confirmed', price: 99.99),
      Ticket(id: '2', title: 'Movie Premiere', date: '2025-07-05', status: 'Pending', price: 15.50),
      Ticket(id: '3', title: 'Sports Event', date: '2025-07-10', status: 'Confirmed', price: 49.99),
    ];
  }
}

final ticketDataSourceProvider = Provider<TicketDataSource>((ref) => TicketDataSource());