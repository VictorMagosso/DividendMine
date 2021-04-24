import 'dart:async';

import 'package:DividendMine/anim/logo_anim.dart';
import 'package:DividendMine/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../core/core.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3)).then((_) => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        ));

    return Scaffold(
      body: Center(
        child: Container(
          color: Color.fromRGBO(0, 0, 0, 1),
          child: LogoAnimatedWidget(),
        ),
      ),
    );
  }
}
