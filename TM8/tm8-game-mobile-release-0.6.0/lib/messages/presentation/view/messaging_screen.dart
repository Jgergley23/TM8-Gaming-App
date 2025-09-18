import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loggy/loggy.dart';
import 'package:stream_chat_flutter/scrollable_positioned_list/src/scrollable_positioned_list.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:tm8/app/api/get_stream_client.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/router/router.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/storage/tm8_storage.dart';
import 'package:tm8/app/widgets/tm8_alert_dialog_widget.dart';
import 'package:tm8/app/widgets/tm8_body_container_widget.dart';
import 'package:tm8/app/widgets/tm8_error_widget.dart';
import 'package:tm8/app/widgets/tm8_feedback_widget.dart';
import 'package:tm8/app/widgets/tm8_main_app_bar_scaffold_widget.dart';
import 'package:tm8/app/widgets/tm8_main_button_widget.dart';
import 'package:tm8/app/widgets/tm8_snack_bar_widget.dart';
import 'package:tm8/env/env.dart';
import 'package:tm8/friends/presentation/logic/fetch_friends_cubit/fetch_friends_cubit.dart';
import 'package:tm8/gen/assets.gen.dart';
import 'package:tm8/login/presentation/widgets/tm8_loading_overlay_widget.dart';
import 'package:tm8/messages/presentation/logic/add_friend_cubit/add_friend_cubit.dart';
import 'package:tm8/messages/presentation/logic/block_status_cubit/block_status_cubit.dart';
import 'package:tm8/messages/presentation/logic/check_feedback_cubit/check_feedback_cubit.dart';
import 'package:tm8/messages/presentation/logic/check_friend_status_cubit/check_friend_status_cubit.dart';
import 'package:tm8/messages/presentation/logic/create_channel_cubit/create_channel_cubit.dart';
import 'package:tm8/messages/presentation/logic/fetch_channels_cubit/fetch_channels_cubit.dart';
import 'package:tm8/messages/presentation/logic/fetch_metchId_cubit/fetch_match_id_cubit.dart';
import 'package:tm8/messages/presentation/logic/rebuild_edit_button_cubit/rebuild_edit_button_cubit.dart';
import 'package:tm8/messages/presentation/logic/send_feedback_cubit/send_feedback_cubit.dart';
import 'package:tm8/messages/presentation/logic/send_message_notification_cubit/send_message_notification_cubit.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

@RoutePage() //MessagingRoute.page
class MessagingScreen extends StatefulWidget {
  const MessagingScreen({
    super.key,
    required this.username,
    required this.userId,
    this.channel,
    this.photoKey,
  });

  final String username;
  final String userId;
  final String? photoKey;
  final Channel? channel;

  @override
  State<MessagingScreen> createState() => _MessagingScreenState();
}

class _MessagingScreenState extends State<MessagingScreen> {
  final createChannelCubit = sl<CreateChannelCubit>();
  final addFriendCubit = sl<AddFriendCubit>();
  final checkFriendStatusCubit = sl<CheckFriendStatusCubit>();
  final sendMessageNotificationCubit = sl<SendMessageNotificationCubit>();
  final checkFeedbackCubit = sl<CheckFeedbackCubit>();
  final sendFeedbackCubit = sl<SendFeedbackCubit>();
  final fetchMatchIdCubit = sl<FetchMatchIdCubit>();
  final rebuildEditButtonCubit = sl<RebuildEditButtonCubit>();
  final blockStatusCubit = sl<BlockStatusCubit>();

  bool feedbackCheck = false;
  String matchId = '';
  final ItemScrollController _scrollController = ItemScrollController();

  @override
  void initState() {
    super.initState();
    connectClient();
  }

  @override
  void dispose() {
    _scrollController;
    super.dispose();
  }

