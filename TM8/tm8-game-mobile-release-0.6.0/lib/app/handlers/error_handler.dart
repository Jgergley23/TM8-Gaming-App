import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tm8/app/app_bloc/app_bloc.dart';
import 'package:tm8/app/services/service_locator.dart';

part 'error_handler.freezed.dart';
part 'error_handler.g.dart';

@freezed
class ErrorData with _$ErrorData {
  const factory ErrorData({
    @Default('Something went wrong') String detail,
    int? status,
    String? code,
    String? exception,
    String? origin,
  }) = _ErrorData;

  factory ErrorData.fromJson(Map<String, dynamic> json) =>
      _$ErrorDataFromJson(json);
}

// error handler for parsing errors
extension SwaggerErrorConverter on Response {
  String get handleError {
    try {
      final json = jsonDecode(error.toString());
      var errorHandler = ErrorData.fromJson(json);
      if (errorHandler.status == 429) {
        return 'Too many requests try again in couple of minutes';
      } else if (errorHandler.code == 'TGMD-0013') {
        sl<AppBloc>().add(AppEvent.banOrSuspend(message: errorHandler.detail));
        return errorHandler.detail;
      } else {
        return errorHandler.detail;
      }
    } catch (e) {
      return 'Something went wrong';
    }
  }
}
