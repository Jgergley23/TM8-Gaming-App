import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/api/api_service.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

part 'add_phone_number_state.dart';
part 'add_phone_number_cubit.freezed.dart';

@injectable
class AddPhoneNumberCubit extends Cubit<AddPhoneNumberState> {
  AddPhoneNumberCubit() : super(const AddPhoneNumberState.initial());

  Future<void> addPhoneNumber({required SetUserPhoneInput body}) async {
    try {
      emit(const AddPhoneNumberState.loading());

      await api.apiV1AuthSetPhoneNumberPatch(body: body);

      emit(AddPhoneNumberState.loaded(phoneNumber: body.phoneNumber));
    } catch (e) {
      logError(e.toString());
      emit(AddPhoneNumberState.error(error: e.toString()));
    }
  }
}
