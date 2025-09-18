import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tm8_game_admin/app/app_bloc/app_bloc.dart';
import 'package:tm8_game_admin/app/constants/constants.dart';
import 'package:tm8_game_admin/app/constants/fonts.dart';
import 'package:tm8_game_admin/app/constants/palette.dart';
import 'package:tm8_game_admin/app/services/service_locator.dart';
import 'package:tm8_game_admin/app/storage/tm8_game_admin_storage.dart';
import 'package:tm8_game_admin/app/widgets/tm8_alert_dialog_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_main_button_widget.dart';

class Tm8LogoutWidget extends StatelessWidget {
  const Tm8LogoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          sl<Tm8GameAdminStorage>().userName,
          style: body1Regular.copyWith(color: achromatic100),
        ),
        w8,
        InkWell(
          onTap: () {
            tm8PopUpDialogWidget(
              context,
              padding: 20,
              width: 360,
              borderRadius: 24,
              popup: _buildLogoutPopUp(context),
            );
          },
          child: SvgPicture.asset('assets/common/logout.svg'),
        ),
      ],
    );
  }

  Column _buildLogoutPopUp(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Log out?',
              style: heading2Regular.copyWith(
                color: achromatic100,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: SvgPicture.asset(
                'assets/common/close.svg',
              ),
            ),
          ],
        ),
        h16,
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Are you sure you want to log out?',
            style: body1Regular.copyWith(
              color: achromatic200,
            ),
          ),
        ),
        h16,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Tm8MainButtonWidget(
              onPressed: () {
                Navigator.of(context).pop();
              },
              buttonColor: achromatic600,
              text: 'Cancel',
              width: 150,
            ),
            Tm8MainButtonWidget(
              onPressed: () {
                // context.beamBack();
                sl<AppBloc>().add(const AppEvent.logOut());
                Navigator.of(context).pop();
              },
              buttonColor: errorColor,
              text: 'Log out',
              width: 150,
            ),
          ],
        ),
      ],
    );
  }
}
