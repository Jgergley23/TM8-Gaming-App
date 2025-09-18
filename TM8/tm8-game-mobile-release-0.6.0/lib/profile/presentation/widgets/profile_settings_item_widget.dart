import 'package:flutter/material.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/gen/assets.gen.dart';

class ProfileSettingsItemWidget extends StatelessWidget {
  const ProfileSettingsItemWidget({
    super.key,
    required this.onTap,
    required this.itemName,
    required this.itemValue,
  });

  final VoidCallback onTap;
  final String itemName;
  final String itemValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: achromatic600,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  itemName,
                  style: body2Regular.copyWith(
                    color: achromatic300,
                  ),
                ),
                SizedBox(
                  width: 250,
                  child: Text(
                    itemValue,
                    style: body1Regular.copyWith(
                      color: achromatic100,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
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
