import 'package:flutter/material.dart';
import 'package:tm8_game_admin/app/constants/fonts.dart';

class Tm8SecondaryButtonWidget extends StatelessWidget {
  const Tm8SecondaryButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
    this.textColor = Colors.white,
    this.textStyle = body1Regular,
  });

  final Color textColor;
  final VoidCallback onPressed;
  final TextStyle textStyle;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: textStyle.copyWith(color: textColor),
      ),
    );
  }
}
