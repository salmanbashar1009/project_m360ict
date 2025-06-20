import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/contact.dart';

class ContactDataSource {
  Future<List<Contact>> getContacts() async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));
    return [
      Contact(id: '1', name: 'John Doe', email: 'john@example.com'),
      Contact(id: '2', name: 'Jane Smith', email: 'jane@example.com'),
      Contact(id: '3', name: 'Mike Johnson', email: 'mike@example.com'),
    ];
  }
}

final contactDataSourceProvider = Provider<ContactDataSource>((ref) => ContactDataSource());
