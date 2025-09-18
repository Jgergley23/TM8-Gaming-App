import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/storage/tm8_storage.dart';

part 'epic_games_first_run_check_state.dart';
part 'epic_games_first_run_check_cubit.freezed.dart';

// cubit which checks if epic games first run or not. It will be used to show the onboarding screen only once.
// Once user follows up sign up, it will not be shown again.
@injectable
class EpicGamesFirstRunCheckCubit extends Cubit<EpicGamesFirstRunCheckState> {
  EpicGamesFirstRunCheckCubit()
      : super(const EpicGamesFirstRunCheckState.initial());

  Future<void> firstRunCheck() async {
    final firstRun = sl<Tm8Storage>().firstRunKeyEpicGames;
    if (firstRun) {
      emit(const EpicGamesFirstRunCheckState.skip());
    } else {
      sl<Tm8Storage>().firstRunKeyEpicGames = true;
      emit(const EpicGamesFirstRunCheckState.execute());
    }
  }
}
