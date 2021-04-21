import 'package:DividendMine/home/widgets/app_bar/app_bar_widget.dart';
import 'package:DividendMine/home/widgets/modal_add_stock/modal_add_stock.dart';
import 'package:DividendMine/home/widgets/stock_cards/stock_cards.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(),
        body: Column(
          children: [
            ModalAddStockWidget(
              isVisible: _isVisible,
            ),
            StockCardWidget()
          ],
        ),
        backgroundColor: AppColors.primaryLight,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            toggleFormAddStock();
          },
          label: Text(_labelFab),
          icon: _icon,
          backgroundColor: _fabBgColor,
        ));
  }

  void toggleFormAddStock() {
    setState(() {
      if (_isVisible) {
        _isVisible = false;
        _labelFab = 'Adicionar';
        _fabBgColor = AppColors.secondary;
        _icon = Icon(Icons.add);
      } else {
        _isVisible = true;
        _labelFab = 'Cancelar';
        _fabBgColor = AppColors.bgAddStockCardColor;
        _icon = Icon(Icons.close);
      }
    });
  }
}
