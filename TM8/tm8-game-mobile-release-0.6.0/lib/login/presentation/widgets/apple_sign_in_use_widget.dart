import 'package:flutter/widgets.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/gen/assets.gen.dart';

class AppleSignInUseWidget extends StatelessWidget {
  const AppleSignInUseWidget({super.key});

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
              'Apple ID already in use ',
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
          'To reset Sign in with Apple:',
          style: body1Regular.copyWith(
            color: achromatic100,
          ),
          textAlign: TextAlign.center,
        ),
        h4,
        Text(
          'Go to iPhone Settings > Apple Id > Sign in & Security > Sing in with Apple > TM8 Mobile > Stop using Apple ID',
          style: body1Regular.copyWith(
            color: achromatic200,
          ),
          textAlign: TextAlign.left,
        ),
        h12,
      ],
    );
  }
}
