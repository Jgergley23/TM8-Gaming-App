import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class TableOnHoverCubit extends Cubit<TableHoverClass> {
  TableOnHoverCubit()
      : super(
          TableHoverClass(
            isHover: false,
            index: 0,
          ),
        );

  void changeHoverState({
    required bool isHover,
    required int index,
  }) {
    emit(
      TableHoverClass(
        isHover: isHover,
        index: index,
      ),
    );
  }
}

class TableHoverClass {
  TableHoverClass({required this.isHover, required this.index});
  final bool isHover;
  final int index;
}
