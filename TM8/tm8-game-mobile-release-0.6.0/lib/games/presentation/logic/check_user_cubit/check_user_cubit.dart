import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'check_user_state.dart';
part 'check_user_cubit.freezed.dart';

@injectable
class CheckUserCubit extends Cubit<CheckUserState> {
  CheckUserCubit() : super(const CheckUserState.initial());

  Future<void> checkUser({required String matchUserId}) async {
    try {
      emit(const CheckUserState.loading());

      final resultMatch =
          await api.apiV1UsersUserIdProfileGet(userId: matchUserId);
      final result = await api.apiV1UsersMeGet();
      emit(
        CheckUserState.loaded(
          profileMatch: resultMatch.bodyOrThrow,
          profileUser: result.bodyOrThrow,
        ),
      );
    } catch (e) {
      logError(e.toString());
      emit(
        CheckUserState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
