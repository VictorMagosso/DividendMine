import 'dart:async';

import 'package:DividendMine/pages/home_page.dart';
import 'package:flutter/material.dart';
import '../core/core.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Route createRoute() {
      return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = Offset(10.0, 0.0);
            var end = Offset.zero;
            var tween = Tween(begin: begin, end: end);
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          });
    }

    Timer(
        Duration(seconds: 3), () => Navigator.of(context).push(createRoute()));
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
