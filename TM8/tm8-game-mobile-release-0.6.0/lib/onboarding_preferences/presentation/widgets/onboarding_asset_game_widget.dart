import 'package:flutter/material.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';

class OnboardingAssetGameWidget extends StatelessWidget {
  const OnboardingAssetGameWidget({
    super.key,
    required this.assetImage,
    required this.gameName,
  });

  final String assetImage;
  final String gameName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          assetImage,
          height: 64,
          width: 64,
        ),
        h8,
        Text(
          gameName,
          style: heading4Regular.copyWith(
            color: achromatic100,
          ),
        ),
      ],
    );
  }
}
