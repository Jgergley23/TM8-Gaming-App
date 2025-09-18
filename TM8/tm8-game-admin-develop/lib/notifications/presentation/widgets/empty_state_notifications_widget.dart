import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:tm8_game_admin/app/constants/constants.dart';
import 'package:tm8_game_admin/app/constants/fonts.dart';
import 'package:tm8_game_admin/app/constants/palette.dart';
import 'package:tm8_game_admin/app/constants/routing_names.dart';
import 'package:tm8_game_admin/app/widgets/tm8_main_button_widget.dart';
import 'package:tm8_game_admin/gen/assets.gen.dart';

class EmptyStateNotificationsWidget extends StatelessWidget {
  const EmptyStateNotificationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(
        top: height / 3,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'There are no notifications to show yet.\n'
            'All custom notifications will appear here.',
            style: body1Regular.copyWith(color: achromatic200),
            textAlign: TextAlign.center,
          ),
          h10,
          Tm8MainButtonWidget(
            onPressed: () {
              context.beamToNamed(notificationAdd);
            },
            buttonColor: primaryTeal,
            text: 'Create notification',
            assetColor: achromatic100,
            asset: Assets.common.plus.path,
            width: 170,
          ),
        ],
      ),
    );
  }
}
