part of 'fetch_channels_cubit.dart';

@freezed
class FetchChannelsState with _$FetchChannelsState {
  const factory FetchChannelsState.initial() = _Initial;
  const factory FetchChannelsState.loading({
    required ChatChannelPaginatedResponse chats,
    required List<Channel> channels,
  }) = _Loading;
  const factory FetchChannelsState.loaded({
    required ChatChannelPaginatedResponse response,
    required String? username,
    required List<int> unreadMessagesCount,
    required List<Channel> channels,
    required int unavailableUsersCount,
  }) = _Loaded;
  const factory FetchChannelsState.error({required String error}) = _Error;
}
