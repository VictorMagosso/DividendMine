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
    return Expanded(
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            margin: EdgeInsets.only(left: 24, right: 24, bottom: 34),
            decoration: BoxDecoration(
              color: AppColors.bgOpacity.withOpacity(0.4),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: AppColors.card1, width: 1),
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
                              child: Text(
                                'Previsão para o próximo mês',
                                style: AppTextStyles.sumUpTitle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: Text(
                                '$formattedValue',
                                style: TextStyle(
                                    color: AppColors.accent, fontSize: 24),
                                textAlign: TextAlign.center,
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
          ),
        ),
      ),
    );
  }
}
