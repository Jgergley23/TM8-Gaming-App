import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';

class Tm8SocialButtonWidget extends StatelessWidget {
  const Tm8SocialButtonWidget({
    super.key,
    required this.onTap,
    required this.icon,
    required this.text,
  });

  final VoidCallback onTap;
  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: achromatic500,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(icon),
            w6,
            Text(text, style: body1Regular.copyWith(color: achromatic100)),
          ],
        ),
      ),
    );
  }
}
