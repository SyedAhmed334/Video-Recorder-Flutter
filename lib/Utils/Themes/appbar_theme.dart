import 'package:flutter/material.dart';

class XAppBarTheme {
  XAppBarTheme._();
  static const lightAppBarTheme = AppBarTheme(
    elevation: 3,
    centerTitle: true,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.red,
    surfaceTintColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black, size: 24),
    actionsIconTheme: IconThemeData(color: Colors.black, size: 24),
    titleTextStyle: TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white),
  ); // AppBarTheme
}
