import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'manual_sign_up_state.dart';
part 'manual_sign_up_cubit.freezed.dart';

@injectable
class ManualSignUpCubit extends Cubit<ManualSignUpState> {
  ManualSignUpCubit() : super(const ManualSignUpState.initial());

  Future<void> manualSignUp({required RegisterInput body}) async {
    try {
      emit(const ManualSignUpState.loading());

      await api.apiV1AuthRegisterPost(body: body);

      emit(ManualSignUpState.loaded(email: body.email));
    } catch (e) {
      logError(e.toString());
      emit(ManualSignUpState.error(error: e.toString()));
    }
  }
}
