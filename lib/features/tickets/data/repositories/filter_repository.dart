import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data_sources/filter_data_source.dart';
import '../models/filter.dart';

class FilterRepository {
  final FilterDataSource _dataSource;

  FilterRepository(this._dataSource);

  Future<List<Filter>> getFilters() async {
    return await _dataSource.getFilters();
  }
}

final filterRepositoryProvider = Provider<FilterRepository>((ref) {
  return FilterRepository(ref.read(filterDataSourceProvider));
});