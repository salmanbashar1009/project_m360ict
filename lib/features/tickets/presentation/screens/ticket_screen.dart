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

    Color _getStatusColor(String status) {
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

    debugPrint('============= TicketScreen built =============');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tickets'),
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
          itemBuilder: (context, index) {
            final ticket = tickets[index];

            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              color: Colors.white70,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title section
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                      decoration: BoxDecoration(
                        color: _getStatusColor(ticket.status).withAlpha(20),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(ticket.status,style: TextStyle(color: _getStatusColor(ticket.status))),
                    ),
                    const SizedBox(height: 8),
                    Text("id: ${ticket.id}",style: const  TextStyle(fontSize: 14,color: Colors.grey,fontWeight: FontWeight.w500,)),
                    Text(ticket.title,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    // Subtitle and trailing section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${ticket.name} • ${ticket.date}'),
                        Text('\$${ticket.price.toStringAsFixed(2)}'),
                      ],
                    ),
                    Divider(),
                    PriorityButtons(priorityText: ticket.priority),
                  ],
                ),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) context.push('/contacts');
          if (index == 2) context.push('/profile');
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