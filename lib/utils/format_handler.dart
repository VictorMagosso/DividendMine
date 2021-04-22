import 'package:intl/intl.dart';

class MoneyFormatter {
  String moneyHandler(double param) {
    return NumberFormat.currency(locale: 'pt-BR', symbol: 'R\$').format(param);
  }
}
