import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/storage/tm8_storage.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'apple_sign_up_state.dart';
part 'apple_sign_up_cubit.freezed.dart';

@injectable
class AppleSignUpCubit extends Cubit<AppleSignUpState> {
  AppleSignUpCubit() : super(const AppleSignUpState.initial());

  Future<void> appleSignUp({required VerifyAppleIdInput body}) async {
    try {
      emit(const AppleSignUpState.loading());

      final result = await api.apiV1AuthAppleVerifyPost(body: body);

      sl<Tm8Storage>().accessToken = result.body?.accessToken ?? '';
      sl<Tm8Storage>().refreshToken = result.body?.refreshToken ?? '';
      sl<Tm8Storage>().userId = result.body?.id ?? '';
      sl<Tm8Storage>().chatToken = result.body?.chatToken ?? '';
      sl<Tm8Storage>().userName = result.body?.username ?? '';
      sl<Tm8Storage>().signupType = result.body?.signupType ?? '';
      emit(AppleSignUpState.loaded(response: result.bodyOrThrow));
    } catch (e) {
      logError(e.toString());
      emit(AppleSignUpState.error(error: e.toString()));
    }
  }
}
