

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data_sources/profile_data_source.dart';
import '../models/profile.dart';

class ProfileRepository {
  final ProfileDataSource _dataSource;

  ProfileRepository(this._dataSource);

  Future<Profile> getProfile() async {
    return await _dataSource.getProfile();
  }
}

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository(ref.read(profileDataSourceProvider));
});