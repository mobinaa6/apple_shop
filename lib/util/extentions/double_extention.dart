import 'package:intl/intl.dart';

extension PriceParsing on int? {
  String FormatPriceWithCommas() {
    final formater = NumberFormat("#,##0", "en_US");
    return formater.format(this);
  }
}
