import 'package:flutter/material.dart';

class Tm8SecondaryButtonWidget extends StatelessWidget {
  const Tm8SecondaryButtonWidget({
    super.key,
    required this.textColor,
    required this.onPressed,
    required this.textStyle,
    required this.text,
  });

  final Color textColor;
  final VoidCallback onPressed;
  final TextStyle textStyle;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.all(Colors.transparent),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: textStyle.copyWith(color: textColor),
      ),
    );
  }
}
