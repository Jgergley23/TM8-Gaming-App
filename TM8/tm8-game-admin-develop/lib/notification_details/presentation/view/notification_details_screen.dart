import 'dart:async';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tm8_game_admin/app/constants/constants.dart';
import 'package:tm8_game_admin/app/constants/fonts.dart';
import 'package:tm8_game_admin/app/constants/palette.dart';
import 'package:tm8_game_admin/app/constants/routing_names.dart';
import 'package:tm8_game_admin/app/services/service_locator.dart';
import 'package:tm8_game_admin/app/widgets/tm8_error_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_logout_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_main_button_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_side_menu_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_snack_bar.dart';
import 'package:tm8_game_admin/gen/assets.gen.dart';
import 'package:tm8_game_admin/manage_users/presentation/logic/unfocus_drop_down_cubit/unfocus_drop_down_cubit.dart';
import 'package:tm8_game_admin/notification_add/presentation/logic/refetch_notification_table_cubit/refetch_notification_table_cubit.dart';
import 'package:tm8_game_admin/notification_add/presentation/widgets/notification_form_items_widget.dart';
import 'package:tm8_game_admin/notification_details/presentation/logic/edit_notification_cubit/edit_notification_cubit.dart';
import 'package:tm8_game_admin/notification_details/presentation/logic/fetch_notification_details/fetch_notification_details_cubit.dart';
import 'package:tm8_game_admin/notifications/presentation/logic/fetch_notifications_types_cubit/fetch_notification_types_cubit.dart';
import 'package:tm8_game_admin/notifications/presentation/logic/fetch_user_groups_cubit/fetch_user_groups_cubit.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

class NotificationDetailsScreen extends StatefulWidget {
  const NotificationDetailsScreen({
    super.key,
    required this.notificationId,
  });

  final String notificationId;

  @override
  State<NotificationDetailsScreen> createState() =>
      _NotificationDetailsScreenState();
}

