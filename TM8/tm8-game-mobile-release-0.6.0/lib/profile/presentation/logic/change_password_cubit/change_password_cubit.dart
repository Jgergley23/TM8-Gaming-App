import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/profile/presentation/logic/fetch_user_profile_cubit/fetch_user_profile_cubit.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'change_password_state.dart';
part 'change_password_cubit.freezed.dart';

@injectable
class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(const ChangePasswordState.initial());

  Future<void> changePassword({required ChangePasswordInput body}) async {
    try {
      emit(const ChangePasswordState.loading());

      await api.apiV1UsersPasswordPatch(body: body);

      emit(
        const ChangePasswordState.loaded(),
      );
      sl<FetchUserProfileCubit>().fetchUserProfile();
    } catch (e) {
      logError(e.toString());
      emit(
        ChangePasswordState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
