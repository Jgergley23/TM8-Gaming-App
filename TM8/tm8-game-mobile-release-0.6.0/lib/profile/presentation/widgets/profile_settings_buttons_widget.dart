import 'package:flutter/material.dart';
import 'package:tm8/app/constants/palette.dart';

class ProfileSettingsButtonsWidget extends StatelessWidget {
  const ProfileSettingsButtonsWidget({super.key, required this.asset});

  final Widget asset;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: achromatic500,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: asset,
      ),
    );
  }
}
