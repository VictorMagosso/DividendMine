import 'dart:async';
import 'dart:ui';

import 'package:DividendMine/controller/stock_controller.dart';
import 'package:DividendMine/core/app_colors.dart';
import 'package:DividendMine/core/app_gradients.dart';
import 'package:DividendMine/core/app_texts.dart';
import 'package:DividendMine/utils/format_handler.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SumUp extends StatefulWidget {
  @override
  _SumUpState createState() => _SumUpState();
}

var stockController = StockController();
var formatMoney = MoneyFormatter();
double dividendNextMonth = 0.0;

class _SumUpState extends State<SumUp> {
  @override
  void initState() {
    super.initState();
    fetchSumDividends();
  }

  var formattedValue = '';

  void fetchSumDividends() async {
    var res = await stockController.sumAllDividend();
    setState(() {
      dividendNextMonth = res;
      formattedValue = formatMoney.moneyHandler(dividendNextMonth);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(300),
      ),
      child: Stack(children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.maxFinite,
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.bar_chart, color: AppColors.secondary),
                            Text(
                              'Previsão de dividendos',
                              style: AppTextStyles.sumUpTitle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_right,
                              color: AppColors.positive,
                            ),
                            Text(
                              '$formattedValue',
                              style: TextStyle(
                                  color: AppColors.accent, fontSize: 24),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ]),
    );
  }
}
