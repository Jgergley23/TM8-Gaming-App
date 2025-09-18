import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/router/router.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/widgets/tm8_error_widget.dart';
import 'package:tm8/app/widgets/tm8_snack_bar_widget.dart';
import 'package:tm8/notifications/logic/delete_notification_cubit/delete_notification_cubit.dart';
import 'package:tm8/notifications/logic/fetch_notifications_cubit/fetch_notifications_cubit.dart';
import 'package:tm8/notifications/logic/read_notification_cubit/read_notification_cubit.dart';
import 'package:tm8/notifications/presentation/widgets/notification_item_widget.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

@RoutePage() //NotificationsRoute.page
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({
    super.key,
  });

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final readNotificationCubit = sl<ReadNotificationCubit>();
  final deleteNotificationCubit = sl<DeleteNotificationCubit>();
  final ScrollController _scrollController = ScrollController();
  bool hasNextPage = false;
  double page = 1;
  var notificationList = <NotificationResponse>[];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // Reached the bottom of the list, add more items
        if (hasNextPage) {
          page = page + 1;
          sl<FetchNotificationsCubit>().fetchNextPage(
            page: page.toInt(),
            notificationList: notificationList,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: sl<FetchNotificationsCubit>()..fetchNotifications(),
        ),
        BlocProvider(
          create: (context) => readNotificationCubit,
        ),
        BlocProvider(
          create: (context) => deleteNotificationCubit,
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<ReadNotificationCubit, ReadNotificationState>(
            listener: (context, state) {
              state.whenOrNull(
                loaded: () {
                  sl<FetchNotificationsCubit>().fetchNotifications();
                },
              );
            },
          ),
          BlocListener<DeleteNotificationCubit, DeleteNotificationState>(
            listener: (context, state) {
              state.whenOrNull(
                loading: () {
                  context.loaderOverlay.show();
                },
                loaded: () {
                  context.loaderOverlay.hide();
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    Tm8SnackBar.snackBar(
                      color: glassEffectColor,
                      text: 'Successfully deleted notification',
                      error: false,
                    ),
                  );
                  sl<FetchNotificationsCubit>().fetchNotifications();
                },
                error: (error) {
                  context.loaderOverlay.hide();
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    Tm8SnackBar.snackBar(
                      color: glassEffectColor,
                      text: error.toString(),
                      error: true,
                    ),
                  );
                },
              );
            },
          ),
          BlocListener<FetchNotificationsCubit, FetchNotificationsState>(
            listener: (context, state) {
              state.whenOrNull(
                loaded: (notifications) {
                  hasNextPage = notifications.meta.hasNextPage;
                  notificationList = notifications.items;
                },
              );
            },
          ),
        ],
        child: BlocBuilder<FetchNotificationsCubit, FetchNotificationsState>(
          builder: (context, state) {
            return state.when(
              initial: SizedBox.new,
              loading: (notificationList) {
                return Column(
                  children: [
                    _buildLoadedNotifications(notificationList),
                    h12,
                    _buildLoadingNotifications(),
                  ],
                );
              },
              loaded: (notifications) {
                if (notifications.items.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'No notifications yet',
                          style: heading2Regular.copyWith(
                            color: achromatic100,
                          ),
                        ),
                        h12,
                        Text(
                          'All notifications will appear here.',
                          style: body1Regular.copyWith(
                            color: achromatic200,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return _buildLoadedNotifications(notifications.items);
              },
              error: (error) {
                return Tm8ErrorWidget(
                  onTapRetry: () {
                    sl<FetchNotificationsCubit>().fetchNotifications();
                  },
                  error: error,
                );
              },
            );
          },
        ),
      ),
    );
  }

  ListView _buildLoadedNotifications(
    List<NotificationResponse> notifications,
  ) {
    return ListView.separated(
      shrinkWrap: true,
      controller: _scrollController,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            if (!notifications[index].data.isRead) {
              readNotificationCubit.readNotification(
                notificationId: notifications[index].id,
              );
            }
            context.pushRoute(
              NotificationDetailsRoute(
                notification: notifications[index],
              ),
            );
          },
          child: NotificationItemWidget(
            onTap: () {
              deleteNotificationCubit.deleteNotification(
                notificationId: notifications[index].id,
              );
            },
            notification: notifications[index],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return h12;
      },
      itemCount: notifications.length,
    );
  }

  Skeletonizer _buildLoadingNotifications() {
    return Skeletonizer(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final now = DateTime.now();
          return GestureDetector(
            onTap: () {},
            child: NotificationItemWidget(
              onTap: () {},
              notification: NotificationResponse(
                id: 'id',
                user: 'user',
                since: now,
                until: now,
                data: const NotificationDataResponse(
                  title: 'Notification title',
                  description: 'Notification description',
                  redirectScreen: '',
                  isRead: true,
                  notificationType:
                      NotificationDataResponseNotificationType.friendRequest,
                ),
                createdAt: now,
                updatedAt: now,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return h12;
        },
        itemCount: 6,
      ),
    );
  }
}
