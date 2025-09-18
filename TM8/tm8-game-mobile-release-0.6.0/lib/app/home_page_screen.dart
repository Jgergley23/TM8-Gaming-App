import 'package:auto_route/auto_route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tm8/app/api/socket_io.dart';
import 'package:tm8/app/bottom_app_navigation_cubit/bottom_app_navigation_cubit.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/router/router.dart';
import 'package:tm8/app/services/notification_service.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/widgets/tm8_body_container_widget.dart';
import 'package:tm8/app/widgets/tm8_bottom_app_bar_widget.dart';
import 'package:tm8/app/widgets/tm8_main_app_bar_scaffold_widget.dart';
import 'package:tm8/app/widgets/tm8_snack_bar_widget.dart';
import 'package:tm8/friends/presentation/logic/fetch_friends_cubit/fetch_friends_cubit.dart';
import 'package:tm8/gen/assets.gen.dart';
import 'package:tm8/login/presentation/widgets/tm8_loading_overlay_widget.dart';
import 'package:tm8/messages/presentation/logic/fetch_channels_cubit/fetch_channels_cubit.dart';
import 'package:tm8/notifications/logic/fetch_notifications_cubit/fetch_notifications_cubit.dart';
import 'package:tm8/notifications/logic/notification_unread_count_cubit/notification_unread_count_cubit.dart';
import 'package:tm8/notifications/logic/refresh_notification_token_cubit/refresh_notification_token_cubit.dart';
import 'package:tm8/notifications/logic/slidable_controller_cubit/slidable_controller_cubit.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

