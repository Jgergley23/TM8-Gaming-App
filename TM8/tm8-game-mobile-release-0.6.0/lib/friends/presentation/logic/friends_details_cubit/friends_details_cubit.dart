import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'friends_details_state.dart';
part 'friends_details_cubit.freezed.dart';

@injectable
class FriendsDetailsCubit extends Cubit<FriendsDetailsState> {
  FriendsDetailsCubit() : super(const FriendsDetailsState.initial());

  Future<void> fetchFriendDetails({required String userId}) async {
    try {
      emit(const FriendsDetailsState.loading());

      final result = await api.apiV1UsersUserIdProfileGet(
        userId: userId,
      );

      emit(
        FriendsDetailsState.loaded(
          userProfile: result.bodyOrThrow,
        ),
      );
    } catch (e) {
      logError(e.toString());
      emit(FriendsDetailsState.error(error: e.toString()));
    }
  }
}
