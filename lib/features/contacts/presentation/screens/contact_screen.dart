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
        centerTitle: true,
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
                final textTheme = Theme.of(context).textTheme;
                return contactState.when(
                  data: (contacts) => ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      final contact = contacts[index];
                      return Card(
                        color: Colors.grey.shade50,
                        margin: const EdgeInsets.all(8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Row for avatar, title, and more icon
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: const NetworkImage('https://s3.eu-central-1.amazonaws.com/uploads.mangoweb.org/shared-prod/visegradfund.org/uploads/2021/08/placeholder-male.jpg'),
                                    radius: 24.0,
                                  ),
                                  const SizedBox(width: 12.0),
                                   Expanded(
                                    child: Text(
                                      contact.name,
                                      style: textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  const Icon(Icons.more_horiz),
                                ],
                              ),
                              const SizedBox(height: 12.0),
                              // Email
                               Row(
                                children: [
                                  Icon(Icons.email, size: 16.0),
                                  SizedBox(width: 8.0),
                                  Text(contact.email,),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              // Phone
                               Row(
                                children: [
                                  Icon(Icons.phone, size: 16.0),
                                  SizedBox(width: 8.0),
                                  Text(contact.phone ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              // Address
                               Row(
                                children: [
                                  Icon(Icons.location_on, size: 16.0),
                                  SizedBox(width: 8.0),
                                  Text(contact.address),
                                ],
                              ),
                            ],
                          ),
                        ),
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
