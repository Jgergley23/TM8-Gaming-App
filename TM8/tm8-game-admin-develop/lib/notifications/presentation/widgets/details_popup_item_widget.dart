import 'package:flutter/material.dart';
import 'package:tm8_game_admin/app/constants/fonts.dart';
import 'package:tm8_game_admin/app/constants/palette.dart';

class DetailsPupUpItemWidget extends StatelessWidget {
  const DetailsPupUpItemWidget({
    super.key,
    required this.name,
    required this.value,
  });
  final String name;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: body1Regular.copyWith(color: achromatic100),
        ),
        Text(
          value,
          style: body2Regular.copyWith(color: achromatic300),
        ),
      ],
    );
  }
}
