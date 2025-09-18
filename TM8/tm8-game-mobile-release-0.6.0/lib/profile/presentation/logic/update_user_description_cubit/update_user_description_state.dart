part of 'update_user_description_cubit.dart';

@freezed
class UpdateUserDescriptionState with _$UpdateUserDescriptionState {
  const factory UpdateUserDescriptionState.initial() = _Initial;
  const factory UpdateUserDescriptionState.loading() = _Loading;
  const factory UpdateUserDescriptionState.loaded() = _Loaded;
  const factory UpdateUserDescriptionState.error({required String error}) =
      _Error;
}
