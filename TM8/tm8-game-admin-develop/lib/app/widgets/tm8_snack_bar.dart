import 'package:flutter/material.dart';
import 'package:tm8_game_admin/app/constants/constants.dart';
import 'package:tm8_game_admin/app/constants/fonts.dart';
import 'package:tm8_game_admin/app/constants/palette.dart';
import 'package:tm8_game_admin/app/widgets/tm8_secondary_button_widget.dart';

class Tm8SnackBar {
  static SnackBar snackBar({
    double width = 290,
    required Color color,
    required String text,
    required bool button,
    VoidCallback? onPressed,
    String? buttonText,
    Color? buttonColor,
    TextStyle? buttonStyle,
    Color? textColor,
    int duration = 2,
  }) =>
      SnackBar(
        backgroundColor: Colors.transparent,
        duration: Duration(seconds: duration),
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        width: width,
        content: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color,
            boxShadow: [overlayShadow],
            borderRadius: const BorderRadius.all(
              Radius.circular(
                10,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                textAlign: TextAlign.center,
                style: body1Regular.copyWith(
                  color: textColor ?? achromatic200,
                ),
              ),
              if (button) ...[
                w12,
                Tm8SecondaryButtonWidget(
                  onPressed: onPressed ?? () {},
                  text: buttonText ?? '',
                  textStyle: buttonStyle ?? body1Regular,
                  textColor: buttonColor ?? Colors.white,
                ),
              ],
            ],
          ),
        ),
      );
}
