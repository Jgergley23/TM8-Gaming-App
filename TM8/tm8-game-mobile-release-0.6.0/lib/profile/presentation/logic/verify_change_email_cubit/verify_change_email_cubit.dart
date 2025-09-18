import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'verify_change_email_state.dart';
part 'verify_change_email_cubit.freezed.dart';

@injectable
class VerifyChangeEmailCubit extends Cubit<VerifyChangeEmailState> {
  VerifyChangeEmailCubit() : super(const VerifyChangeEmailState.initial());

  Future<void> verifyEmail({required VerifyEmailChangeInput body}) async {
    try {
      emit(const VerifyChangeEmailState.loading());

      await api.apiV1UsersEmailConfirmPatch(body: body);

      emit(
        const VerifyChangeEmailState.loaded(),
      );
    } catch (e) {
      logError(e.toString());
      emit(
        VerifyChangeEmailState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
