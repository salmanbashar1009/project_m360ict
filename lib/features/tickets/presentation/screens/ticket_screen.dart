import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_m360ict/features/tickets/presentation/screens/widgets/priority_button.dart';
import '../providers/ticket_provider.dart';

class TicketScreen extends ConsumerWidget {
  const TicketScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticketState = ref.watch(ticketProvider);
    final ticketNotifier = ref.watch(ticketProvider.notifier);
    final textTheme = Theme.of(context).textTheme.bodyMedium;

    ticketState.when(
      data: (_) {
        if (ticketNotifier.showNoMatchSnackbar && ticketNotifier.filteredTicketCount == 0) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('No match'), duration: Duration(seconds: 2)),
              );
          });
        }
      },
      loading: () {},
      error: (_, __) {},
    );

    debugPrint('============= TicketScreen built =============');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tickets'),
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => context.push('/filter'),
          ),
        ],
      ),
      body: ticketState.when(
        data: (tickets) => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: tickets.length,
          itemBuilder: (context, index) => TicketCard(ticket: tickets[index], textStyle: textTheme!),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: 0,
        onTap: (index) {
          const paths = ['/tickets', '/contacts', '/profile'];
          if (index < paths.length) context.push(paths[index]);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.confirmation_number), label: 'Tickets'),
          BottomNavigationBarItem(icon: Icon(Icons.contacts), label: 'Contacts'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class TicketCard extends StatelessWidget {
  final dynamic ticket;
  final TextStyle textStyle;

  const TicketCard({super.key, required this.ticket, required this.textStyle});

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'new':
        return Colors.blue;
      case 'first response overdue':
        return Colors.amber;
      case 'customer responded':
        return Colors.purple;
      default:
        return Colors.black87;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = getStatusColor(ticket.status);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: Colors.grey.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withAlpha(50),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              ticket.status,
              style: textStyle.copyWith(color: statusColor),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "id: ${ticket.id}",
            style: textStyle.copyWith(color: Colors.grey, fontWeight: FontWeight.w500),
          ),
          Text(
            ticket.title,
            style: textStyle.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${ticket.name} • ${ticket.date}'),
              Text('\$${ticket.price.toStringAsFixed(2)}'),
            ],
          ),
          const Divider(),
          PriorityButtons(priorityText: ticket.priority),
        ]),
      ),
    );
  }
}