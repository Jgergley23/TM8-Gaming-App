import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isoweek/isoweek.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tm8_game_admin/app/constants/constants.dart';
import 'package:tm8_game_admin/app/constants/fonts.dart';
import 'package:tm8_game_admin/app/constants/palette.dart';
import 'package:tm8_game_admin/app/widgets/tm8_drop_down_form_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_error_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_line_chart_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_main_container_widget.dart';
import 'package:tm8_game_admin/manage_users/presentation/logic/onboarding_completion_cubit/onboarding_completion_cubit.dart';
import 'package:tm8_game_admin/manage_users/presentation/logic/registered_users_cubit/registered_users_cubit.dart';
import 'package:tm8_game_admin/manage_users/presentation/logic/total_users_cubit/total_users_cubit.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

class TotalOnboardingRegisterWidget extends StatelessWidget {
  const TotalOnboardingRegisterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 24,
      alignment: WrapAlignment.center,
      children: [
        Column(
          children: [
            BlocBuilder<TotalUsersCubit, TotalUsersState>(
              builder: (context, state) {
                return state.when(
                  initial: SizedBox.new,
                  loading: () {
                    return _buildLoadingTotalUsersWidget();
                  },
                  loaded: (totalCount) {
                    return _buildLoadedTotalUsersWidget(totalCount);
                  },
                  error: (error) {
                    return Tm8ErrorWidget(
                      onTapRetry: () {
                        context.read<TotalUsersCubit>().fetchTotalUser();
                      },
                      error: error,
                    );
                  },
                );
              },
            ),
            h24,
            BlocBuilder<OnboardingCompletionCubit, OnboardingCompletionState>(
              builder: (context, state) {
                return state.when(
                  initial: SizedBox.new,
                  loading: () {
                    return _buildLoadingOnboardingCompletionWidget();
                  },
                  loaded: (count) {
                    return _buildLoadedOnboardingCompletionWidget(count);
                  },
                  error: (error) => Tm8ErrorWidget(
                    onTapRetry: () {
                      context
                          .read<OnboardingCompletionCubit>()
                          .fetchOnboardingCompletion();
                    },
                    error: error,
                  ),
                );
              },
            ),
          ],
        ),
        w24,
        BlocBuilder<RegisteredUsersCubit, RegisteredUsersState>(
          builder: (context, state) {
            return state.when(
              initial: SizedBox.new,
              loading: () {
                return _buildLoadingRegisteredUsers(context);
              },
              loaded: (flSpots, titles, increasedY, selectedValue) {
                return _buildLoadedRegisteredUsers(
                  flSpots,
                  titles,
                  context,
                  increasedY,
                  selectedValue,
                );
              },
              error: (error) {
                return Tm8ErrorWidget(
                  onTapRetry: () {
                    Week currentWeek = Week.current();

                    context
                        .read<RegisteredUsersCubit>()
                        .fetchRegisteredUsersGraph(
                          startDate: currentWeek.days.first.toString(),
                          endDate: currentWeek.days.last.toString(),
                          groupBy:
                              ApiV1StatisticsUsersNewUsersRegisteredGetGroupBy
                                  .day,
                          timeSelected: TimeSelected.weekly,
                          selectedValue: 'Weekly',
                        );
                  },
                  error: error,
                );
              },
            );
          },
        ),
      ],
    );
  }

  Tm8MainContainerWidget _buildLoadedRegisteredUsers(
    List<FlSpot> flSpots,
    List<String> titles,
    BuildContext context,
    int increasedY,
    String selectedValue,
  ) {
    return Tm8MainContainerWidget(
      borderRadius: 20,
      padding: 16,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'New users registered',
                style: heading4Regular.copyWith(
                  color: achromatic100,
                ),
              ),
              Tm8DropDownFormWidget(
                mainCategory: 'Weekly',
                categories: const ['Weekly', 'Monthly', 'Yearly', 'All time'],
                itemKeys: const ['Weekly', 'Monthly', 'Yearly', 'All time'],
                dropDownSelection: (value) {
                  _onDropDownSelection(value, context);
                },
                selectedItem: selectedValue,
                followerAlignment: Alignment.topCenter,
                width: 110,
              ),
            ],
          ),
          h12,
          Tm8LineChartWidget(
            maxX: titles.length.toDouble() - 1,
            flSpot: flSpots,
            maxY: increasedY.toDouble(),
            titles: titles,
            selectedValue: selectedValue,
          ),
        ],
      ),
      width: 740,
      constraints: const BoxConstraints(minWidth: 350, maxHeight: 740),
    );
  }

  Skeletonizer _buildLoadingRegisteredUsers(
    BuildContext context,
  ) {
    return Skeletonizer(
      child: Tm8MainContainerWidget(
        borderRadius: 20,
        padding: 16,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'New users registered',
                  style: heading4Regular.copyWith(
                    color: achromatic100,
                  ),
                ),
                Tm8DropDownFormWidget(
                  mainCategory: 'Weekly',
                  categories: const ['Weekly', 'Monthly', 'Yearly', 'All time'],
                  itemKeys: const ['Weekly', 'Monthly', 'Yearly', 'All time'],
                  dropDownSelection: (value) {
                    _onDropDownSelection(value, context);
                  },
                  selectedItem: 'Weekly',
                  followerAlignment: Alignment.topCenter,
                  width: 110,
                ),
              ],
            ),
            h12,
            const Tm8LineChartWidget(
              maxX: 6,
              flSpot: [],
              maxY: 6,
              titles: ['', '', '', '', '', '', ''],
              selectedValue: 'Weekly',
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width * 0.5,
        constraints: const BoxConstraints(minWidth: 350),
      ),
    );
  }

  Skeletonizer _buildLoadingTotalUsersWidget() {
    return Skeletonizer(
      child: Tm8MainContainerWidget(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total users',
              style: body1Regular.copyWith(
                color: achromatic200,
              ),
            ),
            h12,
            Text(
              '1029',
              style: heading1Bold.copyWith(color: achromatic100),
            ),
            h12,
            Text(
              '+12 since last week',
              style: body2Regular.copyWith(color: successColor),
            ),
          ],
        ),
        borderRadius: 20,
        padding: 16,
        width: 350,
      ),
    );
  }

  Tm8MainContainerWidget _buildLoadedTotalUsersWidget(
    StatisticsTotalCountResponse totalCount,
  ) {
    return Tm8MainContainerWidget(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total users',
            style: body1Regular.copyWith(
              color: achromatic200,
            ),
          ),
          h12,
          Text(
            totalCount.total.toString(),
            style: heading1Bold.copyWith(color: achromatic100),
          ),
          h12,
          Text(
            _buildSinceLastWeekTotalUsersText(totalCount),
            style: body2Regular.copyWith(
              color: _buildSinceLastWeekTotalUsersColor(totalCount),
            ),
          ),
        ],
      ),
      borderRadius: 20,
      padding: 16,
      width: 350,
    );
  }

  Skeletonizer _buildLoadingOnboardingCompletionWidget() {
    return Skeletonizer(
      child: Tm8MainContainerWidget(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Onboarding completion rate',
              style: body1Regular.copyWith(
                color: achromatic200,
              ),
            ),
            h12,
            Text(
              '89.1 %',
              style: heading1Bold.copyWith(color: achromatic100),
            ),
            h12,
            Text(
              '+12 since last week',
              style: body2Regular.copyWith(color: successColor),
            ),
          ],
        ),
        borderRadius: 20,
        padding: 16,
        width: 350,
      ),
    );
  }

  Tm8MainContainerWidget _buildLoadedOnboardingCompletionWidget(
    StatisticsOnboardingCompletionResponse totalCount,
  ) {
    return Tm8MainContainerWidget(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Onboarding completion rate',
            style: body1Regular.copyWith(
              color: achromatic200,
            ),
          ),
          h12,
          Text(
            '${totalCount.onboardingPct.toStringAsFixed(1)}%',
            style: heading1Bold.copyWith(color: achromatic100),
          ),
          h12,
          Text(
            _buildSinceLastWeekOnboardingUsersText(totalCount),
            style: body2Regular.copyWith(
              color: _buildSinceLastWeekOnboardingUsersColor(totalCount),
            ),
          ),
        ],
      ),
      borderRadius: 20,
      padding: 16,
      width: 350,
    );
  }

  String _buildSinceLastWeekTotalUsersText(
    StatisticsTotalCountResponse totalCount,
  ) {
    if (totalCount.currentWeek == 0) {
      return 'No change since last week';
    } else if (totalCount.currentWeek.isNegative) {
      return '${totalCount.currentWeek} since last week';
    } else {
      return '+${totalCount.currentWeek} since last week';
    }
  }

  Color _buildSinceLastWeekTotalUsersColor(
    StatisticsTotalCountResponse totalCount,
  ) {
    if (totalCount.currentWeek == 0) {
      return achromatic200;
    } else if (totalCount.currentWeek.isNegative) {
      return errorColor;
    } else {
      return successColor;
    }
  }

  String _buildSinceLastWeekOnboardingUsersText(
    StatisticsOnboardingCompletionResponse totalCount,
  ) {
    if (totalCount.currentWeek == 0) {
      return 'No change since last week';
    } else if (totalCount.currentWeek.isNegative) {
      return '${totalCount.currentWeek.toStringAsFixed(1)}% since last week';
    } else {
      return '+${totalCount.currentWeek.toStringAsFixed(1)}% since last week';
    }
  }

  Color _buildSinceLastWeekOnboardingUsersColor(
    StatisticsOnboardingCompletionResponse totalCount,
  ) {
    if (totalCount.currentWeek == 0) {
      return achromatic200;
    } else if (totalCount.currentWeek.isNegative) {
      return errorColor;
    } else {
      return successColor;
    }
  }

  void _onDropDownSelection(String value, BuildContext context) {
    var startDate = '';
    var endDate = '';
    final now = DateTime.now();
    final Map<String, TimeSelected?> statusMapTimeSelected = {
      'Weekly': TimeSelected.weekly,
      'Monthly': TimeSelected.monthly,
      'Yearly': TimeSelected.yearly,
      'All time': TimeSelected.allTime,
    };
    final Map<String, ApiV1StatisticsUsersNewUsersRegisteredGetGroupBy?>
        statusMapGroupBySelected = {
      'Weekly': ApiV1StatisticsUsersNewUsersRegisteredGetGroupBy.day,
      'Monthly': ApiV1StatisticsUsersNewUsersRegisteredGetGroupBy.day,
      'Yearly': ApiV1StatisticsUsersNewUsersRegisteredGetGroupBy.week,
      'All time': ApiV1StatisticsUsersNewUsersRegisteredGetGroupBy.week,
    };
    final timeSelected = statusMapTimeSelected[value] ?? TimeSelected.weekly;
    final groupBy = statusMapGroupBySelected[value] ??
        ApiV1StatisticsUsersNewUsersRegisteredGetGroupBy.day;

    if (timeSelected == TimeSelected.weekly) {
      Week currentWeek = Week.current();
      startDate = currentWeek.days.first.toString();
      endDate = currentWeek.days.last.toString();
    } else if (timeSelected == TimeSelected.monthly) {
      startDate = DateTime(now.year, now.month).toString();
      endDate = DateTime(now.year, now.month + 1, 0).toString();
    } else if (timeSelected == TimeSelected.yearly) {
      startDate = DateTime(now.year).toString();
      endDate = DateTime(
        now.year,
        12,
        31,
      ).toString();
    } else {
      startDate = DateTime(now.year).toString();
      endDate = DateTime(
        now.year,
        12,
        31,
      ).toString();
    }

    context.read<RegisteredUsersCubit>().fetchRegisteredUsersGraph(
          startDate: startDate,
          endDate: endDate,
          groupBy: groupBy,
          timeSelected: timeSelected,
          selectedValue: value,
        );
  }
}
