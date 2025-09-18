part of 'add_phone_number_cubit.dart';

@freezed
class AddPhoneNumberState with _$AddPhoneNumberState {
  const factory AddPhoneNumberState.initial() = _Initial;
  const factory AddPhoneNumberState.loading() = _Loading;
  const factory AddPhoneNumberState.loaded({required String phoneNumber}) =
      _Loaded;
  const factory AddPhoneNumberState.error({required String error}) = _Error;
}
