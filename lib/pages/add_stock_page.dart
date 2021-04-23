import 'package:DividendMine/controller/stock_controller.dart';
import 'package:DividendMine/core/core.dart';
import 'package:DividendMine/model/stock.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class AddStockPage extends StatelessWidget {
  final stockController = StockController();
  var codeController = TextEditingController();
  var qttController = TextEditingController();
  var valPerStockController =
      MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryLight,
      body: Container(
        width: double.maxFinite,
        height: 295,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: TextField(
                style: TextStyle(
                  color: AppColors.accent,
                ),
                controller: codeController,
                textCapitalization: TextCapitalization.characters,
                maxLength: 6,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                decoration: InputDecoration(
                    counterText: '',
                    prefixIcon: Icon(
                      Icons.stacked_line_chart,
                      color: AppColors.accent,
                    ),
                    prefixStyle: AppTextStyles.cardText,
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.invisible)),
                    border: OutlineInputBorder(),
                    fillColor: AppColors.accent,
                    errorStyle: TextStyle(color: AppColors.negative),
                    labelText: 'Código do papel',
                    labelStyle: TextStyle(color: AppColors.secondary),
                    hintStyle: AppTextStyles.cardText,
                    hintText: 'Ex.: BCFF11, HGLG11'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: qttController,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: AppColors.accent,
                ),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.invisible)),
                  fillColor: AppColors.accent,
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: AppColors.secondary),
                  errorStyle: TextStyle(color: AppColors.negative),
                  labelText: 'Quantidade',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: valPerStockController,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: AppColors.accent,
                ),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.invisible)),
                  fillColor: AppColors.accent,
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(color: AppColors.secondary),
                  errorStyle: TextStyle(color: AppColors.negative),
                  labelText: 'Valor por cota',
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          saveOrUpdateStock(context);
        },
        label: Text('Confirmar'),
        icon: Icon(Icons.check),
        backgroundColor: AppColors.positive,
      ),
    );
  }

  Future<void> saveOrUpdateStock(BuildContext context) async {
    print('clicou');
    Stock stock = Stock(
        int.parse(qttController.text),
        double.parse(valPerStockController.text.replaceAll(',', '.')),
        codeController.text.toUpperCase());
    var res = await stockController.persistStock(stock);

    if (!res) {
      var snackBar = SnackBar(
          content: Text('Algo deu errado ao salvar...'),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () => {},
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      var snackBar = SnackBar(
          content: Text('${stock.stockCode} adicionado!'),
          action: SnackBarAction(
            label: 'OK',
            onPressed: () => {},
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pop(context);
    }
  }
}
