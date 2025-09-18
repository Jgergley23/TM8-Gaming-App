import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/router/router.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/widgets/tm8_alert_dialog_widget.dart';
import 'package:tm8/app/widgets/tm8_body_container_widget.dart';
import 'package:tm8/app/widgets/tm8_error_widget.dart';
import 'package:tm8/app/widgets/tm8_main_app_bar_scaffold_widget.dart';
import 'package:tm8/app/widgets/tm8_main_button_widget.dart';
import 'package:tm8/app/widgets/tm8_snack_bar_widget.dart';
import 'package:tm8/env/env.dart';
import 'package:tm8/friends/presentation/logic/fetch_friends_cubit/fetch_friends_cubit.dart';
import 'package:tm8/friends/presentation/logic/friends_details_cubit/friends_details_cubit.dart';
import 'package:tm8/friends/presentation/widgets/block_user_widget.dart';
import 'package:tm8/friends/presentation/widgets/report_user_widget.dart';
import 'package:tm8/gen/assets.gen.dart';
import 'package:tm8/login/presentation/widgets/tm8_loading_overlay_widget.dart';
import 'package:tm8/messages/presentation/logic/add_friend_cubit/add_friend_cubit.dart';
import 'package:tm8/messages/presentation/logic/block_logic_cubit/block_logic_cubit.dart';
import 'package:tm8/messages/presentation/logic/block_user_cubit/block_user_cubit.dart';
import 'package:tm8/messages/presentation/logic/check_friend_status_cubit/check_friend_status_cubit.dart';
import 'package:tm8/messages/presentation/logic/fetch_channels_cubit/fetch_channels_cubit.dart';
import 'package:tm8/messages/presentation/logic/report_user_cubit/report_user_cubit.dart';
import 'package:tm8/messages/presentation/logic/unblock_user_cubit/unblock_user_cubit.dart';
import 'package:tm8/messages/presentation/widgets/user_actions_widget.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

@RoutePage() //MessagesProfileDetailsRoute.page
class MessagesProfileDetailsScreen extends StatefulWidget {
  const MessagesProfileDetailsScreen({
    super.key,
    required this.userId,
    required this.userName,
    this.photoKey,
  });

  final String userId;
  final String userName;
  final String? photoKey;

  @override
  State<MessagesProfileDetailsScreen> createState() =>
      _MessagesProfileDetailsScreenState();
}

