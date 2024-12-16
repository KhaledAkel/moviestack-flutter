import 'package:flutter/material.dart';
import 'package:moviestack/views/index.dart' show AppColors, AppTextStyles;

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'MovieStack',
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
        fontFamily: AppTextStyles.fontFamilyPrimary,
      ),
    );
  }
}
