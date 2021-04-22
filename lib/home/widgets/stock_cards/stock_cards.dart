import 'dart:math';

import 'package:DividendMine/controller/stock_controller.dart';
import 'package:DividendMine/core/core.dart';
import 'package:DividendMine/model/stock.dart';
import 'package:DividendMine/utils/format_handler.dart';
import 'package:flutter/material.dart';

class StockCardWidget extends StatefulWidget {
  @override
  _StockCardWidgetState createState() => _StockCardWidgetState();
}

List<Color> colors = [
  AppColors.card1,
  AppColors.card2,
  AppColors.card3,
];

Icon icon = Icon(Icons.apartment);

var moneyFormatter = MoneyFormatter();

class _StockCardWidgetState extends State<StockCardWidget> {
  final stockController = StockController();
  List<Stock> allStocks = [];

  @override
  void initState() {
    super.initState();
    fetchStocks();
  }

  void fetchStocks() async {
    var res = await stockController.getAllStocks();
    setState(() {
      allStocks = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return allStocks.length != 0
        ? Expanded(
            child: RefreshIndicator(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 14),
                itemCount: allStocks.length,
                itemBuilder: (context, index) {
                  return _allStocks(context, index);
                },
              ),
              onRefresh: _getStocks,
            ),
          )
        : Center(
            child: Padding(
            padding: const EdgeInsets.only(top: 80),
            child: CircularProgressIndicator(),
          ));
  }

  _allStocks(BuildContext context, int index) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Container(
          width: double.maxFinite,
          height: 145,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        width: 0.2,
                        color: colors.elementAt(Random().nextInt(3))),
                    gradient: AppGradients.linear),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      direction: Axis.horizontal,
                      children: [
                        Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                allStocks[index].stockCode[
                                            allStocks[index].stockCode.length -
                                                1] ==
                                        '1'
                                    ? Icon(
                                        Icons.apartment_sharp,
                                        color: AppColors.secondary,
                                      )
                                    : Icon(
                                        Icons.work_outline,
                                        color: AppColors.secondary,
                                      ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(allStocks[index].stockCode,
                                      style: TextStyle(
                                          color: colors
                                              .elementAt(Random().nextInt(3)),
                                          fontSize: 24)),
                                ),
                              ],
                            ),
                            Text(
                              'Qtde.: ${allStocks[index].quantity}',
                              style: AppTextStyles.cardText,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Wrap(
                        direction: Axis.horizontal,
                        spacing: 165,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Cada cota:",
                                      style: AppTextStyles.cardText,
                                    ),
                                    Text(
                                      '${moneyFormatter.moneyHandler(allStocks[index].valuePerStock)}',
                                      style: AppTextStyles.cardText,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "Total de dividendos",
                                      style: AppTextStyles.cardText,
                                    ),
                                    Text(
                                      '${moneyFormatter.moneyHandler((allStocks[index].quantity * allStocks[index].valuePerStock))}',
                                      style: AppTextStyles.cardTotalMoney,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getStocks() async {
    setState(() {
      fetchStocks();
    });
  }
}
