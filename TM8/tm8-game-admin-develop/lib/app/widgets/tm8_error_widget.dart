import 'package:flutter/material.dart';
import 'package:tm8_game_admin/app/constants/constants.dart';
import 'package:tm8_game_admin/app/constants/fonts.dart';
import 'package:tm8_game_admin/app/constants/palette.dart';
import 'package:tm8_game_admin/app/widgets/tm8_main_button_widget.dart';

class Tm8ErrorWidget extends StatelessWidget {
  const Tm8ErrorWidget({
    super.key,
    required this.onTapRetry,
    this.error,
  });

  final VoidCallback onTapRetry;
  final String? error;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          error != null ? error! : 'Something went wrong, please try again!',
          style: body1Regular.copyWith(color: errorTextColor),
        ),
        h10,
        Tm8MainButtonWidget(
          onPressed: onTapRetry,
          buttonColor: primaryTeal,
          text: 'Refresh',
        ),
      ],
    );
  }
}
