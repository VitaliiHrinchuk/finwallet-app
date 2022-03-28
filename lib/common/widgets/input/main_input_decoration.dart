import 'package:flutter/material.dart';

class MainInputDecoration extends InputDecoration {
  @override
  InputBorder get border =>
      UnderlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          width: 0,
          style: BorderStyle.none,
        ),
      );

  @override
  bool? get filled => true;

  MainInputDecoration({
    String? labelText,
    String? errorText,
    Widget? suffixIcon
  }) : super(labelText: labelText, errorText: errorText, suffixIcon: suffixIcon);
}
