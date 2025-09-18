import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'manual_sign_up_resend_code_state.dart';
part 'manual_sign_up_resend_code_cubit.freezed.dart';

@injectable
class ManualSignUpResendCodeCubit extends Cubit<ManualSignUpResendCodeState> {
  ManualSignUpResendCodeCubit()
      : super(const ManualSignUpResendCodeState.initial());

  Future<void> manualSignUpResendCode({
    required PhoneVerificationInput body,
  }) async {
    try {
      emit(const ManualSignUpResendCodeState.loading());

      await api.apiV1AuthResendCodePost(body: body);

      emit(const ManualSignUpResendCodeState.loaded());
    } catch (e) {
      logError(e.toString());
      emit(
        ManualSignUpResendCodeState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
