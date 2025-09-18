import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'forgot_password_verify_state.dart';
part 'forgot_password_verify_cubit.freezed.dart';

@injectable
class ForgotPasswordVerifyCubit extends Cubit<ForgotPasswordVerifyState> {
  ForgotPasswordVerifyCubit()
      : super(const ForgotPasswordVerifyState.initial());

  Future<void> forgotPasswordVerifyCode({required VerifyCodeInput body}) async {
    try {
      emit(const ForgotPasswordVerifyState.loading());

      await api.apiV1AuthForgotPasswordVerifyPost(body: body);

      emit(const ForgotPasswordVerifyState.loaded());
    } catch (e) {
      logError(e.toString());
      emit(
        ForgotPasswordVerifyState.error(error: e.toString()),
      );
    }
  }
}
