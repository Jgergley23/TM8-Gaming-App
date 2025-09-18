part of 'total_users_cubit.dart';

@freezed
class TotalUsersState with _$TotalUsersState {
  const factory TotalUsersState.initial() = _Initial;
  const factory TotalUsersState.loading() = _Loading;
  const factory TotalUsersState.loaded({
    required StatisticsTotalCountResponse totalCountResponse,
  }) = _Loaded;
  const factory TotalUsersState.error({required String error}) = _Error;
}
