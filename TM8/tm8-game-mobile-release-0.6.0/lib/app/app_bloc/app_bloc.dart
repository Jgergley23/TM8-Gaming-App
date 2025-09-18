import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/socket_io.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:injectable/injectable.dart';
import 'package:tm8/app/storage/tm8_storage.dart';

part 'app_event.dart';
part 'app_state.dart';
part 'app_bloc.freezed.dart';

// main bloc off the app checks when user is logged into the app
// logouts user, deletes storage etc..
@singleton
class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState.unauthenticated()) {
    on<AppEvent>((event, emit) async {
      Future<void> logOut() async {
        sl<Tm8Storage>().clear();
        SocketInitialized().disconnect();
        emit(const AppState.unauthenticated());
      }

      await event.when(
        checkStatus: () async {
          final accessToken = sl<Tm8Storage>().accessToken;
          logInfo('Check status AccessToken: $accessToken');
          if (accessToken == '') {
            logOut();
            return;
          }
          emit(const AppState.authenticated());
        },
        logOut: () async {
          sl<Tm8Storage>().clear();
          SocketInitialized().disconnect();
          emit(const AppState.unauthenticated());
        },
        banOrSuspend: (message) {
          sl<Tm8Storage>().clearAll();
          SocketInitialized().disconnect();
          emit(AppState.unauthenticated(message: message));
        },
        delete: (message) {
          sl<Tm8Storage>().clearAll();
          SocketInitialized().disconnect();
          emit(AppState.unauthenticated(message: message));
        },
      );
    });
  }
}
