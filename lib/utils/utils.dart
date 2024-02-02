import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Utils {
  const Utils._();
  //show snack bar method
  static void showSnackBar(String message, BuildContext context,
      {Color? color}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: color,
    ));
  }

  //method to generate unique id
  static String generateUniqueId() => const Uuid().v4();
}
