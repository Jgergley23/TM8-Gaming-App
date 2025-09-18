import 'package:flutter/material.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/gen/assets.gen.dart';

class SettingsItemWidget extends StatelessWidget {
  const SettingsItemWidget({
    super.key,
    required this.onTap,
    required this.itemName,
    required this.itemAssetIcon,
    this.itemNameColor,
  });

  final VoidCallback onTap;
  final String itemName;
  final Widget itemAssetIcon;
  final Color? itemNameColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: achromatic600,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                itemAssetIcon,
                w8,
                Text(
                  itemName,
                  style: body1Regular.copyWith(
                    color: itemNameColor ?? achromatic100,
                  ),
                ),
              ],
            ),
            Assets.common.navigateRight.svg(
              colorFilter: ColorFilter.mode(
                itemNameColor ?? achromatic100,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
