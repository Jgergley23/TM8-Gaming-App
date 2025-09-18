import 'package:flutter/material.dart';
import 'package:tm8_game_admin/app/constants/palette.dart';

class Tm8MainContainerWidget extends StatelessWidget {
  const Tm8MainContainerWidget({
    super.key,
    required this.content,
    this.borderRadius = 30,
    this.padding = 16,
    required this.width,
    this.constraints,
  });

  final Widget content;
  final double borderRadius;
  final double padding;
  final double width;
  final BoxConstraints? constraints;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: achromatic800,
      ),
      constraints: constraints,
      child: content,
    );
  }
}
