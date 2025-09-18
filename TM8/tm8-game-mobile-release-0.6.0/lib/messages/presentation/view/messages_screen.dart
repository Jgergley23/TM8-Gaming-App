import 'dart:async';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/router/router.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/widgets/tm8_error_widget.dart';
import 'package:tm8/app/widgets/tm8_main_button_widget.dart';
import 'package:tm8/app/widgets/tm8_search_widget.dart';
import 'package:tm8/env/env.dart';
import 'package:tm8/messages/presentation/logic/create_channel_cubit/create_channel_cubit.dart';
import 'package:tm8/messages/presentation/logic/fetch_channels_cubit/fetch_channels_cubit.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

@RoutePage() //MessagesRoute.page
class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key, required this.focusNode});

  final FocusNode focusNode;

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final createChannelCubit = sl<CreateChannelCubit>();
  final ScrollController _scrollController = ScrollController();

  String? search;
  Timer? _debounce;
  double page = 1;
  var chats = const ChatChannelPaginatedResponse(
    items: [],
    meta: PaginationMetaResponse(
      page: 1,
      limit: 10,
      itemCount: 10,
      pageCount: 1,
      hasPreviousPage: false,
      hasNextPage: false,
    ),
  );
  bool hasNextPage = false;
  var mainChannels = <Channel>[];
  var mainUnreadMessagesCount = <int>[];
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // Reached the bottom of the list, add more items
        if (hasNextPage) {
          page = page + 1;
          sl<FetchChannelsCubit>().fetchNextPage(
            username: search,
            page: page.toInt(),
            chats: chats,
            mainChannels: mainChannels,
            unreadMessagesCount: mainUnreadMessagesCount,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String? search) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (search != null) {
        context.read<FetchChannelsCubit>().fetchChannels(username: search);
      } else {
        context.read<FetchChannelsCubit>().fetchChannels(username: null);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => createChannelCubit,
        ),
      ],
      child: BlocListener<FetchChannelsCubit, FetchChannelsState>(
        listener: (context, state) {
          state.whenOrNull(
            loaded: (
              response,
              username,
              unreadMessagesCount,
              channels,
              unavailableUsersCount,
            ) {
              chats = response;
              hasNextPage = response.meta.hasNextPage;
              mainChannels = channels;
              mainUnreadMessagesCount = unreadMessagesCount;
            },
          );
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Tm8SearchWidget(
                onChanged: (text) {
                  if (search != text) {
                    search = text;
                    if (text.length > 1) {
                      _onSearchChanged(search);
                    } else if (text.isEmpty) {
                      _onSearchChanged(null);
                    }
                  }
                },
                hintText: 'Search',
                width: 270,
              ),
              h12,
              BlocBuilder<FetchChannelsCubit, FetchChannelsState>(
                builder: (context, state) {
                  return state.when(
                    initial: SizedBox.new,
                    loading: (chats, channels) {
                      return Column(
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return _buildMessageListItem(
                                chats,
                                index,
                                List.generate(chats.items.length, (index) => 0),
                                channels,
                              );
                            },
                            separatorBuilder: (context, index) {
                              return h12;
                            },
                            itemCount: chats.items.length,
                          ),
                          _buildLoadingChannels(),
                        ],
                      );
                    },
                    loaded: (
                      response,
                      username,
                      unreadMessagesCount,
                      channels,
                      unavailableUsersCount,
                    ) {
                      if ((response.items.isEmpty && username == null) ||
                          (response.items.length == unavailableUsersCount)) {
                        return _buildNoMessagesWidget();
                      }
                      return Column(
                        children: [
                          if (response.items.isEmpty && username != null) ...[
                            Text(
                              'No messages found for search',
                              style: body1Regular.copyWith(
                                color: achromatic100,
                              ),
                            ),
                            h12,
                          ],
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              if (response.items[index].chattingWith.username ==
                                  'Unavailable user') {
                                return const SizedBox();
                              } else {
                                return _buildMessageListItem(
                                  response,
                                  index,
                                  unreadMessagesCount,
                                  channels,
                                );
                              }
                            },
                            separatorBuilder: (context, index) {
                              if (response.items[index].chattingWith.username ==
                                  'Unavailable user') {
                                return const SizedBox();
                              }
                              return h12;
                            },
                            itemCount:
                                response.items.length == unavailableUsersCount
                                    ? 0
                                    : response.items.length,
                          ),
                        ],
                      );
                    },
                    error: (error) {
                      return Tm8ErrorWidget(
                        onTapRetry: () {
                          context
                              .read<FetchChannelsCubit>()
                              .fetchChannels(username: search);
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
    );
  }

  Column _buildNoMessagesWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        h200,
        Text(
          'No messages yet',
          style: heading2Regular.copyWith(
            color: achromatic100,
          ),
        ),
        h12,
        Text(
          'No messages to show yet.\n'
          'When you message someone, the inbox will appear here.',
          style: body1Regular.copyWith(color: achromatic200),
          textAlign: TextAlign.center,
        ),
        h24,
        Tm8MainButtonWidget(
          onTap: () {
            context.pushRoute(const SearchUsersMessagesRoute());
          },
          buttonColor: primaryTeal,
          text: 'Send message',
        ),
      ],
    );
  }

  Skeletonizer _buildLoadingChannels() {
    return Skeletonizer(
      child: Column(
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return _buildMessageListItem(
                ChatChannelPaginatedResponse(
                  items: const [
                    ChatChannelResponse(
                      id: 'testingId',
                      chattingWith: ChatChattingWithResponse(
                        username: 'Testing username',
                        online: false,
                        id: '',
                      ),
                      lastMessage: 'Hello mate! How are you?',
                    ),
                    ChatChannelResponse(
                      id: 'testingId',
                      chattingWith: ChatChattingWithResponse(
                        username: 'Testing username',
                        online: false,
                        id: '',
                      ),
                      lastMessage: 'Hello mate! How are you?',
                    ),
                    ChatChannelResponse(
                      id: 'testingId',
                      chattingWith: ChatChattingWithResponse(
                        username: 'Testing username',
                        online: false,
                        id: '',
                      ),
                      lastMessage: 'Hello mate! How are you?',
                    ),
                    ChatChannelResponse(
                      id: 'testingId',
                      chattingWith: ChatChattingWithResponse(
                        username: 'Testing username',
                        online: false,
                        id: '',
                      ),
                      lastMessage: 'Hello mate! How are you?',
                    ),
                    ChatChannelResponse(
                      id: 'testingId',
                      chattingWith: ChatChattingWithResponse(
                        username: 'Testing username',
                        online: false,
                        id: '',
                      ),
                      lastMessage: 'Hello mate! How are you?',
                    ),
                  ],
                  meta: PaginationMetaResponse(
                    page: page,
                    limit: 10,
                    itemCount: 10,
                    pageCount: 1,
                    hasPreviousPage: false,
                    hasNextPage: hasNextPage,
                  ),
                ),
                index,
                [0, 0, 0, 0, 0],
                [],
              );
            },
            separatorBuilder: (context, index) {
              return h12;
            },
            itemCount: 5,
          ),
        ],
      ),
    );
  }

  GestureDetector _buildMessageListItem(
    ChatChannelPaginatedResponse chats,
    int index,
    List<int> unreadMessagesCount,
    List<Channel> channels,
  ) {
    return GestureDetector(
      onTap: () {
        context
            .pushRoute(
          MessagingRoute(
            username: chats.items[index].chattingWith.username,
            channel: channels[index],
            userId: chats.items[index].chattingWith.id,
            photoKey: chats.items[index].chattingWith.avatar,
          ),
        )
            .whenComplete(() {
          channels[index].stopWatching();
          sl<FetchChannelsCubit>().refetchSpecificMessages(
            chats: chats,
            mainChannels: channels,
            unreadMessagesCount: unreadMessagesCount,
            id: channels[index].id ?? '',
            username: search,
            index: index,
          );
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: achromatic700,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            if (chats.items[index].chattingWith.avatar == null) ...[
              Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: achromatic600,
                ),
                child: Center(
                  child: Text(
                    chats.items[index].chattingWith.username[0].toUpperCase(),
                    style: heading4Bold.copyWith(
                      color: achromatic100,
                    ),
                  ),
                ),
              ),
            ] else ...[
              ClipOval(
                child: Image.network(
                  '${Env.stagingUrlAmazon}/${chats.items[index].chattingWith.avatar}',
                  height: 32,
                  width: 32,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ],
            w8,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chats.items[index].chattingWith.username,
                  style: body1Regular.copyWith(
                    color: achromatic100,
                  ),
                ),
                SizedBox(
                  width: 250,
                  child: Text(
                    chats.items[index].lastMessage,
                    style: unreadMessagesCount[index] != 0
                        ? body2Bold.copyWith(color: achromatic100)
                        : body2Regular.copyWith(
                            color: achromatic200,
                          ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            expanded,
            if (chats.items[index].chattingWith.online)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      color: successColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
