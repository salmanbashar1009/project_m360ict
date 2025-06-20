import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../data/models/filter.dart';
import '../../data/repositories/filter_repository.dart';

final filterProvider = StateNotifierProvider<FilterNotifier, AsyncValue<List<Filter>>>((ref) {
  return FilterNotifier(ref.read(filterRepositoryProvider));
});

class FilterNotifier extends StateNotifier<AsyncValue<List<Filter>>> {
  final FilterRepository _repository;

  FilterNotifier(this._repository) : super(const AsyncValue.loading()) {
    fetchFilters();
  }

  Future<void> fetchFilters() async {
    try {
      state = const AsyncValue.loading();
      final filters = await _repository.getFilters();
      state = AsyncValue.data(filters);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  void toggleFilter(String id) {
    state.whenData((filters) {
      state = AsyncValue.data(filters
          .map((filter) => filter.id == id ? filter.copyWith(isSelected: !filter.isSelected) : filter)
          .toList());
    });
  }
}