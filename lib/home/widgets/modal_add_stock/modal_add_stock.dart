import 'package:DividendMine/core/core.dart';
import 'package:DividendMine/db/db_helper.dart';
import 'package:DividendMine/home/widgets/button_actions_widget/button_actions_widget.dart';
import 'package:DividendMine/model/stock.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ModalAddStockWidget extends StatelessWidget {
  final bool isVisible;
  DatabaseHelper db = DatabaseHelper();

  var codeController = TextEditingController();
  var qttController = TextEditingController();
  var valPerStockController = TextEditingController();

  ModalAddStockWidget({Key? key, required this.isVisible})
      : assert([true, false].contains(isVisible)),
        super(key: key);

  final config = {
    'true': {
      'visibility': true,
    },
    'false': {
      'visibility': false,
    }
  };

  bool get visibility => config[isVisible]!['visibility']!;

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: isVisible,
        child: Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: AppColors.bgAddStockCardColor,
          child: Center(
            child: Container(
              width: double.maxFinite,
              height: 300,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: TextField(
                      style: TextStyle(
                        color: AppColors.accent,
                      ),
                      controller: codeController,
                      textCapitalization: TextCapitalization.characters,
                      maxLength: 6,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.stacked_line_chart,
                            color: AppColors.accent,
                          ),
                          prefixStyle: AppTextStyles.cardText,
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.invisible)),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        child: ButtonActionsWidget(label: 'Confirmar'),
                        onTap: () => saveOrUpdateStock(),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void saveOrUpdateStock() {
    DatabaseHelper db = DatabaseHelper();
    Stock stock = Stock(
        quantity: int.parse(qttController.text),
        valuePerStock: double.parse(valPerStockController.text),
        stockCode: codeController.text);

    var res = db.persist(stock);
    if (res == 0) {
//aparece um toast
    } else {
      //dismiss modal
    }
  }
}
