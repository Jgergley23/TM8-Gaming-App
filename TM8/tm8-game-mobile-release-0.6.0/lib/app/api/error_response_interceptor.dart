import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:tm8/app/handlers/error_handler.dart';

//class that checks if api response is successful and returns error or response
class CustomErrorResponseInterceptor implements ResponseInterceptor {
  @override
  FutureOr<Response> onResponse(Response response) {
    if (!response.isSuccessful) {
      final error = response.handleError;
      throw error;
    } else {
      return response;
    }
  }
}
