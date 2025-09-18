import 'dart:async';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tm8_game_admin/app/constants/constants.dart';
import 'package:tm8_game_admin/app/constants/fonts.dart';
import 'package:tm8_game_admin/app/constants/palette.dart';
import 'package:tm8_game_admin/app/constants/routing_names.dart';
import 'package:tm8_game_admin/app/services/service_locator.dart';
import 'package:tm8_game_admin/app/widgets/tm8_logout_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_main_button_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_side_menu_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_snack_bar.dart';
import 'package:tm8_game_admin/gen/assets.gen.dart';
import 'package:tm8_game_admin/manage_users/presentation/logic/unfocus_drop_down_cubit/unfocus_drop_down_cubit.dart';
import 'package:tm8_game_admin/notification_add/presentation/logic/add_notification_cubit/add_notification_cubit.dart';
import 'package:tm8_game_admin/notification_add/presentation/logic/refetch_notification_table_cubit/refetch_notification_table_cubit.dart';
import 'package:tm8_game_admin/notification_add/presentation/widgets/notification_form_items_widget.dart';
import 'package:tm8_game_admin/notifications/presentation/logic/fetch_notifications_types_cubit/fetch_notification_types_cubit.dart';
import 'package:tm8_game_admin/notifications/presentation/logic/fetch_user_groups_cubit/fetch_user_groups_cubit.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

class NotificationAddScreen extends StatefulWidget {
  const NotificationAddScreen({super.key});

  @override
  State<NotificationAddScreen> createState() => _NotificationAddScreenState();
}

class _NotificationAddScreenState extends State<NotificationAddScreen> {
  late CreateScheduledNotificationInputNotificationType notificationType;
  late CreateScheduledNotificationInputTargetGroup targetGroup;
  late CreateScheduledNotificationInputInterval interval;
  String? individualUserId;
  final now = DateTime.now();
  late DateTime date;
  late DateTime time;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    // default values
    date = now;
    time = now;
    notificationType = CreateScheduledNotificationInputNotificationType
        .swaggerGeneratedUnknown;
    targetGroup =
        CreateScheduledNotificationInputTargetGroup.swaggerGeneratedUnknown;
    interval = CreateScheduledNotificationInputInterval.doesntRepeat;
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<RefetchNotificationTableCubit>(),
      child: Portal(
        child: GestureDetector(
          onTap: () {
            context.read<UnfocusDropDownCubit>().unfocus();
          },
          child: BlocListener<AddNotificationCubit, AddNotificationState>(
            listener: (context, state) {
              state.whenOrNull(
                loaded: (notificationDetails) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    Tm8SnackBar.snackBar(
                      color: achromatic600,
                      text: 'Successfully added notification',
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
                    child: _buildNotificationAdd(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  FormBuilder _buildNotificationAdd(BuildContext context) {
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
            'New Notification',
            style: heading1Regular.copyWith(
              color: achromatic100,
            ),
          ),
          h24,
          NotificationFormItemsWidget(
            onSelectedType: (value) {
              notificationType = value;
            },
            onSelectedUserGroup: (value) {
              targetGroup = value;
              if (targetGroup !=
                  CreateScheduledNotificationInputTargetGroup.individualUser) {
                individualUserId = null;
              }
            },
            onSelectedDate: (value) {
              date = value;
            },
            onSelectedTime: (value) {
              time = value;
            },
            onSelectedInterval: (value) {
              interval = value;
            },
            onSelectedIndividual: (value) {
              individualUserId = value;
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
                  if (_debounce?.isActive ?? false) _debounce?.cancel();
                  _debounce = Timer(const Duration(milliseconds: 300), () {
                    final state = formKey.currentState!;
                    _validateForm(state, context);
                  });
                },
                buttonColor: primaryTeal,
                text: 'Send notification',
                width: 135,
              ),
            ],
          ),
          h100,
          h100, //for ease of use of drop downs
        ],
      ),
    );
  }

  void _validateForm(FormBuilderState state, BuildContext context) {
    if (state.saveAndValidate()) {
      if (notificationType ==
              CreateScheduledNotificationInputNotificationType
                  .swaggerGeneratedUnknown &&
          targetGroup ==
              CreateScheduledNotificationInputTargetGroup
                  .swaggerGeneratedUnknown) {
        context.read<FetchNotificationTypesCubit>().reEmitted(true);
        context.read<FetchUserGroupsCubit>().reEmitted(true);
      } else if (targetGroup ==
          CreateScheduledNotificationInputTargetGroup.swaggerGeneratedUnknown) {
        context.read<FetchUserGroupsCubit>().reEmitted(true);
        context.read<FetchNotificationTypesCubit>().reEmitted(false);
      } else if (notificationType ==
          CreateScheduledNotificationInputNotificationType
              .swaggerGeneratedUnknown) {
        context.read<FetchNotificationTypesCubit>().reEmitted(true);
        context.read<FetchUserGroupsCubit>().reEmitted(false);
      } else {
        if (individualUserId == null &&
            targetGroup ==
                CreateScheduledNotificationInputTargetGroup.individualUser) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            Tm8SnackBar.snackBar(
              color: achromatic600,
              text:
                  'If Individual user group is selected, search must be filled.',
              textColor: errorColor,
              button: false,
              duration: 4,
              width: 500,
            ),
          );
        } else {
          final sendingTime = DateTime.now();
          context.read<AddNotificationCubit>().addNotification(
                notificationInput: CreateScheduledNotificationInput(
                  title: state.fields['title']!.value.toString(),
                  description: state.fields['desc']!.value.toString(),
                  redirectScreen: 'home',
                  notificationType: notificationType,
                  individualUserId: individualUserId,
                  date: DateTime(
                    date.year,
                    date.month,
                    date.day,
                    now.hour == time.hour ? sendingTime.hour : time.hour,
                    now.minute == time.minute
                        ? sendingTime.minute + 1
                        : time.minute,
                  ).toUtc().toString(),
                  interval: interval,
                  targetGroup: targetGroup,
                ),
              );
        }
      }
    } else {
      if (notificationType ==
          CreateScheduledNotificationInputNotificationType
              .swaggerGeneratedUnknown) {
        context.read<FetchNotificationTypesCubit>().reEmitted(true);
      }
      if (targetGroup ==
          CreateScheduledNotificationInputTargetGroup.swaggerGeneratedUnknown) {
        context.read<FetchUserGroupsCubit>().reEmitted(true);
      }
    }
  }
}
