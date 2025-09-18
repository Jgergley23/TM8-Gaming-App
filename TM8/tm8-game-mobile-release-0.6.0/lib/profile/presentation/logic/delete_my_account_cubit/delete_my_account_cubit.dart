import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';

part 'delete_my_account_state.dart';
part 'delete_my_account_cubit.freezed.dart';

@injectable
class DeleteMyAccountCubit extends Cubit<DeleteMyAccountState> {
  DeleteMyAccountCubit() : super(const DeleteMyAccountState.initial());

  Future<void> deleteMyAccount() async {
    try {
      emit(const DeleteMyAccountState.loading());

      await api.apiV1UsersMeDelete();

      emit(
        const DeleteMyAccountState.loaded(),
      );
    } catch (e) {
      logError(e.toString());
      emit(
        DeleteMyAccountState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
