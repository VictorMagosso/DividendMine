import 'package:DividendMine/controller/stock_controller.dart';
import 'package:DividendMine/core/core.dart';
import 'package:DividendMine/home/widgets/sum_up/sum_app.dart';
import 'package:DividendMine/model/stock.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

// ignore: must_be_immutable
//
// TODO -> remover o terceiro numero depois do digito no input de valPerStock
class AddStockPage extends StatefulWidget {
  @override
  _AddStockPageState createState() => _AddStockPageState();
}

class _AddStockPageState extends State<AddStockPage> {
  final stockController = StockController();

  var codeController = TextEditingController();
  var qttController = TextEditingController(text: '0');
  var dateController = TextEditingController();

  var valPerStockController = MoneyMaskedTextController(
    decimalSeparator: ',',
    thousandSeparator: '.',
  );

  var _stockFilled = '';
  var _valueDividend = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppGradients.addStockBg),
        padding: EdgeInsets.only(right: 15, left: 15, top: 30),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, bottom: 30),
                  child: Text(
                    'Adicionar papel',
                    style: AppTextStyles.title,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _stockFilled,
                        style: AppTextStyles.cardTitle,
                      ),
                      Text(
                        '-',
                        style: AppTextStyles.cardTitle,
                      ),
                      Text(
                        _valueDividend,
                        style: AppTextStyles.cardTitle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: TextField(
                style: AppTextStyles.inputStock,
                controller: codeController,
                onChanged: (value) {
                  setState(() {
                    _stockFilled = value;
                  });
                },
                textCapitalization: TextCapitalization.characters,
                maxLength: 6,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                decoration: InputDecoration(
                    filled: true,
                    counterText: '',
                    prefixIcon: Icon(
                      Icons.stacked_line_chart,
                      color: AppColors.card2,
                    ),
                    prefixStyle: AppTextStyles.cardText,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide:
                            BorderSide(width: 0.2, color: AppColors.secondary)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    fillColor: AppColors.primary,
                    labelStyle: TextStyle(color: AppColors.accent),
                    errorStyle: TextStyle(color: AppColors.negative),
                    labelText: 'Código do papel',
                    hintStyle: AppTextStyles.cardText,
                    hintText: 'Ex.: BCFF11, HGLG11'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: TextField(
                controller: qttController,
                onChanged: (value) {
                  setState(() {
                    print('qttController: ' + value);
                    _valueDividend = formatMoney.moneyHandler((int.parse(
                            value) *
                        double.parse(
                            valPerStockController.text.replaceAll(',', '.'))));
                  });
                },
                keyboardType: TextInputType.number,
                style: AppTextStyles.inputStock,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.calculate_outlined,
                    color: AppColors.card2,
                  ),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          BorderSide(width: 0.2, color: AppColors.secondary)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  fillColor: AppColors.primary,
                  labelStyle: TextStyle(color: AppColors.accent),
                  errorStyle: TextStyle(color: AppColors.negative),
                  labelText: 'Quantidade',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: TextField(
                controller: valPerStockController,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    print('valPerStock: ' + value);
                    _valueDividend = formatMoney.moneyHandler(
                        (int.parse(qttController.text) *
                            double.parse(value.replaceAll(',', '.'))));
                  });
                },
                style: AppTextStyles.inputStock,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.monetization_on,
                    color: AppColors.card2,
                  ),
                  prefix: Text(
                    'R\$ ',
                    style: TextStyle(color: AppColors.accent),
                  ),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          BorderSide(width: 0.2, color: AppColors.secondary)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  fillColor: AppColors.primary,
                  labelStyle: TextStyle(color: AppColors.accent),
                  errorStyle: TextStyle(color: AppColors.negative),
                  labelText: 'Valor por cota',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: TextField(
                keyboardType: TextInputType.number,
                maxLength: 2,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                controller: dateController,
                style: AppTextStyles.inputStock,
                decoration: InputDecoration(
                  prefix: Text(
                    'Todo dia ',
                    style: TextStyle(color: AppColors.accent),
                  ),
                  prefixIcon: Icon(
                    Icons.date_range,
                    color: AppColors.card2,
                  ),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          BorderSide(width: 0.2, color: AppColors.secondary)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  fillColor: AppColors.primary,
                  labelStyle: TextStyle(color: AppColors.accent),
                  errorStyle: TextStyle(color: AppColors.negative),
                  labelText: 'Previsão de recebimento',
                ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              FloatingActionButton.extended(
                heroTag: 'btnGoBack',
                onPressed: () {
                  Navigator.pop(context);
                },
                label: Text(
                  'Voltar',
                  style: TextStyle(color: AppColors.primaryLight),
                ),
                icon: Icon(
                  Icons.arrow_back,
                  color: AppColors.primaryLight,
                ),
                backgroundColor: AppColors.accent,
              ),
              FloatingActionButton.extended(
                heroTag: 'btnConclude',
                onPressed: () {
                  saveOrUpdateStock(context);
                },
                label: Text('Confirmar'),
                icon: Icon(Icons.check),
                backgroundColor: AppColors.positive,
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Future<void> saveOrUpdateStock(BuildContext context) async {
    Stock stock = Stock(
        int.parse(qttController.text),
        double.parse(valPerStockController.text.replaceAll(',', '.')),
        codeController.text.toUpperCase(),
        int.parse(dateController.text));
    var res = await stockController.persistStock(stock);

    // ignore: unnecessary_statements
    res ? Navigator.pop(context) : '';
  }
}
