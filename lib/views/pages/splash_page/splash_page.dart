import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moviestack/views/index.dart' show Logo; // Import Logo widget

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Add a delay of 3 seconds before checking the login status
    Future.delayed(const Duration(seconds: 3), () async {
      context.go('/popular-now');
    });

    // Display the splash screen with the logo
    return const Scaffold(
      body: Center(
        child: Logo(
          size: 50,
        ), // Show logo for splash screen
      ),
    );
  }
}
