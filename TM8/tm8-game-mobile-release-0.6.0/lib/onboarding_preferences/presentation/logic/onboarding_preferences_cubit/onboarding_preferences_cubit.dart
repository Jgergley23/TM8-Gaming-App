import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'onboarding_preferences_state.dart';
part 'onboarding_preferences_cubit.freezed.dart';

@injectable
class OnboardingPreferencesCubit extends Cubit<OnboardingPreferencesState> {
  OnboardingPreferencesCubit()
      : super(const OnboardingPreferencesState.initial());

  Future<void> onboardingPreferencesGet({
    required String game,
    required int index,
  }) async {
    try {
      emit(const OnboardingPreferencesState.loading());

      final result = await api.apiV1GamesGamePreferenceFormGet(game: game);

      emit(
        OnboardingPreferencesState.loaded(
          inputResponse: result.bodyOrThrow,
          game: game,
          index: index,
        ),
      );
    } catch (e) {
      logError(e.toString());
      emit(
        OnboardingPreferencesState.error(
          error: e.toString(),
          game: game,
          index: index,
        ),
      );
    }
  }
}
