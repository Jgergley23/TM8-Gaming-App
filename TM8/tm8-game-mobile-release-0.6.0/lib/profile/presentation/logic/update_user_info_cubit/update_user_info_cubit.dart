import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/messages/presentation/logic/fetch_channels_cubit/fetch_channels_cubit.dart';
import 'package:tm8/profile/presentation/logic/fetch_user_profile_cubit/fetch_user_profile_cubit.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'update_user_info_state.dart';
part 'update_user_info_cubit.freezed.dart';

@injectable
class UpdateUserInfoCubit extends Cubit<UpdateUserInfoState> {
  UpdateUserInfoCubit() : super(const UpdateUserInfoState.initial());

  Future<void> updateCountry({required ChangeUserInfoInput body}) async {
    try {
      emit(const UpdateUserInfoState.loading());

      await api.apiV1UsersInfoPatch(body: body);

      emit(
        const UpdateUserInfoState.loaded(),
      );
      sl<FetchUserProfileCubit>().fetchUserProfile();
      sl<FetchChannelsCubit>().fetchChannels(username: null);
    } catch (e) {
      logError(e.toString());
      emit(
        UpdateUserInfoState.error(
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> updatedGender({required ChangeUserInfoInput body}) async {
    try {
      emit(const UpdateUserInfoState.loading());

      await api.apiV1UsersInfoPatch(body: body);

      emit(
        const UpdateUserInfoState.loaded(),
      );
      sl<FetchUserProfileCubit>().fetchUserProfile();
    } catch (e) {
      logError(e.toString());
      emit(
        UpdateUserInfoState.error(
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> updatedDateOfBirth({required ChangeUserInfoInput body}) async {
    try {
      emit(const UpdateUserInfoState.loading());

      await api.apiV1UsersInfoPatch(body: body);

      emit(
        const UpdateUserInfoState.loaded(),
      );
      sl<FetchUserProfileCubit>().fetchUserProfile();
    } catch (e) {
      logError(e.toString());
      emit(
        UpdateUserInfoState.error(
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> updatedLanguage({required ChangeUserInfoInput body}) async {
    try {
      emit(const UpdateUserInfoState.loading());

      await api.apiV1UsersInfoPatch(body: body);

      emit(
        const UpdateUserInfoState.loaded(),
      );
      sl<FetchUserProfileCubit>().fetchUserProfile();
    } catch (e) {
      logError(e.toString());
      emit(
        UpdateUserInfoState.error(
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> updateRegion({required ChangeUserInfoInput body}) async {
    try {
      emit(const UpdateUserInfoState.loading());

      await api.apiV1UsersInfoPatch(body: body);

      emit(
        const UpdateUserInfoState.loaded(),
      );
      sl<FetchUserProfileCubit>().fetchUserProfile();
    } catch (e) {
      logError(e.toString());
      emit(
        UpdateUserInfoState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
