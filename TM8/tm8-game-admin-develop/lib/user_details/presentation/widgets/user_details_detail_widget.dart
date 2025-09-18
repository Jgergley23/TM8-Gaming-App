import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tm8_game_admin/app/constants/constants.dart';
import 'package:tm8_game_admin/app/constants/fonts.dart';
import 'package:tm8_game_admin/app/constants/palette.dart';

class UserDetailsDetailWidget extends StatelessWidget {
  const UserDetailsDetailWidget({
    super.key,
    required this.asset,
    required this.category,
    required this.value,
  });

  final String asset;
  final String category;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(asset),
              h16,
            ],
          ),
          w8,
          Column(
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
        ],
      ),
    );
  }
}
