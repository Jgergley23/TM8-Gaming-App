import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/widgets/tm8_main_button_widget.dart';

class Tm8LogoutDialogWidget extends StatelessWidget {
  const Tm8LogoutDialogWidget({
    super.key,
    required this.onLogoutTap,
  });

  final VoidCallback onLogoutTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Log out',
              style: heading4Regular.copyWith(
                color: achromatic100,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: SvgPicture.asset('assets/common/x.svg'),
            ),
          ],
        ),
        h12,
        Text(
          'Are you sure you want to log out?',
          style: body1Regular.copyWith(
            color: achromatic200,
          ),
          textAlign: TextAlign.left,
        ),
        h12,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Tm8MainButtonWidget(
              onTap: () {
                Navigator.of(context).pop();
              },
              buttonColor: achromatic500,
              text: 'Stay logged in',
            ),
            Tm8MainButtonWidget(
              onTap: onLogoutTap,
              buttonColor: errorColor,
              text: 'Log out',
            ),
          ],
        ),
      ],
    );
  }
}
