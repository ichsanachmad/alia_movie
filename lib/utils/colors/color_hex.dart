import 'package:flutter/painting.dart';

class ColorHex extends Color {
  ColorHex(String hex) : super(_getColorFromHex(hex));
  static int _getColorFromHex(String hex) {
    String colorHexReplaced = hex.replaceAll('#', 'FF');
    return int.parse(colorHexReplaced, radix: 16);
  }
}
