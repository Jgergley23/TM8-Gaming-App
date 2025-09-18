import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/app/api/get_stream_client.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/storage/tm8_storage.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'fetch_channels_state.dart';
part 'fetch_channels_cubit.freezed.dart';

@singleton
class FetchChannelsCubit extends Cubit<FetchChannelsState> {
  FetchChannelsCubit() : super(const FetchChannelsState.initial());

  Future<void> fetchChannels({required String? username}) async {
    try {
      emit(
        const FetchChannelsState.loading(
          chats: ChatChannelPaginatedResponse(
            items: [],
            meta: PaginationMetaResponse(
              page: 1,
              limit: 10,
              itemCount: 10,
              pageCount: 1,
              hasPreviousPage: false,
              hasNextPage: false,
            ),
          ),
          channels: [],
        ),
      );

      final result = await api.apiV1ChatUserChannelsGet(
        page: 1,
        limit: 10,
        username: username,
      );

      var userId = sl<Tm8Storage>().userId;
      if (userId == '' || userId.isEmpty) {
        final result = await api.apiV1UsersMeGet();
        if (result.bodyOrThrow.id != '') {
          userId = result.body?.id ?? '';
        }
      }

      final unreadMessagesCount = <int>[];
      final channels = <Channel>[];
      final chatToken = sl<Tm8Storage>().chatToken;
      if (chatToken != '') {
        await client.disconnectUser();
        await client.connectUser(
          User(id: userId),
          chatToken,
        );
      }

      if (result.bodyOrThrow.items.isNotEmpty) {
        for (final item in result.bodyOrThrow.items) {
          final channel = client.channel('dm', id: item.id);

          channels.add(channel);

          await channel.query();

          final unread = channel.state?.unreadCount;

          logInfo(unread);

          if (item.chattingWith.username != 'Unavailable user') {
            logInfo('Unavailable user');
            unreadMessagesCount.add(unread ?? 0);
          } else {
            unreadMessagesCount.add(0);
          }
        }
      }

      final unavailableUsersCount = result.bodyOrThrow.items
          .where(
            (element) => element.chattingWith.username == 'Unavailable user',
          )
          .length;

      emit(
        FetchChannelsState.loaded(
          response: result.bodyOrThrow,
          username: username,
          unreadMessagesCount: unreadMessagesCount,
          channels: channels,
          unavailableUsersCount: unavailableUsersCount,
        ),
      );
    } catch (e) {
      logError(e.toString());
      if (e is StreamChatNetworkError) {
        // Refresh token errors
        final result = await api.apiV1ChatTokenRefreshPost();
        sl<Tm8Storage>().chatToken = result.bodyOrThrow.chatToken;

        sl<FetchChannelsCubit>().fetchChannels(username: null);

        emit(
          FetchChannelsState.error(
            error: e.toString(),
          ),
        );
      } else {
        emit(
          const FetchChannelsState.error(
            error: 'Something went wrong',
          ),
        );
      }
    }
  }

  Future<void> fetchNextPage({
    required String? username,
    required int page,
    required ChatChannelPaginatedResponse chats,
    required List<Channel> mainChannels,
    required List<int> unreadMessagesCount,
  }) async {
    try {
      emit(FetchChannelsState.loading(chats: chats, channels: mainChannels));

      final result = await api.apiV1ChatUserChannelsGet(
        page: page,
        limit: 10,
        username: username,
      );

      final userId = sl<Tm8Storage>().userId;

      await client.disconnectUser();
      await client.connectUser(
        User(id: userId),
        sl<Tm8Storage>().chatToken,
      );
      var mainUnreadMessagesCount = <int>[];
      final channels = <Channel>[];

      for (final item in result.bodyOrThrow.items) {
        final channel = client.channel('dm', id: item.id);

        channels.add(channel);

        await channel.query();

        final unread = channel.state?.unreadCount;

        logInfo(unread);
        if (item.chattingWith.username != 'Unavailable user') {
          logInfo('Unavailable user');

          mainUnreadMessagesCount.add(unread ?? 0);
        } else {
          mainUnreadMessagesCount.add(0);
        }
      }

      var unavailableUsersCount = result.bodyOrThrow.items
              .where(
                (element) =>
                    element.chattingWith.username == 'Unavailable user',
              )
              .length +
          chats.items
              .where(
                (element) =>
                    element.chattingWith.username == 'Unavailable user',
              )
              .length;

      emit(
        FetchChannelsState.loaded(
          response: ChatChannelPaginatedResponse(
            items: chats.items + result.bodyOrThrow.items,
            meta: result.bodyOrThrow.meta,
          ),
          username: username,
          unreadMessagesCount: unreadMessagesCount + mainUnreadMessagesCount,
          channels: channels,
          unavailableUsersCount: unavailableUsersCount,
        ),
      );
    } catch (e) {
      logError(e.toString());
      emit(
        const FetchChannelsState.error(
          error: 'Something went wrong',
        ),
      );
    }
  }

