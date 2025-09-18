import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tm8_game_admin/app/constants/constants.dart';
import 'package:tm8_game_admin/app/constants/fonts.dart';
import 'package:tm8_game_admin/app/constants/palette.dart';
import 'package:tm8_game_admin/app/constants/validators.dart';
import 'package:tm8_game_admin/app/widgets/tm8_drop_down_form_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_input_form_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_main_container_widget.dart';
import 'package:tm8_game_admin/gen/assets.gen.dart';
import 'package:tm8_game_admin/notification_add/presentation/logic/fetch_notification_intervals_cubit/fetch_notification_intervals_cubit.dart';
import 'package:tm8_game_admin/notification_add/presentation/logic/reset_search_cubit/reset_search_cubit.dart';
import 'package:tm8_game_admin/notification_add/presentation/logic/show_search_user_cubit/show_search_user_cubit.dart';
import 'package:tm8_game_admin/notification_add/presentation/widgets/search_portal_widget.dart';
import 'package:tm8_game_admin/notification_add/presentation/widgets/tm8_body_input_widget.dart';
import 'package:tm8_game_admin/notification_add/presentation/widgets/tm8_date_picker_portal_widget.dart';
import 'package:tm8_game_admin/notifications/presentation/logic/fetch_notifications_types_cubit/fetch_notification_types_cubit.dart';
import 'package:tm8_game_admin/notifications/presentation/logic/fetch_user_groups_cubit/fetch_user_groups_cubit.dart';
import 'package:tm8_game_admin/notifications/presentation/view/notifications_screen.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

class NotificationFormItemsWidget extends StatefulWidget {
  const NotificationFormItemsWidget({
    super.key,
    this.notificationDetails,
    required this.onSelectedType,
    required this.onSelectedUserGroup,
    required this.onSelectedDate,
    required this.onSelectedTime,
    required this.onSelectedInterval,
    required this.onSelectedIndividual,
  });

  final ScheduledNotificationResponse? notificationDetails;
  final Function(CreateScheduledNotificationInputNotificationType)
      onSelectedType;
  final Function(CreateScheduledNotificationInputTargetGroup)
      onSelectedUserGroup;
  final Function(DateTime) onSelectedDate;
  final Function(DateTime) onSelectedTime;
  final Function(CreateScheduledNotificationInputInterval) onSelectedInterval;
  final Function(String?) onSelectedIndividual;

  @override
  State<NotificationFormItemsWidget> createState() =>
      _NotificationFormItemsWidgetState();
}

