import 'package:flutter/material.dart';
import 'package:video_recorder/utils/constants/colors.dart';
import 'package:video_recorder/utils/themes/appbar_theme.dart';
import 'package:video_recorder/utils/themes/elevated_button_theme.dart';
import 'package:video_recorder/utils/themes/input_decoration_theme.dart';
import 'package:video_recorder/utils/themes/text_Theme.dart';

class XTheme {
  XTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: false,
    fontFamily: 'Montserrat',
    brightness: Brightness.light,
    primaryColor: XColors.primaryColor,
    scaffoldBackgroundColor: XColors.whiteColor,
    textTheme: XTextThemes.lightTextTheme,
    elevatedButtonTheme: XElevatedButtonTheme.lightElevatedButtonTheme,
    appBarTheme: XAppBarTheme.lightAppBarTheme,
    inputDecorationTheme: XInputDecorationTheme.lightInputDecorationTheme,
  );
}
