import 'package:flutter/material.dart';
import 'package:moviestack/views/index.dart' show AppColors, AppTextStyles;

class Logo extends StatelessWidget {
  final double size;
  const Logo({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Text(
      'MovieStack',
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
        fontFamily: AppTextStyles.fontFamilyPrimary,
      ),
    );
  }
}
