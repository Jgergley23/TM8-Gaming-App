import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/storage/tm8_storage.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'fetch_user_profile_state.dart';
part 'fetch_user_profile_cubit.freezed.dart';

@singleton
class FetchUserProfileCubit extends Cubit<FetchUserProfileState> {
  FetchUserProfileCubit() : super(const FetchUserProfileState.initial());

  Future<void> fetchUserProfile() async {
    try {
      emit(const FetchUserProfileState.loading());

      final result = await api.apiV1UsersMeGet();

      if (result.bodyOrThrow.regions == null ||
          result.bodyOrThrow.regions!.isEmpty) {
        sl<Tm8Storage>().regionCheck = false;
      } else {
        sl<Tm8Storage>().regionCheck = true;
      }

      emit(
        FetchUserProfileState.loaded(userProfile: result.bodyOrThrow),
      );

      sl<Tm8Storage>().userId = result.body?.id ?? '';
    } catch (e) {
      logError(e.toString());
      emit(
        FetchUserProfileState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
