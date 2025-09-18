import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/messages/presentation/logic/fetch_channels_cubit/fetch_channels_cubit.dart';
import 'package:tm8/profile/presentation/logic/fetch_user_profile_cubit/fetch_user_profile_cubit.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'update_username_state.dart';
part 'update_username_cubit.freezed.dart';

@injectable
class UpdateUsernameCubit extends Cubit<UpdateUsernameState> {
  UpdateUsernameCubit() : super(const UpdateUsernameState.initial());

  Future<void> updateUsername({required UpdateUsernameInput body}) async {
    try {
      emit(const UpdateUsernameState.loading());

      await api.apiV1UsersUsernamePatch(body: body);

      emit(
        const UpdateUsernameState.loaded(),
      );
      sl<FetchUserProfileCubit>().fetchUserProfile();
      sl<FetchChannelsCubit>().fetchChannels(username: null);
    } catch (e) {
      logError(e.toString());
      emit(
        UpdateUsernameState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