class _MessagesProfileDetailsScreenState
    extends State<MessagesProfileDetailsScreen> {
  final addFriendCubit = sl<AddFriendCubit>();
  final checkFriendStatusCubit = sl<CheckFriendStatusCubit>();
  final reportUserCubit = sl<ReportUserCubit>();
  final blockUserCubit = sl<BlockUserCubit>();
  final unblockUserCubit = sl<UnblockUserCubit>();
  final blockLogicCubit = sl<BlockLogicCubit>();
  final friendsDetailsCubit = sl<FriendsDetailsCubit>();

  List<String> items = ['Report User', 'Block User'];
  List<Widget> icons = [
    Assets.user.reportUser.svg(),
    Assets.user.blockUser.svg(),
  ];

  @override
  void initState() {
    super.initState();
    checkFriendStatusCubit.checkFriendStatus(userId: widget.userId);
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
            create: (context) => addFriendCubit,
          ),
          BlocProvider(
            create: (context) => checkFriendStatusCubit,
          ),
          BlocProvider(
            create: (context) => reportUserCubit,
          ),
          BlocProvider(
            create: (context) => blockUserCubit,
          ),
          BlocProvider(
            create: (context) => unblockUserCubit,
          ),
          BlocProvider(
            create: (context) => blockLogicCubit,
          ),
          BlocProvider(
            create: (context) => friendsDetailsCubit
              ..fetchFriendDetails(
                userId: widget.userId,
              ),
          ),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<AddFriendCubit, AddFriendState>(
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
                        text: 'Friend request sent',
                        error: false,
                      ),
                    );
                    checkFriendStatusCubit.checkFriendStatus(
                      userId: widget.userId,
                    );
                    sl<FetchFriendsCubit>().fetchFriends(username: null);
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
            ),
            BlocListener<ReportUserCubit, ReportUserState>(
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
                        text: 'Thanks for reporting',
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
            ),
            BlocListener<BlockUserCubit, BlockUserState>(
              listener: (context, state) {
                state.whenOrNull(
                  loading: () {
                    context.loaderOverlay.show();
                  },
                  loaded: () {
                    context.loaderOverlay.hide();
                    context.router.popUntilRouteWithName(HomePageRoute.name);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      Tm8SnackBar.snackBar(
                        color: glassEffectColor,
                        text: 'User blocked successfully',
                        error: false,
                      ),
                    );
                    blockLogicCubit.blockLogic(block: true);
                    sl<FetchChannelsCubit>().fetchChannels(username: null);
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
            ),
            BlocListener<UnblockUserCubit, UnblockUserState>(
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
                        text: 'User unblocked successfully',
                        error: false,
                      ),
                    );
                    blockLogicCubit.blockLogic(block: false);
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
            ),
            BlocListener<FriendsDetailsCubit, FriendsDetailsState>(
              listener: (context, state) {
                state.whenOrNull(
                  loaded: (userProfile) {
                    blockLogicCubit.blockLogic(block: false);
                  },
                  error: (error) {
                    if (error == 'User is blocked') {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        context.router
                            .popUntilRouteWithName(HomePageRoute.name);
                        sl<FetchFriendsCubit>().fetchFriends(username: null);
                        sl<FetchChannelsCubit>().fetchChannels(username: null);
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          Tm8SnackBar.snackBar(
                            color: glassEffectColor,
                            text: 'User has blocked you',
                            error: false,
                          ),
                        );
                      });
                    }
                  },
                );
              },
            ),
          ],
          child: Tm8BodyContainerWidget(
            child: Scaffold(
              appBar: Tm8MainAppBarScaffoldWidget(
                leading: true,
                title: 'Details',
                navigationPadding: screenPadding,
              ),
              body: Padding(
                padding: screenPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    h12,
                    if (widget.photoKey == null) ...[
                      Container(
                        height: 64,
                        width: 64,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: achromatic600,
                        ),
                        child: Center(
                          child: Text(
                            widget.userName[0].toUpperCase(),
                            style: heading4Bold.copyWith(
                              color: achromatic100,
                            ),
                          ),
                        ),
                      ),
                    ] else ...[
                      ClipOval(
                        child: Image.network(
                          '${Env.stagingUrlAmazon}/${widget.photoKey}',
                          height: 64,
                          width: 64,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ],
                    h8,
                    Text(
                      widget.userName,
                      style: heading4Bold.copyWith(color: achromatic100),
                    ),
                    h12,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BlocBuilder<CheckFriendStatusCubit,
                            CheckFriendStatusState>(
                          builder: (context, state) {
                            return state.when(
                              initial: SizedBox.new,
                              loading: SizedBox.new,
                              loaded: (friendStatus) {
                                if (friendStatus.isFriend) {
                                  return const SizedBox();
                                } else {
                                  return Row(
                                    children: [
                                      Tm8MainButtonWidget(
                                        onTap: () {
                                          addFriendCubit.addFriend(
                                            userId: widget.userId,
                                            username: widget.userName,
                                          );
                                        },
                                        buttonColor: primaryTeal,
                                        text: 'Add friend',
                                      ),
                                      w12,
                                    ],
                                  );
                                }
                              },
                              error: (error) {
                                return Tm8ErrorWidget(
                                  onTapRetry: () {},
                                  error: error,
                                );
                              },
                            );
                          },
                        ),
                        BlocBuilder<BlockLogicCubit, bool>(
                          builder: (context, state) {
                            return Tm8MainButtonWidget(
                              onTap: () {
                                if (!state) {
                                  context.pushRoute(
                                    FriendsDetailsRoute(
                                      userId: widget.userId,
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    Tm8SnackBar.snackBar(
                                      color: glassEffectColor,
                                      text: 'This user was blocked by you.',
                                      error: false,
                                    ),
                                  );
                                }
                              },
                              buttonColor: achromatic500,
                              text: 'View profile',
                            );
                          },
                        ),
                      ],
                    ),
                    h24,
                    BlocBuilder<BlockLogicCubit, bool>(
                      builder: (context, state) {
                        return ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return UserActionsWidget(
                              onTap: () {
                                if (index == 0) {
                                  tm8PopUpDialogWidget(
                                    context,
                                    padding: 12,
                                    width: 300,
                                    borderRadius: 20,
                                    popup: (context) => ReportUserWidget(
                                      onTap: (value) {
                                        reportUserCubit.reportUsers(
                                          userId: widget.userId,
                                          body: ReportUserInput(
                                            reportReason: value,
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                } else if (index == 1) {
                                  if (state) {
                                    tm8PopUpDialogWidget(
                                      context,
                                      padding: 12,
                                      width: 300,
                                      borderRadius: 20,
                                      popup: (context) =>
                                          _buildUnblockUserPopUp(context),
                                    );
                                  } else {
                                    tm8PopUpDialogWidget(
                                      context,
                                      padding: 12,
                                      width: 300,
                                      borderRadius: 20,
                                      popup: (context) => BlockUserWidget(
                                        onTap: () {
                                          blockUserCubit.blockUser(
                                            userId: widget.userId,
                                          );
                                        },
                                      ),
                                    );
                                  }
                                }
                              },
                              item: index == 1 && state
                                  ? 'Unblock user'
                                  : items[index],
                              icon: icons[index],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return h12;
                          },
                          itemCount: items.length,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column _buildUnblockUserPopUp(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Unblock User?',
              style: heading4Regular.copyWith(
                color: achromatic100,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Assets.common.x.svg(),
            ),
          ],
        ),
        h18,
        Text(
          'Are you sure you want to unblock this user? This user will be able to send you messages if you unblock them. ',
          style: body1Regular.copyWith(
            color: achromatic200,
          ),
          textAlign: TextAlign.left,
        ),
        h12,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Tm8MainButtonWidget(
              onTap: () async {
                Navigator.of(context).pop();
              },
              buttonColor: achromatic500,
              text: 'Cancel',
              width: 130,
            ),
            w12,
            Tm8MainButtonWidget(
              onTap: () {
                unblockUserCubit.unblockUser(
                  userId: widget.userId,
                );
                Navigator.of(context).pop();
              },
              buttonColor: primaryTeal,
              text: 'Unblock',
              width: 130,
            ),
          ],
        ),
      ],
    );
  }
}