@RoutePage()
class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final titles = [
    'Matchmaking',
    'Friends',
    'Messages',
    'Notifications',
    'Profile',
  ];
  final actionIcons = [
    Assets.common.plus.svg(),
    Assets.common.addFriend.svg(),
    Assets.common.editMessage.svg(),
    null,
    Assets.common.settings.svg(),
  ];
  var addedGames = <String>[];
  GetMeUserResponse? userInfo;

  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    sl<FetchChannelsCubit>().fetchChannels(username: null);
    _handlePermission();
    _handleNotifications();
    _refreshNotificationToken();
    SocketInitialized().initSocket();
  }

  // handle all necessary permissions for home page
  _handlePermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    // for testing purposes
    // final token = await messaging.getToken();
    // final userID = sl<Tm8Storage>().userId;

    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  // handle notifications on home page
  // if user receives a notification, it will be handled here
  void _handleNotifications() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.notification != null) {
        final notificationService = NotificationService();
        sl<NotificationUnreadCountCubit>().fetchNotificationUnreadCount();
        sl<FetchNotificationsCubit>().fetchNotifications();
        if (message.data['redirectScreen'] == 'Messages') {
          sl<FetchChannelsCubit>().fetchChannels(username: null);
        } else if (message.data['redirectScreen']
            .toString()
            .contains('match')) {
          final split = message.data['redirectScreen'].toString().split('/');
          context
              .pushRoute(MatchRoute(game: 'Fortnite', matchUserId: split.last));
        } else if (message.data['redirectScreen']
            .toString()
            .contains('friend')) {
          sl<FetchFriendsCubit>().fetchFriends(username: null);
        }
        await notificationService.showNotification(
          message.notification.hashCode,
          message.notification?.title ?? '',
          message.notification?.body ?? '',
          message.data['redirectScreen'] ?? '',
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      final notification = message.notification;
      if (notification != null) {
        sl<NotificationUnreadCountCubit>().fetchNotificationUnreadCount();
        sl<FetchNotificationsCubit>().fetchNotifications();

        if (message.data['redirectScreen'] == 'Messages') {
          sl<FetchChannelsCubit>().fetchChannels(username: null);
        } else if (message.data['redirectScreen']
            .toString()
            .contains('match')) {
          final split = message.data['redirectScreen'].toString().split('/');
          context
              .pushRoute(MatchRoute(game: 'Fortnite', matchUserId: split.last));
        } else if (message.data['redirectScreen']
            .toString()
            .contains('CallScreen')) {
          final split = message.data['redirectScreen'].toString().split('/');
          context.pushRoute(
            CallRoute(
              userCallId: split[1],
              username: split.last,
              callId: split[1],
            ),
          );
        } else if (message.data['redirectScreen']
            .toString()
            .contains('friend')) {
          sl<FetchFriendsCubit>().fetchFriends(username: null);
        }
      }
    });

    FirebaseMessaging.onBackgroundMessage((message) async {
      final notification = message.notification;
      if (notification != null) {
        sl<NotificationUnreadCountCubit>().fetchNotificationUnreadCount();
        sl<FetchNotificationsCubit>().fetchNotifications();
        if (message.data['redirectScreen'] == 'Messages') {
          sl<FetchChannelsCubit>().fetchChannels(username: null);
        } else if (message.data['redirectScreen']
            .toString()
            .contains('match')) {
          final split = message.data['redirectScreen'].toString().split('/');
          context
              .pushRoute(MatchRoute(game: 'Fortnite', matchUserId: split.last));
        } else if (message.data['redirectScreen']
            .toString()
            .contains('CallScreen')) {
          final split = message.data['redirectScreen'].toString().split('/');
          context.pushRoute(
            CallRoute(
              userCallId: split[1],
              username: split.last,
              callId: split[1],
            ),
          );
        } else if (message.data['redirectScreen']
            .toString()
            .contains('friend')) {
          sl<FetchFriendsCubit>().fetchFriends(username: null);
        }
      }
    });
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        sl<NotificationUnreadCountCubit>().fetchNotificationUnreadCount();
        sl<FetchNotificationsCubit>().fetchNotifications();
      }
    });
  }

  // if token expires, refresh it for notifications
  void _refreshNotificationToken() async {
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
      await sl<RefreshNotificationTokenCubit>()
          .refreshToken(body: NotificationRefreshTokenDto(token: fcmToken));
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focusNode.unfocus();
      },
      child: Tm8BodyContainerWidget(
        child: LoaderOverlay(
          useDefaultLoading: false,
          overlayWidgetBuilder: (progress) {
            return Tm8LoadingOverlayWidget(progress: progress);
          },
          overlayColor: Colors.transparent,
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => sl<BottomAppNavigationCubit>(),
              ),
              BlocProvider.value(
                value: sl<NotificationUnreadCountCubit>()
                  ..fetchNotificationUnreadCount(),
              ),
            ],
            child: AutoTabsRouter.pageView(
              routes: [
                GamesRoute(
                  addedGamesCallback: (value) {
                    addedGames = value;
                  },
                ),
                FriendsRoute(focusNode: focusNode),
                MessagesRoute(focusNode: focusNode),
                const NotificationsRoute(),
                ProfileRoute(
                  profileInfoCallback: (userProfile) {
                    userInfo = userProfile;
                  },
                ),
              ],
              builder: (context, child, controller) {
                final tabsRouter = AutoTabsRouter.of(context);
                context
                    .read<BottomAppNavigationCubit>()
                    .emitNewPage(index: tabsRouter.activeIndex);
                sl<SlidableControllerCubit>().open();
                focusNode.unfocus();
                return Scaffold(
                  appBar: Tm8MainAppBarScaffoldWidget(
                    onActionPressed: () {
                      if (tabsRouter.activeIndex == 0) {
                        if (addedGames.length == 4) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            Tm8SnackBar.snackBar(
                              color: glassEffectColor,
                              text: 'No games left to add.',
                              error: false,
                            ),
                          );
                        } else {
                          context
                              .pushRoute(AddGameRoute(addedGames: addedGames));
                        }
                      } else if (tabsRouter.activeIndex == 1) {
                        context.pushRoute(const AddFriendsRoute());
                      } else if (tabsRouter.activeIndex == 2) {
                        context.pushRoute(const SearchUsersMessagesRoute());
                      } else if (tabsRouter.activeIndex == 4) {
                        // if (userInfo != null) {
                        context.pushRoute(const SettingsRoute());
                        // }
                      }
                    },
                    title: titles[tabsRouter.activeIndex],
                    leading: false,
                    action: actionIcons[tabsRouter.activeIndex] != null
                        ? true
                        : null,
                    actionIcon: actionIcons[tabsRouter.activeIndex],
                    navigationPadding: const EdgeInsets.only(top: 12),
                  ),
                  body: Container(
                    padding: screenPadding,
                    child: child,
                  ),
                  bottomNavigationBar: Tm8BottomAppBarWidget(
                    onTap: (value) {
                      focusNode.unfocus();
                      tabsRouter.setActiveIndex(value);
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
