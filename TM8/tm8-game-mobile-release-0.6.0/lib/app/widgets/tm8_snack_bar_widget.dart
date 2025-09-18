import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/widgets/tm8_secondary_button_widget.dart';
import 'package:tm8/gen/assets.gen.dart';

class Tm8SnackBar {
  static SnackBar snackBar({
    required Color color,
    required String text,
    required bool error,
    bool? button,
    VoidCallback? onPressed,
    String? buttonText,
    Color? buttonColor,
    int duration = 2,
  }) =>
      SnackBar(
        backgroundColor: Colors.transparent,
        duration: Duration(seconds: duration),
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12.5),
          decoration: BoxDecoration(
            color: color,
            // boxShadow: [overlayShadow],
            borderRadius: const BorderRadius.all(
              Radius.circular(
                10,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Align(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (error) ...[
                        SvgPicture.asset(Assets.common.errorSnackBar.path),
                        w8,
                      ],
                      Expanded(
                        child: Text(
                          text,
                          style: body1Regular.copyWith(
                            color: error == true ? errorColor : achromatic200,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (button != null) ...[
                w12,
                Tm8SecondaryButtonWidget(
                  onPressed: onPressed ?? () {},
                  text: buttonText ?? '',
                  textStyle: body1Regular,
                  textColor: achromatic100,
                ),
              ],
            ],
          ),
        ),
      );
}
