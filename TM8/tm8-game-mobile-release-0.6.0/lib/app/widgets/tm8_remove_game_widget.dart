import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/widgets/tm8_main_button_widget.dart';

class Tm8RemoveGameWidget extends StatelessWidget {
  const Tm8RemoveGameWidget({
    super.key,
    required this.onRemoveTap,
  });

  final VoidCallback onRemoveTap;

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
              'Remove this game?',
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
          'Are you sure you want to remove this game and all preferences you set? You won’t be able to matchmake in this game any more. If you change your mind you can add this game again later. ',
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
              text: 'Cancel',
            ),
            Tm8MainButtonWidget(
              onTap: onRemoveTap,
              buttonColor: errorColor,
              text: 'Remove',
            ),
          ],
        ),
      ],
    );
  }
}
