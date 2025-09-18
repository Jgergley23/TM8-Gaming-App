part of 'app_bloc.dart';

@freezed
class AppState with _$AppState {
  const factory AppState.authenticated() = _Authenticated;
  const factory AppState.unauthenticated({
     String? message,
  }) = _Unauthenticated;
}
