import 'package:flutter/material.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('App Top Bar'),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
