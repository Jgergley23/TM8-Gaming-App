import 'package:flutter/material.dart';
import 'package:tm8_game_admin/app/constants/fonts.dart';
import 'package:tm8_game_admin/app/constants/palette.dart';

class Tm8GameAdminTheme {
  const Tm8GameAdminTheme._();
  static final dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: backgroundColor,
    iconTheme: const IconThemeData(color: Colors.white),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: backgroundColor,
      indicatorColor: Colors.white,
      iconTheme:
          const MaterialStatePropertyAll(IconThemeData(color: Colors.white)),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: backgroundColor,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(primaryTeal),
      checkColor: MaterialStateProperty.all(achromatic100),
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      side: BorderSide(width: 1, color: achromatic300),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(achromatic200),
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      splashRadius: 0,
    ),
    scrollbarTheme: ScrollbarThemeData(
      thickness: MaterialStateProperty.all(
        4,
      ),
      radius: const Radius.circular(
        20,
      ),
      thumbColor: MaterialStateProperty.all(
        achromatic500,
      ),
      trackColor: MaterialStateProperty.all(backgroundColor),
      trackVisibility: MaterialStateProperty.all(
        false,
      ),
      thumbVisibility: MaterialStateProperty.all(
        true,
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: achromatic600,
      contentTextStyle: body1Regular.copyWith(color: achromatic200),
    ),
    inputDecorationTheme: InputDecorationTheme(
      errorStyle: TextStyle(color: errorTextColor),
    ),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    textTheme: const TextTheme(
      headlineLarge: heading1Regular,
      headlineMedium: heading2Regular,
      headlineSmall: heading3Regular,
      displayLarge: heading1Bold,
      displayMedium: heading2Bold,
      displaySmall: heading4Bold,
      bodyLarge: heading4Regular,
      bodyMedium: body1Regular,
      bodySmall: body2Regular,
      titleLarge: heading4Bold,
      titleMedium: body1Bold,
      titleSmall: body2Bold,
    ),
  );
}
