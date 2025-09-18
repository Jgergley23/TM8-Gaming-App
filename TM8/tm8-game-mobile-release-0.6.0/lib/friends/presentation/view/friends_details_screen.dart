import 'package:audioplayers/audioplayers.dart';
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
import 'package:tm8/app/widgets/tm8_alert_dialog_widget.dart';
import 'package:tm8/app/widgets/tm8_body_container_widget.dart';
import 'package:tm8/app/widgets/tm8_error_widget.dart';
import 'package:tm8/app/widgets/tm8_main_app_bar_scaffold_widget.dart';
import 'package:tm8/app/widgets/tm8_main_button_widget.dart';
import 'package:tm8/app/widgets/tm8_snack_bar_widget.dart';
import 'package:tm8/env/env.dart';
import 'package:tm8/friends/presentation/logic/fetch_friends_cubit/fetch_friends_cubit.dart';
import 'package:tm8/friends/presentation/logic/fetch_friends_games_cubit/fetch_friends_games_cubit.dart';
import 'package:tm8/friends/presentation/logic/friend_details_bottom_sheet_logic_cubit/friend_details_bottom_sheet_logic_cubit.dart';
import 'package:tm8/friends/presentation/logic/friends_details_cubit/friends_details_cubit.dart';
import 'package:tm8/friends/presentation/logic/remove_friend_cubit/remove_friend_cubit.dart';
import 'package:tm8/friends/presentation/widgets/block_user_widget.dart';
import 'package:tm8/friends/presentation/widgets/bottom_sheet_friend_details_widget.dart';
import 'package:tm8/friends/presentation/widgets/report_user_widget.dart';
import 'package:tm8/gen/assets.gen.dart';
import 'package:tm8/login/presentation/widgets/tm8_loading_overlay_widget.dart';
import 'package:tm8/messages/presentation/logic/add_friend_cubit/add_friend_cubit.dart';
import 'package:tm8/messages/presentation/logic/audio_controller_cubit/audio_controller_cubit.dart';
import 'package:tm8/messages/presentation/logic/block_user_cubit/block_user_cubit.dart';
import 'package:tm8/messages/presentation/logic/fetch_channels_cubit/fetch_channels_cubit.dart';
import 'package:tm8/messages/presentation/logic/report_user_cubit/report_user_cubit.dart';
import 'package:tm8/profile/presentation/logic/download_intro_cubit/download_intro_cubit.dart';
import 'package:tm8/profile/presentation/logic/fetch_user_profile_cubit/fetch_user_profile_cubit.dart';
import 'package:tm8/profile/presentation/widgets/profile_settings_buttons_widget.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

@RoutePage() //AddFriendsRoute.page
class FriendsDetailsScreen extends StatefulWidget {
  const FriendsDetailsScreen({super.key, required this.userId});

  final String userId;

  @override
  State<FriendsDetailsScreen> createState() => _FriendsDetailsScreenState();
}

class _FriendsDetailsScreenState extends State<FriendsDetailsScreen> {
  final friendsDetailsCubit = sl<FriendsDetailsCubit>();
  final addFriendCubit = sl<AddFriendCubit>();
  final removeFriendCubit = sl<RemoveFriendCubit>();
  final fetchFriendsGamesCubit = sl<FetchFriendsGamesCubit>();
  final reportUserCubit = sl<ReportUserCubit>();
  final blockUserCubit = sl<BlockUserCubit>();
  final friendDetailsBottomSheetLogicCubit =
      sl<FriendDetailsBottomSheetLogicCubit>();
  final audioControllerCubit = sl<AudioControllerCubit>();
  final downloadIntroCubit = sl<DownloadIntroCubit>();

  late AudioPlayer audioPlayer;
  Duration? duration;

