import 'package:flutter/material.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/gen/assets.gen.dart';

class UserActionsWidget extends StatelessWidget {
  const UserActionsWidget({
    super.key,
    required this.item,
    required this.icon,
    required this.onTap,
  });

  final String item;
  final Widget icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: achromatic700,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                icon,
                w8,
                Text(
                  item,
                  style: body1Regular.copyWith(color: achromatic100),
                ),
              ],
            ),
            Assets.common.navigateRight.svg(),
          ],
        ),
      ),
    );
  }
}
