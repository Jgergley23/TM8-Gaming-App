import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8_game_admin/app/api/api_service.dart';
import 'package:tm8_game_admin/app/services/service_locator.dart';
import 'package:tm8_game_admin/app/storage/tm8_game_admin_storage.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState.initial());

  Future<void> login({required AuthLoginInput loginInput}) async {
    try {
      emit(const LoginState.loading());
      final result = await api.apiV1AuthSignInPost(
        body: loginInput,
      );

      if (result.isSuccessful) {
        sl<Tm8GameAdminStorage>().accessToken = result.body?.accessToken ?? '';
        sl<Tm8GameAdminStorage>().refreshToken =
            result.body?.refreshToken ?? '';

        sl<Tm8GameAdminStorage>().userEmail = loginInput.email;
        sl<Tm8GameAdminStorage>().userName = result.body?.name ?? 'Name';
        sl<Tm8GameAdminStorage>().userId = result.body?.id ?? '';
        sl<Tm8GameAdminStorage>().userRole = result.body?.role ?? '';
        emit(LoginState.loaded(email: loginInput.email));
      } else {
        final e = jsonDecode(result.error.toString());
        emit(LoginState.error(error: e['detail'].toString()));
      }
    } catch (e) {
      logError(e.toString());
      emit(const LoginState.error(error: 'Something went wrong'));
    }
  }
}
