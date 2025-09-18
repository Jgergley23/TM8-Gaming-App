import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/constants/validators.dart';
import 'package:tm8/app/widgets/tm8_secondary_button_widget.dart';

class Tm8DateOfBirthWidget extends StatefulWidget {
  const Tm8DateOfBirthWidget({
    super.key,
    this.labelText,
    required this.name,
    required this.hintText,
    this.maxLines = 1,
  });

  final String? labelText;
  final String name;
  final String hintText;
  final int maxLines;
  @override
  State<Tm8DateOfBirthWidget> createState() => _Tm8DateOfBirthWidgetState();
}

class _Tm8DateOfBirthWidgetState extends State<Tm8DateOfBirthWidget> {
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
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null) ...[
          Text(
            widget.labelText!,
            style: body1Regular.copyWith(color: achromatic200),
          ),
          h4,
        ],
        FormBuilderField(
          focusNode: focusNode,
          validator: dateValidator,
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
                                  mode: CupertinoDatePickerMode.date,
                                  dateOrder: DatePickerDateOrder.dmy,
                                  initialDateTime: now,
                                  backgroundColor: achromatic700,
                                  maximumDate: now,
                                  onDateTimeChanged: (newDate) {
                                    field.didChange(newDate.toString());
                                    setState(() {
                                      selectedDate = newDate;
                                    });
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
                      : DateFormat('dd MMM yyyy').format(selectedDate!),
                  style: body1Regular.copyWith(
                    color: selectedDate == null ? achromatic300 : achromatic100,
                  ),
                ),
              ),
            );
          },
          name: widget.name,
        ),
      ],
    );
  }
}
