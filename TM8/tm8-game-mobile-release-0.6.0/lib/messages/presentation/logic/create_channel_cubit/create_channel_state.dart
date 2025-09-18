part of 'create_channel_cubit.dart';

@freezed
class CreateChannelState with _$CreateChannelState {
  const factory CreateChannelState.initial() = _Initial;
  const factory CreateChannelState.loading() = _Loading;
  const factory CreateChannelState.loaded({
    required Channel channel,
  }) = _Loaded;
  const factory CreateChannelState.error({required String error}) = _Error;
}
