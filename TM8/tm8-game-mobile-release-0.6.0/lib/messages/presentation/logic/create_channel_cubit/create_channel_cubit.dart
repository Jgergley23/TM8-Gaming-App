import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:stream_chat/stream_chat.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/app/api/get_stream_client.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'create_channel_state.dart';
part 'create_channel_cubit.freezed.dart';

@injectable
class CreateChannelCubit extends Cubit<CreateChannelState> {
  CreateChannelCubit() : super(const CreateChannelState.initial());

  Future<void> createChannel({required CreateChannelInput body}) async {
    try {
      emit(const CreateChannelState.loading());

      final result = await api.apiV1ChatChannelPost(body: body);

      final channel = client.channel('dm', id: result.bodyOrThrow.id);

      await channel.query();

      channel.watch();

      emit(
        CreateChannelState.loaded(channel: channel),
      );
    } catch (e) {
      logError(e.toString());
      emit(
        CreateChannelState.error(
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> watchExistingChannel({required Channel channel}) async {
    try {
      emit(const CreateChannelState.loading());

      channel.watch();

      emit(
        CreateChannelState.loaded(channel: channel),
      );
    } catch (e) {
      logError(e.toString());
      emit(
        CreateChannelState.error(
          error: e.toString(),
        ),
      );
    }
  }
}
