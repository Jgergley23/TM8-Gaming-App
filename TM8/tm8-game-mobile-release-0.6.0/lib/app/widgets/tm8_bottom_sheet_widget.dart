import 'package:flutter/material.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';

tm8BottomSheetWidget(
  BuildContext context, {
  required Function(int) onTap,
  required List<String> item,
  required List<Widget> assetIcon,
  required List<Color> colors,
}) {
  return showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    backgroundColor: achromatic700,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 4,
                width: 67,
                decoration: BoxDecoration(
                  color: achromatic200,
                  borderRadius: BorderRadius.circular(17),
                ),
              ),
            ),
            h8,
            for (var i = 0; i < item.length; i++) ...[
              _buildModalRow(assetIcon, item, i, onTap, colors, context),
              h8,
            ],
          ],
        ),
      );
    },
  );
}

Widget _buildModalRow(
  List<Widget> assetIcon,
  List<String> item,
  int index,
  Function(int) onTap,
  List<Color> colors,
  BuildContext context,
) {
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () {
      onTap(index);
    },
    child: SizedBox(
      height: 40,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          assetIcon[index],
          w8,
          Text(
            item[index],
            style: body1Regular.copyWith(color: colors[index]),
          ),
        ],
      ),
    ),
  );
}
