import 'dart:async';
import 'package:DividendMine/model/stock.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:state_notifier/state_notifier.dart';
import '../db/db_helper.dart';

class StockController {
  static DatabaseHelper db = DatabaseHelper();

  Future<bool> persistStock(Stock stock) async {
    if (await db.persist(stock) == 0) {
      return false;
    }
    return true;
  }

  FutureOr<bool> deleteStock(int id) async {
    return await db.delete(id);
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

    if (allDividends.length == 0) {
      return 0;
    }
    return allDividends.reduce((a, b) => a + b);
  }
}
