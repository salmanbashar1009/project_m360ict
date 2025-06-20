import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/filter.dart';

class FilterDataSource {
  Future<List<Filter>> getFilters() async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));
    return [
      Filter(id: '1', name: 'Confirmed', isSelected: false),
      Filter(id: '2', name: 'Pending', isSelected: false),
      Filter(id: '3', name: 'Cancelled', isSelected: false),
      Filter(id: '4', name: 'VIP', isSelected: false),
    ];
  }
}

final filterDataSourceProvider = Provider<FilterDataSource>((ref) => FilterDataSource());