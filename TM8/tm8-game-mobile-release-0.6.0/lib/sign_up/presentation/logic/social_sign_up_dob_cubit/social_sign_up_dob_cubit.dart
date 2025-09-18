import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'social_sign_up_dob_state.dart';
part 'social_sign_up_dob_cubit.freezed.dart';

@injectable
class SocialSignUpDobCubit extends Cubit<SocialSignUpDobState> {
  SocialSignUpDobCubit() : super(const SocialSignUpDobState.initial());

  Future<void> addDob({required SetDateOfBirthInput body}) async {
    try {
      emit(const SocialSignUpDobState.loading());

      await api.apiV1AuthDateOfBirthPatch(body: body);

      emit(const SocialSignUpDobState.loaded());
    } catch (e) {
      logError(e.toString());
      emit(SocialSignUpDobState.error(error: e.toString()));
    }
  }
}
