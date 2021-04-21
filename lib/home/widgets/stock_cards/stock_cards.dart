import 'package:DividendMine/core/core.dart';
import 'package:DividendMine/db/db_helper.dart';
import 'package:DividendMine/model/stock.dart';
import 'package:flutter/material.dart';

class StockCardWidget extends StatefulWidget {
  @override
  _StockCardWidgetState createState() => _StockCardWidgetState();
}

class _StockCardWidgetState extends State<StockCardWidget> {
  DatabaseHelper db = DatabaseHelper();
  List<Stock> allStocks = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      db.getAllStocks().then((list) {
        allStocks = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 14),
        itemCount: allStocks.length,
        itemBuilder: (context, index) {
          return _allStocks(context, index);
        },
      ),
    );
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
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 0.2, color: AppColors.secondary),
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
                            Text(
                              allStocks[index].stockCode,
                              style: AppTextStyles.cardTitle,
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
                            padding: const EdgeInsets.all(8.0),
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
                                      'R\$ ${allStocks[index].valuePerStock}',
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
                                      'R\$ ${(allStocks[index].quantity * allStocks[index].valuePerStock).toStringAsFixed(2).replaceAll('.', ',')}',
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
}
