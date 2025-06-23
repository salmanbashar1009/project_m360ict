import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/ticket.dart';
import '../../data/repositories/ticket_repository.dart';
import 'filter_provider.dart';

final ticketProvider = StateNotifierProvider<TicketNotifier, AsyncValue<List<Ticket>>>((ref) {
  return TicketNotifier(ref.read(ticketRepositoryProvider), ref);
});

class TicketNotifier extends StateNotifier<AsyncValue<List<Ticket>>> {
  final TicketRepository _repository;
  final Ref _ref;
  bool _showNoMatchSnackbar = false;
  int _filteredTicketCount = 0; // Track number of filtered tickets

  TicketNotifier(this._repository, this._ref) : super(const AsyncValue.loading()) {
    fetchTickets();
  }

  bool get showNoMatchSnackbar => _showNoMatchSnackbar;
  int get filteredTicketCount => _filteredTicketCount;

  Future<void> fetchTickets() async {
    try {
      state = const AsyncValue.loading();
      _showNoMatchSnackbar = false; // Reset snackbar flag
      _filteredTicketCount = 0; // Reset filtered count

      final tickets = await _repository.getTickets();
      final filterState = _ref.read(filterProvider);

      // Apply filters
      List<Ticket> filteredTickets = tickets;

      // Filter by status
      if (filterState.selectedStatuses.isNotEmpty) {
        filteredTickets = filteredTickets
            .where((ticket) => filterState.selectedStatuses.contains(ticket.status))
            .toList();
      }

      // Filter by priority
      if (filterState.selectedPriority != null) {
        filteredTickets = filteredTickets
            .where((ticket) => ticket.priority == filterState.selectedPriority)
            .toList();
      }

      // Check if filtered list is empty and filters applied
      final hasFilters = filterState.selectedStatuses.isNotEmpty || filterState.selectedPriority != null;
      if (hasFilters && filteredTickets.isEmpty) {
        _showNoMatchSnackbar = true;
        _filteredTicketCount = 0;
        state = AsyncValue.data(tickets); // Show all tickets
      } else {
        _showNoMatchSnackbar = false;
        _filteredTicketCount = filteredTickets.length;
        state = AsyncValue.data(filteredTickets); // Show filtered tickets
      }
    } catch (e) {
      _showNoMatchSnackbar = false;
      _filteredTicketCount = 0;
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}