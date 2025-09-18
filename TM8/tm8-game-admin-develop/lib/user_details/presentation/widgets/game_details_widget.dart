import 'package:flutter/widgets.dart';
import 'package:tm8_game_admin/app/constants/fonts.dart';
import 'package:tm8_game_admin/app/constants/palette.dart';

class GameDetailsWidget extends StatelessWidget {
  const GameDetailsWidget({
    super.key,
    required this.category,
    required this.value,
  });

  final String category;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category,
            style: body1Regular.copyWith(color: achromatic100),
          ),
          Text(
            value,
            style: body1Regular.copyWith(color: achromatic200),
          ),
        ],
      ),
    );
  }
}
