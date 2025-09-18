import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:tm8_game_admin/app/constants/palette.dart';

class Tm8LoadingOverlayWidget extends StatelessWidget {
  const Tm8LoadingOverlayWidget({
    super.key,
    this.progress,
  });

  final double? progress;

  @override
  Widget build(BuildContext context) {
    return BlurryContainer(
      height: double.infinity,
      width: double.infinity,
      color: overlayColor,
      blur: 4,
      child: Center(
        child: SizedBox(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(
            value: progress,
            valueColor: AlwaysStoppedAnimation<Color>(achromatic200),
          ),
        ),
      ),
    );
  }
}
