import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'forgot_password_state.dart';
part 'forgot_password_cubit.freezed.dart';

@injectable
class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(const ForgotPasswordState.initial());

  Future<void> forgotPassword({required ForgotPasswordInput body}) async {
    try {
      emit(const ForgotPasswordState.loading());

      await api.apiV1AuthForgotPasswordPost(body: body);

      emit(ForgotPasswordState.loaded(phoneNumber: body.phoneNumber!));
    } catch (e) {
      logError(e.toString());
      emit(ForgotPasswordState.error(error: e.toString()));
    }
  }
}
