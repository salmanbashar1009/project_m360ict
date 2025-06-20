import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/tickets/presentation/screens/filter_screen.dart';
import '../features/tickets/presentation/screens/ticket_screen.dart';


final routerProvider = Provider<GoRouter>((ref) => GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const TicketScreen(),
    ),
    GoRoute(
      path: '/filter',
      builder: (context, state) => const FilterScreen(),
    ),
    // GoRoute(
    //   path: '/contacts',
    //   builder: (context, state) => const ContactScreen(),
    // ),
    // GoRoute(
    //   path: '/profile',
    //   builder: (context, state) => const ProfileScreen(),
    // ),
  ],
));