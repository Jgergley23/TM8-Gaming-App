part of 'send_contact_form_cubit.dart';

@freezed
class SendContactFormState with _$SendContactFormState {
  const factory SendContactFormState.initial() = _Initial;
  const factory SendContactFormState.loading() = _Loading;
  const factory SendContactFormState.loaded() = _Loaded;
  const factory SendContactFormState.error({required String error}) = _Error;
}
