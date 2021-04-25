import 'package:intl/intl.dart';

class MoneyFormatter {
  String moneyHandler(double moneyValue) {
    return NumberFormat.currency(
            locale: 'pt-BR', symbol: 'R\$', decimalDigits: 2)
        .format(moneyValue);
  }
}
