import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data_sources/ticket_data_source.dart';
import '../models/ticket.dart';

class TicketRepository {
  final TicketDataSource _dataSource;

  TicketRepository(this._dataSource);

  Future<List<Ticket>> getTickets() async {
    return await _dataSource.getTickets();
  }
}

final ticketRepositoryProvider = Provider<TicketRepository>((ref) {
  return TicketRepository(ref.read(ticketDataSourceProvider));
});