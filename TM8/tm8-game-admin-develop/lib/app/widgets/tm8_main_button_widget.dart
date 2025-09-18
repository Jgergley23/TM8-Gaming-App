import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tm8_game_admin/app/constants/constants.dart';
import 'package:tm8_game_admin/app/constants/fonts.dart';

class Tm8MainButtonWidget extends StatelessWidget {
  const Tm8MainButtonWidget({
    super.key,
    this.width = 290,
    required this.buttonColor,
    required this.onPressed,
    required this.text,
    this.height = 40,
    this.textColor = Colors.white,
    this.textStyle = body1Regular,
    this.asset,
    this.assetColor,
  });

  final double height;
  final double width;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onPressed;
  final TextStyle textStyle;
  final String text;
  final String? asset;
  final Color? assetColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: buttonColor,
        ),
        child: asset != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    asset!,
                    colorFilter: assetColor != null
                        ? ColorFilter.mode(assetColor!, BlendMode.srcIn)
                        : null,
                    fit: BoxFit.scaleDown,
                  ),
                  w8,
                  Text(
                    text,
                    style: textStyle.copyWith(
                      color: textColor,
                    ),
                  ),
                ],
              )
            : Center(
                child: Text(
                  text,
                  style: textStyle.copyWith(
                    color: textColor,
                  ),
                ),
              ),
      ),
    );
  }
}