  @override
  void initState() {
    super.initState();
    friendsDetailsCubit.fetchFriendDetails(userId: widget.userId);
    fetchFriendsGamesCubit.fetchUserGames(userId: widget.userId);
    audioPlayer = AudioPlayer();
    audioPlayer.onPlayerStateChanged.listen((event) {
      if (event == PlayerState.completed) {
        audioControllerCubit.changeSetting(enabled: false);
      }
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  void playAudio(Source source) async {
    await audioPlayer.setVolume(1);
    await audioPlayer.play(source);
    duration = await audioPlayer.getDuration();
    audioControllerCubit.changeSetting(enabled: true);
  }

  void pauseAudio() async {
    await audioPlayer.pause();

    audioControllerCubit.changeSetting(enabled: false);
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
            create: (context) => friendsDetailsCubit,
          ),
          BlocProvider(
            create: (context) => addFriendCubit,
          ),
          BlocProvider(
            create: (context) => fetchFriendsGamesCubit,
          ),
          BlocProvider(
            create: (context) => reportUserCubit,
          ),
          BlocProvider(
            create: (context) => blockUserCubit,
          ),
          BlocProvider(
            create: (context) => removeFriendCubit,
          ),
          BlocProvider(
            create: (context) => friendDetailsBottomSheetLogicCubit,
          ),
          BlocProvider(
            create: (context) =>
                audioControllerCubit..changeSetting(enabled: false),
          ),
          BlocProvider(
            create: (context) => downloadIntroCubit,
          ),
          BlocProvider.value(
            value: sl<FetchUserProfileCubit>()..fetchUserProfile(),
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
                        text: 'Friend successfully added',
                        error: false,
                      ),
                    );
                    sl<FetchFriendsCubit>().fetchFriends(username: null);
                    friendsDetailsCubit.fetchFriendDetails(
                      userId: widget.userId,
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
            BlocListener<RemoveFriendCubit, RemoveFriendState>(
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
                        text: 'Friend successfully removed',
                        error: false,
                      ),
                    );
                    sl<FetchFriendsCubit>().fetchFriends(username: null);
                    friendsDetailsCubit.fetchFriendDetails(
                      userId: widget.userId,
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
            BlocListener<FriendsDetailsCubit, FriendsDetailsState>(
              listener: (context, state) {
                state.whenOrNull(
                  loaded: (userProfile) {
                    if (userProfile.isFriend == true) {
                      friendDetailsBottomSheetLogicCubit
                          .bottomShieldLogicUpdate(
                        items: BottomSheetItems(
                          items: ['Remove', 'Block', 'Report'],
                          assets: [
                            Assets.common.friendIcon.svg(),
                            Assets.user.blockUser.svg(),
                            Assets.user.reportUser.svg(),
                          ],
                          colors: [achromatic100, achromatic100, achromatic100],
                        ),
                      );
                    } else {
                      friendDetailsBottomSheetLogicCubit
                          .bottomShieldLogicUpdate(
                        items: BottomSheetItems(
                          items: ['Block', 'Report'],
                          assets: [
                            Assets.user.blockUser.svg(),
                            Assets.user.reportUser.svg(),
                          ],
                          colors: [achromatic100, achromatic100],
                        ),
                      );
                    }
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
            BlocListener<DownloadIntroCubit, DownloadIntroState>(
              listener: (context, state) {
                state.whenOrNull(
                  loaded: (source) {
                    playAudio(source);
                  },
                  error: (error) {
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
          ],
          child: Tm8BodyContainerWidget(
            child: Scaffold(
              appBar: Tm8MainAppBarScaffoldWidget(
                onActionPressed: () {
                  tm8BottomSheetFriendDetailsWidget(
                    context,
                    onTap: (value) {
                      Navigator.of(context).pop();
                      if (value == 'Remove') {
                        tm8PopUpDialogWidget(
                          context,
                          padding: 12,
                          width: 300,
                          borderRadius: 20,
                          popup: (context) => _buildRemoveFriendPopUp(context),
                        );
                      } else if (value == 'Report') {
                        tm8PopUpDialogWidget(
                          context,
                          padding: 12,
                          width: 300,
                          borderRadius: 20,
                          popup: (context) => ReportUserWidget(
                            onTap: (value) {
                              reportUserCubit.reportUsers(
                                userId: widget.userId,
                                body: ReportUserInput(reportReason: value),
                              );
                            },
                          ),
                        );
                      } else if (value == 'Block') {
                        tm8PopUpDialogWidget(
                          context,
                          padding: 12,
                          width: 300,
                          borderRadius: 20,
                          popup: (context) => BlockUserWidget(
                            onTap: () {
                              blockUserCubit.blockUser(userId: widget.userId);
                            },
                          ),
                        );
                      }
                    },
                    items: friendDetailsBottomSheetLogicCubit.state,
                  );
                },
                title: '',
                leading: true,
                action: true,
                actionIcon: Assets.common.hamburger.image(),
                navigationPadding: const EdgeInsets.only(top: 12, left: 12),
              ),
              body: SingleChildScrollView(
                padding: screenPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BlocBuilder<FriendsDetailsCubit, FriendsDetailsState>(
                      builder: (context, state) {
                        return state.when(
                          initial: SizedBox.new,
                          loading: () {
                            return _buildLoadingFriendsDetails();
                          },
                          loaded: (userProfile) {
                            return _buildLoadedFriendsDetails(
                              userProfile,
                              context,
                            );
                          },
                          error: (error) {
                            if (error == 'User is blocked') {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                context.maybePop();
                                sl<FetchFriendsCubit>()
                                    .fetchFriends(username: null);
                                sl<FetchChannelsCubit>()
                                    .fetchChannels(username: null);
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  Tm8SnackBar.snackBar(
                                    color: glassEffectColor,
                                    text: 'User has blocked you',
                                    error: false,
                                  ),
                                );
                              });
                            }
                            return Tm8ErrorWidget(
                              onTapRetry: () {
                                friendsDetailsCubit.fetchFriendDetails(
                                  userId: widget.userId,
                                );
                              },
                              error: error,
                            );
                          },
                        );
                      },
                    ),
                    Text(
                      'Games added',
                      style: heading4Regular.copyWith(
                        color: achromatic100,
                      ),
                    ),
                    h12,
                    BlocBuilder<FetchFriendsGamesCubit, FetchFriendsGamesState>(
                      builder: (context, state) {
                        return state.when(
                          initial: SizedBox.new,
                          loading: () {
                            return _buildLoadingGamesAdded();
                          },
                          loaded: (games) {
                            if (games.games.isEmpty) {
                              return Column(
                                children: [
                                  Text(
                                    'User has no games',
                                    style: body1Regular.copyWith(
                                      color: achromatic200,
                                    ),
                                  ),
                                ],
                              );
                            }
                            return _buildLoadedGamesAdded(games);
                          },
                          error: (error) {
                            return Tm8ErrorWidget(
                              onTapRetry: () {
                                fetchFriendsGamesCubit.fetchUserGames(
                                  userId: widget.userId,
                                );
                              },
                              error: error,
                            );
                          },
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

  GridView _buildLoadedGamesAdded(UserGamesResponse games) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: games.games.length,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            Container(
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(
                    statusMapAsset[games.games[index].displayName] ?? '',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: gameTextShadowColor,
              ),
            ),
            SizedBox(
              height: 160,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    statusMapAssetIcon[games.games[index].displayName] ??
                        const SizedBox(),
                    h8,
                    Text(
                      games.games[index].displayName,
                      style: body1Bold.copyWith(
                        color: achromatic100,
                      ),
                    ),
                    h10,
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Skeletonizer _buildLoadingGamesAdded() {
    return Skeletonizer(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemCount: 2,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Container(
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage(
                      statusMapAsset['Fortnite'] ?? '',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: gameTextShadowColor,
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    statusMapAssetIcon['Fortnite'] ?? const SizedBox(),
                    h8,
                    Text(
                      'Fortnite',
                      style: body1Bold.copyWith(
                        color: achromatic100,
                      ),
                    ),
                    h20,
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Skeletonizer _buildLoadingFriendsDetails() {
    return Skeletonizer(
      child: Column(
        children: [
          BlocBuilder<FetchUserProfileCubit, FetchUserProfileState>(
            builder: (context, state) {
              return state.maybeWhen(
                loaded: (userProfile) {
                  if (userProfile.photoKey == null) {
                    return Container(
                      height: 64,
                      width: 64,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: achromatic600,
                      ),
                      child: Center(
                        child: Text(
                          userProfile.username[0].toUpperCase(),
                          style: heading4Bold.copyWith(
                            color: achromatic100,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return ClipOval(
                      child: Image.network(
                        '${Env.stagingUrlAmazon}/${userProfile.photoKey}',
                        height: 64,
                        width: 64,
                        fit: BoxFit.fitWidth,
                      ),
                    );
                  }
                },
                orElse: SizedBox.new,
              );
            },
          ),
          h8,
          Text(
            'username',
            style: heading4Bold.copyWith(
              color: achromatic100,
            ),
          ),
          h12,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Tm8MainButtonWidget(
                onTap: () {},
                buttonColor: primaryTeal,
                text: 'Add friend',
              ),
              w12,
              Tm8MainButtonWidget(
                onTap: () {},
                buttonColor: achromatic500,
                text: 'Message',
              ),
              w12,
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 40,
                  width: 45,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: achromatic500,
                  ),
                  child: Center(
                    child: Assets.user.playButton.svg(),
                  ),
                ),
              ),
            ],
          ),
          h12,
          Text(
            'user profile description',
            style: body1Regular.copyWith(
              color: achromatic200,
            ),
          ),
          h24,
        ],
      ),
    );
  }

  Column _buildLoadedFriendsDetails(
    UserProfileResponse userProfile,
    BuildContext context,
  ) {
    return Column(
      children: [
        if (userProfile.photo == null) ...[
          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: achromatic600,
            ),
            child: Center(
              child: Text(
                userProfile.username[0].toUpperCase(),
                style: heading2Bold.copyWith(
                  color: achromatic100,
                ),
              ),
            ),
          ),
        ] else ...[
          ClipOval(
            child: Image.network(
              '${Env.stagingUrlAmazon}/${userProfile.photo}',
              height: 90,
              width: 90,
              fit: BoxFit.fitWidth,
            ),
          ),
        ],
        h8,
        Text(
          userProfile.username,
          style: heading4Bold.copyWith(
            color: achromatic100,
          ),
        ),
        h12,
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (userProfile.isFriend != true) ...[
              Tm8MainButtonWidget(
                onTap: () {
                  tm8PopUpDialogWidget(
                    context,
                    padding: 12,
                    width: 300,
                    borderRadius: 20,
                    popup: (context) => _buildAddFriendPopUp(
                      context,
                      userProfile.username,
                    ),
                  );
                },
                buttonColor: primaryTeal,
                text: 'Add friend',
              ),
              w12,
            ],
            Tm8MainButtonWidget(
              onTap: () async {
                sl<FetchChannelsCubit>().fetchChannels(
                  username: null,
                );
                context
                    .pushRoute(
                  MessagingRoute(
                    userId: widget.userId,
                    username: userProfile.username,
                  ),
                )
                    .whenComplete(() {
                  sl<FetchChannelsCubit>().refetchMessages();
                });
              },
              buttonColor: achromatic500,
              text: 'Message',
            ),
            w12,
            BlocBuilder<AudioControllerCubit, bool>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    if (state) {
                      pauseAudio();
                    } else {
                      if (userProfile.audio != null) {
                        downloadIntroCubit.downloadIntro(
                          audioKey: userProfile.audio!,
                        );
                      } else {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          Tm8SnackBar.snackBar(
                            color: glassEffectColor,
                            text: 'No intro audio to play.',
                            error: false,
                          ),
                        );
                      }
                    }
                  },
                  child: Stack(
                    children: [
                      ProfileSettingsButtonsWidget(
                        asset: state
                            ? Assets.common.stopAudio.svg()
                            : Assets.common.startAudio.svg(),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        if (userProfile.description != null) ...[
          h12,
          Text(
            userProfile.description ?? '',
            style: body1Regular.copyWith(
              color: achromatic200,
            ),
          ),
        ],
        h24,
      ],
    );
  }

  Column _buildAddFriendPopUp(
    BuildContext context,
    String username,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Add friend ',
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
          'Are you sure you want to add $username as your friend? ',
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
                addFriendCubit.addFriend(
                  userId: widget.userId,
                  username: username,
                );
                Navigator.of(context).pop();
              },
              buttonColor: primaryTeal,
              text: 'Add',
              width: 130,
            ),
          ],
        ),
      ],
    );
  }

  Column _buildRemoveFriendPopUp(
    BuildContext context,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Remove friend? ',
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
          'Are you sure you want to remove your friend? ',
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
                removeFriendCubit.removeFriend(userId: widget.userId);
                Navigator.of(context).pop();
              },
              buttonColor: errorTextColor,
              text: 'Remove',
              width: 130,
            ),
          ],
        ),
      ],
    );
  }

  final Map<String, String> statusMapAsset = {
    'Apex Legends': Assets.games.apexLegendsAsset.path,
    'Fortnite': Assets.games.fortniteAsset.path,
    'Call Of Duty': Assets.games.callOfDutyAsset.path,
    'Rocket League': Assets.games.rocketLeagueAsset.path,
  };
  final Map<String, Widget> statusMapAssetIcon = {
    'Apex Legends': Assets.games.apexLegendsIcon.image(height: 24, width: 24),
    'Fortnite': Assets.games.fortniteIcon.image(height: 24, width: 24),
    'Call Of Duty': Assets.games.callOfDutyIcon.image(height: 24, width: 24),
    'Rocket League': Assets.games.rocketLeagueIcon.image(height: 24, width: 24),
  };
}
