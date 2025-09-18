import 'package:flutter/material.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';

class Tm8GameMobileTheme {
  const Tm8GameMobileTheme._();
  static final dark = ThemeData(
    extensions: <ThemeExtension<dynamic>>[
      StreamVideoTheme(
        brightness: Brightness.light,
        callContentTheme: const StreamCallContentThemeData(
          callContentBackgroundColor: Colors.transparent,
        ),
        callControlsTheme: const StreamCallControlsThemeData(
          backgroundColor: Colors.transparent,
        ),
      ),
    ],
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.transparent,
    iconTheme: const IconThemeData(color: Colors.white),
    navigationBarTheme: const NavigationBarThemeData(
      backgroundColor: Colors.transparent,
      indicatorColor: Colors.white,
      iconTheme: WidgetStatePropertyAll(IconThemeData(color: Colors.white)),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.all(Colors.transparent),
      checkColor: WidgetStateProperty.all(achromatic100),
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      side: BorderSide(width: 1, color: achromatic300),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.all(primaryTeal),
      overlayColor: WidgetStateProperty.all(achromatic300),
    ),
    scrollbarTheme: ScrollbarThemeData(
      thickness: WidgetStateProperty.all(
        2,
      ),
      radius: const Radius.circular(
        20,
      ),
      thumbColor: WidgetStateProperty.all(
        achromatic500,
      ),
      trackColor: WidgetStateProperty.all(achromatic500),
      trackVisibility: WidgetStateProperty.all(
        true,
      ),
      thumbVisibility: WidgetStateProperty.all(
        true,
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: achromatic600,
      contentTextStyle: body1Regular.copyWith(color: achromatic200),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: primaryTeal,
      inactiveTrackColor: adminBackgroundColor,
      thumbColor: primaryTeal,
      trackHeight: 4,
      thumbShape: const RoundSliderThumbShape(
        enabledThumbRadius: 8,
      ),
      overlayColor: Colors.transparent,
      valueIndicatorColor: achromatic700,
      valueIndicatorTextStyle: body1Bold.copyWith(color: achromatic100),
      valueIndicatorShape: const RectangularSliderValueIndicatorShape(),
      inactiveTickMarkColor: Colors.transparent,
      activeTickMarkColor: Colors.transparent,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: achromatic700,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
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
