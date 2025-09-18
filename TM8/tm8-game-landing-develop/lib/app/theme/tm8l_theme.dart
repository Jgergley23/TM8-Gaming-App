import 'package:flutter/material.dart';
import 'package:tm8l/app/constants/fonts.dart';
import 'package:tm8l/app/constants/palette.dart';

class Tm8GameLandingTheme {
  const Tm8GameLandingTheme._();

  static final dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: backgroundColor,
    iconTheme: const IconThemeData(color: Colors.white),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    snackBarTheme: SnackBarThemeData(
      backgroundColor: achromatic600,
      contentTextStyle: body1Regular.copyWith(color: achromatic200),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(Colors.transparent),
      checkColor: MaterialStateProperty.all(achromatic100),
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      side: BorderSide(width: 1, color: achromatic300),
    ),
    textTheme: const TextTheme(
      headlineLarge: landingPageHeading1,
      headlineMedium: landingPageHeading2,
      headlineSmall: landingPageHeading3,
      displayLarge: landingPageBodyRegular,
      displayMedium: landingPageBodyRegular,
    ),
  );
}
