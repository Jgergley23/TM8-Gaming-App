import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8_game_admin/app/api/api_service.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

part 'onboarding_completion_state.dart';
part 'onboarding_completion_cubit.freezed.dart';

@injectable
class OnboardingCompletionCubit extends Cubit<OnboardingCompletionState> {
  OnboardingCompletionCubit()
      : super(const OnboardingCompletionState.initial());

  Future<void> fetchOnboardingCompletion() async {
    try {
      emit(const OnboardingCompletionState.loading());
      final result = await api.apiV1StatisticsUsersOnboardingCompletionGet();

      if (result.isSuccessful) {
        emit(
          OnboardingCompletionState.loaded(
            statisticsOnboardingCompletionResponse: result.bodyOrThrow,
          ),
        );
      } else {
        final e = jsonDecode(result.error.toString());
        emit(OnboardingCompletionState.error(error: e['detail'].toString()));
      }
    } catch (e) {
      logError(e.toString());
      emit(
        const OnboardingCompletionState.error(error: 'Something went wrong'),
      );
    }
  }
}
