import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';

part 'add_friend_state.dart';
part 'add_friend_cubit.freezed.dart';

@injectable
class AddFriendCubit extends Cubit<AddFriendState> {
  AddFriendCubit() : super(const AddFriendState.initial());

  Future<void> addFriend({
    required String userId,
    required String username,
  }) async {
    try {
      emit(const AddFriendState.loading());

      await api.apiV1UsersUserIdFriendPost(userId: userId);

      emit(
        const AddFriendState.loaded(),
      );
    } catch (e) {
      logError(e.toString());
      emit(
        AddFriendState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
