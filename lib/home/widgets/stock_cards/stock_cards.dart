import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:DividendMine/controller/stock_controller.dart';
import 'package:DividendMine/core/core.dart';
import 'package:DividendMine/home/widgets/sum_up/sum_app.dart';
import 'package:DividendMine/model/stock.dart';
import 'package:DividendMine/utils/format_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';

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
String? _snackBarMessage;
String _successMessage = 'Papel removido.';
String _errorMessage =
    'Algo deu errado ao deletar... Tente novamente mais tarde.';

var moneyFormatter = MoneyFormatter();

class _StockCardWidgetState extends State<StockCardWidget>
    with TickerProviderStateMixin {
  final stockController = StockController();
  List<Stock> allStocks = [];
  var rotationController;
  var slideController;

  @override
  void initState() {
    rotationController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    rotationController.repeat();
    super.initState();
    fetchStocks();
    stockController.sumAllDividendByMonth();
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
            child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                // child: AnimatedSwitcher(
                //   duration: Duration(milliseconds: 500),
                child: RotationTransition(
                  turns:
                      Tween(begin: 0.0, end: 1.0).animate(rotationController),
                  child: Image.asset(
                    AppImages.noMoney,
                    scale: 2,
                  ),
                ),
              ),
              // ),
              Text(
                'Nenhum papel cadastrado',
                style: TextStyle(color: AppColors.accent, fontSize: 18),
              ),
            ],
          ));
  }

  _allStocks(BuildContext context, int index) {
    return GestureDetector(
      onTap: () => _showDialog(allStocks[index]),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Container(
          width: double.maxFinite,
          height: 157,
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
                            Column(
                              children: [
                                Row(
                                  children: [
                                    allStocks[index].stockCode[allStocks[index]
                                                    .stockCode
                                                    .length -
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
                                      padding: const EdgeInsets.only(left: 1),
                                      child: Text(allStocks[index].stockCode,
                                          style: TextStyle(
                                              color: colors.elementAt(
                                                  Random().nextInt(3)),
                                              fontSize: 24)),
                                    ),
                                  ],
                                ),
                                Text(
                                    'Recebimento dia ${allStocks[index].dateReceiving}',
                                    style: TextStyle(
                                        color: colors
                                            .elementAt(Random().nextInt(3)),
                                        fontSize: 10)),
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

  void _showDialog(Stock stock) {
    var id = stock.id;
    var stockCode = stock.stockCode;
    var _stockCodeController = TextEditingController(
      text: stock.stockCode,
    );
    var _qttController = TextEditingController(
      text: stock.quantity.toString(),
    );
    var _valPerStockController = MoneyMaskedTextController(
      decimalSeparator: ',',
      thousandSeparator: '.',
    );
    _valPerStockController.text = stock.valuePerStock.toString();
    var _dateReceiveController = TextEditingController(
      text: stock.dateReceiving.toString(),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Info - $stockCode',
            ),
            content: Form(
                child: Container(
              height: 330,
              child: ListView(
                children: [
                  TextFormField(
                    controller: _stockCodeController,
                    textCapitalization: TextCapitalization.characters,
                    maxLength: 6,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    onChanged: (_) => stockCode = _stockCodeController.text,
                    decoration: InputDecoration(labelText: 'Código do papel'),
                  ),
                  TextFormField(
                    controller: _qttController,
                    decoration: InputDecoration(labelText: 'Quantidade'),
                  ),
                  TextFormField(
                    controller: _valPerStockController,
                    decoration: InputDecoration(
                      labelText: 'Retorno por cota',
                      prefix: Text(
                        'R\$ ',
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _dateReceiveController,
                    decoration:
                        InputDecoration(labelText: 'Previsão do recebimento'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: FloatingActionButton.extended(
                      onPressed: () {
                        var updatedStock = Stock(
                            int.parse(_qttController.text),
                            double.parse(_valPerStockController.text
                                .replaceAll(',', '.')),
                            _stockCodeController.text.toUpperCase(),
                            int.parse(_dateReceiveController.text));
                        _updateStock(id!, updatedStock, context);
                      },
                      label: Text('Atualizar'),
                      icon: Icon(Icons.refresh),
                    ),
                  )
                ],
              ),
            )),
          );
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
                        String msg = '';
                        var timer = Timer(duration, () async {
                          var res = await stockController.deleteStock(id);
                          res ? msg = _successMessage : msg = _errorMessage;
                        });
                        createSnackBar(context, msg, 'DESFAZER', timer);
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

  void createSnackBar(
      BuildContext context, String message, String label, Timer? timer) {
    var snackBar = SnackBar(
        content: Text(_successMessage),
        action: SnackBarAction(
          label: 'DESFAZER',
          onPressed: () => {timer?.cancel()},
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

FutureOr<void> _updateStock(int id, Stock stock, BuildContext context) async {
  try {
    await stockController.updateStock(id, stock);
    Navigator.pop(context);
  } catch (Exception) {}
}
