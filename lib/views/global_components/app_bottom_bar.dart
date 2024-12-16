import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moviestack/views/index.dart' show AppColors;

class AppBottomBar extends StatefulWidget {
  final int selectedPage;

  AppBottomBar({required this.selectedPage});

  @override
  State<AppBottomBar> createState() => _AppBottomBarState();
}

class _AppBottomBarState extends State<AppBottomBar> {
  final size = 40.0;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            iconSize: size,
            icon: Icon(Icons.home),
            onPressed: () {
              // Navigate to home page
              if (widget.selectedPage != 0) {
                context.go('/popular-now');
              }
            },
            color: widget.selectedPage == 0
                ? AppColors.primary
                : Theme.of(context).primaryColor,
          ),
          IconButton(
            iconSize: size,
            icon: Icon(Icons.search),
            onPressed: () {
              // Navigate to search page
              if (widget.selectedPage != 1) {
                context.go('/search');
              }
            },
            color: widget.selectedPage == 1
                ? AppColors.primary
                : Theme.of(context).primaryColor,
          ),
          IconButton(
            iconSize: size,
            icon: Icon(Icons.person),
            onPressed: () {
              // Navigate to favorites page
              if (widget.selectedPage != 2) {
                context.go('/profile');
              }
            },
            color: widget.selectedPage == 2
                ? AppColors.primary
                : Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
