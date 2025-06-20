import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/profile.dart';

class ProfileDataSource {
  Future<Profile> getProfile() async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));
    return Profile(
      id: '1',
      name: 'Alex Johnson',
      email: 'alex@example.com',
      phone: '+1 234 567 890',
    );
  }
}

final profileDataSourceProvider = Provider<ProfileDataSource>((ref) => ProfileDataSource());