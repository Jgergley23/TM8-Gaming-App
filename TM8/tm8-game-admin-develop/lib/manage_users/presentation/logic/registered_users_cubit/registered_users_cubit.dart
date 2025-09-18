import 'package:chopper/chopper.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:isoweek/isoweek.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8_game_admin/app/api/api_service.dart';
import 'package:tm8_game_admin/app/handlers/error_handler.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

part 'registered_users_state.dart';
part 'registered_users_cubit.freezed.dart';

@injectable
class RegisteredUsersCubit extends Cubit<RegisteredUsersState> {
  RegisteredUsersCubit() : super(const RegisteredUsersState.initial());

  Future<void> fetchRegisteredUsersGraph({
    required String startDate,
    required String endDate,
    required ApiV1StatisticsUsersNewUsersRegisteredGetGroupBy groupBy,
    required TimeSelected timeSelected,
    required String selectedValue,
  }) async {
    try {
      emit(const RegisteredUsersState.loading());
      final result = await api.apiV1StatisticsUsersNewUsersRegisteredGet(
        startDate: startDate,
        groupBy: groupBy,
        endDate: endDate,
      );

      if (result.isSuccessful) {
        logInfo(result.body.toString());
        final flSpots = _getFlSpots(result);

        final increasedY = _getIncreasedY(flSpots);
        final titles = _getTitles(timeSelected: timeSelected);

        emit(
          RegisteredUsersState.loaded(
            flSpots: flSpots,
            titles: titles,
            increasedY: increasedY,
            selectedValue: selectedValue,
          ),
        );
      } else {
        emit(
          RegisteredUsersState.error(
            error: result.handleError,
          ),
        );
      }
    } catch (e) {
      logError(e.toString());
      emit(
        const RegisteredUsersState.error(error: 'Something went wrong'),
      );
    }
  }

  int _getIncreasedY(List<FlSpot> flSpots) {
    double highestY = 0;
    for (int i = 0; i < flSpots.length; i++) {
      if (flSpots[i].y > highestY) {
        highestY = flSpots[i].y;
      }
    }
    var increasedSpot = (highestY * 1.2).ceil();

    return increasedSpot;
  }

  List<String> _getTitles({
    required TimeSelected timeSelected,
  }) {
    final now = DateTime.now();
    var titles = <String>[];
    if (timeSelected == TimeSelected.weekly) {
      titles = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    } else if (timeSelected == TimeSelected.monthly) {
      final month = now.month;
      final daysInMonth = getDaysInMonth(now.year, month);
      titles = List.generate(daysInMonth, (index) => ('${index + 1}/$month'));
    } else if (timeSelected == TimeSelected.yearly) {
      List<DateTime> startDates = getStartDatesForISOWeeks(2024);
      titles = List.generate(
        52,
        (index) => DateFormat('yyyy/dd/MM').format(
          startDates[index],
        ),
      );
    } else {
      List<DateTime> startDates = getStartDatesForISOWeeks(2024);
      titles = List.generate(
        52,
        (index) => DateFormat('yyyy/dd/MM').format(
          startDates[index],
        ),
      );
    }
    return titles;
  }

  List<FlSpot> _getFlSpots(
    Response<StatisticsNewUsersRegisteredResponse> result,
  ) {
    if (result.body != null) {
      if (result.body?.chart != null) {
        if (result.body!.chart.isEmpty) {
          return [];
        } else {
          var flSpots = <FlSpot>[];
          for (var i = 0; i < result.body!.chart.length; i++) {
            flSpots.add(
              FlSpot(
                i.toDouble(),
                result.body!.chart[i].quantity.toDouble(),
              ),
            );
          }
          return flSpots;
        }
      }
    }
    return [];
  }

  int getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  List<DateTime> getStartDatesForISOWeeks(int year) {
    var startDates = <DateTime>[];
    var firstDayOfYear = DateTime(year, 1, 1);
    var firstWeek = Week.fromDate(firstDayOfYear);
    startDates.add(firstWeek.days.first);
    for (var i = 0; i < 51; i++) {
      final nextWeek = firstWeek.next.days.first;
      firstWeek = firstWeek.next;
      startDates.add(nextWeek);
    }

    return startDates;
  }
}

enum TimeSelected {
  weekly,
  monthly,
  yearly,
  allTime,
}
