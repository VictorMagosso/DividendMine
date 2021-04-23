import 'dart:async';
import 'dart:io';
import '../model/stock.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  //unica instancia (singleton)
  static Database? _database;

  //definicao da coluna da tabela
  final String tableName = 'table_stocks';
  String id = 'id';
  String quantity = 'quantity';
  String valuePerStock = 'valuePerStock';
  String stockCode = 'stockCode';

  // ignore: unused_element

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDb();
    }
    return _database!;
  }

  Future<Database> initializeDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/stocks.db';

    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  FutureOr<void> _createDb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $tableName ($id INTEGER PRIMARY KEY AUTOINCREMENT, $stockCode TEXT,' +
            '$quantity INTEGER, $valuePerStock DOUBLE)');
  }

  FutureOr<int> persist(Stock stock) async {
    Database db = await this.database;
    var res = await db.insert(tableName, stock.toMap());
    return res;
  }

  FutureOr<bool> delete(int id) async {
    Database db = await this.database;
    try {
      await db.rawDelete('DELETE FROM $tableName WHERE id = $id');
      return true;
    } catch (e) {
      return false;
    }
  }

  FutureOr<Stock> getStock(int id) async {
    Database db = await this.database;
    List<Map<String, dynamic>> res =
        await db.rawQuery('SELECT * FROM $tableName WHERE id = $id');
    return Stock.fromMap(res.first);
  }

  FutureOr<String> update(Stock stock) async {
    Database db = await this.database;
    try {
      await db.update(tableName, stock.toMap(),
          where: '$id = ?', whereArgs: [stock.id]);
      return 'O item ${stock.stockCode.toUpperCase()} foi atuallizado!';
    } catch (e) {
      return 'Não foi possível deletar.';
    }
  }

  Future<List<Stock>> getAllStocks() async {
    Database db = await this.database;
    var res = await db.query(tableName);
    List<Stock> returnList =
        res.isNotEmpty ? res.map((e) => Stock.fromMap(e)).toList() : [];

    return returnList.isNotEmpty ? returnList : [];
  }

  Future close() async {
    Database db = await this.database;
    db.close();
  }
}
