import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/gen/assets.gen.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

class Tm8GamePreferencesWidget extends StatefulWidget {
  const Tm8GamePreferencesWidget({
    super.key,
    required this.selected,
    required this.mainPreference,
    required this.choice,
    required this.choices,
    this.selectedPreference,
    required this.cascadeSelected,
    this.cascadeSelectedPreference,
  });

  final String mainPreference;
  final List<String>? selectedPreference;
  final List<String>? cascadeSelectedPreference;
  final GamePreferenceInputResponseType choice;
  final List<SelectOptionResponse> choices;
  final Function(SelectOptionResponseAttribute) selected;
  final Function(SelectOptionResponseAttribute) cascadeSelected;
  @override
  State<Tm8GamePreferencesWidget> createState() =>
      _Tm8GamePreferencesWidgetState();
}

// widget that displays the game preferences either added or not added
//
class _Tm8GamePreferencesWidgetState extends State<Tm8GamePreferencesWidget> {
  int selected = 0;
  List<bool> isSelected = [];
  List<bool> cascadeIsSelected = [];
  bool cascade = false;
  int cascadeIndex = 0;

  @override
  void initState() {
    super.initState();
    // logic if the preferences are selected or not
    // meaning if it is edit or add screen
    // if it is edit screen, the selected preferences will be displayed
    if (widget.selectedPreference != null) {
      if (widget.selectedPreference?.length == 1) {
        final index = widget.choices.indexWhere(
          (element) => element.display == widget.selectedPreference?.first,
        );
        isSelected = List<bool>.filled(widget.choices.length, false);
        if (index != -1) {
          isSelected[index] = true;
        }
      } else {
        final indexes = <int>[];
        for (final item in widget.selectedPreference!) {
          indexes.add(
            widget.choices.indexWhere(
              (element) => element.display == item,
            ),
          );
        }
        isSelected = List<bool>.filled(widget.choices.length, false);
        for (final index in indexes) {
          if (index != -1) {
            isSelected[index] = true;
          }
        }
      }
    } else {
      isSelected = List<bool>.filled(widget.choices.length, false);
    }
    // logic if the cascade preferences are selected or not
    // if cascade preferences exists then it looks for the selected preferences
    // cascade means selection opens another selection
    if (widget.cascadeSelectedPreference != null) {
      if (widget.cascadeSelectedPreference!.isNotEmpty) {
        final element = widget.choices.where(
          (element) => element.cascade != null,
        );

        cascadeIndex = 3;

        if (element.isNotEmpty) {
          final optionsLen = element.first.cascade!.selectOptions!.length;
          cascadeIsSelected = List<bool>.filled(
            optionsLen,
            false,
          );
          for (final item in element.first.cascade!.selectOptions!) {
            final index =
                item.display == widget.cascadeSelectedPreference?.first
                    ? element.first.cascade!.selectOptions!.indexOf(item)
                    : -1;
            if (index != -1) {
              cascadeIsSelected[index] = true;
            }
          }
          cascade = true;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.mainPreference,
              style: heading4Regular.copyWith(
                color: achromatic100,
              ),
            ),
            if (widget.choice == GamePreferenceInputResponseType.select) ...[
              Text(
                '${isSelected.where((element) => element == true).length}/1',
                style: body1Regular.copyWith(
                  color: achromatic200,
                ),
              ),
            ] else
              Text(
                '${isSelected.where((element) => element == true).length}/${widget.choices.length}',
                style: body1Regular.copyWith(
                  color: achromatic200,
                ),
              ),
          ],
        ),
        h13,
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.start,
            children: [
              for (var i = 0; i < widget.choices.length; i++)
                preferencesContainer(i, isSelected[i]),
            ],
          ),
        ),
        if (cascade) _buildCascadeItem(context),
      ],
    );
  }

  Column _buildCascadeItem(BuildContext context) {
    return Column(
      children: [
        h12,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.choices[cascadeIndex].cascade!.title,
              style: heading4Regular.copyWith(
                color: achromatic100,
              ),
            ),
            if (widget.choice == GamePreferenceInputResponseType.select) ...[
              Text(
                '${cascadeIsSelected.where((element) => element == true).length}/1',
                style: body1Regular.copyWith(
                  color: achromatic200,
                ),
              ),
            ] else
              Text(
                '${cascadeIsSelected.where((element) => element == true).length}/${widget.choices[cascadeIndex].cascade!.selectOptions!.length}',
                style: body1Regular.copyWith(
                  color: achromatic200,
                ),
              ),
          ],
        ),
        h13,
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.start,
            children: [
              for (var i = 0;
                  i <
                      widget
                          .choices[cascadeIndex].cascade!.selectOptions!.length;
                  i++)
                preferencesCascadeContainer(i, cascadeIsSelected[i]),
            ],
          ),
        ),
      ],
    );
  }

  GestureDetector preferencesCascadeContainer(
    int index,
    bool containerSelected,
  ) {
    return GestureDetector(
      onTap: () {
        if (widget.choice == GamePreferenceInputResponseType.select) {
          setState(() {
            if (cascadeIsSelected[index]) {
              cascadeIsSelected[index] = !cascadeIsSelected[index];
            } else {
              cascadeIsSelected = List<bool>.filled(
                widget.choices[cascadeIndex].cascade?.selectOptions?.length ??
                    0,
                false,
              );
              cascadeIsSelected[index] = !cascadeIsSelected[index];
            }
          });
        } else {
          setState(() {
            cascadeIsSelected[index] = !cascadeIsSelected[index];
          });
        }
        widget.cascadeSelected(
          widget.choices[cascadeIndex].cascade!.selectOptions![index].attribute,
        );
      },
      child: Container(
        height: 32,
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: containerSelected ? primaryTeal : achromatic500,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              widget.choices[cascadeIndex].cascade?.selectOptions?[index]
                      .display ??
                  '',
              style: body1Regular.copyWith(
                color: achromatic100,
              ),
            ),
            if (containerSelected) ...[
              w4,
              SvgPicture.asset(Assets.common.gamePreferencesSelected.path),
            ],
          ],
        ),
      ),
    );
  }

  GestureDetector preferencesContainer(int index, bool containerSelected) {
    return GestureDetector(
      onTap: () {
        if (widget.choice == GamePreferenceInputResponseType.select) {
          setState(() {
            if (isSelected[index]) {
              isSelected[index] = !isSelected[index];
            } else {
              isSelected = List<bool>.filled(widget.choices.length, false);
              isSelected[index] = !isSelected[index];
            }
            if (widget.choices[index].cascade != null) {
              cascade = true;
              cascadeIndex = index;
              cascadeIsSelected = List<bool>.filled(
                widget.choices[index].cascade?.selectOptions?.length ?? 0,
                false,
              );
            } else {
              cascadeIsSelected = [];
              cascade = false;
              cascadeIndex = 0;
            }
          });
        } else {
          setState(() {
            isSelected[index] = !isSelected[index];
            final hasCascade =
                widget.choices.any((element) => element.cascade != null);
            if (hasCascade) {
              if (widget.choices[index].cascade != null) {
                cascade = !cascade;
                cascadeIndex = index;
                cascadeIsSelected = List<bool>.filled(
                  widget.choices[index].cascade?.selectOptions?.length ?? 0,
                  false,
                );
              }
            } else {
              cascadeIsSelected = [];
              cascade = false;
              cascadeIndex = 0;
            }
          });
        }
        widget.selected(widget.choices[index].attribute);
      },
      child: Container(
        height: 32,
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: containerSelected ? primaryTeal : achromatic500,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              widget.choices[index].display,
              style: body1Regular.copyWith(
                color: achromatic100,
              ),
            ),
            if (containerSelected) ...[
              w4,
              SvgPicture.asset(Assets.common.gamePreferencesSelected.path),
            ],
          ],
        ),
      ),
    );
  }
}
