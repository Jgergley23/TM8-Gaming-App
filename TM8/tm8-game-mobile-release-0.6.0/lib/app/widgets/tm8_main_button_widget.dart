import 'package:flutter/material.dart';
import 'package:tm8/app/constants/fonts.dart';

class Tm8MainButtonWidget extends StatelessWidget {
  const Tm8MainButtonWidget({
    super.key,
    required this.onTap,
    required this.buttonColor,
    required this.text,
    this.height = 40,
    this.textColor = Colors.white,
    this.textStyle = body1Regular,
    this.width,
  });

  final double height;
  final double? width;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onTap;
  final TextStyle textStyle;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: buttonColor,
        ),
        child: Center(
          child: Text(
            text,
            style: textStyle.copyWith(color: textColor),
          ),
        ),
      ),
    );
  }
}
