
import 'package:flutter/material.dart';

Color hexToColorWidget(String hexColor) {
  return Color(int.parse('0xFF${hexColor}'));
}

String widgetColorToHex(Color color) {
  String hex = '${color.value.toRadixString(16)}';
  return hex.substring(2);
}