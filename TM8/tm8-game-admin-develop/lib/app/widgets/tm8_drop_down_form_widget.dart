import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8_game_admin/app/constants/constants.dart';
import 'package:tm8_game_admin/app/constants/fonts.dart';
import 'package:tm8_game_admin/app/constants/palette.dart';
import 'package:tm8_game_admin/gen/assets.gen.dart';
import 'package:tm8_game_admin/manage_users/presentation/logic/unfocus_drop_down_cubit/unfocus_drop_down_cubit.dart';

class Tm8DropDownFormWidget extends StatefulWidget {
  const Tm8DropDownFormWidget({
    super.key,
    required this.mainCategory,
    required this.categories,
    required this.dropDownSelection,
    this.mainText,
    this.selected,
    this.width = 270,
    required this.selectedItem,
    required this.followerAlignment,
    this.isScrollable,
    this.failedValidation,
    this.hintText,
    this.dropDownHeight,
    this.constraints,
    required this.itemKeys,
    this.failedValidationText,
    this.scrollableHeight,
    this.assetImage,
    this.onTap,
  });

  final String mainCategory;
  final List<String> categories;
  final Function(String) dropDownSelection;
  final String? mainText;
  final bool? selected;
  final double width;
  final String selectedItem;
  final Alignment followerAlignment;
  final bool? isScrollable;
  final bool? failedValidation;
  final String? hintText;
  final double? dropDownHeight;
  final BoxConstraints? constraints;
  final List<String> itemKeys;
  final String? failedValidationText;
  final double? scrollableHeight;
  final String? assetImage;
  final VoidCallback? onTap;

  @override
  State<Tm8DropDownFormWidget> createState() => _Tm8DropDownFormWidgetState();
}

class _Tm8DropDownFormWidgetState extends State<Tm8DropDownFormWidget> {
  late String selectedCategory;
  late FocusNode focusNode;

  @override
  void initState() {
    focusNode = FocusNode();
    final selectedItemIndex = widget.itemKeys.indexOf(widget.selectedItem);
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
        'Focus updated ${widget.mainCategory}: hasFocus: ${focusNode.hasFocus}',
      );
    });
    super.initState();
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
            if (widget.followerAlignment == Alignment.topCenter) h8,
            if (widget.followerAlignment == Alignment.center)
              SizedBox(
                height: height < 750 ? height * 0.12 : height * 0.22,
              ),
            Container(
              width: widget.width,
              height: widget.isScrollable != null
                  ? widget.scrollableHeight ?? 160
                  : 40 + (widget.categories.length * 45),
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
                  if (widget.selected != null &&
                      selectedCategory == widget.categories[index]) {
                    return SizedBox(
                      height: widget.dropDownHeight ?? 40,
                      child: InkWell(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        onTap: () {
                          setState(() {
                            if (selectedCategory != widget.categories[index]) {
                              selectedCategory = widget.categories[index];
                              widget
                                  .dropDownSelection(widget.categories[index]);
                            } else {
                              if (widget.hintText == null) {
                                final selectedItemIndex = widget.itemKeys
                                    .indexOf(widget.selectedItem);
                                if (selectedItemIndex != -1) {
                                  selectedCategory =
                                      widget.categories[selectedItemIndex];
                                  widget.dropDownSelection(
                                    widget.categories[selectedItemIndex],
                                  );
                                } else {
                                  selectedCategory = '';
                                  widget.dropDownSelection('');
                                }
                              } else {
                                selectedCategory = '';
                                widget.dropDownSelection('');
                              }
                            }
                            focusNode.unfocus();
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.categories[index],
                              style:
                                  body1Regular.copyWith(color: achromatic200),
                            ),
                            SvgPicture.asset(
                              'assets/common/check_selected.svg',
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return SizedBox(
                      height: widget.dropDownHeight ?? 40,
                      child: InkWell(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        onTap: () {
                          setState(() {
                            if (selectedCategory != widget.categories[index]) {
                              selectedCategory = widget.categories[index];
                              widget
                                  .dropDownSelection(widget.categories[index]);
                            } else {
                              if (widget.hintText == null) {
                                final selectedItemIndex = widget.itemKeys
                                    .indexOf(widget.selectedItem);
                                if (selectedItemIndex != -1) {
                                  selectedCategory =
                                      widget.categories[selectedItemIndex];
                                  widget.dropDownSelection(
                                    widget.categories[selectedItemIndex],
                                  );
                                } else {
                                  selectedCategory = '';
                                  widget.dropDownSelection('');
                                }
                              } else {
                                selectedCategory = '';
                                widget.dropDownSelection('');
                              }
                            }

                            focusNode.unfocus();
                          });
                        },
                        child: Row(
                          children: [
                            Text(
                              widget.categories[index],
                              style:
                                  body1Regular.copyWith(color: achromatic200),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
                separatorBuilder: (context, index) {
                  return h8;
                },
                itemCount: widget.categories.length,
              ),
            ),
          ],
        ),
        anchor: Aligned(
          follower: widget.followerAlignment,
          target: Alignment.bottomCenter,
        ),
        child: InkWell(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          onTap: () {
            context.read<UnfocusDropDownCubit>().unfocus();
            Future.delayed(const Duration(milliseconds: 100), () {
              if (focusNode.hasFocus) {
                focusNode.unfocus();
              } else {
                focusNode.requestFocus();
              }
              setState(() {});
            });
            if (widget.onTap != null) {
              widget.onTap!();
            }
          },
          child: Focus(
            focusNode: focusNode,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: widget.width,
                  height: widget.dropDownHeight ?? 40,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  constraints: widget.constraints,
                  decoration: BoxDecoration(
                    color: focusNode.hasFocus == true
                        ? achromatic500
                        : achromatic600,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 2,
                      color: widget.failedValidation != null &&
                              widget.failedValidation == true
                          ? errorColor
                          : focusNode.hasFocus
                              ? achromatic500
                              : achromatic600,
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
                          selectedCategory.isEmpty
                              ? widget.hintText!
                              : selectedCategory,
                          style: body1Regular.copyWith(
                            color: selectedCategory.isEmpty
                                ? achromatic200
                                : achromatic100,
                          ),
                        ),
                      SvgPicture.asset(
                        focusNode.hasFocus
                            ? widget.assetImage ?? Assets.common.dropDownUp.path
                            : widget.assetImage ??
                                Assets.common.dropDownDown.path,
                      ),
                    ],
                  ),
                ),
                if (widget.failedValidation != null &&
                    widget.failedValidation == true) ...[
                  h8,
                  Text(
                    widget.failedValidationText ?? 'Please select a category',
                    style: body2Regular.copyWith(color: errorTextColor),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
