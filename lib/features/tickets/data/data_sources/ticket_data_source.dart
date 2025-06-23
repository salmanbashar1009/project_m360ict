import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/ticket.dart';

class TicketDataSource {
  Future<List<Ticket>> getTickets() async {
    /// API simulation with a 1-second delay
    await Future.delayed(const Duration(seconds: 1));
    return [
      Ticket(
          id: '#01',
          title: 'Concert A',
          date: '2025-07-01',
          status: 'New',
          priority: "Low",
          name: "Tahmin",
          price: 99.99),
      Ticket(
          id: '#03',
          title: 'Sports Event',
          date: '2025-07-10',
          status: 'Customer responded',
          priority: 'Medium',
          name: 'Bashar',
          price: 49.99),
      Ticket(
          id: '#02',
          title: 'Movie Premiere',
          date: '2025-07-05',
          status: 'First response overdue',
          priority: "Urgent",
          name: "Habib",
          price: 15.50),
      Ticket(
          id: '#03',
          title: 'Sports Event',
          date: '2025-07-10',
          status: 'Customer responded',
          priority: 'Low',
          name: 'Bashar',
          price: 49.99),
      Ticket(
          id: '#01',
          title: 'Concert A',
          date: '2025-07-01',
          status: 'New',
          priority: "Urgent",
          name: "Tahmin",
          price: 99.99),
      Ticket(
          id: '#01',
          title: 'Concert A',
          date: '2025-07-01',
          status: 'New',
          priority: "Medium",
          name: "Tahmin",
          price: 99.99),
      Ticket(
          id: '#03',
          title: 'Sports Event',
          date: '2025-07-10',
          status: 'Customer responded',
          priority: 'urgent',
          name: 'Bashar',
          price: 49.99),
      Ticket(
          id: '#02',
          title: 'Movie Premiere',
          date: '2025-07-05',
          status: 'First response overdue',
          priority: "Medium",
          name: "Habib",
          price: 15.50),
      Ticket(
          id: '#03',
          title: 'Sports Event',
          date: '2025-07-10',
          status: 'Customer responded',
          priority: 'Low',
          name: 'Bashar',
          price: 49.99),
      Ticket(
          id: '#01',
          title: 'Concert A',
          date: '2025-07-01',
          status: 'New',
          priority: "Medium",
          name: "Tahmin",
          price: 99.99),
      Ticket(
          id: '#01',
          title: 'Concert A',
          date: '2025-07-01',
          status: 'New',
          priority: "Urgent",
          name: "Tahmin",
          price: 99.99),
      Ticket(
          id: '#03',
          title: 'Sports Event',
          date: '2025-07-10',
          status: 'Customer responded',
          priority: 'Low',
          name: 'Bashar',
          price: 49.99),
      Ticket(
          id: '#02',
          title: 'Movie Premiere',
          date: '2025-07-05',
          status: 'First response overdue',
          priority: "Medium",
          name: "Habib",
          price: 15.50),
      Ticket(
          id: '#03',
          title: 'Sports Event',
          date: '2025-07-10',
          status: 'Customer responded',
          priority: 'Low',
          name: 'Bashar',
          price: 49.99),
      Ticket(
          id: '#01',
          title: 'Concert A',
          date: '2025-07-01',
          status: 'New',
          priority: "Low",
          name: "Tahmin",
          price: 99.99),
    ];
  }
}

final ticketDataSourceProvider =
    Provider<TicketDataSource>((ref) => TicketDataSource());
