import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_m360ict/core/theme/app_text_theme.dart';

import 'core/router.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Ticketing App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme:  AppBarTheme(
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          elevation: 1,
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
        ),
        textTheme: AppTextTheme.textTheme
      ),
      routerConfig: router,
    );
  }
}