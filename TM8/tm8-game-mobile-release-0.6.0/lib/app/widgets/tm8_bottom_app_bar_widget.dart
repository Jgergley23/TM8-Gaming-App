import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tm8/app/bottom_app_navigation_cubit/bottom_app_navigation_cubit.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/gen/assets.gen.dart';
import 'package:tm8/messages/presentation/logic/fetch_channels_cubit/fetch_channels_cubit.dart';
import 'package:tm8/notifications/logic/notification_unread_count_cubit/notification_unread_count_cubit.dart';

class Tm8BottomAppBarWidget extends StatefulWidget {
  const Tm8BottomAppBarWidget({
    super.key,
    required this.onTap,
  });

  final Function(int) onTap;

  @override
  State<Tm8BottomAppBarWidget> createState() => _Tm8BottomAppBarWidgetState();
}

class _Tm8BottomAppBarWidgetState extends State<Tm8BottomAppBarWidget> {
  List<String> icons = [
    Assets.menu.matchmakingIcon.path,
    Assets.menu.friendsIcon.path,
    Assets.menu.messagesIcon.path,
    Assets.menu.notificationIcon.path,
    Assets.menu.profileIcon.path,
  ];

  var sumOfUnread = 0;

  var sumOfUnreadNotification = 0;
  final platform = Platform.isIOS ? 'ios' : 'android';
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<FetchChannelsCubit, FetchChannelsState>(
          listener: (context, state) {
            state.whenOrNull(
              loaded: (
                response,
                username,
                unreadMessagesCount,
                channels,
                unavailableUsersCount,
              ) {
                if (username == null) {
                  setState(() {
                    if (unreadMessagesCount.isNotEmpty) {
                      sumOfUnread = unreadMessagesCount
                          .reduce((value, element) => value + element);
                    }
                  });
                }
              },
            );
          },
        ),
        BlocListener<NotificationUnreadCountCubit,
            NotificationUnreadCountState>(
          listener: (context, state) {
            state.whenOrNull(
              loaded: (notificationCount) {
                setState(() {
                  if (notificationCount.count != null) {
                    sumOfUnreadNotification = notificationCount.count!.toInt();
                  } else {
                    sumOfUnreadNotification = 0;
                  }
                });
              },
            );
          },
        ),
      ],
      child: Stack(
        children: [
          Container(
            height: platform == 'ios' ? 80 : 55,
            padding: platform == 'ios'
                ? const EdgeInsets.only(
                    left: 12,
                    right: 12,
                    top: 12,
                    bottom: 30,
                  )
                : const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: glassEffectColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (var i = 0; i < 5; i++) _bottomAppBarItem(i),
              ],
            ),
          ),
          if (sumOfUnread > 0) ...[
            Positioned(
              left: MediaQuery.of(context).size.width / 2 + 6,
              top: 10,
              child: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  color: primaryTeal,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    sumOfUnread.toString(),
                    style: body2Bold.copyWith(
                      color: achromatic100,
                      fontSize: 8,
                    ),
                  ),
                ),
              ),
            ),
          ],
          if (sumOfUnreadNotification > 0) ...[
            Positioned(
              left: MediaQuery.of(context).size.width / 1.52 + 6,
              top: 10,
              child: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  color: primaryTeal,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    sumOfUnreadNotification.toString(),
                    style: body2Bold.copyWith(
                      color: achromatic100,
                      fontSize: 8,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _bottomAppBarItem(int index) {
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        widget.onTap(index);
      },
      child: BlocBuilder<BottomAppNavigationCubit, List<bool>>(
        builder: (context, state) {
          return Center(
            child: SizedBox(
              width: width * 0.18,
              child: SvgPicture.asset(
                icons[index],
                colorFilter: ColorFilter.mode(
                  state[index] == true ? achromatic100 : achromatic200,
                  BlendMode.srcIn,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
