import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';

part 'remove_friend_state.dart';
part 'remove_friend_cubit.freezed.dart';

@injectable
class RemoveFriendCubit extends Cubit<RemoveFriendState> {
  RemoveFriendCubit() : super(const RemoveFriendState.initial());

  Future<void> removeFriend({required String userId}) async {
    try {
      emit(const RemoveFriendState.loading());

      await api.apiV1UsersUserIdFriendDelete(userId: userId);

      emit(
        const RemoveFriendState.loaded(),
      );
    } catch (e) {
      logError(e.toString());
      emit(RemoveFriendState.error(error: e.toString()));
    }
  }
}
