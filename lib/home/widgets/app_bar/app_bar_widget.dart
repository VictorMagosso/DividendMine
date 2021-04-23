import 'dart:collection';

import 'package:DividendMine/home/widgets/sum_up/sum_app.dart';

import '../../../core/core.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends PreferredSize {
  AppBarWidget()
      : super(
          preferredSize: Size.fromHeight(210),
          child: Container(
              width: double.maxFinite,
              height: 210,
              child: Stack(children: [
                Container(
                  width: double.maxFinite,
                  height: 140,
                  padding: EdgeInsets.only(top: 40),
                  decoration:
                      BoxDecoration(gradient: AppGradients.appBarLinear),
                  child: Column(
                    children: [
                      Text(
                        "Meus dividendos",
                        style: AppTextStyles.title,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: 100),
                    alignment: Alignment.bottomCenter,
                    child: SumUp(),
                  ),
                )
              ])),
        );
}
