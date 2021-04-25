import 'dart:async';

import 'package:DividendMine/controller/stock_controller.dart';
import 'package:DividendMine/home/widgets/app_bar/app_bar_widget.dart';
import 'package:DividendMine/home/widgets/stock_cards/stock_cards.dart';
import 'package:DividendMine/pages/add_stock_page.dart';
import 'package:DividendMine/utils/format_handler.dart';
import '../core/core.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isPressed = false;
  bool _isVisible = false;
  String _labelFab = 'Adicionar';
  Color _fabBgColor = AppColors.secondary;
  Icon _icon = Icon(Icons.add);
  var stockController = StockController();
  var dividends = [];
  var formatHandler = MoneyFormatter();

  @override
  void initState() {
    _dividendsByInterval();
    super.initState();
    stockController.dividendByInterval.addListener(() {
      setState(() {});
    });
  }

  Future<void> _dividendsByInterval() async {
    dividends = await stockController.sumAllDividendByMonth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    stockController.dividendByInterval.value.isNotEmpty
                        ? '1 a 9\n${formatHandler.moneyHandler(stockController.dividendByInterval.value[0]['begin'])}'
                            .toString()
                        : '0,00',
                    style: AppTextStyles.monthText,
                  ),
                  Text(
                    stockController.dividendByInterval.value.isNotEmpty
                        ? '10 a 18\n${formatHandler.moneyHandler(stockController.dividendByInterval.value[0]['firstQuarter'])}'
                            .toString()
                        : '0,00',
                    style: AppTextStyles.monthText,
                  ),
                  Text(
                    stockController.dividendByInterval.value.isNotEmpty
                        ? '19 a 25\n${formatHandler.moneyHandler(stockController.dividendByInterval.value[0]['lastQuarter'])}'
                            .toString()
                        : '0,00',
                    style: AppTextStyles.monthText,
                  ),
                  Text(
                    stockController.dividendByInterval.value.isNotEmpty
                        ? '26 a 31\n${formatHandler.moneyHandler(stockController.dividendByInterval.value[0]['end'])}'
                            .toString()
                        : '0,00',
                    style: AppTextStyles.monthText,
                  ),
                ],
              ),
            ),
            StockCardWidget(),
          ],
        ),
        backgroundColor: AppColors.primaryLight,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            openAddStockPage(context);
          },
          label: Text(_labelFab),
          icon: _icon,
          backgroundColor: _fabBgColor,
        ));
  }

  void openAddStockPage(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (c, a1, a2) => AddStockPage(),
        transitionsBuilder: (c, anim, a2, child) => SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(anim),
          child: child,
        ),
        transitionDuration: Duration(milliseconds: 300),
      ),
    );
  }
}
