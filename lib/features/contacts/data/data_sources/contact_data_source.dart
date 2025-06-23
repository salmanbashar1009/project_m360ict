import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/contact.dart';

class ContactDataSource {
  Future<List<Contact>> getContacts() async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));
    return [
      Contact(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
          phone: '1234567890',
          address: '123 Main St'),
      Contact(
          id: '2',
          name: 'Jane Smith',
          email: 'jane@example.com',
          phone: '9876543210',
          address: '456 Elm St'),
      Contact(
          id: '3',
          name: 'Mike Johnson',
          email: 'mike@example.com',
          phone: '5555555555',
          address: '789 Oak St'),
      Contact(
          id: '4',
          name: 'Emily Brown',
          email: 'emily@example.com',
          phone: '1112223333',
          address: '321 Pine St'),
      Contact(
          id: '5',
          name: 'David Lee',
          email: 'david@example.com',
          phone: '9998887777',
          address: '654 Maple St'),
      Contact(
          id: '6',
          name: 'Sarah Wilson',
          email: 'sarah@example.com',
          phone: '4443332222',
          address: '987 Cedar St'),
    ];
  }
}

final contactDataSourceProvider =
    Provider<ContactDataSource>((ref) => ContactDataSource());
