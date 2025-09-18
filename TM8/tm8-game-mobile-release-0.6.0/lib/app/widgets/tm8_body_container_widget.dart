import 'package:flutter/material.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/gen/assets.gen.dart';

class Tm8BodyContainerWidget extends StatelessWidget {
  const Tm8BodyContainerWidget({
    super.key,
    required this.child,
  });

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.common.background.path),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          left: -61,
          top: -54,
          child: Container(
            width: 225,
            height: 212,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 144,
                  color: ellipseColor,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: -106,
          bottom: -70,
          child: Container(
            width: 291,
            height: 274,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 144,
                  color: ellipseColor,
                ),
              ],
            ),
          ),
        ),

        // ignore: avoid_unnecessary_containers
        Container(
          // color: backgroundColorOpacity,
          child: Center(
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  child: child,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
