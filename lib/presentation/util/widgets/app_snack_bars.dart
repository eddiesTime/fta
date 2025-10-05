import 'package:flutter/material.dart';

class AppSnackBars {
  static SnackBar error(String text) =>
      SnackBar(content: Text(text), backgroundColor: Colors.redAccent);

  static SnackBar success(String text) =>
      SnackBar(content: Text(text), backgroundColor: Colors.green);

  static SnackBar info(String text) =>
      SnackBar(content: Text(text), backgroundColor: Colors.grey);
}
