import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/gen/assets.gen.dart';

class Tm8SelectGameWidget extends StatefulWidget {
  const Tm8SelectGameWidget({
    super.key,
    required this.onTap,
    required this.assetImage,
    required this.assetIcon,
    required this.gameName,
  });

  final String assetImage;
  final String assetIcon;
  final String gameName;
  final VoidCallback onTap;

  @override
  State<Tm8SelectGameWidget> createState() => _Tm8SelectGameWidgetState();
}

class _Tm8SelectGameWidgetState extends State<Tm8SelectGameWidget> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
        });
        widget.onTap();
      },
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: selected ? 2 : 0,
            color: selected ? primaryTealText : Colors.transparent,
          ),
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
                    if (selected)
                      SvgPicture.asset(
                        Assets.common.gamePreferencesSelected.path,
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
