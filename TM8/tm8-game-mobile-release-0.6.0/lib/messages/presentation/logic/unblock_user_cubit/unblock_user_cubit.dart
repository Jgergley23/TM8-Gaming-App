import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/messages/presentation/logic/fetch_channels_cubit/fetch_channels_cubit.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'unblock_user_state.dart';
part 'unblock_user_cubit.freezed.dart';

@injectable
class UnblockUserCubit extends Cubit<UnblockUserState> {
  UnblockUserCubit() : super(const UnblockUserState.initial());

  Future<void> unblockUser({required String userId}) async {
    try {
      emit(const UnblockUserState.loading());

      await api.apiV1UsersBlocksDelete(
        body: GetUsersByIdsParams(userIds: [userId]),
      );

      emit(
        const UnblockUserState.loaded(),
      );
      sl<FetchChannelsCubit>().fetchChannels(username: null);
    } catch (e) {
      logError(e.toString());
      emit(
        UnblockUserState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
