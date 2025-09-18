import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';

@injectable
class AddPreferencesCubit extends Cubit<Map<String, dynamic>> {
  AddPreferencesCubit() : super({});

  Future<void> addToMap({
    required String name,
    required String gameName,
    String? valueString,
    List<String>? valueListString,
    double? valueDouble,
  }) async {
    var map = {...state};
    if (!map.containsKey(gameName)) {
      map[gameName] = {};
    }
    if (valueString != null) {
      if (map[gameName][name] == valueString) {
        map[gameName].remove(name);
      } else {
        map[gameName][name] = valueString;
      }
    } else if (valueDouble != null) {
      map[gameName][name] = valueDouble;
    } else if (valueListString != null) {
      var list = map[gameName][name];
      if (list == null) {
        map[gameName][name] = valueListString;
      } else {
        list = list as List<String>;
        if (list.contains(valueListString.first)) {
          list.remove(valueListString.first);
          map[gameName][name] = list;
        } else {
          list.add(valueListString.first);
          map[gameName][name] = list;
        }
        if (list.isEmpty) {
          map[gameName].remove(name);
        }
      }
    }
    logInfo(map);
    emit(map);
  }

  Future<void> reset() async {
    final map = {...state};
    map.clear;
    emit(map);
  }

  Future<void> addWholeMap({required Map<String, dynamic> preferences}) async {
    emit(preferences);
  }
}
