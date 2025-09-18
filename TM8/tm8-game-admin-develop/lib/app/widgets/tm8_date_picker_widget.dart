import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:tm8_game_admin/app/constants/constants.dart';
import 'package:tm8_game_admin/app/constants/fonts.dart';
import 'package:tm8_game_admin/app/constants/palette.dart';

class Tm8DatePickerWidget extends StatefulWidget {
  const Tm8DatePickerWidget({
    super.key,
    required this.onDay,
    this.selectedDate,
    required this.maxSelectedDate,
    required this.minSelectedDate,
  });

  final Function(DateTime) onDay;
  final DateTime? selectedDate;
  final DateTime maxSelectedDate;
  final DateTime minSelectedDate;

  @override
  State<Tm8DatePickerWidget> createState() => _Tm8DatePickerWidgetState();
}

class _Tm8DatePickerWidgetState extends State<Tm8DatePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 280,
      decoration: BoxDecoration(
        color: achromatic800,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [overlayShadow],
      ),
      child: CalendarCarousel(
        height: 300,
        width: 280,
        onDayPressed: (date, event) {
          setState(() {
            widget.onDay(date);
          });
        },
        selectedDateTime: widget.selectedDate,
        iconColor: achromatic100,
        selectedDayButtonColor: primaryTeal,
        selectedDayBorderColor: primaryTeal,
        headerTextStyle: heading4Regular.copyWith(color: achromatic100),
        weekdayTextStyle: body2Regular.copyWith(color: achromatic200),
        dayPadding: 0,
        headerMargin: const EdgeInsets.all(8),
        weekDayMargin: const EdgeInsets.only(bottom: 8, top: 8),
        minSelectedDate: widget.minSelectedDate,
        maxSelectedDate: widget.maxSelectedDate,
        customDayBuilder: (
          bool isSelectable,
          int index,
          bool isSelectedDay,
          bool isToday,
          bool isPrevMonthDay,
          TextStyle textStyle,
          bool isNextMonthDay,
          bool isThisMonthDay,
          DateTime day,
        ) {
          if (isSelectedDay) {
            return Container(
              decoration: BoxDecoration(
                color: primaryTeal,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  day.day.toString(),
                  style: body2Regular.copyWith(
                    color: achromatic100,
                  ),
                ),
              ),
            );
          } else if (isNextMonthDay || isPrevMonthDay) {
            return Container(
              decoration: BoxDecoration(
                color: achromatic800,
              ),
              child: Center(
                child: Text(
                  day.day.toString(),
                  style: body2Regular.copyWith(
                    color: achromatic300,
                  ),
                ),
              ),
            );
          } else if (!isSelectable) {
            return Container(
              decoration: BoxDecoration(
                color: achromatic800,
              ),
              child: Center(
                child: Text(
                  day.day.toString(),
                  style: body2Regular.copyWith(
                    color: achromatic200,
                  ),
                ),
              ),
            );
          } else {
            return Container(
              decoration: BoxDecoration(
                color: achromatic800,
              ),
              child: Center(
                child: Text(
                  day.day.toString(),
                  style: body2Regular.copyWith(
                    color: achromatic100,
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
