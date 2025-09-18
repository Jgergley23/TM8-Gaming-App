import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class FriendDetailsBottomSheetLogicCubit extends Cubit<BottomSheetItems> {
  FriendDetailsBottomSheetLogicCubit()
      : super(BottomSheetItems(items: [], assets: [], colors: []));

  Future<void> bottomShieldLogicUpdate({
    required BottomSheetItems items,
  }) async {
    emit(items);
  }
}

class BottomSheetItems {
  BottomSheetItems({
    required this.items,
    required this.assets,
    required this.colors,
  });
  final List<String> items;
  final List<Widget> assets;
  final List<Color> colors;
}
