import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/profile/presentation/logic/fetch_user_profile_cubit/fetch_user_profile_cubit.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'update_user_description_state.dart';
part 'update_user_description_cubit.freezed.dart';

@injectable
class UpdateUserDescriptionCubit extends Cubit<UpdateUserDescriptionState> {
  UpdateUserDescriptionCubit()
      : super(const UpdateUserDescriptionState.initial());

  Future<void> updateDescription({required ChangeUserInfoInput body}) async {
    try {
      emit(const UpdateUserDescriptionState.loading());

      await api.apiV1UsersInfoPatch(body: body);

      emit(
        const UpdateUserDescriptionState.loaded(),
      );
      sl<FetchUserProfileCubit>().fetchUserProfile();
    } catch (e) {
      logError(e.toString());
      emit(
        UpdateUserDescriptionState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
