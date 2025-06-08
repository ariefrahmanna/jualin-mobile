import 'package:intl/intl.dart';

class CurrencyFormatter {
  static final NumberFormat _rupiahFormat = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  static String toRupiah(dynamic number) {
    if (number == null) return 'Rp 0';

    if (number is String) {
      number = double.tryParse(number.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0;
    }

    if (number is num) {
      return _rupiahFormat.format(number);
    }

    return 'Rp 0';
  }
}
