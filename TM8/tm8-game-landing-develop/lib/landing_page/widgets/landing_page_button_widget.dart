import 'package:flutter/material.dart';
import 'package:tm8l/app/constants/fonts.dart';

class LandingPageButtonWidget extends StatelessWidget {
  const LandingPageButtonWidget({
    super.key,
    this.width = 125,
    required this.buttonColor,
    required this.onPressed,
    required this.text,
    this.height = 44,
    this.textColor = Colors.white,
    this.textStyle = heading4Regular,
  });

  final double height;
  final double width;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onPressed;
  final TextStyle textStyle;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: buttonColor,
        ),
        child: Center(
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
