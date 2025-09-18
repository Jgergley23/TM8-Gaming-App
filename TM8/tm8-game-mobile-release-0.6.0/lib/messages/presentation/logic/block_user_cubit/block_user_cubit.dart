import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/friends/presentation/logic/fetch_friends_cubit/fetch_friends_cubit.dart';
import 'package:tm8/messages/presentation/logic/fetch_channels_cubit/fetch_channels_cubit.dart';

part 'block_user_state.dart';
part 'block_user_cubit.freezed.dart';

@injectable
class BlockUserCubit extends Cubit<BlockUserState> {
  BlockUserCubit() : super(const BlockUserState.initial());

  Future<void> blockUser({required String userId}) async {
    try {
      emit(const BlockUserState.loading());

      await api.apiV1UsersUserIdBlockPost(
        userId: userId,
      );

      emit(
        const BlockUserState.loaded(),
      );
      sl<FetchChannelsCubit>().fetchChannels(username: null);
      sl<FetchFriendsCubit>().fetchFriends(username: null);
    } catch (e) {
      logError(e.toString());
      emit(
        BlockUserState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
