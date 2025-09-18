part of 'send_user_notes_cubit.dart';

@freezed
class SendUserNotesState with _$SendUserNotesState {
  const factory SendUserNotesState.initial() = _Initial;
  const factory SendUserNotesState.loading() = _Loading;
  const factory SendUserNotesState.loaded({required UserResponse user}) =
      _Loaded;
  const factory SendUserNotesState.error({
    required String error,
  }) = _Error;
}
