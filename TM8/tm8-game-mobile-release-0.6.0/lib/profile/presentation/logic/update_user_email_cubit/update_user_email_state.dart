part of 'update_user_email_cubit.dart';

@freezed
class UpdateUserEmailState with _$UpdateUserEmailState {
  const factory UpdateUserEmailState.initial() = _Initial;
  const factory UpdateUserEmailState.loading() = _Loading;
  const factory UpdateUserEmailState.loaded() = _Loaded;
  const factory UpdateUserEmailState.error({required String error}) = _Error;
}
