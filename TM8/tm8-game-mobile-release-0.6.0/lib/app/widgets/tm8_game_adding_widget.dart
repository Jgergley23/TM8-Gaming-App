import 'package:flutter/material.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';

class Tm8GameAddingWidget extends StatelessWidget {
  const Tm8GameAddingWidget({
    super.key,
    required this.gameName,
    required this.gameIcon,
    required this.onChanged,
    this.value = false,
  });

  final String gameName;
  final String gameIcon;
  final Function(bool?)? onChanged;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: achromatic700,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                gameIcon,
                height: 24,
                width: 24,
              ),
              w8,
              Text(
                gameName,
                style: body1Regular.copyWith(color: achromatic100),
              ),
            ],
          ),
          Checkbox(
            value: value,
            fillColor: value == true
                ? WidgetStateProperty.all(primaryTeal)
                : WidgetStateProperty.all(Colors.transparent),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
