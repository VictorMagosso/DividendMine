import 'dart:async';
import 'package:DividendMine/model/stock.dart';
import 'package:flutter/foundation.dart';
import '../db/db_helper.dart';

class StockController with ChangeNotifier {
  static DatabaseHelper db = DatabaseHelper();

  double totalDividend = 0;
  ValueNotifier<List<dynamic>> dividendByInterval = ValueNotifier([]);
  List<Stock> allStocks = [];

  Future<bool> persistStock(Stock stock) async {
    if (await db.persist(stock) == 0) {
      return false;
    }
    return true;
  }

  FutureOr<bool> deleteStock(int id) async {
    return await db.delete(id);
  }

  FutureOr<bool> updateStock(int id, Stock stock) async {
    stock.id = id;
    return await db.update(stock);
  }

  FutureOr<List<Stock>> getAllStocks() async {
    List<Stock> stockList = [];
    await db.getAllStocks().then((res) {
      stockList = res;
    });
    allStocks = stockList;
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
    totalDividend = allDividends.reduce((a, b) => a + b);
    return totalDividend;
  }

  Future<dynamic> sumAllDividendByMonth() async {
    var begin = [1, 2, 3, 4, 5, 6, 7, 8, 9];
    var firstQuarter = [10, 11, 12, 13, 14, 15, 16, 17, 18];
    var lastQuarter = [19, 20, 21, 22, 23, 24, 25];
    var end = [26, 27, 28, 29, 30, 31];

    var stocks = await getAllStocks();

    var objList = [];

    var beginAux = [];
    var firstQuarterAux = [];
    var lastQuarterAux = [];
    var endAux = [];

    if (stocks.length > 0) {
      for (var s in stocks) {
        if (begin.contains(s.dateReceiving)) {
          beginAux.add(s.quantity * s.valuePerStock);
        }

        if (firstQuarter.contains(s.dateReceiving)) {
          firstQuarterAux.add(s.quantity * s.valuePerStock);
        }

        if (lastQuarter.contains(s.dateReceiving)) {
          lastQuarterAux.add(s.quantity * s.valuePerStock);
        }

        if (end.contains(s.dateReceiving)) {
          endAux.add(s.quantity * s.valuePerStock);
        }
      }
    }
    var tempObj = {};

    beginAux.length > 0
        ? tempObj['begin'] = beginAux.reduce((a, b) => a + b)
        : tempObj['begin'] = 0.0;

    firstQuarterAux.length > 0
        ? tempObj['firstQuarter'] = firstQuarterAux.reduce((a, b) => a + b)
        : tempObj['firstQuarter'] = 0.0;

    lastQuarterAux.length > 0
        ? tempObj['lastQuarter'] = lastQuarterAux.reduce((a, b) => a + b)
        : tempObj['lastQuarter'] = 0.0;

    endAux.length > 0
        ? tempObj['end'] = endAux.reduce((a, b) => a + b)
        : tempObj['end'] = 0.0;

    objList.add(tempObj);
    dividendByInterval.value = objList;
    notifyListeners();
    return dividendByInterval.value;
  }
}
