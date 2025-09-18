import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tm8_game_admin/app/api/api_service.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

part 'forgot_password_verification_state.dart';
part 'forgot_password_verification_cubit.freezed.dart';

@injectable
class ForgotPasswordVerificationCubit
    extends Cubit<ForgotPasswordVerificationState> {
  ForgotPasswordVerificationCubit()
      : super(const ForgotPasswordVerificationState.initial());

  Future<void> verifyCode({
    required VerifyCodeInput verifyCodeInput,
  }) async {
    try {
      emit(const ForgotPasswordVerificationState.loading());
      final result = await api.apiV1AuthForgotPasswordVerifyPost(
        body: verifyCodeInput,
      );

      if (result.isSuccessful) {
        emit(const ForgotPasswordVerificationState.loaded());
      } else {
        final e = jsonDecode(result.error.toString());
        emit(
          ForgotPasswordVerificationState.error(
            error: e['detail'].toString(),
          ),
        );
      }
    } catch (e) {
      emit(
        const ForgotPasswordVerificationState.error(
          error: 'Something went wrong',
        ),
      );
    }
  }
}
