import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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

extension SwaggerErrorConverter on Response {
  String get handleError {
    try {
      final json = jsonDecode(error.toString());
      var errorHandler = ErrorData.fromJson(json);
      return errorHandler.detail;
    } catch (e) {
      return 'Something went wrong';
    }
  }
}
