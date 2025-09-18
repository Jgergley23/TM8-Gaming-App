import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/widgets/tm8_body_container_widget.dart';
import 'package:tm8/app/widgets/tm8_error_widget.dart';
import 'package:tm8/app/widgets/tm8_main_app_bar_scaffold_widget.dart';
import 'package:tm8/app/widgets/tm8_snack_bar_widget.dart';
import 'package:tm8/gen/assets.gen.dart';
import 'package:tm8/login/presentation/widgets/tm8_loading_overlay_widget.dart';
import 'package:tm8/profile/presentation/logic/update_notification_settings_cubit/update_notifications_settings_cubit.dart';
import 'package:tm8/profile/presentation/logic/fetch_notification_settings_cubit/fetch_notification_settings_cubit.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

@RoutePage() //NotificationSettingsRoute.page
class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({
    super.key,
    required this.notificationSettings,
  });

  final UserNotificationSettingsResponse notificationSettings;

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  final fetchNotificationSettingsCubit = sl<FetchNotificationSettingsCubit>();
  final updateNotificationSettingsCubit =
      sl<UpdateNotificationsSettingsCubit>();

  List<bool> switches = [false, false, false, false, false, false];

  @override
  void initState() {
    super.initState();

    switches = [
      widget.notificationSettings.enabled,
      widget.notificationSettings.match,
      widget.notificationSettings.message,
      widget.notificationSettings.friendAdded,
      widget.notificationSettings.news,
      widget.notificationSettings.reminders,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidgetBuilder: (progress) {
        return Tm8LoadingOverlayWidget(progress: progress);
      },
      overlayColor: Colors.transparent,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                fetchNotificationSettingsCubit..fetchNotificationSettings(),
          ),
          BlocProvider(
            create: (context) => updateNotificationSettingsCubit,
          ),
        ],
        child: BlocListener<UpdateNotificationsSettingsCubit,
            UpdateNotificationsSettingsState>(
          listener: (context, state) {
            state.whenOrNull(
              loading: () {
                context.loaderOverlay.show();
              },
              loaded: () {
                context.loaderOverlay.hide();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.maybePop();
                });
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  Tm8SnackBar.snackBar(
                    color: glassEffectColor,
                    text: 'Notification settings updated successfully.',
                    error: false,
                  ),
                );
              },
              error: (error) {
                context.loaderOverlay.hide();
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  Tm8SnackBar.snackBar(
                    color: glassEffectColor,
                    text: error,
                    error: true,
                  ),
                );
              },
            );
          },
          child: Tm8BodyContainerWidget(
            child: Scaffold(
              appBar: Tm8MainAppBarScaffoldWidget(
                onActionPressed: () {
                  switches[0] == false
                      ? updateNotificationSettingsCubit
                          .updateNotificationSettings(
                          body: UpdateNotificationSettingsDto(
                            enabled: false,
                            match: switches[1],
                            message: switches[2],
                            friendAdded: switches[3],
                            news: switches[4],
                            reminders: switches[5],
                          ),
                        )
                      : updateNotificationSettingsCubit
                          .updateNotificationSettings(
                          body: UpdateNotificationSettingsDto(
                            enabled: switches[0],
                            match: switches[1],
                            message: switches[2],
                            friendAdded: switches[3],
                            news: switches[4],
                            reminders: switches[5],
                          ),
                        );
                },
                title: 'Notification settings',
                leading: true,
                navigationPadding: const EdgeInsets.only(top: 12, left: 12),
                action: true,
                actionIcon: Assets.settings.checkmark.svg(),
                actionPadding: EdgeInsets.zero,
              ),
              body: Padding(
                padding: screenPadding,
                child: BlocBuilder<FetchNotificationSettingsCubit,
                    FetchNotificationSettingsState>(
                  builder: (context, state) {
                    return state.when(
                      initial: SizedBox.new,
                      loading: () {
                        return Skeletonizer(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              h12,
                              for (var i = 0; i < 6; i++) ...[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Display Value',
                                      style: heading4Regular.copyWith(
                                        color: achromatic200,
                                      ),
                                    ),
                                    w12,
                                    Switch(
                                      value: false,
                                      activeColor: primaryTeal,
                                      inactiveTrackColor: achromatic400,
                                      activeTrackColor: achromatic400,
                                      onChanged: (value) {},
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        );
                      },
                      loaded: (notificationSettings) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            h12,
                            for (final item in notificationSettings) ...[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    item.displayValue,
                                    style: heading4Regular.copyWith(
                                      color: achromatic200,
                                    ),
                                  ),
                                  Container(
                                    transform: Matrix4.identity()..scale(0.8),
                                    child: Switch(
                                      onChanged: (value) {
                                        if (switches[0] == false &&
                                            notificationSettings
                                                    .indexOf(item) !=
                                                0) {
                                          return;
                                        }
                                        setState(() {
                                          switches[notificationSettings
                                              .indexOf(item)] = value;
                                        });
                                      },
                                      value: switches[
                                          notificationSettings.indexOf(item)],
                                      activeColor: switches[0] == false &&
                                              notificationSettings
                                                      .indexOf(item) !=
                                                  0
                                          ? achromatic100
                                          : primaryTeal,
                                      inactiveTrackColor: achromatic400,
                                      activeTrackColor: achromatic400,
                                      trackOutlineColor:
                                          const WidgetStatePropertyAll(
                                        Colors.transparent,
                                      ),
                                      trackOutlineWidth:
                                          const WidgetStatePropertyAll(4),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        );
                      },
                      error: (error) {
                        return Tm8ErrorWidget(
                          onTapRetry: () {
                            fetchNotificationSettingsCubit
                                .fetchNotificationSettings();
                          },
                          error: error,
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
