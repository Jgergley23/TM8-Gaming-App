import 'package:flutter/material.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/friends/presentation/logic/friend_details_bottom_sheet_logic_cubit/friend_details_bottom_sheet_logic_cubit.dart';

tm8BottomSheetFriendDetailsWidget(
  BuildContext mainContext, {
  required Function(String) onTap,
  required BottomSheetItems items,
}) {
  return showModalBottomSheet(
    context: mainContext,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    backgroundColor: achromatic700,
    builder: (mainContext) {
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
            for (var i = 0; i < items.items.length; i++) ...[
              _buildModalRow(
                items.assets,
                items.items,
                i,
                onTap,
                items.colors,
              ),
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
  Function(String) onTap,
  List<Color> colors,
) {
  return GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () {
      onTap(item[index]);
    },
    child: SizedBox(
      height: 40,
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
