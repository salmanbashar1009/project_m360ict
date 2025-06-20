

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data_sources/contact_data_source.dart';
import '../models/contact.dart';

class ContactRepository {
  final ContactDataSource _dataSource;

  ContactRepository(this._dataSource);

  Future<List<Contact>> getContacts() async {
    return await _dataSource.getContacts();
  }
}

final contactRepositoryProvider = Provider<ContactRepository>((ref) {
  return ContactRepository(ref.read(contactDataSourceProvider));
});