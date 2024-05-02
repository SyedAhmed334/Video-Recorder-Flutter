import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double height;
  const AppLogo({super.key, this.height = 80});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/logos/app_logo.png',
      height: height,
    );
  }
}
