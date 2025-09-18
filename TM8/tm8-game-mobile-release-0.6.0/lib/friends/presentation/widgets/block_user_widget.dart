import 'package:flutter/material.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/widgets/tm8_main_button_widget.dart';
import 'package:tm8/gen/assets.gen.dart';

class BlockUserWidget extends StatelessWidget {
  const BlockUserWidget({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Block User',
              style: heading4Regular.copyWith(
                color: achromatic100,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Assets.common.x.svg(),
            ),
          ],
        ),
        h18,
        Text(
          'Are you sure you want to block this user? This user won’t be able to message you any more. If you change your mind, you can always undo this action.',
          style: body1Regular.copyWith(
            color: achromatic200,
          ),
          textAlign: TextAlign.left,
        ),
        h12,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Tm8MainButtonWidget(
              onTap: () async {
                Navigator.of(context).pop();
              },
              buttonColor: achromatic500,
              text: 'Cancel',
              width: 130,
            ),
            w12,
            Tm8MainButtonWidget(
              onTap: () {
                onTap();
                Navigator.of(context).pop();
              },
              buttonColor: errorTextColor,
              text: 'Block',
              width: 130,
            ),
          ],
        ),
      ],
    );
  }
}
