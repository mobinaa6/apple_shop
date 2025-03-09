import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension ColorParsing on String? {
  Color parsToColor() {
    String colorString = 'ff${this}';
    int hexcolor = int.parse(colorString, radix: 16);
    return Color(hexcolor);
  }
}
