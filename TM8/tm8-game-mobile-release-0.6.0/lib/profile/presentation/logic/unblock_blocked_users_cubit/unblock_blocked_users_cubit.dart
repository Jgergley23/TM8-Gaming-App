import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/messages/presentation/logic/fetch_channels_cubit/fetch_channels_cubit.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'unblock_blocked_users_state.dart';
part 'unblock_blocked_users_cubit.freezed.dart';

@injectable
class UnblockBlockedUsersCubit extends Cubit<UnblockBlockedUsersState> {
  UnblockBlockedUsersCubit() : super(const UnblockBlockedUsersState.initial());

  Future<void> unblockUsers({required GetUsersByIdsParams body}) async {
    try {
      emit(const UnblockBlockedUsersState.loading());

      await api.apiV1UsersBlocksDelete(body: body);

      sl<FetchChannelsCubit>().fetchChannels(username: null);

      emit(
        const UnblockBlockedUsersState.loaded(),
      );
    } catch (e) {
      logError(e.toString());
      emit(
        UnblockBlockedUsersState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
