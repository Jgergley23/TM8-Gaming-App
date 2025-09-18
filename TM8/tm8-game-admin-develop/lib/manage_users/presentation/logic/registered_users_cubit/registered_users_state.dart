part of 'registered_users_cubit.dart';

@freezed
class RegisteredUsersState with _$RegisteredUsersState {
  const factory RegisteredUsersState.initial() = _Initial;
  const factory RegisteredUsersState.loading() = _Loading;
  const factory RegisteredUsersState.loaded({
    required List<FlSpot> flSpots,
    required List<String> titles,
    required int increasedY,
    required String selectedValue,
  }) = _Loaded;
  const factory RegisteredUsersState.error({required String error}) = _Error;
}
