import 'package:flutter/material.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/palette.dart';

Future<Object?> tm8PopUpDialogWidget(
  BuildContext context, {
  required Widget Function(BuildContext context) popup,
  required double padding,
  required double width,
  required double borderRadius,
  bool? barrierDismissible,
}) {
  return showDialog(
    context: context,
    useRootNavigator: true,
    barrierDismissible: barrierDismissible ?? true,
    barrierLabel: '',
    builder: (BuildContext context) {
      return Center(
        child: Container(
          width: width,
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            color: achromatic700,
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            boxShadow: [overlayShadow],
          ),
          child: Material(
            color: Colors.transparent,
            child: popup(context),
          ),
        ),
      );
    },
  );
}
