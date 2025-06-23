import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/profile_providers.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider);
    return Scaffold(
      appBar: AppBar(
          surfaceTintColor: Colors.transparent, title: const Text('Profile')),
      body: profileState.when(
        data: (profile) => Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                child:
                    Text(profile.name[0], style: const TextStyle(fontSize: 40)),
              ),
              const SizedBox(height: 16),
              Text(profile.name,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(profile.email,
                  style: const TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(height: 24),
              ListTile(
                leading: const Icon(Icons.email),
                title: const Text('Email'),
                subtitle: Text(profile.email),
              ),
              ListTile(
                leading: const Icon(Icons.phone),
                title: const Text('Phone'),
                subtitle: Text(profile.phone ?? 'Not provided'),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
