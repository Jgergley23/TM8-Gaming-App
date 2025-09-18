import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'check_friend_status_state.dart';
part 'check_friend_status_cubit.freezed.dart';

@injectable
class CheckFriendStatusCubit extends Cubit<CheckFriendStatusState> {
  CheckFriendStatusCubit() : super(const CheckFriendStatusState.initial());

  Future<void> checkFriendStatus({required String userId}) async {
    try {
      emit(const CheckFriendStatusState.loading());

      final result = await api.apiV1UsersUserIdFriendCheckGet(userId: userId);
      emit(
        CheckFriendStatusState.loaded(friendStatus: result.bodyOrThrow),
      );
    } catch (e) {
      logError(e.toString());
      emit(
        CheckFriendStatusState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
