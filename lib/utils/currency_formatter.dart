import 'package:intl/intl.dart';

class CurrencyFormatter {
  static String formatColombianPrice(double amount) {
    final formatter = NumberFormat.currency(
      locale: 'es_CO',
      symbol: '\$',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  static String formatPrice(double amount) {
    return '\$${amount.toStringAsFixed(2)}';
  }
}
