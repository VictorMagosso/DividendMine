import 'package:DividendMine/home/home_page.dart';
import 'package:DividendMine/splash/splash_page.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "DividendMine",
        home: HomePage(),
        debugShowCheckedModeBanner: false);
  }
}
