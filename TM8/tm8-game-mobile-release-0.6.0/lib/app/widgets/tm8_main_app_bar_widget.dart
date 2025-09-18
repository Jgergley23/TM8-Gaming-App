import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/gen/assets.gen.dart';

class Tm8MainAppBarWidget extends StatelessWidget {
  const Tm8MainAppBarWidget({
    super.key,
    this.title,
    this.leading,
    this.action,
    this.actionIcon,
    this.onActionPressed,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.spaceBetween,
  });

  final String? title;
  final bool? leading;
  final bool? action;
  final String? actionIcon;
  final VoidCallback? onActionPressed;
  final MainAxisAlignment mainAxisAlignment;
  final bool? spaceBetween;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).viewPadding.top;
    return Padding(
      padding: EdgeInsets.only(top: height),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          if (leading != null) ...[
            GestureDetector(
              onTap: () {
                context.maybePop();
              },
              child: Container(
                height: 32,
                width: 32,
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: achromatic500,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    Assets.common.navigationBackArrow.path,
                  ),
                ),
              ),
            ),
          ],
          Text(
            title ?? '',
            style: heading4Regular.copyWith(
              color: achromatic200,
            ),
          ),
          if (action != null) ...[
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: GestureDetector(
                onTap: onActionPressed,
                child: Container(
                  height: 32,
                  width: 32,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: achromatic500,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      actionIcon ?? '',
                    ),
                  ),
                ),
              ),
            ),
          ],
          if (spaceBetween != null) ...[
            const SizedBox(
              width: 32,
            ),
          ],
        ],
      ),
    );
  }
}
