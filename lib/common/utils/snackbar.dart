
import 'package:flutter/material.dart';

void showFloatSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        margin: EdgeInsets.all(5),
        behavior: SnackBarBehavior.floating,
      )
  );
}