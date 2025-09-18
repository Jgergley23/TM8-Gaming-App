import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/messages/presentation/logic/fetch_channels_cubit/fetch_channels_cubit.dart';
import 'package:tm8/profile/presentation/logic/fetch_user_profile_cubit/fetch_user_profile_cubit.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'update_user_email_state.dart';
part 'update_user_email_cubit.freezed.dart';

@injectable
class UpdateUserEmailCubit extends Cubit<UpdateUserEmailState> {
  UpdateUserEmailCubit() : super(const UpdateUserEmailState.initial());

  Future<void> updateEmail({required ChangeEmailInput body}) async {
    try {
      emit(const UpdateUserEmailState.loading());

      await api.apiV1UsersEmailPatch(body: body);

      emit(
        const UpdateUserEmailState.loaded(),
      );
      sl<FetchUserProfileCubit>().fetchUserProfile();
      sl<FetchChannelsCubit>().fetchChannels(username: null);
    } catch (e) {
      logError(e.toString());
      emit(
        UpdateUserEmailState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
