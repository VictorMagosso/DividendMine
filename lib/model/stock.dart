class Stock {
  int id = 0;
  int quantity = 0;
  double valuePerStock = 0.0;
  String stockCode = '';

  Stock(this.id, this.quantity, this.valuePerStock, this.stockCode);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'quantity': quantity,
      'valuePerStock': valuePerStock,
      'stockCode': stockCode
    };
    return map;
  }

  Stock.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    quantity = map['quantity'];
    valuePerStock = map['valuePerStock'];
    stockCode = map['stockCode'];
  }

  @override
  String toString() {
    return "Stock => (id: $id, quantity: $quantity, valuePerStock: $valuePerStock, stockCode: $stockCode)";
  }
}
