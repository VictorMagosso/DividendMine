import 'dart:async';
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
                            Row(
                              children: [
                                Text(
                                  'Qtde.: ${allStocks[index].quantity}',
                                  style: AppTextStyles.cardText,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: GestureDetector(
                                    onTap: () => deleteStock(
                                        allStocks[index].id!,
                                        allStocks[index].stockCode),
                                    child: Icon(
                                      Icons.remove_circle_outline,
                                      color: AppColors.negative,
                                    ),
                                  ),
                                ),
                              ],
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

  void deleteStock(int id, String stock) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            titleTextStyle: TextStyle(
              fontSize: 24,
              color: AppColors.secondary,
            ),
            title: Text('$stock'),
            contentPadding:
                EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 40),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'Remover esse papel?',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.pop(context);
                        var snackBar = SnackBar(
                            content: Text(
                                'Algo deu errado ao deletar... Tente novamente mais tarde.'),
                            action: SnackBarAction(
                              label: 'OK',
                              onPressed: () => {},
                            ));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      icon: Icon(Icons.close, color: AppColors.primaryLight),
                      label: Text(
                        'Cancelar',
                        style: TextStyle(color: AppColors.primaryLight),
                      ),
                      backgroundColor: AppColors.accent,
                    ),
                    FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.pop(context);
                        var duration = Duration(seconds: 6);
                        var timer = Timer(duration, () {
                          stockController.deleteStock(id);
                        });

                        var snackBar = SnackBar(
                            content: Text('Papel removido.'),
                            action: SnackBarAction(
                              label: 'DESFAZER',
                              onPressed: () => {timer.cancel()},
                            ));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      label: Text('Deletar'),
                      backgroundColor: AppColors.secondary,
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