  Future<void> refetchMessages() async {
    try {
      emit(
        const FetchChannelsState.loading(
          chats: ChatChannelPaginatedResponse(
            items: [],
            meta: PaginationMetaResponse(
              page: 1,
              limit: 10,
              itemCount: 10,
              pageCount: 1,
              hasPreviousPage: false,
              hasNextPage: false,
            ),
          ),
          channels: [],
        ),
      );

      final result = await api.apiV1ChatUserChannelsGet(
        page: 1,
        limit: 10,
        username: null,
      );

      final unreadMessagesCount = <int>[];
      final channels = <Channel>[];

      for (final item in result.bodyOrThrow.items) {
        final channel = client.channel('dm', id: item.id);

        channels.add(channel);

        await channel.query();

        final unread = channel.state?.unreadCount;

        logInfo(unread);

        if (item.chattingWith.username != 'Unavailable user') {
          logInfo('Unavailable user');

          unreadMessagesCount.add(unread ?? 0);
        } else {
          unreadMessagesCount.add(0);
        }
      }

      final unavailableUsersCount = result.bodyOrThrow.items
          .where(
            (element) => element.chattingWith.username == 'Unavailable user',
          )
          .length;

      emit(
        FetchChannelsState.loaded(
          response: result.bodyOrThrow,
          username: null,
          unreadMessagesCount: unreadMessagesCount,
          channels: channels,
          unavailableUsersCount: unavailableUsersCount,
        ),
      );
    } catch (e) {
      logError(e.toString());
      emit(
        const FetchChannelsState.error(
          error: 'Something went wrong',
        ),
      );
    }
  }

  Future<void> refetchSpecificMessages({
    required String id,
    required ChatChannelPaginatedResponse chats,
    required List<Channel> mainChannels,
    required List<int> unreadMessagesCount,
    required String? username,
    required int index,
  }) async {
    try {
      emit(
        FetchChannelsState.loading(
          chats: chats,
          channels: mainChannels,
        ),
      );

      final channel = client.channel('dm', id: id);

      await channel.query();

      final chat = chats.items.where((value) => value.id == id);

      final changedChat = ChatChannelResponse(
        id: id,
        chattingWith: chat.first.chattingWith,
        lastMessage: channel.state?.messages.last.text ?? '',
      );

      final updatedChats = [...chats.items];

      updatedChats[index] = changedChat;

      final updatedUnreadMessagesCount = [...unreadMessagesCount];

      updatedUnreadMessagesCount[index] = channel.state?.unreadCount ?? 0;

      final unavailableUsersCount = chats.items
          .where(
            (element) => element.chattingWith.username == 'Unavailable user',
          )
          .length;

      emit(
        FetchChannelsState.loaded(
          response: ChatChannelPaginatedResponse(
            items: updatedChats,
            meta: chats.meta,
          ),
          username: username,
          unreadMessagesCount: updatedUnreadMessagesCount,
          channels: mainChannels,
          unavailableUsersCount: unavailableUsersCount,
        ),
      );
    } catch (e) {
      logError(e.toString());
      emit(
        const FetchChannelsState.error(
          error: 'Something went wrong',
        ),
      );
    }
  }
}
