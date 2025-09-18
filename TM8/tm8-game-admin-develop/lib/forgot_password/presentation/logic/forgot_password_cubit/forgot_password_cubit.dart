import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tm8_game_admin/app/api/api_service.dart';
import 'package:tm8_game_admin/app/services/service_locator.dart';
import 'package:tm8_game_admin/app/storage/tm8_game_admin_storage.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

part 'forgot_password_state.dart';
part 'forgot_password_cubit.freezed.dart';

@injectable
class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(const ForgotPasswordState.initial());

  Future<void> forgetPasswordEmail({
    required ForgotPasswordInput forgotPasswordInput,
  }) async {
    try {
      emit(const ForgotPasswordState.loading());
      final result = await api.apiV1AuthForgotPasswordPost(
        body: forgotPasswordInput,
      );

      if (result.isSuccessful) {
        sl<Tm8GameAdminStorage>().resetEmail = forgotPasswordInput.email ?? '';
        emit(const ForgotPasswordState.loaded());
      } else {
        final e = jsonDecode(result.error.toString());
        emit(ForgotPasswordState.error(error: e['detail'].toString()));
      }
    } catch (e) {
      emit(const ForgotPasswordState.error(error: 'Something went wrong'));
    }
  }
}
