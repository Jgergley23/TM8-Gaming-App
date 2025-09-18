part of 'app_bloc.dart';

@freezed
class AppEvent with _$AppEvent {
  const factory AppEvent.checkStatus() = _CheckStatus;
  const factory AppEvent.logOut() = _LogOut;
}
