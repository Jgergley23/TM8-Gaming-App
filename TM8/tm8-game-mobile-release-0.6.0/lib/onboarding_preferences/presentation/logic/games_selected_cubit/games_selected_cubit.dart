import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class GamesSelectedCubit extends Cubit<List<String>> {
  GamesSelectedCubit() : super([]);

  void addRemoveGame({required String game}) {
    final games = [...state];
    if (games.contains(game)) {
      games.remove(game);
    } else {
      games.add(game);
    }
    emit(games);
  }
}
