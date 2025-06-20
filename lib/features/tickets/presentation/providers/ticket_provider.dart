import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/ticket.dart';
import '../../data/repositories/ticket_repository.dart';


final ticketProvider = StateNotifierProvider<TicketNotifier, AsyncValue<List<Ticket>>>((ref) {
  return TicketNotifier(ref.read(ticketRepositoryProvider));
});

class TicketNotifier extends StateNotifier<AsyncValue<List<Ticket>>> {
  final TicketRepository _repository;

  TicketNotifier(this._repository) : super(const AsyncValue.loading()) {
    fetchTickets();
  }

  Future<void> fetchTickets() async {
    try {
      state = const AsyncValue.loading();
      final tickets = await _repository.getTickets();
      state = AsyncValue.data(tickets);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}