import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/profile_providers.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider);

    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
      ),
      body: profileState.when(
        data: (profile) => ListView(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.blue.shade50,
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://s3.eu-central-1.amazonaws.com/uploads.mangoweb.org/shared-prod/visegradfund.org/uploads/2021/08/placeholder-male.jpg'),
                    radius: 30.0,
                  ),
                  const SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile.name,
                        style: textTheme.bodyLarge!
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      const Text('Support'),
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.edit),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24.0),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Basic info',
                      style: textTheme.bodyLarge!
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8.0),
                  ListTile(
                    title: const Text('First Name'),
                    subtitle: Text(profile.name.split(' ')[0]),
                  ),
                  ListTile(
                    title: const Text('Last Name'),
                    subtitle: Text(profile.name.split(' ').length > 1
                        ? profile.name.split(' ')[1]
                        : ''),
                  ),
                  ListTile(
                    title: const Text('Email'),
                    subtitle: Text(profile.email),
                  ),
                  if (profile.phone != null)
                    ListTile(
                      title: const Text('Phone'),
                      subtitle: Text(profile.phone!),
                    ),
                  const SizedBox(height: 24.0),
                  Text('Assigned roles (1)',
                      style: textTheme.bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8.0),
                  Card(
                    margin: EdgeInsets.zero,
                    color: Colors.grey.shade50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.person_outline_rounded),
                          const SizedBox(width: 16.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Salman Bashar',
                                style: textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87.withAlpha(450)),
                              ),
                              const Text('Team Leader'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink[100],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: const Text('Logout',
                          style: TextStyle(color: Colors.red)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
