import 'package:flutter/widgets.dart';
import 'package:tm8_game_admin/app/constants/fonts.dart';
import 'package:tm8_game_admin/app/constants/palette.dart';

class FilterEmptyResultWidget extends StatelessWidget {
  const FilterEmptyResultWidget({
    super.key,
    required this.message,
  });
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          message,
          style: body1Regular.copyWith(
            color: achromatic200,
          ),
        ),
      ],
    );
  }
}
