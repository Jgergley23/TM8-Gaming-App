import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/storage/tm8_storage.dart';
import 'package:tm8/app/widgets/tm8_secondary_button_widget.dart';

class Tm8OnlineScheduleWidget extends StatefulWidget {
  const Tm8OnlineScheduleWidget({
    required this.onDateSelected,
    super.key,
    required this.name,
    required this.hintText,
    this.maxLines = 1,
    required this.mode,
    required this.maximumDate,
    this.date,
  });

  final Function(DateTime) onDateSelected;
  final DateTime maximumDate;
  final DateTime? date;
  final String name;
  final String hintText;
  final int maxLines;
  final CupertinoDatePickerMode mode;

  @override
  State<Tm8OnlineScheduleWidget> createState() =>
      _Tm8OnlineScheduleWidgetState();
}

class _Tm8OnlineScheduleWidgetState extends State<Tm8OnlineScheduleWidget> {
  late FocusNode focusNode;
  final now = DateTime.now();
  DateTime? selectedDate;
  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    focusNode.addListener(() {
      setState(() {
        logInfo(
          'Focus updated ${widget.name}: hasFocus: ${focusNode.hasFocus}',
        );
      });
    });
    if (widget.date != null) {
      selectedDate = widget.date;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.date == null) {
      selectedDate = null;
    }
    return FormBuilderField(
      focusNode: focusNode,
      builder: (field) {
        return InputDecorator(
          decoration: InputDecoration(
            hintText: focusNode.hasFocus ? '' : widget.hintText,
            hintMaxLines: 1,
            hintStyle: body1Regular.copyWith(color: achromatic300),
            filled: true,
            contentPadding: const EdgeInsets.only(
              left: 12,
              right: 12,
              top: 2,
              bottom: 2,
            ),
            fillColor:
                focusNode.hasFocus == true ? achromatic400 : achromatic500,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 2,
                color: achromatic500,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 2,
                color: achromatic500,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 2,
                color: errorTextColor,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 2,
                color: errorTextColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 2,
                color: achromatic500,
              ),
            ),
            errorMaxLines: 1,
            errorStyle: body2Regular.copyWith(
              color: errorTextColor,
            ),
            errorText: field.errorText,
          ),
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: achromatic700,
                barrierColor: overlayColor,
                builder: (BuildContext builder) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    color: achromatic700,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Tm8SecondaryButtonWidget(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              textColor: achromatic100,
                              textStyle: body1Bold,
                              text: 'Cancel',
                            ),
                            Tm8SecondaryButtonWidget(
                              onPressed: () {
                                Navigator.of(context).pop();
                                if (selectedDate != null) {
                                  field.didChange(selectedDate.toString());
                                  widget.onDateSelected(selectedDate!);
                                } else {
                                  final time = DateTime(
                                    now.year,
                                    now.month,
                                    now.day,
                                    now.minute >= 30 ? now.hour + 1 : now.hour,
                                    now.minute >= 30 ? 0 : 30,
                                  );
                                  selectedDate = time;
                                  field.didChange(
                                    selectedDate.toString(),
                                  );

                                  widget.onDateSelected(
                                    selectedDate!,
                                  );
                                }
                              },
                              textColor: achromatic100,
                              textStyle: body1Bold,
                              text: 'Done',
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 150,
                          child: CupertinoTheme(
                            data: CupertinoThemeData(
                              textTheme: CupertinoTextThemeData(
                                dateTimePickerTextStyle:
                                    heading4Regular.copyWith(
                                  color: achromatic200,
                                ),
                              ),
                            ),
                            child: CupertinoDatePicker(
                              mode: widget.mode,
                              dateOrder: DatePickerDateOrder.dmy,
                              minuteInterval: 30,
                              use24hFormat:
                                  sl<Tm8Storage>().region == 'north-america'
                                      ? false
                                      : true,
                              initialDateTime: DateTime(
                                now.year,
                                now.month,
                                now.day,
                                now.minute > 30 ? now.hour + 1 : now.hour,
                                now.minute > 30 ? 0 : 30,
                              ),
                              backgroundColor: achromatic700,
                              maximumDate: widget.maximumDate,
                              minimumDate: DateTime(
                                now.year,
                                now.month,
                                now.day,
                                now.minute > 30 ? now.hour + 1 : now.hour,
                                now.minute > 30 ? 0 : 30,
                              ),
                              onDateTimeChanged: (newDate) {
                                selectedDate = newDate;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Text(
              selectedDate == null
                  ? widget.hintText
                  : DateFormat('dd MMM yyyy HH:mm').format(selectedDate!),
              style: body1Regular.copyWith(
                color: selectedDate == null ? achromatic300 : achromatic100,
              ),
            ),
          ),
        );
      },
      name: widget.name,
    );
  }
}
