import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:woomam/components/components.dart';

ThemeData customThemeData = ThemeData(
  /// colors
  primaryColor: primaryColor,

  // colors - background
  backgroundColor: backgroundColor,
  scaffoldBackgroundColor: backgroundColor,

  appBarTheme: const AppBarTheme(
    backgroundColor: backgroundColor,
    shadowColor: Colors.transparent,
    elevation: 0.0,
    systemOverlayStyle: SystemUiOverlayStyle.light,
  ),

  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      overlayColor:
          MaterialStateColor.resolveWith((states) => Colors.transparent),
    ),
  ),
);
