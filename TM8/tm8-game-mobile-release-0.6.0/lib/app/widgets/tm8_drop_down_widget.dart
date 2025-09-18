import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/gen/assets.gen.dart';
import 'package:tm8/onboarding_preferences/presentation/logic/unfocus_drop_down_cubit/unfocus_drop_down_cubit.dart';

class Tm8DropDownWidget extends StatefulWidget {
  const Tm8DropDownWidget({
    super.key,
    required this.categories,
    required this.dropDownSelection,
    required this.followerAlignment,
    this.mainText,
    this.selected,
    this.width,
    this.hintText,
    required this.selectedItem,
  });

  final List<String> categories;
  final Function(String) dropDownSelection;
  final Alignment followerAlignment;
  final String selectedItem;
  final String? mainText;
  final String? hintText;
  final bool? selected;
  final double? width;

  @override
  State<Tm8DropDownWidget> createState() => _Tm8DropDownWidgetState();
}

class _Tm8DropDownWidgetState extends State<Tm8DropDownWidget> {
  late FocusNode focusNode;
  late String selectedCategory;
  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    final selectedItemIndex = widget.categories.indexOf(widget.selectedItem);
    if (widget.hintText != null && selectedItemIndex == -1) {
      selectedCategory = '';
    } else {
      if (selectedItemIndex != -1) {
        selectedCategory = widget.categories[selectedItemIndex];
      } else {
        selectedCategory = '';
      }
    }
    focusNode.addListener(() {
      logInfo(
        'Focus updated dropDown: hasFocus: ${focusNode.hasFocus}',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocListener<UnfocusDropDownCubit, bool>(
      listener: (context, state) {
        if (focusNode.hasFocus) {
          setState(() {
            focusNode.unfocus();
          });
        }
      },
      child: PortalTarget(
        visible: focusNode.hasFocus,
        portalFollower: Column(
          children: [
            if (widget.followerAlignment != Alignment.topCenter) ...[
              SizedBox(
                height: height * 0.18,
              ),
            ],
            Padding(
              padding: screenPadding,
              child: Container(
                height: 200,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: achromatic800,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [overlayShadow],
                ),
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 40,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = widget.categories[index];
                            widget.dropDownSelection(widget.categories[index]);
                            focusNode.unfocus();
                          });
                        },
                        child: Text(
                          widget.categories[index],
                          style: body1Regular.copyWith(color: achromatic200),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return h8;
                  },
                  itemCount: widget.categories.length,
                ),
              ),
            ),
          ],
        ),
        anchor: Aligned(
          follower: widget.followerAlignment,
          target: Alignment.bottomCenter,
        ),
        child: GestureDetector(
          onTap: () {
            if (focusNode.hasFocus) {
              focusNode.unfocus();
            } else {
              focusNode.requestFocus();
            }
            setState(() {});
          },
          child: Focus(
            focusNode: focusNode,
            child: Container(
              width: widget.width,
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color:
                    focusNode.hasFocus == true ? achromatic400 : achromatic500,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 2,
                  color: achromatic500,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.mainText != null) ...[
                    Text(
                      widget.mainText! + selectedCategory,
                      style: body1Regular.copyWith(color: achromatic100),
                    ),
                  ] else
                    Text(
                      selectedCategory == ''
                          ? widget.hintText!
                          : selectedCategory,
                      style: body1Regular.copyWith(
                        color: selectedCategory == ''
                            ? achromatic300
                            : achromatic100,
                      ),
                    ),
                  SvgPicture.asset(
                    focusNode.hasFocus
                        ? Assets.common.dropDownUp.path
                        : Assets.common.dropDownDown.path,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