class _NotificationFormItemsWidgetState
    extends State<NotificationFormItemsWidget> {
  String? userId;
  @override
  void initState() {
    super.initState();
    if (widget.notificationDetails?.data.targetGroup ==
        ScheduledNotificationDataResponseTargetGroup.individualUser) {
      userId = widget.notificationDetails?.users.first;
      context.read<ShowSearchUserCubit>().changeShowSearchUser(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final isSmallScreen = maxWidth < 768;
        return Tm8MainContainerWidget(
          padding: 16,
          borderRadius: 20,
          width: width * 0.8,
          content: Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.start,
            spacing: 16,
            runSpacing: 12,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Tm8InputFormWidget(
                    name: 'title',
                    hintText: 'Enter title',
                    validator: titleValidator,
                    initialValue: widget.notificationDetails?.data.title,
                    labelText: 'Notification title',
                    width: width * 0.5,
                    constraints: const BoxConstraints(minWidth: 270),
                    inputFormatters: [
                      FirstLetterUpperCaseTextFormatter(),
                    ],
                    onTap: () {
                      // so it resets drop downs
                      setState(() {});
                    },
                  ),
                  h12,
                  Tm8BodyInputWidget(
                    name: 'desc',
                    hintText: 'Enter body',
                    initialValue: widget.notificationDetails?.data.description,
                    labelText: 'Notification body',
                    width: width * 0.5,
                    validator: bodyValidator,
                    constraints: const BoxConstraints(minWidth: 270),
                    inputFormatters: [
                      FirstLetterUpperCaseTextFormatter(),
                    ],
                    onTap: () {
                      // so it resets drop downs
                      setState(() {});
                    },
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Notification type',
                    style: body1Regular.copyWith(color: achromatic200),
                  ),
                  h4,
                  BlocBuilder<FetchNotificationTypesCubit,
                      FetchNotificationTypesState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        loading: () {
                          return Skeletonizer(
                            child: Tm8DropDownFormWidget(
                              dropDownSelection: (value) {},
                              mainCategory: '',
                              categories: const [],
                              itemKeys: const [],
                              followerAlignment: Alignment.topCenter,
                              selectedItem: '',
                              hintText: 'All types',
                              width: width * 0.225,
                              dropDownHeight: 54,
                              constraints: const BoxConstraints(minWidth: 270),
                            ),
                          );
                        },
                        loaded: (notificationTypes, failedValidation) {
                          return Tm8DropDownFormWidget(
                            onTap: () {
                              context.read<ResetSearchCubit>().resetSearch();
                              setState(() {});
                            },
                            dropDownSelection: (value) {
                              widget.onSelectedType(
                                statusMapNotificationTypesConverter[value] ??
                                    CreateScheduledNotificationInputNotificationType
                                        .swaggerGeneratedUnknown,
                              );
                            },
                            mainCategory: '',
                            categories:
                                notificationTypes.map((e) => e.name).toList(),
                            itemKeys:
                                notificationTypes.map((e) => e.name).toList(),
                            followerAlignment: Alignment.topCenter,
                            selectedItem: statusMapNotificationTypes[widget
                                    .notificationDetails
                                    ?.data
                                    .notificationType] ??
                                '',
                            hintText: 'All types',
                            width: isSmallScreen ? 270 : width * 0.225,
                            dropDownHeight: 54,
                            constraints: const BoxConstraints(minWidth: 270),
                            failedValidation: failedValidation,
                            failedValidationText:
                                'Please set notification type',
                          );
                        },
                        orElse: SizedBox.new,
                      );
                    },
                  ),
                  h16,
                  Text(
                    'User group',
                    style: body1Regular.copyWith(color: achromatic200),
                  ),
                  h4,
                  BlocBuilder<FetchUserGroupsCubit, FetchUserGroupsState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        loading: () {
                          return Skeletonizer(
                            child: Tm8DropDownFormWidget(
                              dropDownSelection: (value) {},
                              mainCategory: '',
                              categories: const [],
                              itemKeys: const [],
                              followerAlignment: Alignment.topCenter,
                              selectedItem: '',
                              hintText: 'All groups',
                              width: isSmallScreen ? 270 : width * 0.225,
                              dropDownHeight: 54,
                              constraints: const BoxConstraints(minWidth: 270),
                            ),
                          );
                        },
                        loaded: (userGroups, failedValidation) {
                          return Tm8DropDownFormWidget(
                            onTap: () {
                              context.read<ResetSearchCubit>().resetSearch();
                              setState(() {});
                            },
                            dropDownSelection: (value) {
                              var selectedGroup = userGroups
                                  .where(
                                    (element) =>
                                        '${element.name} ${element.count != null ? '(${element.count})' : ''}' ==
                                        value,
                                  )
                                  .first
                                  .name;
                              widget.onSelectedUserGroup(
                                statusMapNotificationGroupConverter[
                                        selectedGroup] ??
                                    CreateScheduledNotificationInputTargetGroup
                                        .fortnitePlayers,
                              );
                              if (value.trim() == 'Individual user') {
                                context
                                    .read<ShowSearchUserCubit>()
                                    .changeShowSearchUser(true);
                              } else {
                                context
                                    .read<ShowSearchUserCubit>()
                                    .changeShowSearchUser(false);
                              }
                            },
                            mainCategory: '',
                            categories: userGroups
                                .map(
                                  (e) =>
                                      '${e.name} ${e.count != null ? '(${e.count})' : ''}',
                                )
                                .toList(),
                            itemKeys: userGroups.map((e) => e.name).toList(),
                            followerAlignment: Alignment.topCenter,
                            selectedItem: statusMapNotificationGroup[widget
                                    .notificationDetails?.data.targetGroup] ??
                                '',
                            hintText: 'All groups',
                            width: isSmallScreen ? 270 : width * 0.225,
                            dropDownHeight: 54,
                            constraints: const BoxConstraints(minWidth: 270),
                            failedValidation: failedValidation,
                            failedValidationText: 'Please set user group',
                          );
                        },
                        orElse: SizedBox.new,
                      );
                    },
                  ),
                  BlocBuilder<ShowSearchUserCubit, bool>(
                    builder: (context, state) {
                      if (state) {
                        return SearchPortalWidget(
                          selectedIndividual: widget.onSelectedIndividual,
                          width: width,
                          followerAlignment: Alignment.topCenter,
                          userId: userId,
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                  h16,
                  Container(
                    width: width * 0.225,
                    constraints: const BoxConstraints(minWidth: 270),
                    height: 2,
                    color: achromatic500,
                  ),
                  h16,
                  Wrap(
                    runSpacing: 12,
                    spacing: 8,
                    children: [
                      Tm8DatePickerPortalWidget(
                        selectedDate: widget.onSelectedDate,
                        hintText: 'dd/mm/yy',
                        followerAlignment: Alignment.topLeft,
                        width: isSmallScreen ? 270 : width * 0.11,
                        dropDownHeight: 54,
                        initialDate: widget.notificationDetails?.date,
                        constraints:
                            BoxConstraints(minWidth: isSmallScreen ? 270 : 100),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Set time (optional)',
                            style: body1Regular.copyWith(color: achromatic200),
                          ),
                          h4,
                          Tm8DropDownFormWidget(
                            dropDownSelection: (value) {
                              widget.onSelectedTime(
                                DateFormat('HH:mm a').parse(value),
                              );
                            },
                            mainCategory: '',
                            categories: List.generate(48, (index) {
                              final hour = index ~/ 2;
                              final minute = (index % 2) * 30;
                              final time = DateTime(2024, 1, 1, hour, minute);
                              return DateFormat('hh:mm a').format(time);
                            }),
                            itemKeys: List.generate(48, (index) {
                              final hour = index ~/ 2;
                              final minute = (index % 2) * 30;
                              final time = DateTime(2024, 1, 1, hour, minute);
                              return DateFormat('hh:mm a').format(time);
                            }),
                            isScrollable: true,
                            scrollableHeight: 250,
                            followerAlignment: Alignment.topCenter,
                            selectedItem: _selectedTime(),
                            hintText: 'hh:mm',
                            width: isSmallScreen ? 270 : width * 0.11,
                            dropDownHeight: 54,
                            constraints: BoxConstraints(
                              minWidth: isSmallScreen ? 270 : 100,
                            ),
                            assetImage: Assets.common.timePicker.path,
                          ),
                        ],
                      ),
                    ],
                  ),
                  h16,
                  Text(
                    'Repeat options (optional)',
                    style: body1Regular.copyWith(color: achromatic200),
                  ),
                  h4,
                  BlocBuilder<FetchNotificationIntervalsCubit,
                      FetchNotificationIntervalsState>(
                    builder: (context, state) {
                      return state.maybeWhen(
                        loading: () {
                          return Skeletonizer(
                            child: Tm8DropDownFormWidget(
                              dropDownSelection: (value) {},
                              mainCategory: '',
                              categories: const [],
                              itemKeys: const [],
                              followerAlignment: Alignment.topCenter,
                              selectedItem: '',
                              hintText: 'Doesnt repeat',
                              width: isSmallScreen ? 270 : width * 0.225,
                              dropDownHeight: 54,
                              constraints: const BoxConstraints(minWidth: 270),
                            ),
                          );
                        },
                        loaded: (intervals) {
                          return Tm8DropDownFormWidget(
                            dropDownSelection: (value) {
                              widget.onSelectedInterval(
                                statusMapIntervalConverter[value] ??
                                    CreateScheduledNotificationInputInterval
                                        .swaggerGeneratedUnknown,
                              );
                            },
                            mainCategory: '',
                            categories: intervals.map((e) => e.name).toList(),
                            itemKeys: intervals
                                .map((e) => e.key.value ?? '')
                                .toList(),
                            followerAlignment: Alignment.topCenter,
                            selectedItem:
                                widget.notificationDetails?.interval ??
                                    intervals.first.key.value ??
                                    '',
                            width: isSmallScreen ? 270 : width * 0.225,
                            dropDownHeight: 54,
                            constraints: const BoxConstraints(minWidth: 270),
                          );
                        },
                        orElse: SizedBox.new,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  String _selectedTime() {
    if (widget.notificationDetails != null) {
      return DateFormat('hh:mm a').format(widget.notificationDetails!.date);
    } else {
      return '';
    }
  }
}

final Map<String, CreateScheduledNotificationInputNotificationType>
    statusMapNotificationTypesConverter = {
  'Community news':
      CreateScheduledNotificationInputNotificationType.communityNews,
  'Exclusive offers':
      CreateScheduledNotificationInputNotificationType.exclusiveOffers,
  'Game update': CreateScheduledNotificationInputNotificationType.gameUpdate,
  'New features': CreateScheduledNotificationInputNotificationType.newFeatures,
  'Other': CreateScheduledNotificationInputNotificationType.other,
  'System maintenance':
      CreateScheduledNotificationInputNotificationType.systemMaintenance,
  '': CreateScheduledNotificationInputNotificationType.swaggerGeneratedUnknown,
};

final Map<String, CreateScheduledNotificationInputTargetGroup>
    statusMapNotificationGroupConverter = {
  'All users': CreateScheduledNotificationInputTargetGroup.allUsers,
  'Apex Legends players':
      CreateScheduledNotificationInputTargetGroup.apexLegendsPlayers,
  'Call of Duty players':
      CreateScheduledNotificationInputTargetGroup.callOfDutyPlayers,
  'Fortnite players':
      CreateScheduledNotificationInputTargetGroup.fortnitePlayers,
  'Individual user': CreateScheduledNotificationInputTargetGroup.individualUser,
  'Rocket League players':
      CreateScheduledNotificationInputTargetGroup.rocketLeaguePlayers,
};

final Map<String, CreateScheduledNotificationInputInterval>
    statusMapIntervalConverter = {
  "Doesn't repeat": CreateScheduledNotificationInputInterval.doesntRepeat,
  'Repeat annually': CreateScheduledNotificationInputInterval.repeatAnnually,
  'Repeat biweekly': CreateScheduledNotificationInputInterval.repeatBiWeekly,
  'Repeat daily': CreateScheduledNotificationInputInterval.repeatDaily,
  'Repeat monthly': CreateScheduledNotificationInputInterval.repeatMonthly,
  'Repeat weekly': CreateScheduledNotificationInputInterval.repeatWeekly,
};
