import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8_game_admin/app/constants/constants.dart';
import 'package:tm8_game_admin/app/constants/fonts.dart';
import 'package:tm8_game_admin/app/constants/palette.dart';
import 'package:tm8_game_admin/app/widgets/tm8_date_picker_widget.dart';
import 'package:tm8_game_admin/gen/assets.gen.dart';
import 'package:tm8_game_admin/manage_users/presentation/logic/unfocus_drop_down_cubit/unfocus_drop_down_cubit.dart';

class Tm8DatePickerPortalWidget extends StatefulWidget {
  const Tm8DatePickerPortalWidget({
    super.key,
    this.width = 270,
    required this.followerAlignment,
    this.failedValidation,
    required this.hintText,
    this.dropDownHeight,
    this.constraints,
    required this.selectedDate,
    this.initialDate,
  });
  final double width;
  final Alignment followerAlignment;
  final bool? failedValidation;
  final String hintText;
  final double? dropDownHeight;
  final BoxConstraints? constraints;
  final Function(DateTime) selectedDate;
  final DateTime? initialDate;

  @override
  State<Tm8DatePickerPortalWidget> createState() =>
      _Tm8DatePickerPortalWidgetState();
}

class _Tm8DatePickerPortalWidgetState extends State<Tm8DatePickerPortalWidget> {
  String? selectedCategory;
  DateTime? selectedDate;
  late FocusNode focusNode;
  final now = DateTime.now();

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    if (widget.initialDate != null) {
      selectedDate = widget.initialDate!;
      selectedCategory = DateFormat('dd/MM/yyyy').format(selectedDate!);
    }

    focusNode.addListener(() {
      logInfo(
        'Focus updated ${widget.hintText}: hasFocus: ${focusNode.hasFocus}',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
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
        portalFollower: Tm8DatePickerWidget(
          onDay: (day) {
            setState(() {
              widget.selectedDate(day);
              selectedDate = day;
              selectedCategory = DateFormat('dd/MM/yyyy').format(day);
            });
            focusNode.unfocus();
          },
          maxSelectedDate: DateTime(2026),
          minSelectedDate: DateTime(now.year, now.month, now.day - 1, 23, 59),
          selectedDate: selectedDate,
        ),
        anchor: Aligned(
          follower: widget.followerAlignment,
          target: Alignment.bottomLeft,
        ),
        child: InkWell(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Set date (optional)',
                  style: body1Regular.copyWith(color: achromatic200),
                ),
                h4,
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
                      Text(
                        selectedCategory ?? widget.hintText,
                        style: body1Regular.copyWith(
                          color: selectedCategory == null
                              ? achromatic200
                              : achromatic100,
                        ),
                      ),
                      SvgPicture.asset(
                        Assets.common.datePicker.path,
                      ),
                    ],
                  ),
                ),
                if (widget.failedValidation != null &&
                    widget.failedValidation == true) ...[
                  h8,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Please select date',
                      style: body2Regular.copyWith(color: errorTextColor),
                    ),
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
