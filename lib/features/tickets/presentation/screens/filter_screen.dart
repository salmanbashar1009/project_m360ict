import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/filter_provider.dart';
import '../providers/ticket_provider.dart';

class FilterScreen extends ConsumerWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterState = ref.watch(filterProvider);
    final filterNotifier = ref.read(filterProvider.notifier);

    @override
    // List of statuses
    final List<String> statuses = [
      'New',
      'First response overdue',
      'Customer responded',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter Tickets'),
        surfaceTintColor: Colors.transparent,
        actions: [
          TextButton(
            onPressed: () {
              // Clear all filters
              filterNotifier.clearFilters();
            },
            child: const Text('Clear', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status section
            const Text('Status', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...statuses.map((status) => CheckboxListTile(
              title: Text(status),
              value: filterState.selectedStatuses.contains(status),
              onChanged: (bool? value) {
                filterNotifier.toggleStatus(status);
              },
            )),
            const SizedBox(height: 16),
            // Priority section
            const Text('Priority', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            DropdownButton<String>(
              value: filterState.selectedPriority,
              hint: const Text('Select Priority'),
              isExpanded: true,
              items: const [
                DropdownMenuItem(value: null, child: Text('All')),
                DropdownMenuItem(value: 'Low', child: Text('Low')),
                DropdownMenuItem(value: 'Medium', child: Text('Medium')),
                DropdownMenuItem(value: 'Urgent', child: Text('Urgent')),
              ],
              onChanged: (String? value) {
                filterNotifier.setPriority(value);
              },
            ),
            SizedBox(height: 32,),
            // Apply button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Apply filter and navigate back
                  ref.read(ticketProvider.notifier).fetchTickets();
                  context.go('/');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green
                ),
                child: const Text('Apply Filter',style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}