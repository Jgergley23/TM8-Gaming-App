import 'package:flutter/material.dart';
import 'package:tm8_game_admin/app/constants/fonts.dart';
import 'package:tm8_game_admin/app/constants/palette.dart';

class Tm8NoDataWidget extends StatelessWidget {
  const Tm8NoDataWidget({super.key, required this.message});

  final String message;
  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: body1Regular.copyWith(
        color: achromatic200,
      ),
    );
  }
}
