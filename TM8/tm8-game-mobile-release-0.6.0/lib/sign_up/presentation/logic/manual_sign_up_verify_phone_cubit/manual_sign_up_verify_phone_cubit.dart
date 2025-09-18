import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/storage/tm8_storage.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'manual_sign_up_verify_phone_state.dart';
part 'manual_sign_up_verify_phone_cubit.freezed.dart';

@injectable
class ManualSignUpVerifyPhoneCubit extends Cubit<ManualSignUpVerifyPhoneState> {
  ManualSignUpVerifyPhoneCubit()
      : super(const ManualSignUpVerifyPhoneState.initial());

  Future<void> manualSignUpVerifyPhone({required VerifyCodeInput body}) async {
    try {
      emit(const ManualSignUpVerifyPhoneState.loading());

      final result = await api.apiV1AuthVerifyPhonePost(body: body);

      sl<Tm8Storage>().accessToken = result.body?.accessToken ?? '';
      sl<Tm8Storage>().refreshToken = result.body?.refreshToken ?? '';
      sl<Tm8Storage>().userId = result.body?.id ?? '';
      sl<Tm8Storage>().chatToken = result.body?.chatToken ?? '';
      sl<Tm8Storage>().userName = result.body?.username ?? '';
      sl<Tm8Storage>().signupType = result.body?.signupType ?? '';
      emit(ManualSignUpVerifyPhoneState.loaded(response: result.bodyOrThrow));
    } catch (e) {
      logError(e.toString());
      emit(
        ManualSignUpVerifyPhoneState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
