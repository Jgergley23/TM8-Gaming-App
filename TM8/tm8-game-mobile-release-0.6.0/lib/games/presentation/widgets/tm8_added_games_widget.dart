import 'package:flutter/material.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/gen/assets.gen.dart';

class Tm8AddedGamesWidget extends StatefulWidget {
  const Tm8AddedGamesWidget({
    super.key,
    required this.onTapMain,
    required this.onTap,
    required this.assetImage,
    required this.assetIcon,
    required this.gameName,
  });

  final String assetImage;
  final String assetIcon;
  final String gameName;
  final VoidCallback onTap;
  final VoidCallback onTapMain;

  @override
  State<Tm8AddedGamesWidget> createState() => _Tm8AddedGamesWidgetState();
}

class _Tm8AddedGamesWidgetState extends State<Tm8AddedGamesWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTapMain,
      child: Container(
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                widget.assetImage,
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 73,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: gameTextShadowColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          widget.assetIcon,
                          height: 24,
                          width: 24,
                        ),
                        w8,
                        Text(
                          widget.gameName,
                          style: body1Bold.copyWith(color: achromatic100),
                        ),
                      ],
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: widget.onTap,
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              Assets.common.hamburger.path,
                              height: 24,
                              width: 24,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
