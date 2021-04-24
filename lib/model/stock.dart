class Stock {
  int? id;
  int quantity = 0;
  double valuePerStock = 0.0;
  String stockCode = '';
  int dateReceiving = 0;

  ///constructor com parametros nomeados para setar a obrigatoriedade de cada um
  Stock(this.quantity, this.valuePerStock, this.stockCode, this.dateReceiving);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'quantity': quantity,
      'valuePerStock': valuePerStock,
      'stockCode': stockCode,
      'dateReceiving': dateReceiving
    };
    return map;
  }

  Stock.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    quantity = map['quantity'];
    valuePerStock = map['valuePerStock'];
    stockCode = map['stockCode'];
    dateReceiving = map['dateReceiving'];
  }

  @override
  String toString() {
    return "Stock => (id: $id, quantity: $quantity, valuePerStock: $valuePerStock, stockCode: $stockCode, date: $dateReceiving)";
  }
}
