import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8l/app/api/api_service.dart';
import 'package:tm8l/app/handlers/error_handler.dart';
import 'package:tm8l/swagger_generated_code/swagger.swagger.dart';

part 'send_contact_form_state.dart';
part 'send_contact_form_cubit.freezed.dart';

@injectable
class SendContactFormCubit extends Cubit<SendContactFormState> {
  SendContactFormCubit() : super(const SendContactFormState.initial());

  Future<void> sendContactForm({required ContactFormInput body}) async {
    try {
      emit(const SendContactFormState.loading());
      final result = await api.apiV1LandingPageContactFormPost(body: body);

      if (result.isSuccessful) {
        emit(
          const SendContactFormState.loaded(),
        );
      } else {
        emit(
          SendContactFormState.error(
            error: result.handleError,
          ),
        );
      }
    } catch (e) {
      logError(e.toString());
      emit(
        const SendContactFormState.error(
          error: 'Something went wrong',
        ),
      );
    }
  }
}
