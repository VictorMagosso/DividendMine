import 'dart:async';
import 'package:DividendMine/model/stock.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:state_notifier/state_notifier.dart';
import '../db/db_helper.dart';

class StockController {
  static DatabaseHelper db = DatabaseHelper();

  FutureOr<void> persistStock(Stock stock) async {
    await db.persist(stock);
  }

  FutureOr<void> deleteStock(int id) async {
    await db.delete(id);
  }

  FutureOr<void> updateStock(Stock stock) async {
    await db.update(stock);
  }

  FutureOr<List<Stock>> getAllStocks() async {
    List<Stock> stockList = [];
    await db.getAllStocks().then((res) {
      stockList = res;
    });
    return stockList;
  }

  FutureOr<Stock> getStock(int id) async {
    return await db.getStock(id);
  }

  FutureOr<double> sumAllDividend() async {
    var stocks = await getAllStocks();
    var allDividends = [];
    for (var item in stocks) {
      allDividends.add(item.valuePerStock * item.quantity);
    }

    return allDividends.reduce((a, b) => a + b);
  }
}