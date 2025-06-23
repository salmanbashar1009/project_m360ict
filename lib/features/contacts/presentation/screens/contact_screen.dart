import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/contact_provider.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          surfaceTintColor: Colors.transparent, title: const Text('Contacts')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Consumer(
              builder: (context, ref, _) {
                final searchController = TextEditingController();
                return TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search contacts...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onChanged: (value) {
                    ref.read(contactProvider.notifier).searchContacts(value);
                  },
                );
              },
            ),
          ),
          Expanded(
            child: Consumer(
              builder: (context, ref, _) {
                final contactState = ref.watch(contactProvider);
                return contactState.when(
                  data: (contacts) => ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      final contact = contacts[index];
                      return ListTile(
                        leading: CircleAvatar(child: Text(contact.name[0])),
                        title: Text(contact.name),
                        subtitle: Text(contact.email),
                      );
                    },
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, _) => Center(child: Text('Error: $error')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
