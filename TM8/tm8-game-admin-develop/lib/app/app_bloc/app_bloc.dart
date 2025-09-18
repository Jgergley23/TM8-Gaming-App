import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8_game_admin/app/services/service_locator.dart';
import 'package:injectable/injectable.dart';
import 'package:tm8_game_admin/app/storage/tm8_game_admin_storage.dart';

part 'app_event.dart';
part 'app_state.dart';
part 'app_bloc.freezed.dart';

@LazySingleton()
class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState.unauthenticated()) {
    on<AppEvent>((event, emit) async {
      Future<void> logOut() async {
        sl<Tm8GameAdminStorage>().clear();
        emit(const AppState.unauthenticated());
      }

      await event.when(
        checkStatus: () {
          final accessToken = sl<Tm8GameAdminStorage>().accessToken;
          logInfo('Check status AccessToken: $accessToken');
          if (accessToken == '') {
            logOut();
            return;
          }
          emit(const AppState.authenticated());
        },
        logOut: () async {
          sl<Tm8GameAdminStorage>().clear();
          emit(const AppState.unauthenticated());
        },
      );
    });
  }
}
