import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tm8_game_admin/app/api/api_service.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

part 'forgot_password_reset_state.dart';
part 'forgot_password_reset_cubit.freezed.dart';

@injectable
class ForgotPasswordResetCubit extends Cubit<ForgotPasswordResetState> {
  ForgotPasswordResetCubit() : super(const ForgotPasswordResetState.initial());

  Future<void> resetPassword({
    required ResetPasswordInput resetPasswordInput,
  }) async {
    try {
      emit(const ForgotPasswordResetState.loading());
      final result = await api.apiV1AuthForgotPasswordResetPost(
        body: resetPasswordInput,
      );

      if (result.isSuccessful) {
        emit(const ForgotPasswordResetState.loaded());
      } else {
        final e = jsonDecode(result.error.toString());
        emit(ForgotPasswordResetState.error(error: e['detail'].toString()));
      }
    } catch (e) {
      emit(const ForgotPasswordResetState.error(error: 'Something went wrong'));
    }
  }
}
