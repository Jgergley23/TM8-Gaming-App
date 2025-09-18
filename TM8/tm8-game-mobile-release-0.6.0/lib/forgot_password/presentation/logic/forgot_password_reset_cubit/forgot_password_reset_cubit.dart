import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'forgot_password_reset_state.dart';
part 'forgot_password_reset_cubit.freezed.dart';

@injectable
class ForgotPasswordResetCubit extends Cubit<ForgotPasswordResetState> {
  ForgotPasswordResetCubit() : super(const ForgotPasswordResetState.initial());

  Future<void> forgotPasswordReset({
    required ResetPasswordInput body,
  }) async {
    try {
      emit(const ForgotPasswordResetState.loading());

      final result = await api.apiV1AuthForgotPasswordResetPost(body: body);

      emit(ForgotPasswordResetState.loaded(response: result.bodyOrThrow));
    } catch (e) {
      logError(e.toString());
      emit(
        ForgotPasswordResetState.error(error: e.toString()),
      );
    }
  }
}