  Future<void> connectClient() async {
    final userId = sl<Tm8Storage>().userId;

    if (widget.channel != null) {
      createChannelCubit.watchExistingChannel(
        channel: widget.channel!,
      );
    } else {
      createChannelCubit.createChannel(
        body: CreateChannelInput(
          members: [
            userId,
            widget.userId,
          ],
        ),
      );
    }
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
            create: (context) => createChannelCubit,
          ),
          BlocProvider(
            create: (context) => addFriendCubit,
          ),
          BlocProvider(
            create: (context) => checkFriendStatusCubit,
          ),
          BlocProvider(
            create: (context) => sendMessageNotificationCubit,
          ),
          BlocProvider(
            create: (context) => checkFeedbackCubit
              ..checkFeedback(
                userId: widget.userId,
              ),
          ),
          BlocProvider(
            create: (context) => sendFeedbackCubit,
          ),
          BlocProvider(
            create: (context) =>
                fetchMatchIdCubit..fetchMatchId(userId: widget.userId),
          ),
          BlocProvider(
            create: (context) => rebuildEditButtonCubit,
          ),
          BlocProvider(
            create: (context) =>
                blockStatusCubit..checkBlockStatus(userId: widget.userId),
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
            BlocListener<SendFeedbackCubit, SendFeedbackState>(
              listener: (context, state) {
                state.whenOrNull(
                  loaded: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      Tm8SnackBar.snackBar(
                        color: glassEffectColor,
                        text: 'Feedback sent',
                        error: false,
                      ),
                    );
                    checkFeedbackCubit.checkFeedback(
                      userId: widget.userId,
                    );
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
            BlocListener<CheckFeedbackCubit, CheckFeedbackState>(
              listener: (context, state) {
                state.whenOrNull(
                  loaded: (check) {
                    feedbackCheck = check.feedbackGiven;
                  },
                );
              },
            ),
            BlocListener<FetchMatchIdCubit, FetchMatchIdState>(
              listener: (context, state) {
                state.whenOrNull(
                  loaded: (matchCheck) {
                    matchId = matchCheck.matchId ?? '';
                  },
                );
              },
            ),
            BlocListener<BlockStatusCubit, BlockStatusState>(
              listener: (context, state) {
                state.whenOrNull(
                  loaded: (blockedStatus) {
                    if (blockedStatus.isBlocked) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        context.maybePop();
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
                onTitlePressed: () {
                  context.pushRoute(
                    MessagesProfileDetailsRoute(
                      userId: widget.userId,
                      userName: widget.username,
                      photoKey: widget.photoKey,
                    ),
                  );
                },
                onActionPressed: () {
                  context.router.push(
                    CallRoute(
                      userCallId: widget.userId,
                      username: widget.username,
                      photoKey: widget.photoKey,
                    ),
                  );
                },
                onSecondIconPressed: () {
                  if (!feedbackCheck && matchId.isNotEmpty) {
                    tm8PopUpDialogWidget(
                      context,
                      popup: (context) {
                        return Tm8FeedbackWidget(
                          onSkipTap: () {
                            Navigator.of(context).pop();
                          },
                          onSubmitTap: (feedback) {
                            sendFeedbackCubit.sendFeedback(
                              rating: feedback,
                              matchId: matchId,
                            );
                            Navigator.of(context).pop();
                          },
                        );
                      },
                      padding: 12,
                      width: 350,
                      borderRadius: 20,
                    );
                  } else if (matchId.isEmpty) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      Tm8SnackBar.snackBar(
                        color: glassEffectColor,
                        text: 'Feedback can only be given with matched users',
                        error: false,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      Tm8SnackBar.snackBar(
                        color: glassEffectColor,
                        text: 'Feedback already given',
                        error: false,
                      ),
                    );
                  }
                },
                leading: true,
                title: widget.username,
                action: true,
                actionIcon: Assets.common.phonePerson.svg(),
                secondIcon: Assets.common.feedback.svg(),
                titleIcon: true,
                actionPadding: EdgeInsets.zero,
                titleIconWidget: widget.photoKey == null
                    ? Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: achromatic600,
                        ),
                        child: Center(
                          child: Text(
                            widget.username[0].toUpperCase(),
                            style: heading4Bold.copyWith(
                              color: achromatic100,
                            ),
                          ),
                        ),
                      )
                    : ClipOval(
                        child: Image.network(
                          '${Env.stagingUrlAmazon}/${widget.photoKey}',
                          height: 32,
                          width: 32,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                navigationPadding: const EdgeInsets.only(top: 12, left: 12),
              ),
              body: BlocBuilder<CreateChannelCubit, CreateChannelState>(
                builder: (context, state) {
                  return state.when(
                    initial: SizedBox.new,
                    loading: () {
                      return Center(
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(achromatic200),
                          ),
                        ),
                      );
                    },
                    loaded: (channel) {
                      return Padding(
                        padding: screenPadding,
                        child: _buildStreamChat(channel),
                      );
                    },
                    error: (error) {
                      return Tm8ErrorWidget(
                        onTapRetry: () {
                          if (widget.channel != null) {
                            createChannelCubit.watchExistingChannel(
                              channel: widget.channel!,
                            );
                          } else {
                            createChannelCubit.createChannel(
                              body: CreateChannelInput(
                                members: [
                                  sl<Tm8Storage>().userId,
                                  widget.userId,
                                ],
                              ),
                            );
                          }
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
    );
  }

  void _scrollToBottom() {
    _scrollController.scrollTo(
      index: 0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  StreamChannel _buildStreamChat(Channel channel) {
    return StreamChannel(
      channel: channel,
      child: Column(
        children: [
          Expanded(
            child: StreamMessageListViewTheme(
              data: const StreamMessageListViewThemeData(
                backgroundColor: Colors.transparent,
              ),
              child: StreamMessageListView(
                markReadWhenAtTheBottom: true,
                showUnreadIndicator: false,
                showUnreadCountOnScrollToBottom: true,
                showFloatingDateDivider: false,
                scrollController: _scrollController,
                scrollToBottomBuilder:
                    ((unreadCount, scrollToBottomDefaultTapAction) {
                  return GestureDetector(
                    onTap: () {
                      _scrollToBottom();
                    },
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: primaryTeal,
                            ),
                            child: Center(
                              child: Assets.common.dropDownDown.svg(),
                            ),
                          ),
                          if (unreadCount > 0)
                            Positioned(
                              left: 0,
                              right: 0,
                              top: -10,
                              child: Center(
                                child: Material(
                                  borderRadius: BorderRadius.circular(8),
                                  color: primaryTealHover,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 5,
                                      right: 5,
                                      top: 2,
                                      bottom: 2,
                                    ),
                                    child: Text(
                                      '${unreadCount > 99 ? '99+' : unreadCount}',
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                }),
                messageBuilder: (
                  context,
                  details,
                  messageList,
                  defaultMessageWidget,
                ) {
                  if (details.message.user?.id != sl<Tm8Storage>().userId) {
                    return StreamMessageWidget(
                      reverse: false,
                      showMarkUnreadMessage: false,
                      showUserAvatar: DisplayWidget.show,
                      message: details.message,
                      onMessageTap: (value) {},
                      userAvatarBuilder: (context, user) {
                        if (widget.photoKey == null) {
                          return Container(
                            height: 32,
                            width: 32,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: achromatic600,
                            ),
                            child: Center(
                              child: Text(
                                widget.username[0].toUpperCase(),
                                style: heading4Bold.copyWith(
                                  color: achromatic100,
                                ),
                              ),
                            ),
                          );
                        } else {
                          return ClipOval(
                            child: Image.network(
                              '${Env.stagingUrlAmazon}/${widget.photoKey}',
                              height: 32,
                              width: 32,
                              fit: BoxFit.fitWidth,
                            ),
                          );
                        }
                      },
                      showUsername: false,
                      showCopyMessage: true,
                      showEditMessage: false,
                      showDeleteMessage: false,
                      showPinButton: false,
                      showFlagButton: false,
                      showReactionPicker: false,
                      showThreadReplyIndicator: false,
                      borderRadiusGeometry: BorderRadius.circular(10),
                      messageTheme: StreamMessageThemeData(
                        messageTextStyle: body2Regular.copyWith(
                          color: achromatic100,
                        ),
                        messageAuthorStyle: captionRegular.copyWith(
                          color: achromatic200,
                        ),
                        createdAtStyle: captionRegular.copyWith(
                          color: achromatic200,
                        ),
                        messageBackgroundColor: achromatic700,
                        avatarTheme: StreamAvatarThemeData(
                          constraints: const BoxConstraints.tightFor(
                            width: 24,
                            height: 24,
                          ),
                          borderRadius: BorderRadius.circular(200),
                        ),
                      ),
                    );
                  }

                  return StreamMessageWidget(
                    reverse: true,
                    showMarkUnreadMessage: false,
                    showUserAvatar: DisplayWidget.show,
                    showCopyMessage: true,
                    showEditMessage: true,
                    showDeleteMessage: true,
                    showReactionPicker: false,
                    editMessageInputBuilder: (context, message) {
                      final controller =
                          TextEditingController(text: message.text);
                      controller.addListener(() {
                        controller.text.trim();
                        if (controller.text != message.text) {
                          rebuildEditButtonCubit.rebuild(mainState: true);
                        } else {
                          rebuildEditButtonCubit.rebuild(mainState: false);
                        }
                      });
                      return BlocProvider(
                        create: (context) => rebuildEditButtonCubit,
                        child: Padding(
                          padding: screenPadding,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: controller,
                                  style: body2Regular.copyWith(
                                    color: achromatic100,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: '',
                                    hintMaxLines: 1,
                                    hintStyle: body1Regular.copyWith(
                                      color: achromatic300,
                                    ),
                                    filled: true,
                                    fillColor: achromatic400,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: achromatic500,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: achromatic500,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: errorTextColor,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: errorTextColor,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: achromatic500,
                                      ),
                                    ),
                                    prefixIconColor: achromatic200,
                                    suffixIconColor: achromatic200,
                                    errorMaxLines: 1,
                                    errorStyle: body2Regular.copyWith(
                                      color: errorTextColor,
                                    ),
                                  ),
                                ),
                              ),
                              w10,
                              BlocBuilder<RebuildEditButtonCubit, bool>(
                                builder: (context, state) {
                                  return Container(
                                    height: 44,
                                    width: 44,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color:
                                          state ? primaryTeal : achromatic600,
                                    ),
                                    child: Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          if (controller.text != message.text &&
                                              controller.text.isNotEmpty) {
                                            client.updateMessage(
                                              Message(
                                                id: message.id,
                                                text: controller.text,
                                                user: User(
                                                  id: sl<Tm8Storage>().userId,
                                                ),
                                              ),
                                            );
                                            Navigator.of(context).pop();
                                          }
                                        },
                                        child: Assets.common.sendMessage.svg(
                                          colorFilter: ColorFilter.mode(
                                            state
                                                ? achromatic100
                                                : achromatic400,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    showPinButton: false,
                    showFlagButton: false,
                    message: details.message,
                    onMessageTap: (value) {},
                    userAvatarBuilder: (context, user) {
                      return const SizedBox();
                    },
                    showUsername: false,
                    borderRadiusGeometry: BorderRadius.circular(10),
                    messageTheme: StreamMessageThemeData(
                      messageTextStyle: body2Regular.copyWith(
                        color: achromatic100,
                      ),
                      messageAuthorStyle: captionRegular.copyWith(
                        color: achromatic200,
                      ),
                      createdAtStyle: captionRegular.copyWith(
                        color: achromatic200,
                      ),
                      messageBackgroundColor: primaryTeal,
                      avatarTheme: StreamAvatarThemeData(
                        constraints: const BoxConstraints.tightFor(
                          width: 24,
                          height: 24,
                        ),
                        borderRadius: BorderRadius.circular(200),
                      ),
                    ),
                  );
                },
                emptyBuilder: (context) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                              widget.username[0].toUpperCase(),
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
                        widget.username,
                        style: heading4Bold.copyWith(color: achromatic100),
                      ),
                      h8,
                      BlocBuilder<CheckFriendStatusCubit,
                          CheckFriendStatusState>(
                        builder: (context, state) {
                          return state.when(
                            initial: SizedBox.new,
                            loading: SizedBox.new,
                            loaded: (friend) {
                              if (friend.isFriend) {
                                return const SizedBox();
                              }
                              return Tm8MainButtonWidget(
                                onTap: () {
                                  addFriendCubit.addFriend(
                                    userId: widget.userId,
                                    username: widget.username,
                                  );
                                },
                                buttonColor: primaryTeal,
                                text: 'Add friend',
                                width: 120,
                              );
                            },
                            error: (error) {
                              return Tm8ErrorWidget(
                                onTapRetry: () {
                                  checkFriendStatusCubit.checkFriendStatus(
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
                  );
                },
                loadingBuilder: (context) {
                  return Center(
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(achromatic200),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          StreamChatTheme(
            data: StreamChatThemeData(
              messageInputTheme: StreamMessageInputThemeData(
                inputBackgroundColor: Colors.transparent,
                borderRadius: BorderRadius.zero,
                enableSafeArea: false,
                idleBorderGradient: const LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                  ],
                ),
                activeBorderGradient: const LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                  ],
                ),
                elevation: 0,
                inputDecoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 12, right: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      width: 2,
                      color: achromatic500,
                    ),
                  ),
                  filled: true,
                  fillColor: achromatic500,
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      width: 2,
                      color: achromatic500,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      width: 2,
                      color: achromatic500,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      width: 2,
                      color: achromatic500,
                    ),
                  ),
                  hintStyle: body1Regular.copyWith(
                    color: achromatic300,
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      width: 2,
                      color: achromatic500,
                    ),
                  ),
                ),
                inputTextStyle: body1Regular.copyWith(color: achromatic100),
              ),
            ),
            child: StreamMessageInput(
              maxHeight: 40,
              shadow: null,
              enableSafeArea: false,
              actionsLocation: ActionsLocation.right,
              showCommandsButton: false,
              enableMentionsOverlay: false,
              hintGetter: (context, type) {
                return 'Write a message...';
              },
              sendButtonBuilder: (context, messageInput) {
                return Container(
                  height: 40,
                  width: 44,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: messageInput.text.isNotEmpty &&
                            messageInput.text.trim() != ''
                        ? primaryTeal
                        : achromatic600,
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: messageInput.text.isNotEmpty &&
                              messageInput.text.trim() != ''
                          ? () async {
                              final mainChannel = await channel.query();

                              final watcherCount = mainChannel.watcherCount;
                              logInfo('watcherCount: $watcherCount');
                              if (watcherCount != null &&
                                  watcherCount < 2 &&
                                  messageInput.text.isNotEmpty) {
                                sendMessageNotificationCubit.sendMessage(
                                  body: CreateMessageNotificationDto(
                                    senderUsername: sl<Tm8Storage>().userName,
                                    message: messageInput.text,
                                    recipientId: widget.userId,
                                    redirectScreen: 'Messages',
                                  ),
                                );
                              }
                              if (messageInput.text.isNotEmpty) {
                                client.sendMessage(
                                  Message(
                                    text: messageInput.text,
                                    user: User(id: sl<Tm8Storage>().userId),
                                  ),
                                  channel.id ?? '',
                                  'dm',
                                );
                              }

                              messageInput.clear();
                            }
                          : null,
                      child: Assets.common.sendMessage.svg(
                        colorFilter: ColorFilter.mode(
                          messageInput.text.isNotEmpty &&
                                  messageInput.text.trim() != ''
                              ? achromatic100
                              : achromatic400,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                );
              },
              actionsBuilder: (context, defaultActions) {
                return [];
              },
            ),
          ),
        ],
      ),
    );
  }
}
