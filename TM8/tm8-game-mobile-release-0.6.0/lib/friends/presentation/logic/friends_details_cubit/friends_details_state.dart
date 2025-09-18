part of 'friends_details_cubit.dart';

@freezed
class FriendsDetailsState with _$FriendsDetailsState {
  const factory FriendsDetailsState.initial() = _Initial;
  const factory FriendsDetailsState.loading() = _Loading;
  const factory FriendsDetailsState.loaded({
    required UserProfileResponse userProfile,
  }) = _Loaded;
  const factory FriendsDetailsState.error({required String error}) = _Error;
}
