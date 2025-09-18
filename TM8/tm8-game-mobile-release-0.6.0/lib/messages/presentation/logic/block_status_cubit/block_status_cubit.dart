import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'block_status_state.dart';
part 'block_status_cubit.freezed.dart';

@injectable
class BlockStatusCubit extends Cubit<BlockStatusState> {
  BlockStatusCubit() : super(const BlockStatusState.initial());

  Future<void> checkBlockStatus({required String userId}) async {
    try {
      emit(const BlockStatusState.loading());

      final result = await api.apiV1UsersUserIdBlockCheckGet(
        userId: userId,
      );

      emit(
        BlockStatusState.loaded(checkBlockStatus: result.bodyOrThrow),
      );
    } catch (e) {
      logError(e.toString());
      emit(
        BlockStatusState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
