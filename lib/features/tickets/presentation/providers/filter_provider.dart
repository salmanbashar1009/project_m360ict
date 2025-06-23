import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterState {
  final List<String> selectedStatuses;
  final String? selectedPriority;

  FilterState({
    required this.selectedStatuses,
    this.selectedPriority,
  });

  FilterState copyWith({
    List<String>? selectedStatuses,
    String? selectedPriority,
  }) {
    return FilterState(
      selectedStatuses: selectedStatuses ?? this.selectedStatuses,
      selectedPriority: selectedPriority ?? this.selectedPriority,
    );
  }
}

class FilterNotifier extends StateNotifier<FilterState> {
  FilterNotifier() : super(FilterState(selectedStatuses: []));

  void toggleStatus(String status) {
    final updatedStatuses = [...state.selectedStatuses];
    if (updatedStatuses.contains(status)) {
      updatedStatuses.remove(status);
    } else {
      updatedStatuses.add(status);
    }
    state = state.copyWith(selectedStatuses: updatedStatuses);
  }

  void setPriority(String? priority) {
    state = state.copyWith(selectedPriority: priority);
  }

  void clearFilters() {
    state = FilterState(selectedStatuses: []);
  }
}

final filterProvider = StateNotifierProvider<FilterNotifier, FilterState>((ref) {
  return FilterNotifier();
});