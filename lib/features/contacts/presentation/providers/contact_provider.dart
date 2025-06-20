import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticketing_app/features/contacts/data/models/contact.dart';
import 'package:ticketing_app/features/contacts/data/repositories/contact_repository.dart';

final contactProvider = StateNotifierProvider<ContactNotifier, AsyncValue<List<Contact>>>((ref) {
  return ContactNotifier(ref.read(contactRepositoryProvider));
});

class ContactNotifier extends StateNotifier<AsyncValue<List<Contact>>> {
  final ContactRepository _repository;
  List<Contact> _allContacts = [];

  ContactNotifier(this._repository) : super(const AsyncValue.loading()) {
    fetchContacts();
  }

  Future<void> fetchContacts() async {
    try {
      state = const AsyncValue.loading();
      _allContacts = await _repository.getContacts();
      state = AsyncValue.data(_allContacts);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  void searchContacts(String query) {
    if (query.isEmpty) {
      state = AsyncValue.data(_allContacts);
    } else {
      final filtered = _allContacts
          .where((contact) => contact.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      state = AsyncValue.data(filtered);
    }
  }
}