import 'package:flutter/material.dart';
import 'package:moviestack/views/index.dart' show AppTheme, SplashPage, router;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'MovieStack',
      home: const SplashPage(),
      theme: AppTheme.lightTheme,
    );
  }
}
