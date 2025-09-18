// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tm8l/app/constants/constants.dart';
import 'package:tm8l/app/constants/fonts.dart';
import 'package:tm8l/app/constants/palette.dart';
import 'package:tm8l/app/constants/routing_names.dart';
import 'package:tm8l/gen/assets.gen.dart';
import 'dart:js' as js;

class LandingPageFooterWidget extends StatelessWidget {
  const LandingPageFooterWidget({
    super.key,
    required this.maxWidth,
    required this.isSmallScreen,
    required this.onPressed,
  });

  final double maxWidth;
  final bool isSmallScreen;
  final Function(int) onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 32 : 112),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: maxWidth,
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  runSpacing: 12,
                  children: [
                    if (!isSmallScreen)
                      SvgPicture.asset(Assets.images.logo.path),
                    Wrap(
                      spacing: 32,
                      alignment: WrapAlignment.spaceEvenly,
                      runSpacing: 12,
                      children: [
                        InkWell(
                          onTap: () {
                            onPressed(0);
                          },
                          child: Text(
                            'Home',
                            style: footerAction.copyWith(color: achromatic200),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            onPressed(1);
                          },
                          child: Text(
                            'About',
                            style: footerAction.copyWith(color: achromatic200),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            onPressed(2);
                          },
                          child: Text(
                            'Contact',
                            style: footerAction.copyWith(color: achromatic200),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            context.beamToNamed(termsOfService);
                          },
                          child: Text(
                            'Terms & Conditions',
                            style: footerAction.copyWith(color: achromatic200),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            context.beamToNamed(privacyPolicy);
                          },
                          child: Text(
                            'Privacy Policy',
                            style: footerAction.copyWith(color: achromatic200),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              h32,
              Text(
                'Find your ideal teammate.',
                style: heading4Regular.copyWith(
                  color: achromatic200,
                ),
              ),
            ],
          ),
        ),
        h48,
        Container(
          width: maxWidth,
          height: 2,
          color: achromatic500,
        ),
        h48,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 32 : 112),
          child: SizedBox(
            width: maxWidth,
            child: Wrap(
              runSpacing: 12,
              alignment: WrapAlignment.spaceBetween,
              children: [
                Text(
                  'COPYRIGHT © 2024 TM8 GAMING - ALL RIGHTS RESERVED.',
                  style: heading4Regular.copyWith(
                    color: achromatic200,
                  ),
                ),
                Wrap(
                  spacing: 24,
                  runSpacing: 12,
                  alignment: WrapAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        js.context.callMethod(
                          'open',
                          ['https://twitter.com/TM8GAMING'],
                        );
                      },
                      child: Assets.images.xLogo.image(
                        height: 24,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        js.context.callMethod(
                          'open',
                          ['https://www.tiktok.com/@tm8gaming_'],
                        );
                      },
                      child: Assets.images.tikTokLogo.image(
                        height: 24,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        js.context.callMethod(
                          'open',
                          ['https://www.instagram.com/tm8gaming/'],
                        );
                      },
                      child: Assets.images.instagramLogo.image(
                        height: 24,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        js.context.callMethod(
                          'open',
                          ['https://www.facebook.com/TM8Gaming'],
                        );
                      },
                      child: SvgPicture.asset(
                        Assets.images.facebook.path,
                      ),
                    ),
                  ],
                ),
                Text(
                  'THIS SERVICE IS NOT AFFILIATED WITH OR ENDORSED BY EPIC GAMES. INC., OWNER OF FORTNITE®, ROCKET LEAGUE® OR APEX® REGISTERED TRADEMARKS. THIS SERVICE IS NOT AFFILIATED WITH OR ENDORSED BY ACTIVISION. INC.. OWNER OF CALL OF DUTY® REGISTERED TRADEMARK',
                  style: heading4Regular.copyWith(
                    color: achromatic200,
                  ),
                ),
              ],
            ),
          ),
        ),
        h48,
      ],
    );
  }
}
