import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/widgets/tm8_main_button_widget.dart';

class Tm8FeedbackWidget extends StatefulWidget {
  const Tm8FeedbackWidget({
    super.key,
    required this.onSkipTap,
    required this.onSubmitTap,
  });

  final VoidCallback onSkipTap;
  final Function(double) onSubmitTap;

  @override
  State<Tm8FeedbackWidget> createState() => _Tm8FeedbackWidgetState();
}

class _Tm8FeedbackWidgetState extends State<Tm8FeedbackWidget> {
  double mainRating = 0;
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
              'Your feedback',
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
          'Rate your gaming experience with this user. How good of a match was this user for you?',
          style: body1Regular.copyWith(
            color: achromatic200,
          ),
          textAlign: TextAlign.left,
        ),
        h12,
        RatingBar.builder(
          initialRating: 0,
          minRating: 0,
          direction: Axis.horizontal,
          allowHalfRating: false,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(horizontal: 12),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: achromatic100,
          ),
          onRatingUpdate: (rating) {
            logInfo(rating);
            setState(() {
              mainRating = rating;
            });
          },
        ),
        h12,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Tm8MainButtonWidget(
              onTap: widget.onSkipTap,
              buttonColor: achromatic500,
              text: 'Skip',
              width: 130,
            ),
            Tm8MainButtonWidget(
              onTap: () {
                if (mainRating == 0.0) return;
                widget.onSubmitTap(mainRating);
              },
              buttonColor: mainRating == 0.0 ? achromatic600 : primaryTeal,
              text: 'Submit',
              textColor: mainRating == 0.0 ? achromatic400 : achromatic100,
              width: 130,
            ),
          ],
        ),
      ],
    );
  }
}
