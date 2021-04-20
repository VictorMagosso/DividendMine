import 'package:DividendMine/home/widgets/app_bar/app_bar_widget.dart';
import 'package:DividendMine/home/widgets/stock_cards/stock_cards.dart';
import '../core/core.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(),
        body: StockCardWidget(),
        backgroundColor: AppColors.primaryLight,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            //
          },
          label: const Text("Adicionar"),
          icon: const Icon(Icons.add),
          backgroundColor: AppColors.secondary,
        ));
  }
}
