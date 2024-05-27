import 'package:flutter/material.dart';

class Utils {
  static void showSnackBar(BuildContext context, String? message) {
    if (message == null) return;

    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
