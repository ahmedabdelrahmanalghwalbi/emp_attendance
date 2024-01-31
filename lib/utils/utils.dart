import 'package:flutter/material.dart';

class Utils {
  const Utils._();
  static void showSnackBar(String message, BuildContext context,
      {Color? color}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: color,
    ));
  }
}