class _NotificationDetailsScreenState extends State<NotificationDetailsScreen> {
  UpdateScheduledNotificationInputNotificationType? notificationType;
  UpdateScheduledNotificationInputTargetGroup? targetGroup;
  UpdateScheduledNotificationInputInterval? interval;
  String? individualUserId;
  DateTime? date;
  DateTime? time;
  late ScheduledNotificationDataResponse notificationMainDetails;
  late ScheduledNotificationResponse notificationResponse;
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<RefetchNotificationTableCubit>(),
      child: MultiBlocListener(
        listeners: [
          BlocListener<EditNotificationCubit, EditNotificationState>(
            listener: (context, state) {
              state.whenOrNull(
                loaded: (notificationDetails) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    Tm8SnackBar.snackBar(
                      color: achromatic600,
                      text: 'Successfully edited notification',
                      textColor: achromatic100,
                      button: false,
                    ),
                  );
                  context.beamToNamed(notifications);
                  sl<RefetchNotificationTableCubit>().refetch(true);
                },
                error: (error) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    Tm8SnackBar.snackBar(
                      color: achromatic600,
                      text: error,
                      textColor: errorTextColor,
                      button: false,
                      width: 500,
                    ),
                  );
                },
              );
            },
          ),
          BlocListener<FetchNotificationDetailsCubit,
              FetchNotificationDetailsState>(
            listener: (context, state) {
              state.whenOrNull(
                loaded: (notificationDetails) {
                  notificationMainDetails = notificationDetails.data;
                  notificationResponse = notificationDetails;
                  date = notificationDetails.date;
                  notificationType =
                      UpdateScheduledNotificationInputNotificationType.values[
                          notificationMainDetails.notificationType.index];
                  targetGroup = UpdateScheduledNotificationInputTargetGroup
                      .values[notificationMainDetails.targetGroup.index];
                  interval =
                      statusMapInputInterval[notificationResponse.interval];
                  individualUserId = notificationDetails.users.isNotEmpty
                      ? notificationDetails.users.length == 1
                          ? notificationDetails.users.first
                          : null
                      : null;
                },
              );
            },
          ),
        ],
        child: Portal(
          child: GestureDetector(
            onTap: () {
              context.read<UnfocusDropDownCubit>().unfocus();
            },
            child: Scaffold(
              body: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Tm8SideMenuWidget(
                    pageIndex: (value) {
                      if (value == 0) {
                        context.beamToNamed(
                          home,
                        );
                      } else if (value == 1) {
                        context.beamToNamed(notifications);
                      } else {
                        context.beamToNamed(
                          manageAdmins,
                        );
                      }
                    },
                    currentIndex: 1,
                  ),
                  Expanded(
                    child: _buildNotificationEdit(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  FormBuilder _buildNotificationEdit(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    return FormBuilder(
      key: formKey,
      child: ListView(
        padding: screenPadding,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  if (context.canBeamBack) {
                    context.beamBack();
                  } else {
                    context.beamToNamed(notifications);
                  }
                },
                child: SvgPicture.asset(
                  Assets.common.navigationBackArrow.path,
                ),
              ),
              const Tm8LogoutWidget(),
            ],
          ),
          h24,
          Text(
            'Edit Notification',
            style: heading1Regular.copyWith(
              color: achromatic100,
            ),
          ),
          h24,
          BlocBuilder<FetchNotificationDetailsCubit,
              FetchNotificationDetailsState>(
            builder: (context, state) {
              return state.when(
                initial: SizedBox.new,
                loading: () {
                  return Skeletonizer(
                    child: NotificationFormItemsWidget(
                      onSelectedType: (value) {},
                      onSelectedUserGroup: (value) {},
                      onSelectedDate: (value) {},
                      onSelectedTime: (value) {},
                      onSelectedInterval: (value) {},
                      onSelectedIndividual: (value) {},
                      notificationDetails: ScheduledNotificationResponse(
                        id: '',
                        date: DateTime.now(),
                        interval: 'Interval',
                        openedBy: 2,
                        receivedBy: 2,
                        uniqueId: 'uniqueId',
                        users: [],
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                        data: const ScheduledNotificationDataResponse(
                          title: 'title',
                          description: 'description',
                          targetGroup:
                              ScheduledNotificationDataResponseTargetGroup
                                  .allUsers,
                          notificationType:
                              ScheduledNotificationDataResponseNotificationType
                                  .communityNews,
                        ),
                      ),
                    ),
                  );
                },
                loaded: (notificationDetails) {
                  return NotificationFormItemsWidget(
                    onSelectedType: (value) {
                      notificationType =
                          UpdateScheduledNotificationInputNotificationType
                              .values[value.index];
                    },
                    onSelectedUserGroup: (value) {
                      targetGroup = UpdateScheduledNotificationInputTargetGroup
                          .values[value.index];
                      if (targetGroup !=
                          UpdateScheduledNotificationInputTargetGroup
                              .individualUser) {
                        individualUserId = null;
                      }
                    },
                    onSelectedDate: (value) {
                      date = DateTime(
                        value.year,
                        value.month,
                        value.day,
                        date?.hour ?? 0,
                        date?.minute ?? 0,
                      );
                    },
                    onSelectedTime: (value) {
                      time = value;
                      date = DateTime(
                        date!.year,
                        date!.month,
                        date!.day,
                        time?.hour ?? 0,
                        time?.minute ?? 0,
                      );
                    },
                    onSelectedInterval: (value) {
                      interval = UpdateScheduledNotificationInputInterval
                          .values[value.index];
                    },
                    onSelectedIndividual: (value) {
                      individualUserId = value;
                    },
                    notificationDetails: notificationDetails,
                  );
                },
                error: (error) {
                  return Tm8ErrorWidget(
                    onTapRetry: () {
                      context
                          .read<FetchNotificationDetailsCubit>()
                          .fetchNotificationsData(
                            notificationId: widget.notificationId,
                          );
                    },
                    error: error,
                  );
                },
              );
            },
          ),
          h50,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Tm8MainButtonWidget(
                onPressed: () {
                  context.beamToNamed(notifications);
                },
                buttonColor: achromatic600,
                text: 'Cancel',
                width: 70,
              ),
              w8,
              Tm8MainButtonWidget(
                onPressed: () {
                  final state = formKey.currentState!;
                  if (state.saveAndValidate()) {
                    if (_debounce?.isActive ?? false) _debounce?.cancel();
                    _debounce = Timer(const Duration(milliseconds: 300), () {
                      if (notificationType ==
                              UpdateScheduledNotificationInputNotificationType
                                  .swaggerGeneratedUnknown &&
                          targetGroup ==
                              UpdateScheduledNotificationInputTargetGroup
                                  .swaggerGeneratedUnknown) {
                        context
                            .read<FetchNotificationTypesCubit>()
                            .reEmitted(true);
                        context.read<FetchUserGroupsCubit>().reEmitted(true);
                      } else if (targetGroup ==
                          UpdateScheduledNotificationInputTargetGroup
                              .swaggerGeneratedUnknown) {
                        context.read<FetchUserGroupsCubit>().reEmitted(true);
                        context
                            .read<FetchNotificationTypesCubit>()
                            .reEmitted(false);
                      } else if (notificationType ==
                          UpdateScheduledNotificationInputNotificationType
                              .swaggerGeneratedUnknown) {
                        context
                            .read<FetchNotificationTypesCubit>()
                            .reEmitted(true);
                        context.read<FetchUserGroupsCubit>().reEmitted(false);
                      } else {
                        final title = state.fields['title']!.value.toString();
                        final desc = state.fields['desc']!.value.toString();
                        if (notificationType !=
                                UpdateScheduledNotificationInputNotificationType
                                        .values[
                                    notificationMainDetails
                                        .notificationType.index] ||
                            targetGroup !=
                                UpdateScheduledNotificationInputTargetGroup
                                        .values[
                                    notificationMainDetails
                                        .targetGroup.index] ||
                            interval !=
                                statusMapInputInterval[
                                    notificationResponse.interval] ||
                            title != notificationMainDetails.title ||
                            desc != notificationMainDetails.description ||
                            date != notificationResponse.date) {
                          context
                              .read<EditNotificationCubit>()
                              .editNotification(
                                body: UpdateScheduledNotificationInput(
                                  notificationType: notificationType,
                                  targetGroup: targetGroup,
                                  interval: interval,
                                  individualUserId: individualUserId,
                                  date: date,
                                  title: title != notificationMainDetails.title
                                      ? title
                                      : notificationMainDetails.title,
                                  description: desc !=
                                          notificationMainDetails.description
                                      ? desc
                                      : notificationMainDetails.description,
                                  redirectScreen: 'home',
                                ),
                                notificationId: widget.notificationId,
                              );
                        } else {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            Tm8SnackBar.snackBar(
                              color: achromatic600,
                              text: 'At least one field must be changed',
                              textColor: achromatic100,
                              button: false,
                            ),
                          );
                        }
                      }
                    });
                  }
                },
                buttonColor: primaryTeal,
                text: 'Save changes',
                width: 115,
              ),
            ],
          ),
          h100,
          h100, //for ease of use of drop downs
        ],
      ),
    );
  }
}

final Map<String, UpdateScheduledNotificationInputInterval>
    statusMapInputInterval = {
  "doesnt-repeat": UpdateScheduledNotificationInputInterval.doesntRepeat,
  'repeat-annually': UpdateScheduledNotificationInputInterval.repeatAnnually,
  'repeat-biweekly': UpdateScheduledNotificationInputInterval.repeatBiWeekly,
  'repeat-daily': UpdateScheduledNotificationInputInterval.repeatDaily,
  'repeat-monthly': UpdateScheduledNotificationInputInterval.repeatMonthly,
  'repeat-weekly': UpdateScheduledNotificationInputInterval.repeatWeekly,
};
