import 'package:flutter/material.dart';
import '../core/core.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.primary,
          image: DecorationImage(
            image: AssetImage(AppImages.logo),
            scale: 4,
          ),
        ),
      ),
    );
  }
}
