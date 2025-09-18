// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';

import 'package:chopper/chopper.dart';

import 'client_mapping.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show MultipartFile;
import 'package:chopper/chopper.dart' as chopper;
import 'swagger.enums.swagger.dart' as enums;
export 'swagger.enums.swagger.dart';

part 'swagger.swagger.chopper.dart';
part 'swagger.swagger.g.dart';

// **************************************************************************
// SwaggerChopperGenerator
// **************************************************************************

@ChopperApi()
abstract class Swagger extends ChopperService {
  static Swagger create({
    ChopperClient? client,
    http.Client? httpClient,
    Authenticator? authenticator,
    ErrorConverter? errorConverter,
    Converter? converter,
    Uri? baseUrl,
    Iterable<dynamic>? interceptors,
  }) {
    if (client != null) {
      return _$Swagger(client);
    }

    final newClient = ChopperClient(
        services: [_$Swagger()],
        converter: converter ?? $JsonSerializableConverter(),
        interceptors: interceptors ?? [],
        client: httpClient,
        authenticator: authenticator,
        errorConverter: errorConverter,
        baseUrl: baseUrl ?? Uri.parse('http://'));
    return _$Swagger(newClient);
  }

  ///Get health check information
  Future<chopper.Response<HealthCheckResponse>> get() {
    generatedMapping.putIfAbsent(
        HealthCheckResponse, () => HealthCheckResponse.fromJsonFactory);

    return _get();
  }

  ///Get health check information
  @Get(path: '/')
  Future<chopper.Response<HealthCheckResponse>> _get();

  ///Get exception metadata
  Future<chopper.Response> exceptionsGet() {
    return _exceptionsGet();
  }

  ///Get exception metadata
  @Get(path: '/exceptions')
  Future<chopper.Response> _exceptionsGet();

  ///
  ///@param page Page number
  ///@param limit Page size
  ///@param sort Sorting parameters
  ///@param roles User roles filter
  ///@param username Username filter
  ///@param name Name filter
  ///@param status Status filter
  Future<chopper.Response<UserPaginatedResponse>> apiV1UsersGet({
    num? page,
    num? limit,
    String? sort,
    String? roles,
    String? username,
    String? name,
    enums.ApiV1UsersGetStatus? status,
  }) {
    generatedMapping.putIfAbsent(
        UserPaginatedResponse, () => UserPaginatedResponse.fromJsonFactory);

    return _apiV1UsersGet(
        page: page,
        limit: limit,
        sort: sort,
        roles: roles,
        username: username,
        name: name,
        status: status?.value?.toString());
  }

  ///
  ///@param page Page number
  ///@param limit Page size
  ///@param sort Sorting parameters
  ///@param roles User roles filter
  ///@param username Username filter
  ///@param name Name filter
  ///@param status Status filter
  @Get(path: '/api/v1/users')
  Future<chopper.Response<UserPaginatedResponse>> _apiV1UsersGet({
    @Query('page') num? page,
    @Query('limit') num? limit,
    @Query('sort') String? sort,
    @Query('roles') String? roles,
    @Query('username') String? username,
    @Query('name') String? name,
    @Query('status') String? status,
  });

  ///
  Future<chopper.Response> apiV1UsersAdminPost(
      {required CreateAdminInput? body}) {
    return _apiV1UsersAdminPost(body: body);
  }

  ///
  @Post(
    path: '/api/v1/users/admin',
    optionalBody: true,
  )
  Future<chopper.Response> _apiV1UsersAdminPost(
      {@Body() required CreateAdminInput? body});

  ///
  Future<chopper.Response<List<UserGroupResponse>>> apiV1UsersGroupsGet() {
    generatedMapping.putIfAbsent(
        UserGroupResponse, () => UserGroupResponse.fromJsonFactory);

    return _apiV1UsersGroupsGet();
  }

  ///
  @Get(path: '/api/v1/users/groups')
  Future<chopper.Response<List<UserGroupResponse>>> _apiV1UsersGroupsGet();

  ///
  ///@param username Username
  Future<chopper.Response<List<UserResponse>>> apiV1UsersUsernameUsernameGet(
      {required String? username}) {
    generatedMapping.putIfAbsent(
        UserResponse, () => UserResponse.fromJsonFactory);

    return _apiV1UsersUsernameUsernameGet(username: username);
  }

  ///
  ///@param username Username
  @Get(path: '/api/v1/users/username/{username}')
  Future<chopper.Response<List<UserResponse>>> _apiV1UsersUsernameUsernameGet(
      {@Path('username') required String? username});

  ///
  ///@param userId User ID
  Future<chopper.Response<UserResponse>> apiV1UsersUserIdGet(
      {required String? userId}) {
    generatedMapping.putIfAbsent(
        UserResponse, () => UserResponse.fromJsonFactory);

    return _apiV1UsersUserIdGet(userId: userId);
  }

  ///
  ///@param userId User ID
  @Get(path: '/api/v1/users/{userId}')
  Future<chopper.Response<UserResponse>> _apiV1UsersUserIdGet(
      {@Path('userId') required String? userId});

  ///
  ///@param userId User ID
  Future<chopper.Response> apiV1UsersUserIdDelete({required String? userId}) {
    return _apiV1UsersUserIdDelete(userId: userId);
  }

  ///
  ///@param userId User ID
  @Delete(path: '/api/v1/users/{userId}')
  Future<chopper.Response> _apiV1UsersUserIdDelete(
      {@Path('userId') required String? userId});

  ///
  ///@param userId User ID
  ///@param games Game parameters
  Future<chopper.Response<List<UserGameDataResponse>>>
      apiV1UsersUserIdPreferencesGet({
    required String? userId,
    String? games,
  }) {
    generatedMapping.putIfAbsent(
        UserGameDataResponse, () => UserGameDataResponse.fromJsonFactory);

    return _apiV1UsersUserIdPreferencesGet(userId: userId, games: games);
  }

  ///
  ///@param userId User ID
  ///@param games Game parameters
  @Get(path: '/api/v1/users/{userId}/preferences')
  Future<chopper.Response<List<UserGameDataResponse>>>
      _apiV1UsersUserIdPreferencesGet({
    @Path('userId') required String? userId,
    @Query('games') String? games,
  });

  ///
  ///@param userId User ID
  Future<chopper.Response<UserResponse>> apiV1UsersUserIdAdminNotePatch({
    required String? userId,
    required UserNoteInput? body,
  }) {
    generatedMapping.putIfAbsent(
        UserResponse, () => UserResponse.fromJsonFactory);

    return _apiV1UsersUserIdAdminNotePatch(userId: userId, body: body);
  }

  ///
  ///@param userId User ID
  @Patch(
    path: '/api/v1/users/{userId}/admin-note',
    optionalBody: true,
  )
  Future<chopper.Response<UserResponse>> _apiV1UsersUserIdAdminNotePatch({
    @Path('userId') required String? userId,
    @Body() required UserNoteInput? body,
  });

  ///
  ///@param userId User ID
  Future<chopper.Response<List<UserReportResponse>>> apiV1UsersUserIdReportsGet(
      {required String? userId}) {
    generatedMapping.putIfAbsent(
        UserReportResponse, () => UserReportResponse.fromJsonFactory);

    return _apiV1UsersUserIdReportsGet(userId: userId);
  }

  ///
  ///@param userId User ID
  @Get(path: '/api/v1/users/{userId}/reports')
  Future<chopper.Response<List<UserReportResponse>>>
      _apiV1UsersUserIdReportsGet({@Path('userId') required String? userId});

  ///
  Future<chopper.Response<List<UserWarningTypeResponse>>>
      apiV1UsersWarningTypesGet() {
    generatedMapping.putIfAbsent(
        UserWarningTypeResponse, () => UserWarningTypeResponse.fromJsonFactory);

    return _apiV1UsersWarningTypesGet();
  }

  ///
  @Get(path: '/api/v1/users/warning/types')
  Future<chopper.Response<List<UserWarningTypeResponse>>>
      _apiV1UsersWarningTypesGet();

  ///
  Future<chopper.Response<List<UserReportTypeResponse>>>
      apiV1UsersReportTypesGet() {
    generatedMapping.putIfAbsent(
        UserReportTypeResponse, () => UserReportTypeResponse.fromJsonFactory);

    return _apiV1UsersReportTypesGet();
  }

  ///
  @Get(path: '/api/v1/users/report/types')
  Future<chopper.Response<List<UserReportTypeResponse>>>
      _apiV1UsersReportTypesGet();

  ///
  Future<chopper.Response<List<UserResponse>>> apiV1UsersWarningPatch(
      {required UserWarningInput? body}) {
    generatedMapping.putIfAbsent(
        UserResponse, () => UserResponse.fromJsonFactory);

    return _apiV1UsersWarningPatch(body: body);
  }

  ///
  @Patch(
    path: '/api/v1/users/warning',
    optionalBody: true,
  )
  Future<chopper.Response<List<UserResponse>>> _apiV1UsersWarningPatch(
      {@Body() required UserWarningInput? body});

  ///
  Future<chopper.Response<List<UserResponse>>> apiV1UsersBanPatch(
      {required UserBanInput? body}) {
    generatedMapping.putIfAbsent(
        UserResponse, () => UserResponse.fromJsonFactory);

    return _apiV1UsersBanPatch(body: body);
  }

  ///
  @Patch(
    path: '/api/v1/users/ban',
    optionalBody: true,
  )
  Future<chopper.Response<List<UserResponse>>> _apiV1UsersBanPatch(
      {@Body() required UserBanInput? body});

  ///
  Future<chopper.Response<List<UserResponse>>> apiV1UsersSuspendPatch(
      {required UserSuspendInput? body}) {
    generatedMapping.putIfAbsent(
        UserResponse, () => UserResponse.fromJsonFactory);

    return _apiV1UsersSuspendPatch(body: body);
  }

  ///
  @Patch(
    path: '/api/v1/users/suspend',
    optionalBody: true,
  )
  Future<chopper.Response<List<UserResponse>>> _apiV1UsersSuspendPatch(
      {@Body() required UserSuspendInput? body});

  ///
  Future<chopper.Response<List<UserResponse>>> apiV1UsersResetPatch(
      {required UserResetInput? body}) {
    generatedMapping.putIfAbsent(
        UserResponse, () => UserResponse.fromJsonFactory);

    return _apiV1UsersResetPatch(body: body);
  }

  ///
  @Patch(
    path: '/api/v1/users/reset',
    optionalBody: true,
  )
  Future<chopper.Response<List<UserResponse>>> _apiV1UsersResetPatch(
      {@Body() required UserResetInput? body});

  ///
  Future<chopper.Response<AuthResponse>> apiV1AuthTokenRefreshPost() {
    generatedMapping.putIfAbsent(
        AuthResponse, () => AuthResponse.fromJsonFactory);

    return _apiV1AuthTokenRefreshPost();
  }

  ///
  @Post(
    path: '/api/v1/auth/token/refresh',
    optionalBody: true,
  )
  Future<chopper.Response<AuthResponse>> _apiV1AuthTokenRefreshPost();

  ///
  Future<chopper.Response<AuthResponse>> apiV1AuthSignInPost(
      {required AuthLoginInput? body}) {
    generatedMapping.putIfAbsent(
        AuthResponse, () => AuthResponse.fromJsonFactory);

    return _apiV1AuthSignInPost(body: body);
  }

  ///
  @Post(
    path: '/api/v1/auth/sign-in',
    optionalBody: true,
  )
  Future<chopper.Response<AuthResponse>> _apiV1AuthSignInPost(
      {@Body() required AuthLoginInput? body});

  ///
  Future<chopper.Response> apiV1AuthForgotPasswordPost(
      {required ForgotPasswordInput? body}) {
    return _apiV1AuthForgotPasswordPost(body: body);
  }

  ///
  @Post(
    path: '/api/v1/auth/forgot-password',
    optionalBody: true,
  )
  Future<chopper.Response> _apiV1AuthForgotPasswordPost(
      {@Body() required ForgotPasswordInput? body});

  ///
  Future<chopper.Response> apiV1AuthForgotPasswordVerifyPost(
      {required VerifyCodeInput? body}) {
    return _apiV1AuthForgotPasswordVerifyPost(body: body);
  }

  ///
  @Post(
    path: '/api/v1/auth/forgot-password/verify',
    optionalBody: true,
  )
  Future<chopper.Response> _apiV1AuthForgotPasswordVerifyPost(
      {@Body() required VerifyCodeInput? body});

  ///
  Future<chopper.Response<AuthResponse>> apiV1AuthForgotPasswordResetPost(
      {required ResetPasswordInput? body}) {
    generatedMapping.putIfAbsent(
        AuthResponse, () => AuthResponse.fromJsonFactory);

    return _apiV1AuthForgotPasswordResetPost(body: body);
  }

  ///
  @Post(
    path: '/api/v1/auth/forgot-password/reset',
    optionalBody: true,
  )
  Future<chopper.Response<AuthResponse>> _apiV1AuthForgotPasswordResetPost(
      {@Body() required ResetPasswordInput? body});

  ///
  Future<chopper.Response<StatisticsTotalCountResponse>>
      apiV1StatisticsUsersTotalCountGet() {
    generatedMapping.putIfAbsent(StatisticsTotalCountResponse,
        () => StatisticsTotalCountResponse.fromJsonFactory);

    return _apiV1StatisticsUsersTotalCountGet();
  }

  ///
  @Get(path: '/api/v1/statistics/users/total-count')
  Future<chopper.Response<StatisticsTotalCountResponse>>
      _apiV1StatisticsUsersTotalCountGet();

  ///
  Future<chopper.Response<StatisticsOnboardingCompletionResponse>>
      apiV1StatisticsUsersOnboardingCompletionGet() {
    generatedMapping.putIfAbsent(StatisticsOnboardingCompletionResponse,
        () => StatisticsOnboardingCompletionResponse.fromJsonFactory);

    return _apiV1StatisticsUsersOnboardingCompletionGet();
  }

  ///
  @Get(path: '/api/v1/statistics/users/onboarding-completion')
  Future<chopper.Response<StatisticsOnboardingCompletionResponse>>
      _apiV1StatisticsUsersOnboardingCompletionGet();

  ///
  ///@param groupBy Group parameter
  ///@param startDate Start date
  ///@param endDate End date
  Future<chopper.Response<StatisticsNewUsersRegisteredResponse>>
      apiV1StatisticsUsersNewUsersRegisteredGet({
    required enums.ApiV1StatisticsUsersNewUsersRegisteredGetGroupBy? groupBy,
    required String? startDate,
    required String? endDate,
  }) {
    generatedMapping.putIfAbsent(StatisticsNewUsersRegisteredResponse,
        () => StatisticsNewUsersRegisteredResponse.fromJsonFactory);

    return _apiV1StatisticsUsersNewUsersRegisteredGet(
        groupBy: groupBy?.value?.toString(),
        startDate: startDate,
        endDate: endDate);
  }

  ///
  ///@param groupBy Group parameter
  ///@param startDate Start date
  ///@param endDate End date
  @Get(path: '/api/v1/statistics/users/new-users-registered')
  Future<chopper.Response<StatisticsNewUsersRegisteredResponse>>
      _apiV1StatisticsUsersNewUsersRegisteredGet({
    @Query('groupBy') required String? groupBy,
    @Query('startDate') required String? startDate,
    @Query('endDate') required String? endDate,
  });

  ///
  ///@param userGroups User group filter
  Future<chopper.Response<UserGroupCountsResponse>>
      apiV1StatisticsUsersGroupCountsGet({String? userGroups}) {
    generatedMapping.putIfAbsent(
        UserGroupCountsResponse, () => UserGroupCountsResponse.fromJsonFactory);

    return _apiV1StatisticsUsersGroupCountsGet(userGroups: userGroups);
  }

  ///
  ///@param userGroups User group filter
  @Get(path: '/api/v1/statistics/users/group-counts')
  Future<chopper.Response<UserGroupCountsResponse>>
      _apiV1StatisticsUsersGroupCountsGet(
          {@Query('userGroups') String? userGroups});

  ///
  ///@param page Page number
  ///@param limit Page size
  ///@param sort Sorting parameters
  ///@param title Title filter
  ///@param userGroups User group filter
  ///@param types Notification type filter
  Future<chopper.Response<ScheduledNotificationPaginatedResponse>>
      apiV1ScheduledNotificationsGet({
    num? page,
    num? limit,
    String? sort,
    String? title,
    String? userGroups,
    String? types,
  }) {
    generatedMapping.putIfAbsent(ScheduledNotificationPaginatedResponse,
        () => ScheduledNotificationPaginatedResponse.fromJsonFactory);

    return _apiV1ScheduledNotificationsGet(
        page: page,
        limit: limit,
        sort: sort,
        title: title,
        userGroups: userGroups,
        types: types);
  }

  ///
  ///@param page Page number
  ///@param limit Page size
  ///@param sort Sorting parameters
  ///@param title Title filter
  ///@param userGroups User group filter
  ///@param types Notification type filter
  @Get(path: '/api/v1/scheduled-notifications')
  Future<chopper.Response<ScheduledNotificationPaginatedResponse>>
      _apiV1ScheduledNotificationsGet({
    @Query('page') num? page,
    @Query('limit') num? limit,
    @Query('sort') String? sort,
    @Query('title') String? title,
    @Query('userGroups') String? userGroups,
    @Query('types') String? types,
  });

  ///
  Future<chopper.Response<ScheduledNotificationResponse>>
      apiV1ScheduledNotificationsPost(
          {required CreateScheduledNotificationInput? body}) {
    generatedMapping.putIfAbsent(ScheduledNotificationResponse,
        () => ScheduledNotificationResponse.fromJsonFactory);

    return _apiV1ScheduledNotificationsPost(body: body);
  }

  ///
  @Post(
    path: '/api/v1/scheduled-notifications',
    optionalBody: true,
  )
  Future<chopper.Response<ScheduledNotificationResponse>>
      _apiV1ScheduledNotificationsPost(
          {@Body() required CreateScheduledNotificationInput? body});

  ///
  Future<chopper.Response> apiV1ScheduledNotificationsDelete(
      {required DeleteScheduledNotificationsInput? body}) {
    return _apiV1ScheduledNotificationsDelete(body: body);
  }

  ///
  @Delete(path: '/api/v1/scheduled-notifications')
  Future<chopper.Response> _apiV1ScheduledNotificationsDelete(
      {@Body() required DeleteScheduledNotificationsInput? body});

  ///
  Future<chopper.Response<List<NotificationTypeResponse>>>
      apiV1ScheduledNotificationsTypesGet() {
    generatedMapping.putIfAbsent(NotificationTypeResponse,
        () => NotificationTypeResponse.fromJsonFactory);

    return _apiV1ScheduledNotificationsTypesGet();
  }

  ///
  @Get(path: '/api/v1/scheduled-notifications/types')
  Future<chopper.Response<List<NotificationTypeResponse>>>
      _apiV1ScheduledNotificationsTypesGet();

  ///
  Future<chopper.Response<List<NotificationIntervalResponse>>>
      apiV1ScheduledNotificationsIntervalsGet() {
    generatedMapping.putIfAbsent(NotificationIntervalResponse,
        () => NotificationIntervalResponse.fromJsonFactory);

    return _apiV1ScheduledNotificationsIntervalsGet();
  }

  ///
  @Get(path: '/api/v1/scheduled-notifications/intervals')
  Future<chopper.Response<List<NotificationIntervalResponse>>>
      _apiV1ScheduledNotificationsIntervalsGet();

  ///
  ///@param notificationId Scheduled Notification ID
  Future<chopper.Response<ScheduledNotificationResponse>>
      apiV1ScheduledNotificationsNotificationIdPatch({
    required String? notificationId,
    required UpdateScheduledNotificationInput? body,
  }) {
    generatedMapping.putIfAbsent(ScheduledNotificationResponse,
        () => ScheduledNotificationResponse.fromJsonFactory);

    return _apiV1ScheduledNotificationsNotificationIdPatch(
        notificationId: notificationId, body: body);
  }

  ///
  ///@param notificationId Scheduled Notification ID
  @Patch(
    path: '/api/v1/scheduled-notifications/{notificationId}',
    optionalBody: true,
  )
  Future<chopper.Response<ScheduledNotificationResponse>>
      _apiV1ScheduledNotificationsNotificationIdPatch({
    @Path('notificationId') required String? notificationId,
    @Body() required UpdateScheduledNotificationInput? body,
  });

  ///
  ///@param notificationId Scheduled Notification ID
  Future<chopper.Response<ScheduledNotificationResponse>>
      apiV1ScheduledNotificationsNotificationIdGet(
          {required String? notificationId}) {
    generatedMapping.putIfAbsent(ScheduledNotificationResponse,
        () => ScheduledNotificationResponse.fromJsonFactory);

    return _apiV1ScheduledNotificationsNotificationIdGet(
        notificationId: notificationId);
  }

  ///
  ///@param notificationId Scheduled Notification ID
  @Get(path: '/api/v1/scheduled-notifications/{notificationId}')
  Future<chopper.Response<ScheduledNotificationResponse>>
      _apiV1ScheduledNotificationsNotificationIdGet(
          {@Path('notificationId') required String? notificationId});

  ///
  Future<chopper.Response> apiV1LandingPageContactFormPost(
      {required ContactFormInput? body}) {
    return _apiV1LandingPageContactFormPost(body: body);
  }

  ///
  @Post(
    path: '/api/v1/landing-page/contact-form',
    optionalBody: true,
  )
  Future<chopper.Response> _apiV1LandingPageContactFormPost(
      {@Body() required ContactFormInput? body});
}

@JsonSerializable(explicitToJson: true)
class HealthCheckResponse {
  const HealthCheckResponse({
    required this.name,
    required this.description,
    required this.version,
  });

  factory HealthCheckResponse.fromJson(Map<String, dynamic> json) =>
      _$HealthCheckResponseFromJson(json);

  static const toJsonFactory = _$HealthCheckResponseToJson;
  Map<String, dynamic> toJson() => _$HealthCheckResponseToJson(this);

  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'version')
  final String version;
  static const fromJsonFactory = _$HealthCheckResponseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is HealthCheckResponse &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.version, version) ||
                const DeepCollectionEquality().equals(other.version, version)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(version) ^
      runtimeType.hashCode;
}

extension $HealthCheckResponseExtension on HealthCheckResponse {
  HealthCheckResponse copyWith(
      {String? name, String? description, String? version}) {
    return HealthCheckResponse(
        name: name ?? this.name,
        description: description ?? this.description,
        version: version ?? this.version);
  }

  HealthCheckResponse copyWithWrapped(
      {Wrapped<String>? name,
      Wrapped<String>? description,
      Wrapped<String>? version}) {
    return HealthCheckResponse(
        name: (name != null ? name.value : this.name),
        description:
            (description != null ? description.value : this.description),
        version: (version != null ? version.value : this.version));
  }
}

@JsonSerializable(explicitToJson: true)
class TGMDExceptionResponse {
  const TGMDExceptionResponse({
    required this.origin,
    required this.status,
    required this.code,
    required this.exception,
    required this.detail,
  });

  factory TGMDExceptionResponse.fromJson(Map<String, dynamic> json) =>
      _$TGMDExceptionResponseFromJson(json);

  static const toJsonFactory = _$TGMDExceptionResponseToJson;
  Map<String, dynamic> toJson() => _$TGMDExceptionResponseToJson(this);

  @JsonKey(
    name: 'origin',
    toJson: tGMDExceptionResponseOriginToJson,
    fromJson: tGMDExceptionResponseOriginFromJson,
  )
  final enums.TGMDExceptionResponseOrigin origin;
  @JsonKey(name: 'status')
  final double status;
  @JsonKey(name: 'code')
  final String code;
  @JsonKey(name: 'exception')
  final String exception;
  @JsonKey(name: 'detail')
  final String detail;
  static const fromJsonFactory = _$TGMDExceptionResponseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is TGMDExceptionResponse &&
            (identical(other.origin, origin) ||
                const DeepCollectionEquality().equals(other.origin, origin)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.code, code) ||
                const DeepCollectionEquality().equals(other.code, code)) &&
            (identical(other.exception, exception) ||
                const DeepCollectionEquality()
                    .equals(other.exception, exception)) &&
            (identical(other.detail, detail) ||
                const DeepCollectionEquality().equals(other.detail, detail)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(origin) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(code) ^
      const DeepCollectionEquality().hash(exception) ^
      const DeepCollectionEquality().hash(detail) ^
      runtimeType.hashCode;
}

extension $TGMDExceptionResponseExtension on TGMDExceptionResponse {
  TGMDExceptionResponse copyWith(
      {enums.TGMDExceptionResponseOrigin? origin,
      double? status,
      String? code,
      String? exception,
      String? detail}) {
    return TGMDExceptionResponse(
        origin: origin ?? this.origin,
        status: status ?? this.status,
        code: code ?? this.code,
        exception: exception ?? this.exception,
        detail: detail ?? this.detail);
  }

  TGMDExceptionResponse copyWithWrapped(
      {Wrapped<enums.TGMDExceptionResponseOrigin>? origin,
      Wrapped<double>? status,
      Wrapped<String>? code,
      Wrapped<String>? exception,
      Wrapped<String>? detail}) {
    return TGMDExceptionResponse(
        origin: (origin != null ? origin.value : this.origin),
        status: (status != null ? status.value : this.status),
        code: (code != null ? code.value : this.code),
        exception: (exception != null ? exception.value : this.exception),
        detail: (detail != null ? detail.value : this.detail));
  }
}

@JsonSerializable(explicitToJson: true)
class UserStatusResponse {
  const UserStatusResponse({
    required this.type,
    this.note,
    this.until,
  });

  factory UserStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$UserStatusResponseFromJson(json);

  static const toJsonFactory = _$UserStatusResponseToJson;
  Map<String, dynamic> toJson() => _$UserStatusResponseToJson(this);

  @JsonKey(
    name: 'type',
    toJson: userStatusResponseTypeToJson,
    fromJson: userStatusResponseTypeFromJson,
  )
  final enums.UserStatusResponseType type;
  @JsonKey(name: 'note')
  final String? note;
  @JsonKey(name: 'until')
  final DateTime? until;
  static const fromJsonFactory = _$UserStatusResponseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserStatusResponse &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.note, note) ||
                const DeepCollectionEquality().equals(other.note, note)) &&
            (identical(other.until, until) ||
                const DeepCollectionEquality().equals(other.until, until)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(note) ^
      const DeepCollectionEquality().hash(until) ^
      runtimeType.hashCode;
}

extension $UserStatusResponseExtension on UserStatusResponse {
  UserStatusResponse copyWith(
      {enums.UserStatusResponseType? type, String? note, DateTime? until}) {
    return UserStatusResponse(
        type: type ?? this.type,
        note: note ?? this.note,
        until: until ?? this.until);
  }

  UserStatusResponse copyWithWrapped(
      {Wrapped<enums.UserStatusResponseType>? type,
      Wrapped<String?>? note,
      Wrapped<DateTime?>? until}) {
    return UserStatusResponse(
        type: (type != null ? type.value : this.type),
        note: (note != null ? note.value : this.note),
        until: (until != null ? until.value : this.until));
  }
}

@JsonSerializable(explicitToJson: true)
class UserResponse {
  const UserResponse({
    required this.id,
    this.name,
    required this.email,
    this.username,
    required this.gender,
    required this.role,
    this.signupType,
    this.timezone,
    this.country,
    this.note,
    this.photoKey,
    required this.phoneNumber,
    required this.createdAt,
    required this.updatedAt,
    this.dateOfBirth,
    this.lastLogin,
    required this.status,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  static const toJsonFactory = _$UserResponseToJson;
  Map<String, dynamic> toJson() => _$UserResponseToJson(this);

  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'username')
  final String? username;
  @JsonKey(
    name: 'gender',
    toJson: userResponseGenderToJson,
    fromJson: userResponseGenderFromJson,
  )
  final enums.UserResponseGender gender;
  @JsonKey(
    name: 'role',
    toJson: userResponseRoleToJson,
    fromJson: userResponseRoleFromJson,
  )
  final enums.UserResponseRole role;
  @JsonKey(
    name: 'signupType',
    toJson: userResponseSignupTypeNullableToJson,
    fromJson: userResponseSignupTypeNullableFromJson,
  )
  final enums.UserResponseSignupType? signupType;
  @JsonKey(
    name: 'timezone',
    toJson: userResponseTimezoneNullableToJson,
    fromJson: userResponseTimezoneNullableFromJson,
  )
  final enums.UserResponseTimezone? timezone;
  @JsonKey(name: 'country')
  final String? country;
  @JsonKey(name: 'note')
  final String? note;
  @JsonKey(name: 'photoKey')
  final String? photoKey;
  @JsonKey(name: 'phoneNumber')
  final String phoneNumber;
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime updatedAt;
  @JsonKey(name: 'dateOfBirth')
  final DateTime? dateOfBirth;
  @JsonKey(name: 'lastLogin')
  final DateTime? lastLogin;
  @JsonKey(name: 'status')
  final UserStatusResponse status;
  static const fromJsonFactory = _$UserResponseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserResponse &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.gender, gender) ||
                const DeepCollectionEquality().equals(other.gender, gender)) &&
            (identical(other.role, role) ||
                const DeepCollectionEquality().equals(other.role, role)) &&
            (identical(other.signupType, signupType) ||
                const DeepCollectionEquality()
                    .equals(other.signupType, signupType)) &&
            (identical(other.timezone, timezone) ||
                const DeepCollectionEquality()
                    .equals(other.timezone, timezone)) &&
            (identical(other.country, country) ||
                const DeepCollectionEquality()
                    .equals(other.country, country)) &&
            (identical(other.note, note) ||
                const DeepCollectionEquality().equals(other.note, note)) &&
            (identical(other.photoKey, photoKey) ||
                const DeepCollectionEquality()
                    .equals(other.photoKey, photoKey)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality()
                    .equals(other.phoneNumber, phoneNumber)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                const DeepCollectionEquality()
                    .equals(other.dateOfBirth, dateOfBirth)) &&
            (identical(other.lastLogin, lastLogin) ||
                const DeepCollectionEquality()
                    .equals(other.lastLogin, lastLogin)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(gender) ^
      const DeepCollectionEquality().hash(role) ^
      const DeepCollectionEquality().hash(signupType) ^
      const DeepCollectionEquality().hash(timezone) ^
      const DeepCollectionEquality().hash(country) ^
      const DeepCollectionEquality().hash(note) ^
      const DeepCollectionEquality().hash(photoKey) ^
      const DeepCollectionEquality().hash(phoneNumber) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(dateOfBirth) ^
      const DeepCollectionEquality().hash(lastLogin) ^
      const DeepCollectionEquality().hash(status) ^
      runtimeType.hashCode;
}

extension $UserResponseExtension on UserResponse {
  UserResponse copyWith(
      {String? id,
      String? name,
      String? email,
      String? username,
      enums.UserResponseGender? gender,
      enums.UserResponseRole? role,
      enums.UserResponseSignupType? signupType,
      enums.UserResponseTimezone? timezone,
      String? country,
      String? note,
      String? photoKey,
      String? phoneNumber,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? dateOfBirth,
      DateTime? lastLogin,
      UserStatusResponse? status}) {
    return UserResponse(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        username: username ?? this.username,
        gender: gender ?? this.gender,
        role: role ?? this.role,
        signupType: signupType ?? this.signupType,
        timezone: timezone ?? this.timezone,
        country: country ?? this.country,
        note: note ?? this.note,
        photoKey: photoKey ?? this.photoKey,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        lastLogin: lastLogin ?? this.lastLogin,
        status: status ?? this.status);
  }

  UserResponse copyWithWrapped(
      {Wrapped<String>? id,
      Wrapped<String?>? name,
      Wrapped<String>? email,
      Wrapped<String?>? username,
      Wrapped<enums.UserResponseGender>? gender,
      Wrapped<enums.UserResponseRole>? role,
      Wrapped<enums.UserResponseSignupType?>? signupType,
      Wrapped<enums.UserResponseTimezone?>? timezone,
      Wrapped<String?>? country,
      Wrapped<String?>? note,
      Wrapped<String?>? photoKey,
      Wrapped<String>? phoneNumber,
      Wrapped<DateTime>? createdAt,
      Wrapped<DateTime>? updatedAt,
      Wrapped<DateTime?>? dateOfBirth,
      Wrapped<DateTime?>? lastLogin,
      Wrapped<UserStatusResponse>? status}) {
    return UserResponse(
        id: (id != null ? id.value : this.id),
        name: (name != null ? name.value : this.name),
        email: (email != null ? email.value : this.email),
        username: (username != null ? username.value : this.username),
        gender: (gender != null ? gender.value : this.gender),
        role: (role != null ? role.value : this.role),
        signupType: (signupType != null ? signupType.value : this.signupType),
        timezone: (timezone != null ? timezone.value : this.timezone),
        country: (country != null ? country.value : this.country),
        note: (note != null ? note.value : this.note),
        photoKey: (photoKey != null ? photoKey.value : this.photoKey),
        phoneNumber:
            (phoneNumber != null ? phoneNumber.value : this.phoneNumber),
        createdAt: (createdAt != null ? createdAt.value : this.createdAt),
        updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
        dateOfBirth:
            (dateOfBirth != null ? dateOfBirth.value : this.dateOfBirth),
        lastLogin: (lastLogin != null ? lastLogin.value : this.lastLogin),
        status: (status != null ? status.value : this.status));
  }
}

@JsonSerializable(explicitToJson: true)
class PaginationMetaResponse {
  const PaginationMetaResponse({
    required this.page,
    required this.limit,
    required this.itemCount,
    required this.pageCount,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });

  factory PaginationMetaResponse.fromJson(Map<String, dynamic> json) =>
      _$PaginationMetaResponseFromJson(json);

  static const toJsonFactory = _$PaginationMetaResponseToJson;
  Map<String, dynamic> toJson() => _$PaginationMetaResponseToJson(this);

  @JsonKey(name: 'page')
  final double page;
  @JsonKey(name: 'limit')
  final double limit;
  @JsonKey(name: 'itemCount')
  final double itemCount;
  @JsonKey(name: 'pageCount')
  final double pageCount;
  @JsonKey(name: 'hasPreviousPage')
  final bool hasPreviousPage;
  @JsonKey(name: 'hasNextPage')
  final bool hasNextPage;
  static const fromJsonFactory = _$PaginationMetaResponseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PaginationMetaResponse &&
            (identical(other.page, page) ||
                const DeepCollectionEquality().equals(other.page, page)) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.itemCount, itemCount) ||
                const DeepCollectionEquality()
                    .equals(other.itemCount, itemCount)) &&
            (identical(other.pageCount, pageCount) ||
                const DeepCollectionEquality()
                    .equals(other.pageCount, pageCount)) &&
            (identical(other.hasPreviousPage, hasPreviousPage) ||
                const DeepCollectionEquality()
                    .equals(other.hasPreviousPage, hasPreviousPage)) &&
            (identical(other.hasNextPage, hasNextPage) ||
                const DeepCollectionEquality()
                    .equals(other.hasNextPage, hasNextPage)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(page) ^
      const DeepCollectionEquality().hash(limit) ^
      const DeepCollectionEquality().hash(itemCount) ^
      const DeepCollectionEquality().hash(pageCount) ^
      const DeepCollectionEquality().hash(hasPreviousPage) ^
      const DeepCollectionEquality().hash(hasNextPage) ^
      runtimeType.hashCode;
}

extension $PaginationMetaResponseExtension on PaginationMetaResponse {
  PaginationMetaResponse copyWith(
      {double? page,
      double? limit,
      double? itemCount,
      double? pageCount,
      bool? hasPreviousPage,
      bool? hasNextPage}) {
    return PaginationMetaResponse(
        page: page ?? this.page,
        limit: limit ?? this.limit,
        itemCount: itemCount ?? this.itemCount,
        pageCount: pageCount ?? this.pageCount,
        hasPreviousPage: hasPreviousPage ?? this.hasPreviousPage,
        hasNextPage: hasNextPage ?? this.hasNextPage);
  }

  PaginationMetaResponse copyWithWrapped(
      {Wrapped<double>? page,
      Wrapped<double>? limit,
      Wrapped<double>? itemCount,
      Wrapped<double>? pageCount,
      Wrapped<bool>? hasPreviousPage,
      Wrapped<bool>? hasNextPage}) {
    return PaginationMetaResponse(
        page: (page != null ? page.value : this.page),
        limit: (limit != null ? limit.value : this.limit),
        itemCount: (itemCount != null ? itemCount.value : this.itemCount),
        pageCount: (pageCount != null ? pageCount.value : this.pageCount),
        hasPreviousPage: (hasPreviousPage != null
            ? hasPreviousPage.value
            : this.hasPreviousPage),
        hasNextPage:
            (hasNextPage != null ? hasNextPage.value : this.hasNextPage));
  }
}

@JsonSerializable(explicitToJson: true)
class UserPaginatedResponse {
  const UserPaginatedResponse({
    required this.items,
    required this.meta,
  });

  factory UserPaginatedResponse.fromJson(Map<String, dynamic> json) =>
      _$UserPaginatedResponseFromJson(json);

  static const toJsonFactory = _$UserPaginatedResponseToJson;
  Map<String, dynamic> toJson() => _$UserPaginatedResponseToJson(this);

  @JsonKey(name: 'items', defaultValue: <UserResponse>[])
  final List<UserResponse> items;
  @JsonKey(name: 'meta')
  final PaginationMetaResponse meta;
  static const fromJsonFactory = _$UserPaginatedResponseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserPaginatedResponse &&
            (identical(other.items, items) ||
                const DeepCollectionEquality().equals(other.items, items)) &&
            (identical(other.meta, meta) ||
                const DeepCollectionEquality().equals(other.meta, meta)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(items) ^
      const DeepCollectionEquality().hash(meta) ^
      runtimeType.hashCode;
}

extension $UserPaginatedResponseExtension on UserPaginatedResponse {
  UserPaginatedResponse copyWith(
      {List<UserResponse>? items, PaginationMetaResponse? meta}) {
    return UserPaginatedResponse(
        items: items ?? this.items, meta: meta ?? this.meta);
  }

  UserPaginatedResponse copyWithWrapped(
      {Wrapped<List<UserResponse>>? items,
      Wrapped<PaginationMetaResponse>? meta}) {
    return UserPaginatedResponse(
        items: (items != null ? items.value : this.items),
        meta: (meta != null ? meta.value : this.meta));
  }
}

@JsonSerializable(explicitToJson: true)
class CreateAdminInput {
  const CreateAdminInput({
    required this.fullName,
    required this.email,
  });

  factory CreateAdminInput.fromJson(Map<String, dynamic> json) =>
      _$CreateAdminInputFromJson(json);

  static const toJsonFactory = _$CreateAdminInputToJson;
  Map<String, dynamic> toJson() => _$CreateAdminInputToJson(this);

  @JsonKey(name: 'fullName')
  final String fullName;
  @JsonKey(name: 'email')
  final String email;
  static const fromJsonFactory = _$CreateAdminInputFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CreateAdminInput &&
            (identical(other.fullName, fullName) ||
                const DeepCollectionEquality()
                    .equals(other.fullName, fullName)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(fullName) ^
      const DeepCollectionEquality().hash(email) ^
      runtimeType.hashCode;
}

extension $CreateAdminInputExtension on CreateAdminInput {
  CreateAdminInput copyWith({String? fullName, String? email}) {
    return CreateAdminInput(
        fullName: fullName ?? this.fullName, email: email ?? this.email);
  }

  CreateAdminInput copyWithWrapped(
      {Wrapped<String>? fullName, Wrapped<String>? email}) {
    return CreateAdminInput(
        fullName: (fullName != null ? fullName.value : this.fullName),
        email: (email != null ? email.value : this.email));
  }
}

@JsonSerializable(explicitToJson: true)
class UserGroupResponse {
  const UserGroupResponse({
    required this.key,
    required this.name,
  });

  factory UserGroupResponse.fromJson(Map<String, dynamic> json) =>
      _$UserGroupResponseFromJson(json);

  static const toJsonFactory = _$UserGroupResponseToJson;
  Map<String, dynamic> toJson() => _$UserGroupResponseToJson(this);

  @JsonKey(
    name: 'key',
    toJson: userGroupResponseKeyToJson,
    fromJson: userGroupResponseKeyFromJson,
  )
  final enums.UserGroupResponseKey key;
  @JsonKey(name: 'name')
  final String name;
  static const fromJsonFactory = _$UserGroupResponseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserGroupResponse &&
            (identical(other.key, key) ||
                const DeepCollectionEquality().equals(other.key, key)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(key) ^
      const DeepCollectionEquality().hash(name) ^
      runtimeType.hashCode;
}

extension $UserGroupResponseExtension on UserGroupResponse {
  UserGroupResponse copyWith({enums.UserGroupResponseKey? key, String? name}) {
    return UserGroupResponse(key: key ?? this.key, name: name ?? this.name);
  }

  UserGroupResponse copyWithWrapped(
      {Wrapped<enums.UserGroupResponseKey>? key, Wrapped<String>? name}) {
    return UserGroupResponse(
        key: (key != null ? key.value : this.key),
        name: (name != null ? name.value : this.name));
  }
}

@JsonSerializable(explicitToJson: true)
class GamePreferenceValueResponse {
  const GamePreferenceValueResponse({
    required this.key,
    this.selectedValue,
    this.numericValue,
    this.numericDisplay,
  });

  factory GamePreferenceValueResponse.fromJson(Map<String, dynamic> json) =>
      _$GamePreferenceValueResponseFromJson(json);

  static const toJsonFactory = _$GamePreferenceValueResponseToJson;
  Map<String, dynamic> toJson() => _$GamePreferenceValueResponseToJson(this);

  @JsonKey(name: 'key')
  final String key;
  @JsonKey(name: 'selectedValue')
  final String? selectedValue;
  @JsonKey(name: 'numericValue')
  final double? numericValue;
  @JsonKey(name: 'numericDisplay')
  final String? numericDisplay;
  static const fromJsonFactory = _$GamePreferenceValueResponseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GamePreferenceValueResponse &&
            (identical(other.key, key) ||
                const DeepCollectionEquality().equals(other.key, key)) &&
            (identical(other.selectedValue, selectedValue) ||
                const DeepCollectionEquality()
                    .equals(other.selectedValue, selectedValue)) &&
            (identical(other.numericValue, numericValue) ||
                const DeepCollectionEquality()
                    .equals(other.numericValue, numericValue)) &&
            (identical(other.numericDisplay, numericDisplay) ||
                const DeepCollectionEquality()
                    .equals(other.numericDisplay, numericDisplay)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(key) ^
      const DeepCollectionEquality().hash(selectedValue) ^
      const DeepCollectionEquality().hash(numericValue) ^
      const DeepCollectionEquality().hash(numericDisplay) ^
      runtimeType.hashCode;
}

extension $GamePreferenceValueResponseExtension on GamePreferenceValueResponse {
  GamePreferenceValueResponse copyWith(
      {String? key,
      String? selectedValue,
      double? numericValue,
      String? numericDisplay}) {
    return GamePreferenceValueResponse(
        key: key ?? this.key,
        selectedValue: selectedValue ?? this.selectedValue,
        numericValue: numericValue ?? this.numericValue,
        numericDisplay: numericDisplay ?? this.numericDisplay);
  }

  GamePreferenceValueResponse copyWithWrapped(
      {Wrapped<String>? key,
      Wrapped<String?>? selectedValue,
      Wrapped<double?>? numericValue,
      Wrapped<String?>? numericDisplay}) {
    return GamePreferenceValueResponse(
        key: (key != null ? key.value : this.key),
        selectedValue:
            (selectedValue != null ? selectedValue.value : this.selectedValue),
        numericValue:
            (numericValue != null ? numericValue.value : this.numericValue),
        numericDisplay: (numericDisplay != null
            ? numericDisplay.value
            : this.numericDisplay));
  }
}

@JsonSerializable(explicitToJson: true)
class GamePreferenceResponse {
  const GamePreferenceResponse({
    required this.key,
    required this.values,
    required this.title,
  });

  factory GamePreferenceResponse.fromJson(Map<String, dynamic> json) =>
      _$GamePreferenceResponseFromJson(json);

  static const toJsonFactory = _$GamePreferenceResponseToJson;
  Map<String, dynamic> toJson() => _$GamePreferenceResponseToJson(this);

  @JsonKey(name: 'key')
  final String key;
  @JsonKey(name: 'values', defaultValue: <GamePreferenceValueResponse>[])
  final List<GamePreferenceValueResponse> values;
  @JsonKey(name: 'title')
  final String title;
  static const fromJsonFactory = _$GamePreferenceResponseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is GamePreferenceResponse &&
            (identical(other.key, key) ||
                const DeepCollectionEquality().equals(other.key, key)) &&
            (identical(other.values, values) ||
                const DeepCollectionEquality().equals(other.values, values)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(key) ^
      const DeepCollectionEquality().hash(values) ^
      const DeepCollectionEquality().hash(title) ^
      runtimeType.hashCode;
}

extension $GamePreferenceResponseExtension on GamePreferenceResponse {
  GamePreferenceResponse copyWith(
      {String? key, List<GamePreferenceValueResponse>? values, String? title}) {
    return GamePreferenceResponse(
        key: key ?? this.key,
        values: values ?? this.values,
        title: title ?? this.title);
  }

  GamePreferenceResponse copyWithWrapped(
      {Wrapped<String>? key,
      Wrapped<List<GamePreferenceValueResponse>>? values,
      Wrapped<String>? title}) {
    return GamePreferenceResponse(
        key: (key != null ? key.value : this.key),
        values: (values != null ? values.value : this.values),
        title: (title != null ? title.value : this.title));
  }
}

@JsonSerializable(explicitToJson: true)
class UserGameDataResponse {
  const UserGameDataResponse({
    required this.id,
    required this.user,
    required this.game,
    required this.preferences,
  });

  factory UserGameDataResponse.fromJson(Map<String, dynamic> json) =>
      _$UserGameDataResponseFromJson(json);

  static const toJsonFactory = _$UserGameDataResponseToJson;
  Map<String, dynamic> toJson() => _$UserGameDataResponseToJson(this);

  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'user')
  final dynamic user;
  @JsonKey(
    name: 'game',
    toJson: userGameDataResponseGameToJson,
    fromJson: userGameDataResponseGameFromJson,
  )
  final enums.UserGameDataResponseGame game;
  @JsonKey(name: 'preferences', defaultValue: <GamePreferenceResponse>[])
  final List<GamePreferenceResponse> preferences;
  static const fromJsonFactory = _$UserGameDataResponseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserGameDataResponse &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.game, game) ||
                const DeepCollectionEquality().equals(other.game, game)) &&
            (identical(other.preferences, preferences) ||
                const DeepCollectionEquality()
                    .equals(other.preferences, preferences)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(user) ^
      const DeepCollectionEquality().hash(game) ^
      const DeepCollectionEquality().hash(preferences) ^
      runtimeType.hashCode;
}

extension $UserGameDataResponseExtension on UserGameDataResponse {
  UserGameDataResponse copyWith(
      {String? id,
      dynamic user,
      enums.UserGameDataResponseGame? game,
      List<GamePreferenceResponse>? preferences}) {
    return UserGameDataResponse(
        id: id ?? this.id,
        user: user ?? this.user,
        game: game ?? this.game,
        preferences: preferences ?? this.preferences);
  }

  UserGameDataResponse copyWithWrapped(
      {Wrapped<String>? id,
      Wrapped<dynamic>? user,
      Wrapped<enums.UserGameDataResponseGame>? game,
      Wrapped<List<GamePreferenceResponse>>? preferences}) {
    return UserGameDataResponse(
        id: (id != null ? id.value : this.id),
        user: (user != null ? user.value : this.user),
        game: (game != null ? game.value : this.game),
        preferences:
            (preferences != null ? preferences.value : this.preferences));
  }
}

@JsonSerializable(explicitToJson: true)
class UserNoteInput {
  const UserNoteInput({
    required this.note,
  });

  factory UserNoteInput.fromJson(Map<String, dynamic> json) =>
      _$UserNoteInputFromJson(json);

  static const toJsonFactory = _$UserNoteInputToJson;
  Map<String, dynamic> toJson() => _$UserNoteInputToJson(this);

  @JsonKey(name: 'note')
  final String note;
  static const fromJsonFactory = _$UserNoteInputFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserNoteInput &&
            (identical(other.note, note) ||
                const DeepCollectionEquality().equals(other.note, note)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(note) ^ runtimeType.hashCode;
}

extension $UserNoteInputExtension on UserNoteInput {
  UserNoteInput copyWith({String? note}) {
    return UserNoteInput(note: note ?? this.note);
  }

  UserNoteInput copyWithWrapped({Wrapped<String>? note}) {
    return UserNoteInput(note: (note != null ? note.value : this.note));
  }
}

@JsonSerializable(explicitToJson: true)
class UserReportResponse {
  const UserReportResponse({
    required this.reporter,
    required this.reportReason,
    required this.createdAt,
  });

  factory UserReportResponse.fromJson(Map<String, dynamic> json) =>
      _$UserReportResponseFromJson(json);

  static const toJsonFactory = _$UserReportResponseToJson;
  Map<String, dynamic> toJson() => _$UserReportResponseToJson(this);

  @JsonKey(name: 'reporter')
  final String reporter;
  @JsonKey(
    name: 'reportReason',
    toJson: userReportResponseReportReasonToJson,
    fromJson: userReportResponseReportReasonFromJson,
  )
  final enums.UserReportResponseReportReason reportReason;
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;
  static const fromJsonFactory = _$UserReportResponseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserReportResponse &&
            (identical(other.reporter, reporter) ||
                const DeepCollectionEquality()
                    .equals(other.reporter, reporter)) &&
            (identical(other.reportReason, reportReason) ||
                const DeepCollectionEquality()
                    .equals(other.reportReason, reportReason)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(reporter) ^
      const DeepCollectionEquality().hash(reportReason) ^
      const DeepCollectionEquality().hash(createdAt) ^
      runtimeType.hashCode;
}

extension $UserReportResponseExtension on UserReportResponse {
  UserReportResponse copyWith(
      {String? reporter,
      enums.UserReportResponseReportReason? reportReason,
      DateTime? createdAt}) {
    return UserReportResponse(
        reporter: reporter ?? this.reporter,
        reportReason: reportReason ?? this.reportReason,
        createdAt: createdAt ?? this.createdAt);
  }

  UserReportResponse copyWithWrapped(
      {Wrapped<String>? reporter,
      Wrapped<enums.UserReportResponseReportReason>? reportReason,
      Wrapped<DateTime>? createdAt}) {
    return UserReportResponse(
        reporter: (reporter != null ? reporter.value : this.reporter),
        reportReason:
            (reportReason != null ? reportReason.value : this.reportReason),
        createdAt: (createdAt != null ? createdAt.value : this.createdAt));
  }
}

@JsonSerializable(explicitToJson: true)
class UserWarningTypeResponse {
  const UserWarningTypeResponse({
    required this.key,
    required this.name,
  });

  factory UserWarningTypeResponse.fromJson(Map<String, dynamic> json) =>
      _$UserWarningTypeResponseFromJson(json);

  static const toJsonFactory = _$UserWarningTypeResponseToJson;
  Map<String, dynamic> toJson() => _$UserWarningTypeResponseToJson(this);

  @JsonKey(
    name: 'key',
    toJson: userWarningTypeResponseKeyToJson,
    fromJson: userWarningTypeResponseKeyFromJson,
  )
  final enums.UserWarningTypeResponseKey key;
  @JsonKey(name: 'name')
  final String name;
  static const fromJsonFactory = _$UserWarningTypeResponseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserWarningTypeResponse &&
            (identical(other.key, key) ||
                const DeepCollectionEquality().equals(other.key, key)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(key) ^
      const DeepCollectionEquality().hash(name) ^
      runtimeType.hashCode;
}

extension $UserWarningTypeResponseExtension on UserWarningTypeResponse {
  UserWarningTypeResponse copyWith(
      {enums.UserWarningTypeResponseKey? key, String? name}) {
    return UserWarningTypeResponse(
        key: key ?? this.key, name: name ?? this.name);
  }

  UserWarningTypeResponse copyWithWrapped(
      {Wrapped<enums.UserWarningTypeResponseKey>? key, Wrapped<String>? name}) {
    return UserWarningTypeResponse(
        key: (key != null ? key.value : this.key),
        name: (name != null ? name.value : this.name));
  }
}

@JsonSerializable(explicitToJson: true)
class UserReportTypeResponse {
  const UserReportTypeResponse({
    required this.key,
    required this.name,
  });

  factory UserReportTypeResponse.fromJson(Map<String, dynamic> json) =>
      _$UserReportTypeResponseFromJson(json);

  static const toJsonFactory = _$UserReportTypeResponseToJson;
  Map<String, dynamic> toJson() => _$UserReportTypeResponseToJson(this);

  @JsonKey(
    name: 'key',
    toJson: userReportTypeResponseKeyToJson,
    fromJson: userReportTypeResponseKeyFromJson,
  )
  final enums.UserReportTypeResponseKey key;
  @JsonKey(name: 'name')
  final String name;
  static const fromJsonFactory = _$UserReportTypeResponseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserReportTypeResponse &&
            (identical(other.key, key) ||
                const DeepCollectionEquality().equals(other.key, key)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(key) ^
      const DeepCollectionEquality().hash(name) ^
      runtimeType.hashCode;
}

extension $UserReportTypeResponseExtension on UserReportTypeResponse {
  UserReportTypeResponse copyWith(
      {enums.UserReportTypeResponseKey? key, String? name}) {
    return UserReportTypeResponse(
        key: key ?? this.key, name: name ?? this.name);
  }

  UserReportTypeResponse copyWithWrapped(
      {Wrapped<enums.UserReportTypeResponseKey>? key, Wrapped<String>? name}) {
    return UserReportTypeResponse(
        key: (key != null ? key.value : this.key),
        name: (name != null ? name.value : this.name));
  }
}

@JsonSerializable(explicitToJson: true)
class UserWarningInput {
  const UserWarningInput({
    required this.userIds,
    required this.note,
    required this.warning,
  });

  factory UserWarningInput.fromJson(Map<String, dynamic> json) =>
      _$UserWarningInputFromJson(json);

  static const toJsonFactory = _$UserWarningInputToJson;
  Map<String, dynamic> toJson() => _$UserWarningInputToJson(this);

  @JsonKey(name: 'userIds', defaultValue: <String>[])
  final List<String> userIds;
  @JsonKey(name: 'note')
  final String note;
  @JsonKey(
    name: 'warning',
    toJson: userWarningInputWarningToJson,
    fromJson: userWarningInputWarningFromJson,
  )
  final enums.UserWarningInputWarning warning;
  static const fromJsonFactory = _$UserWarningInputFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserWarningInput &&
            (identical(other.userIds, userIds) ||
                const DeepCollectionEquality()
                    .equals(other.userIds, userIds)) &&
            (identical(other.note, note) ||
                const DeepCollectionEquality().equals(other.note, note)) &&
            (identical(other.warning, warning) ||
                const DeepCollectionEquality().equals(other.warning, warning)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(userIds) ^
      const DeepCollectionEquality().hash(note) ^
      const DeepCollectionEquality().hash(warning) ^
      runtimeType.hashCode;
}

extension $UserWarningInputExtension on UserWarningInput {
  UserWarningInput copyWith(
      {List<String>? userIds,
      String? note,
      enums.UserWarningInputWarning? warning}) {
    return UserWarningInput(
        userIds: userIds ?? this.userIds,
        note: note ?? this.note,
        warning: warning ?? this.warning);
  }

  UserWarningInput copyWithWrapped(
      {Wrapped<List<String>>? userIds,
      Wrapped<String>? note,
      Wrapped<enums.UserWarningInputWarning>? warning}) {
    return UserWarningInput(
        userIds: (userIds != null ? userIds.value : this.userIds),
        note: (note != null ? note.value : this.note),
        warning: (warning != null ? warning.value : this.warning));
  }
}

@JsonSerializable(explicitToJson: true)
class UserBanInput {
  const UserBanInput({
    required this.userIds,
    required this.note,
  });

  factory UserBanInput.fromJson(Map<String, dynamic> json) =>
      _$UserBanInputFromJson(json);

  static const toJsonFactory = _$UserBanInputToJson;
  Map<String, dynamic> toJson() => _$UserBanInputToJson(this);

  @JsonKey(name: 'userIds', defaultValue: <String>[])
  final List<String> userIds;
  @JsonKey(name: 'note')
  final String note;
  static const fromJsonFactory = _$UserBanInputFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserBanInput &&
            (identical(other.userIds, userIds) ||
                const DeepCollectionEquality()
                    .equals(other.userIds, userIds)) &&
            (identical(other.note, note) ||
                const DeepCollectionEquality().equals(other.note, note)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(userIds) ^
      const DeepCollectionEquality().hash(note) ^
      runtimeType.hashCode;
}

extension $UserBanInputExtension on UserBanInput {
  UserBanInput copyWith({List<String>? userIds, String? note}) {
    return UserBanInput(
        userIds: userIds ?? this.userIds, note: note ?? this.note);
  }

  UserBanInput copyWithWrapped(
      {Wrapped<List<String>>? userIds, Wrapped<String>? note}) {
    return UserBanInput(
        userIds: (userIds != null ? userIds.value : this.userIds),
        note: (note != null ? note.value : this.note));
  }
}

@JsonSerializable(explicitToJson: true)
class UserSuspendInput {
  const UserSuspendInput({
    required this.userIds,
    required this.until,
    required this.note,
  });

  factory UserSuspendInput.fromJson(Map<String, dynamic> json) =>
      _$UserSuspendInputFromJson(json);

  static const toJsonFactory = _$UserSuspendInputToJson;
  Map<String, dynamic> toJson() => _$UserSuspendInputToJson(this);

  @JsonKey(name: 'userIds', defaultValue: <String>[])
  final List<String> userIds;
  @JsonKey(name: 'until')
  final DateTime until;
  @JsonKey(name: 'note')
  final String note;
  static const fromJsonFactory = _$UserSuspendInputFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserSuspendInput &&
            (identical(other.userIds, userIds) ||
                const DeepCollectionEquality()
                    .equals(other.userIds, userIds)) &&
            (identical(other.until, until) ||
                const DeepCollectionEquality().equals(other.until, until)) &&
            (identical(other.note, note) ||
                const DeepCollectionEquality().equals(other.note, note)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(userIds) ^
      const DeepCollectionEquality().hash(until) ^
      const DeepCollectionEquality().hash(note) ^
      runtimeType.hashCode;
}

extension $UserSuspendInputExtension on UserSuspendInput {
  UserSuspendInput copyWith(
      {List<String>? userIds, DateTime? until, String? note}) {
    return UserSuspendInput(
        userIds: userIds ?? this.userIds,
        until: until ?? this.until,
        note: note ?? this.note);
  }

  UserSuspendInput copyWithWrapped(
      {Wrapped<List<String>>? userIds,
      Wrapped<DateTime>? until,
      Wrapped<String>? note}) {
    return UserSuspendInput(
        userIds: (userIds != null ? userIds.value : this.userIds),
        until: (until != null ? until.value : this.until),
        note: (note != null ? note.value : this.note));
  }
}

@JsonSerializable(explicitToJson: true)
class UserResetInput {
  const UserResetInput({
    required this.userIds,
  });

  factory UserResetInput.fromJson(Map<String, dynamic> json) =>
      _$UserResetInputFromJson(json);

  static const toJsonFactory = _$UserResetInputToJson;
  Map<String, dynamic> toJson() => _$UserResetInputToJson(this);

  @JsonKey(name: 'userIds', defaultValue: <String>[])
  final List<String> userIds;
  static const fromJsonFactory = _$UserResetInputFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserResetInput &&
            (identical(other.userIds, userIds) ||
                const DeepCollectionEquality().equals(other.userIds, userIds)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(userIds) ^ runtimeType.hashCode;
}

extension $UserResetInputExtension on UserResetInput {
  UserResetInput copyWith({List<String>? userIds}) {
    return UserResetInput(userIds: userIds ?? this.userIds);
  }

  UserResetInput copyWithWrapped({Wrapped<List<String>>? userIds}) {
    return UserResetInput(
        userIds: (userIds != null ? userIds.value : this.userIds));
  }
}

@JsonSerializable(explicitToJson: true)
class AuthResponse {
  const AuthResponse({
    this.accessToken,
    this.refreshToken,
    required this.success,
    this.username,
    this.name,
    this.nextStep,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  static const toJsonFactory = _$AuthResponseToJson;
  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);

  @JsonKey(name: 'accessToken')
  final String? accessToken;
  @JsonKey(name: 'refreshToken')
  final String? refreshToken;
  @JsonKey(name: 'success')
  final bool success;
  @JsonKey(name: 'username')
  final String? username;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(
    name: 'nextStep',
    toJson: authResponseNextStepNullableToJson,
    fromJson: authResponseNextStepNullableFromJson,
  )
  final enums.AuthResponseNextStep? nextStep;
  static const fromJsonFactory = _$AuthResponseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AuthResponse &&
            (identical(other.accessToken, accessToken) ||
                const DeepCollectionEquality()
                    .equals(other.accessToken, accessToken)) &&
            (identical(other.refreshToken, refreshToken) ||
                const DeepCollectionEquality()
                    .equals(other.refreshToken, refreshToken)) &&
            (identical(other.success, success) ||
                const DeepCollectionEquality()
                    .equals(other.success, success)) &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.nextStep, nextStep) ||
                const DeepCollectionEquality()
                    .equals(other.nextStep, nextStep)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(accessToken) ^
      const DeepCollectionEquality().hash(refreshToken) ^
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(nextStep) ^
      runtimeType.hashCode;
}

extension $AuthResponseExtension on AuthResponse {
  AuthResponse copyWith(
      {String? accessToken,
      String? refreshToken,
      bool? success,
      String? username,
      String? name,
      enums.AuthResponseNextStep? nextStep}) {
    return AuthResponse(
        accessToken: accessToken ?? this.accessToken,
        refreshToken: refreshToken ?? this.refreshToken,
        success: success ?? this.success,
        username: username ?? this.username,
        name: name ?? this.name,
        nextStep: nextStep ?? this.nextStep);
  }

  AuthResponse copyWithWrapped(
      {Wrapped<String?>? accessToken,
      Wrapped<String?>? refreshToken,
      Wrapped<bool>? success,
      Wrapped<String?>? username,
      Wrapped<String?>? name,
      Wrapped<enums.AuthResponseNextStep?>? nextStep}) {
    return AuthResponse(
        accessToken:
            (accessToken != null ? accessToken.value : this.accessToken),
        refreshToken:
            (refreshToken != null ? refreshToken.value : this.refreshToken),
        success: (success != null ? success.value : this.success),
        username: (username != null ? username.value : this.username),
        name: (name != null ? name.value : this.name),
        nextStep: (nextStep != null ? nextStep.value : this.nextStep));
  }
}

@JsonSerializable(explicitToJson: true)
class AuthLoginInput {
  const AuthLoginInput({
    required this.email,
    required this.password,
  });

  factory AuthLoginInput.fromJson(Map<String, dynamic> json) =>
      _$AuthLoginInputFromJson(json);

  static const toJsonFactory = _$AuthLoginInputToJson;
  Map<String, dynamic> toJson() => _$AuthLoginInputToJson(this);

  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'password')
  final String password;
  static const fromJsonFactory = _$AuthLoginInputFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AuthLoginInput &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality()
                    .equals(other.password, password)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(password) ^
      runtimeType.hashCode;
}

extension $AuthLoginInputExtension on AuthLoginInput {
  AuthLoginInput copyWith({String? email, String? password}) {
    return AuthLoginInput(
        email: email ?? this.email, password: password ?? this.password);
  }

  AuthLoginInput copyWithWrapped(
      {Wrapped<String>? email, Wrapped<String>? password}) {
    return AuthLoginInput(
        email: (email != null ? email.value : this.email),
        password: (password != null ? password.value : this.password));
  }
}

@JsonSerializable(explicitToJson: true)
class ForgotPasswordInput {
  const ForgotPasswordInput({
    required this.email,
  });

  factory ForgotPasswordInput.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordInputFromJson(json);

  static const toJsonFactory = _$ForgotPasswordInputToJson;
  Map<String, dynamic> toJson() => _$ForgotPasswordInputToJson(this);

  @JsonKey(name: 'email')
  final String email;
  static const fromJsonFactory = _$ForgotPasswordInputFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ForgotPasswordInput &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(email) ^ runtimeType.hashCode;
}

extension $ForgotPasswordInputExtension on ForgotPasswordInput {
  ForgotPasswordInput copyWith({String? email}) {
    return ForgotPasswordInput(email: email ?? this.email);
  }

  ForgotPasswordInput copyWithWrapped({Wrapped<String>? email}) {
    return ForgotPasswordInput(
        email: (email != null ? email.value : this.email));
  }
}

@JsonSerializable(explicitToJson: true)
class VerifyCodeInput {
  const VerifyCodeInput({
    required this.code,
  });

  factory VerifyCodeInput.fromJson(Map<String, dynamic> json) =>
      _$VerifyCodeInputFromJson(json);

  static const toJsonFactory = _$VerifyCodeInputToJson;
  Map<String, dynamic> toJson() => _$VerifyCodeInputToJson(this);

  @JsonKey(name: 'code')
  final double code;
  static const fromJsonFactory = _$VerifyCodeInputFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is VerifyCodeInput &&
            (identical(other.code, code) ||
                const DeepCollectionEquality().equals(other.code, code)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(code) ^ runtimeType.hashCode;
}

extension $VerifyCodeInputExtension on VerifyCodeInput {
  VerifyCodeInput copyWith({double? code}) {
    return VerifyCodeInput(code: code ?? this.code);
  }

  VerifyCodeInput copyWithWrapped({Wrapped<double>? code}) {
    return VerifyCodeInput(code: (code != null ? code.value : this.code));
  }
}

@JsonSerializable(explicitToJson: true)
class ResetPasswordInput {
  const ResetPasswordInput({
    required this.email,
    required this.password,
  });

  factory ResetPasswordInput.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordInputFromJson(json);

  static const toJsonFactory = _$ResetPasswordInputToJson;
  Map<String, dynamic> toJson() => _$ResetPasswordInputToJson(this);

  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'password')
  final String password;
  static const fromJsonFactory = _$ResetPasswordInputFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ResetPasswordInput &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality()
                    .equals(other.password, password)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(password) ^
      runtimeType.hashCode;
}

extension $ResetPasswordInputExtension on ResetPasswordInput {
  ResetPasswordInput copyWith({String? email, String? password}) {
    return ResetPasswordInput(
        email: email ?? this.email, password: password ?? this.password);
  }

  ResetPasswordInput copyWithWrapped(
      {Wrapped<String>? email, Wrapped<String>? password}) {
    return ResetPasswordInput(
        email: (email != null ? email.value : this.email),
        password: (password != null ? password.value : this.password));
  }
}

@JsonSerializable(explicitToJson: true)
class StatisticsTotalCountResponse {
  const StatisticsTotalCountResponse({
    required this.total,
    required this.currentWeek,
  });

  factory StatisticsTotalCountResponse.fromJson(Map<String, dynamic> json) =>
      _$StatisticsTotalCountResponseFromJson(json);

  static const toJsonFactory = _$StatisticsTotalCountResponseToJson;
  Map<String, dynamic> toJson() => _$StatisticsTotalCountResponseToJson(this);

  @JsonKey(name: 'total')
  final double total;
  @JsonKey(name: 'currentWeek')
  final double currentWeek;
  static const fromJsonFactory = _$StatisticsTotalCountResponseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is StatisticsTotalCountResponse &&
            (identical(other.total, total) ||
                const DeepCollectionEquality().equals(other.total, total)) &&
            (identical(other.currentWeek, currentWeek) ||
                const DeepCollectionEquality()
                    .equals(other.currentWeek, currentWeek)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(total) ^
      const DeepCollectionEquality().hash(currentWeek) ^
      runtimeType.hashCode;
}

extension $StatisticsTotalCountResponseExtension
    on StatisticsTotalCountResponse {
  StatisticsTotalCountResponse copyWith({double? total, double? currentWeek}) {
    return StatisticsTotalCountResponse(
        total: total ?? this.total,
        currentWeek: currentWeek ?? this.currentWeek);
  }

  StatisticsTotalCountResponse copyWithWrapped(
      {Wrapped<double>? total, Wrapped<double>? currentWeek}) {
    return StatisticsTotalCountResponse(
        total: (total != null ? total.value : this.total),
        currentWeek:
            (currentWeek != null ? currentWeek.value : this.currentWeek));
  }
}

@JsonSerializable(explicitToJson: true)
class StatisticsOnboardingCompletionResponse {
  const StatisticsOnboardingCompletionResponse({
    required this.onboardingPct,
    required this.currentWeek,
  });

  factory StatisticsOnboardingCompletionResponse.fromJson(
          Map<String, dynamic> json) =>
      _$StatisticsOnboardingCompletionResponseFromJson(json);

  static const toJsonFactory = _$StatisticsOnboardingCompletionResponseToJson;
  Map<String, dynamic> toJson() =>
      _$StatisticsOnboardingCompletionResponseToJson(this);

  @JsonKey(name: 'onboardingPct')
  final double onboardingPct;
  @JsonKey(name: 'currentWeek')
  final double currentWeek;
  static const fromJsonFactory =
      _$StatisticsOnboardingCompletionResponseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is StatisticsOnboardingCompletionResponse &&
            (identical(other.onboardingPct, onboardingPct) ||
                const DeepCollectionEquality()
                    .equals(other.onboardingPct, onboardingPct)) &&
            (identical(other.currentWeek, currentWeek) ||
                const DeepCollectionEquality()
                    .equals(other.currentWeek, currentWeek)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(onboardingPct) ^
      const DeepCollectionEquality().hash(currentWeek) ^
      runtimeType.hashCode;
}

extension $StatisticsOnboardingCompletionResponseExtension
    on StatisticsOnboardingCompletionResponse {
  StatisticsOnboardingCompletionResponse copyWith(
      {double? onboardingPct, double? currentWeek}) {
    return StatisticsOnboardingCompletionResponse(
        onboardingPct: onboardingPct ?? this.onboardingPct,
        currentWeek: currentWeek ?? this.currentWeek);
  }

  StatisticsOnboardingCompletionResponse copyWithWrapped(
      {Wrapped<double>? onboardingPct, Wrapped<double>? currentWeek}) {
    return StatisticsOnboardingCompletionResponse(
        onboardingPct:
            (onboardingPct != null ? onboardingPct.value : this.onboardingPct),
        currentWeek:
            (currentWeek != null ? currentWeek.value : this.currentWeek));
  }
}

@JsonSerializable(explicitToJson: true)
class NewUsersRegisteredObjectResponse {
  const NewUsersRegisteredObjectResponse({
    required this.date,
    required this.quantity,
  });

  factory NewUsersRegisteredObjectResponse.fromJson(
          Map<String, dynamic> json) =>
      _$NewUsersRegisteredObjectResponseFromJson(json);

  static const toJsonFactory = _$NewUsersRegisteredObjectResponseToJson;
  Map<String, dynamic> toJson() =>
      _$NewUsersRegisteredObjectResponseToJson(this);

  @JsonKey(name: 'date')
  final String date;
  @JsonKey(name: 'quantity')
  final double quantity;
  static const fromJsonFactory = _$NewUsersRegisteredObjectResponseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is NewUsersRegisteredObjectResponse &&
            (identical(other.date, date) ||
                const DeepCollectionEquality().equals(other.date, date)) &&
            (identical(other.quantity, quantity) ||
                const DeepCollectionEquality()
                    .equals(other.quantity, quantity)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(date) ^
      const DeepCollectionEquality().hash(quantity) ^
      runtimeType.hashCode;
}

extension $NewUsersRegisteredObjectResponseExtension
    on NewUsersRegisteredObjectResponse {
  NewUsersRegisteredObjectResponse copyWith({String? date, double? quantity}) {
    return NewUsersRegisteredObjectResponse(
        date: date ?? this.date, quantity: quantity ?? this.quantity);
  }

  NewUsersRegisteredObjectResponse copyWithWrapped(
      {Wrapped<String>? date, Wrapped<double>? quantity}) {
    return NewUsersRegisteredObjectResponse(
        date: (date != null ? date.value : this.date),
        quantity: (quantity != null ? quantity.value : this.quantity));
  }
}

@JsonSerializable(explicitToJson: true)
class StatisticsNewUsersRegisteredResponse {
  const StatisticsNewUsersRegisteredResponse({
    required this.chart,
  });

  factory StatisticsNewUsersRegisteredResponse.fromJson(
          Map<String, dynamic> json) =>
      _$StatisticsNewUsersRegisteredResponseFromJson(json);

  static const toJsonFactory = _$StatisticsNewUsersRegisteredResponseToJson;
  Map<String, dynamic> toJson() =>
      _$StatisticsNewUsersRegisteredResponseToJson(this);

  @JsonKey(name: 'chart', defaultValue: <NewUsersRegisteredObjectResponse>[])
  final List<NewUsersRegisteredObjectResponse> chart;
  static const fromJsonFactory = _$StatisticsNewUsersRegisteredResponseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is StatisticsNewUsersRegisteredResponse &&
            (identical(other.chart, chart) ||
                const DeepCollectionEquality().equals(other.chart, chart)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(chart) ^ runtimeType.hashCode;
}

extension $StatisticsNewUsersRegisteredResponseExtension
    on StatisticsNewUsersRegisteredResponse {
  StatisticsNewUsersRegisteredResponse copyWith(
      {List<NewUsersRegisteredObjectResponse>? chart}) {
    return StatisticsNewUsersRegisteredResponse(chart: chart ?? this.chart);
  }

  StatisticsNewUsersRegisteredResponse copyWithWrapped(
      {Wrapped<List<NewUsersRegisteredObjectResponse>>? chart}) {
    return StatisticsNewUsersRegisteredResponse(
        chart: (chart != null ? chart.value : this.chart));
  }
}

@JsonSerializable(explicitToJson: true)
class UserGroupCountsResponse {
  const UserGroupCountsResponse({
    this.allUsers,
    this.apexLegendsPlayers,
    this.callOfDutyPlayers,
    this.fortnitePlayers,
    this.rocketLeaguePlayers,
  });

  factory UserGroupCountsResponse.fromJson(Map<String, dynamic> json) =>
      _$UserGroupCountsResponseFromJson(json);

  static const toJsonFactory = _$UserGroupCountsResponseToJson;
  Map<String, dynamic> toJson() => _$UserGroupCountsResponseToJson(this);

  @JsonKey(name: 'allUsers')
  final double? allUsers;
  @JsonKey(name: 'apexLegendsPlayers')
  final double? apexLegendsPlayers;
  @JsonKey(name: 'callOfDutyPlayers')
  final double? callOfDutyPlayers;
  @JsonKey(name: 'fortnitePlayers')
  final double? fortnitePlayers;
  @JsonKey(name: 'rocketLeaguePlayers')
  final double? rocketLeaguePlayers;
  static const fromJsonFactory = _$UserGroupCountsResponseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UserGroupCountsResponse &&
            (identical(other.allUsers, allUsers) ||
                const DeepCollectionEquality()
                    .equals(other.allUsers, allUsers)) &&
            (identical(other.apexLegendsPlayers, apexLegendsPlayers) ||
                const DeepCollectionEquality()
                    .equals(other.apexLegendsPlayers, apexLegendsPlayers)) &&
            (identical(other.callOfDutyPlayers, callOfDutyPlayers) ||
                const DeepCollectionEquality()
                    .equals(other.callOfDutyPlayers, callOfDutyPlayers)) &&
            (identical(other.fortnitePlayers, fortnitePlayers) ||
                const DeepCollectionEquality()
                    .equals(other.fortnitePlayers, fortnitePlayers)) &&
            (identical(other.rocketLeaguePlayers, rocketLeaguePlayers) ||
                const DeepCollectionEquality()
                    .equals(other.rocketLeaguePlayers, rocketLeaguePlayers)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(allUsers) ^
      const DeepCollectionEquality().hash(apexLegendsPlayers) ^
      const DeepCollectionEquality().hash(callOfDutyPlayers) ^
      const DeepCollectionEquality().hash(fortnitePlayers) ^
      const DeepCollectionEquality().hash(rocketLeaguePlayers) ^
      runtimeType.hashCode;
}

extension $UserGroupCountsResponseExtension on UserGroupCountsResponse {
  UserGroupCountsResponse copyWith(
      {double? allUsers,
      double? apexLegendsPlayers,
      double? callOfDutyPlayers,
      double? fortnitePlayers,
      double? rocketLeaguePlayers}) {
    return UserGroupCountsResponse(
        allUsers: allUsers ?? this.allUsers,
        apexLegendsPlayers: apexLegendsPlayers ?? this.apexLegendsPlayers,
        callOfDutyPlayers: callOfDutyPlayers ?? this.callOfDutyPlayers,
        fortnitePlayers: fortnitePlayers ?? this.fortnitePlayers,
        rocketLeaguePlayers: rocketLeaguePlayers ?? this.rocketLeaguePlayers);
  }

  UserGroupCountsResponse copyWithWrapped(
      {Wrapped<double?>? allUsers,
      Wrapped<double?>? apexLegendsPlayers,
      Wrapped<double?>? callOfDutyPlayers,
      Wrapped<double?>? fortnitePlayers,
      Wrapped<double?>? rocketLeaguePlayers}) {
    return UserGroupCountsResponse(
        allUsers: (allUsers != null ? allUsers.value : this.allUsers),
        apexLegendsPlayers: (apexLegendsPlayers != null
            ? apexLegendsPlayers.value
            : this.apexLegendsPlayers),
        callOfDutyPlayers: (callOfDutyPlayers != null
            ? callOfDutyPlayers.value
            : this.callOfDutyPlayers),
        fortnitePlayers: (fortnitePlayers != null
            ? fortnitePlayers.value
            : this.fortnitePlayers),
        rocketLeaguePlayers: (rocketLeaguePlayers != null
            ? rocketLeaguePlayers.value
            : this.rocketLeaguePlayers));
  }
}

@JsonSerializable(explicitToJson: true)
class ScheduledNotificationDataResponse {
  const ScheduledNotificationDataResponse({
    required this.title,
    required this.description,
    required this.targetGroup,
    required this.notificationType,
  });

  factory ScheduledNotificationDataResponse.fromJson(
          Map<String, dynamic> json) =>
      _$ScheduledNotificationDataResponseFromJson(json);

  static const toJsonFactory = _$ScheduledNotificationDataResponseToJson;
  Map<String, dynamic> toJson() =>
      _$ScheduledNotificationDataResponseToJson(this);

  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(
    name: 'targetGroup',
    toJson: scheduledNotificationDataResponseTargetGroupToJson,
    fromJson: scheduledNotificationDataResponseTargetGroupFromJson,
  )
  final enums.ScheduledNotificationDataResponseTargetGroup targetGroup;
  @JsonKey(
    name: 'notificationType',
    toJson: scheduledNotificationDataResponseNotificationTypeToJson,
    fromJson: scheduledNotificationDataResponseNotificationTypeFromJson,
  )
  final enums.ScheduledNotificationDataResponseNotificationType
      notificationType;
  static const fromJsonFactory = _$ScheduledNotificationDataResponseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ScheduledNotificationDataResponse &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.targetGroup, targetGroup) ||
                const DeepCollectionEquality()
                    .equals(other.targetGroup, targetGroup)) &&
            (identical(other.notificationType, notificationType) ||
                const DeepCollectionEquality()
                    .equals(other.notificationType, notificationType)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(targetGroup) ^
      const DeepCollectionEquality().hash(notificationType) ^
      runtimeType.hashCode;
}

extension $ScheduledNotificationDataResponseExtension
    on ScheduledNotificationDataResponse {
  ScheduledNotificationDataResponse copyWith(
      {String? title,
      String? description,
      enums.ScheduledNotificationDataResponseTargetGroup? targetGroup,
      enums.ScheduledNotificationDataResponseNotificationType?
          notificationType}) {
    return ScheduledNotificationDataResponse(
        title: title ?? this.title,
        description: description ?? this.description,
        targetGroup: targetGroup ?? this.targetGroup,
        notificationType: notificationType ?? this.notificationType);
  }

  ScheduledNotificationDataResponse copyWithWrapped(
      {Wrapped<String>? title,
      Wrapped<String>? description,
      Wrapped<enums.ScheduledNotificationDataResponseTargetGroup>? targetGroup,
      Wrapped<enums.ScheduledNotificationDataResponseNotificationType>?
          notificationType}) {
    return ScheduledNotificationDataResponse(
        title: (title != null ? title.value : this.title),
        description:
            (description != null ? description.value : this.description),
        targetGroup:
            (targetGroup != null ? targetGroup.value : this.targetGroup),
        notificationType: (notificationType != null
            ? notificationType.value
            : this.notificationType));
  }
}

@JsonSerializable(explicitToJson: true)
class ScheduledNotificationResponse {
  const ScheduledNotificationResponse({
    required this.id,
    required this.date,
    required this.interval,
    required this.openedBy,
    required this.receivedBy,
    required this.uniqueId,
    required this.users,
    required this.createdAt,
    required this.updatedAt,
    required this.data,
  });

  factory ScheduledNotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$ScheduledNotificationResponseFromJson(json);

  static const toJsonFactory = _$ScheduledNotificationResponseToJson;
  Map<String, dynamic> toJson() => _$ScheduledNotificationResponseToJson(this);

  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'date')
  final DateTime date;
  @JsonKey(name: 'interval')
  final String interval;
  @JsonKey(name: 'openedBy')
  final double openedBy;
  @JsonKey(name: 'receivedBy')
  final double receivedBy;
  @JsonKey(name: 'uniqueId')
  final String uniqueId;
  @JsonKey(name: 'users', defaultValue: <String>[])
  final List<String> users;
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime updatedAt;
  @JsonKey(name: 'data')
  final ScheduledNotificationDataResponse data;
  static const fromJsonFactory = _$ScheduledNotificationResponseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ScheduledNotificationResponse &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.date, date) ||
                const DeepCollectionEquality().equals(other.date, date)) &&
            (identical(other.interval, interval) ||
                const DeepCollectionEquality()
                    .equals(other.interval, interval)) &&
            (identical(other.openedBy, openedBy) ||
                const DeepCollectionEquality()
                    .equals(other.openedBy, openedBy)) &&
            (identical(other.receivedBy, receivedBy) ||
                const DeepCollectionEquality()
                    .equals(other.receivedBy, receivedBy)) &&
            (identical(other.uniqueId, uniqueId) ||
                const DeepCollectionEquality()
                    .equals(other.uniqueId, uniqueId)) &&
            (identical(other.users, users) ||
                const DeepCollectionEquality().equals(other.users, users)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)) &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(date) ^
      const DeepCollectionEquality().hash(interval) ^
      const DeepCollectionEquality().hash(openedBy) ^
      const DeepCollectionEquality().hash(receivedBy) ^
      const DeepCollectionEquality().hash(uniqueId) ^
      const DeepCollectionEquality().hash(users) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(data) ^
      runtimeType.hashCode;
}

extension $ScheduledNotificationResponseExtension
    on ScheduledNotificationResponse {
  ScheduledNotificationResponse copyWith(
      {String? id,
      DateTime? date,
      String? interval,
      double? openedBy,
      double? receivedBy,
      String? uniqueId,
      List<String>? users,
      DateTime? createdAt,
      DateTime? updatedAt,
      ScheduledNotificationDataResponse? data}) {
    return ScheduledNotificationResponse(
        id: id ?? this.id,
        date: date ?? this.date,
        interval: interval ?? this.interval,
        openedBy: openedBy ?? this.openedBy,
        receivedBy: receivedBy ?? this.receivedBy,
        uniqueId: uniqueId ?? this.uniqueId,
        users: users ?? this.users,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        data: data ?? this.data);
  }

  ScheduledNotificationResponse copyWithWrapped(
      {Wrapped<String>? id,
      Wrapped<DateTime>? date,
      Wrapped<String>? interval,
      Wrapped<double>? openedBy,
      Wrapped<double>? receivedBy,
      Wrapped<String>? uniqueId,
      Wrapped<List<String>>? users,
      Wrapped<DateTime>? createdAt,
      Wrapped<DateTime>? updatedAt,
      Wrapped<ScheduledNotificationDataResponse>? data}) {
    return ScheduledNotificationResponse(
        id: (id != null ? id.value : this.id),
        date: (date != null ? date.value : this.date),
        interval: (interval != null ? interval.value : this.interval),
        openedBy: (openedBy != null ? openedBy.value : this.openedBy),
        receivedBy: (receivedBy != null ? receivedBy.value : this.receivedBy),
        uniqueId: (uniqueId != null ? uniqueId.value : this.uniqueId),
        users: (users != null ? users.value : this.users),
        createdAt: (createdAt != null ? createdAt.value : this.createdAt),
        updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
        data: (data != null ? data.value : this.data));
  }
}

@JsonSerializable(explicitToJson: true)
class ScheduledNotificationPaginatedResponse {
  const ScheduledNotificationPaginatedResponse({
    required this.items,
    required this.meta,
  });

  factory ScheduledNotificationPaginatedResponse.fromJson(
          Map<String, dynamic> json) =>
      _$ScheduledNotificationPaginatedResponseFromJson(json);

  static const toJsonFactory = _$ScheduledNotificationPaginatedResponseToJson;
  Map<String, dynamic> toJson() =>
      _$ScheduledNotificationPaginatedResponseToJson(this);

  @JsonKey(name: 'items', defaultValue: <ScheduledNotificationResponse>[])
  final List<ScheduledNotificationResponse> items;
  @JsonKey(name: 'meta')
  final PaginationMetaResponse meta;
  static const fromJsonFactory =
      _$ScheduledNotificationPaginatedResponseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ScheduledNotificationPaginatedResponse &&
            (identical(other.items, items) ||
                const DeepCollectionEquality().equals(other.items, items)) &&
            (identical(other.meta, meta) ||
                const DeepCollectionEquality().equals(other.meta, meta)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(items) ^
      const DeepCollectionEquality().hash(meta) ^
      runtimeType.hashCode;
}

extension $ScheduledNotificationPaginatedResponseExtension
    on ScheduledNotificationPaginatedResponse {
  ScheduledNotificationPaginatedResponse copyWith(
      {List<ScheduledNotificationResponse>? items,
      PaginationMetaResponse? meta}) {
    return ScheduledNotificationPaginatedResponse(
        items: items ?? this.items, meta: meta ?? this.meta);
  }

  ScheduledNotificationPaginatedResponse copyWithWrapped(
      {Wrapped<List<ScheduledNotificationResponse>>? items,
      Wrapped<PaginationMetaResponse>? meta}) {
    return ScheduledNotificationPaginatedResponse(
        items: (items != null ? items.value : this.items),
        meta: (meta != null ? meta.value : this.meta));
  }
}

@JsonSerializable(explicitToJson: true)
class NotificationTypeResponse {
  const NotificationTypeResponse({
    required this.key,
    required this.name,
  });

  factory NotificationTypeResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationTypeResponseFromJson(json);

  static const toJsonFactory = _$NotificationTypeResponseToJson;
  Map<String, dynamic> toJson() => _$NotificationTypeResponseToJson(this);

  @JsonKey(
    name: 'key',
    toJson: notificationTypeResponseKeyToJson,
    fromJson: notificationTypeResponseKeyFromJson,
  )
  final enums.NotificationTypeResponseKey key;
  @JsonKey(name: 'name')
  final String name;
  static const fromJsonFactory = _$NotificationTypeResponseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is NotificationTypeResponse &&
            (identical(other.key, key) ||
                const DeepCollectionEquality().equals(other.key, key)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(key) ^
      const DeepCollectionEquality().hash(name) ^
      runtimeType.hashCode;
}

extension $NotificationTypeResponseExtension on NotificationTypeResponse {
  NotificationTypeResponse copyWith(
      {enums.NotificationTypeResponseKey? key, String? name}) {
    return NotificationTypeResponse(
        key: key ?? this.key, name: name ?? this.name);
  }

  NotificationTypeResponse copyWithWrapped(
      {Wrapped<enums.NotificationTypeResponseKey>? key,
      Wrapped<String>? name}) {
    return NotificationTypeResponse(
        key: (key != null ? key.value : this.key),
        name: (name != null ? name.value : this.name));
  }
}

@JsonSerializable(explicitToJson: true)
class NotificationIntervalResponse {
  const NotificationIntervalResponse({
    required this.key,
    required this.name,
  });

  factory NotificationIntervalResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationIntervalResponseFromJson(json);

  static const toJsonFactory = _$NotificationIntervalResponseToJson;
  Map<String, dynamic> toJson() => _$NotificationIntervalResponseToJson(this);

  @JsonKey(
    name: 'key',
    toJson: notificationIntervalResponseKeyToJson,
    fromJson: notificationIntervalResponseKeyFromJson,
  )
  final enums.NotificationIntervalResponseKey key;
  @JsonKey(name: 'name')
  final String name;
  static const fromJsonFactory = _$NotificationIntervalResponseFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is NotificationIntervalResponse &&
            (identical(other.key, key) ||
                const DeepCollectionEquality().equals(other.key, key)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(key) ^
      const DeepCollectionEquality().hash(name) ^
      runtimeType.hashCode;
}

extension $NotificationIntervalResponseExtension
    on NotificationIntervalResponse {
  NotificationIntervalResponse copyWith(
      {enums.NotificationIntervalResponseKey? key, String? name}) {
    return NotificationIntervalResponse(
        key: key ?? this.key, name: name ?? this.name);
  }

  NotificationIntervalResponse copyWithWrapped(
      {Wrapped<enums.NotificationIntervalResponseKey>? key,
      Wrapped<String>? name}) {
    return NotificationIntervalResponse(
        key: (key != null ? key.value : this.key),
        name: (name != null ? name.value : this.name));
  }
}

@JsonSerializable(explicitToJson: true)
class CreateScheduledNotificationInput {
  const CreateScheduledNotificationInput({
    required this.title,
    required this.description,
    required this.redirectScreen,
    required this.notificationType,
    this.individualUserId,
    required this.date,
    required this.interval,
    required this.targetGroup,
  });

  factory CreateScheduledNotificationInput.fromJson(
          Map<String, dynamic> json) =>
      _$CreateScheduledNotificationInputFromJson(json);

  static const toJsonFactory = _$CreateScheduledNotificationInputToJson;
  Map<String, dynamic> toJson() =>
      _$CreateScheduledNotificationInputToJson(this);

  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'redirectScreen')
  final String redirectScreen;
  @JsonKey(
    name: 'notificationType',
    toJson: createScheduledNotificationInputNotificationTypeToJson,
    fromJson: createScheduledNotificationInputNotificationTypeFromJson,
  )
  final enums.CreateScheduledNotificationInputNotificationType notificationType;
  @JsonKey(name: 'individualUserId')
  final String? individualUserId;
  @JsonKey(name: 'date')
  final DateTime date;
  @JsonKey(
    name: 'interval',
    toJson: createScheduledNotificationInputIntervalToJson,
    fromJson: createScheduledNotificationInputIntervalFromJson,
  )
  final enums.CreateScheduledNotificationInputInterval interval;
  @JsonKey(
    name: 'targetGroup',
    toJson: createScheduledNotificationInputTargetGroupToJson,
    fromJson: createScheduledNotificationInputTargetGroupFromJson,
  )
  final enums.CreateScheduledNotificationInputTargetGroup targetGroup;
  static const fromJsonFactory = _$CreateScheduledNotificationInputFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is CreateScheduledNotificationInput &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.redirectScreen, redirectScreen) ||
                const DeepCollectionEquality()
                    .equals(other.redirectScreen, redirectScreen)) &&
            (identical(other.notificationType, notificationType) ||
                const DeepCollectionEquality()
                    .equals(other.notificationType, notificationType)) &&
            (identical(other.individualUserId, individualUserId) ||
                const DeepCollectionEquality()
                    .equals(other.individualUserId, individualUserId)) &&
            (identical(other.date, date) ||
                const DeepCollectionEquality().equals(other.date, date)) &&
            (identical(other.interval, interval) ||
                const DeepCollectionEquality()
                    .equals(other.interval, interval)) &&
            (identical(other.targetGroup, targetGroup) ||
                const DeepCollectionEquality()
                    .equals(other.targetGroup, targetGroup)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(redirectScreen) ^
      const DeepCollectionEquality().hash(notificationType) ^
      const DeepCollectionEquality().hash(individualUserId) ^
      const DeepCollectionEquality().hash(date) ^
      const DeepCollectionEquality().hash(interval) ^
      const DeepCollectionEquality().hash(targetGroup) ^
      runtimeType.hashCode;
}

extension $CreateScheduledNotificationInputExtension
    on CreateScheduledNotificationInput {
  CreateScheduledNotificationInput copyWith(
      {String? title,
      String? description,
      String? redirectScreen,
      enums.CreateScheduledNotificationInputNotificationType? notificationType,
      String? individualUserId,
      DateTime? date,
      enums.CreateScheduledNotificationInputInterval? interval,
      enums.CreateScheduledNotificationInputTargetGroup? targetGroup}) {
    return CreateScheduledNotificationInput(
        title: title ?? this.title,
        description: description ?? this.description,
        redirectScreen: redirectScreen ?? this.redirectScreen,
        notificationType: notificationType ?? this.notificationType,
        individualUserId: individualUserId ?? this.individualUserId,
        date: date ?? this.date,
        interval: interval ?? this.interval,
        targetGroup: targetGroup ?? this.targetGroup);
  }

  CreateScheduledNotificationInput copyWithWrapped(
      {Wrapped<String>? title,
      Wrapped<String>? description,
      Wrapped<String>? redirectScreen,
      Wrapped<enums.CreateScheduledNotificationInputNotificationType>?
          notificationType,
      Wrapped<String?>? individualUserId,
      Wrapped<DateTime>? date,
      Wrapped<enums.CreateScheduledNotificationInputInterval>? interval,
      Wrapped<enums.CreateScheduledNotificationInputTargetGroup>?
          targetGroup}) {
    return CreateScheduledNotificationInput(
        title: (title != null ? title.value : this.title),
        description:
            (description != null ? description.value : this.description),
        redirectScreen: (redirectScreen != null
            ? redirectScreen.value
            : this.redirectScreen),
        notificationType: (notificationType != null
            ? notificationType.value
            : this.notificationType),
        individualUserId: (individualUserId != null
            ? individualUserId.value
            : this.individualUserId),
        date: (date != null ? date.value : this.date),
        interval: (interval != null ? interval.value : this.interval),
        targetGroup:
            (targetGroup != null ? targetGroup.value : this.targetGroup));
  }
}

@JsonSerializable(explicitToJson: true)
class ScheduledNotification {
  const ScheduledNotification();

  factory ScheduledNotification.fromJson(Map<String, dynamic> json) =>
      _$ScheduledNotificationFromJson(json);

  static const toJsonFactory = _$ScheduledNotificationToJson;
  Map<String, dynamic> toJson() => _$ScheduledNotificationToJson(this);

  static const fromJsonFactory = _$ScheduledNotificationFromJson;

  @override
  int get hashCode => runtimeType.hashCode;
}

@JsonSerializable(explicitToJson: true)
class DeleteScheduledNotificationsInput {
  const DeleteScheduledNotificationsInput({
    required this.notificationIds,
  });

  factory DeleteScheduledNotificationsInput.fromJson(
          Map<String, dynamic> json) =>
      _$DeleteScheduledNotificationsInputFromJson(json);

  static const toJsonFactory = _$DeleteScheduledNotificationsInputToJson;
  Map<String, dynamic> toJson() =>
      _$DeleteScheduledNotificationsInputToJson(this);

  @JsonKey(name: 'notificationIds', defaultValue: <String>[])
  final List<String> notificationIds;
  static const fromJsonFactory = _$DeleteScheduledNotificationsInputFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DeleteScheduledNotificationsInput &&
            (identical(other.notificationIds, notificationIds) ||
                const DeepCollectionEquality()
                    .equals(other.notificationIds, notificationIds)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(notificationIds) ^
      runtimeType.hashCode;
}

extension $DeleteScheduledNotificationsInputExtension
    on DeleteScheduledNotificationsInput {
  DeleteScheduledNotificationsInput copyWith({List<String>? notificationIds}) {
    return DeleteScheduledNotificationsInput(
        notificationIds: notificationIds ?? this.notificationIds);
  }

  DeleteScheduledNotificationsInput copyWithWrapped(
      {Wrapped<List<String>>? notificationIds}) {
    return DeleteScheduledNotificationsInput(
        notificationIds: (notificationIds != null
            ? notificationIds.value
            : this.notificationIds));
  }
}

@JsonSerializable(explicitToJson: true)
class UpdateScheduledNotificationInput {
  const UpdateScheduledNotificationInput({
    this.title,
    this.description,
    this.redirectScreen,
    this.notificationType,
    this.individualUserId,
    this.date,
    this.interval,
    this.targetGroup,
  });

  factory UpdateScheduledNotificationInput.fromJson(
          Map<String, dynamic> json) =>
      _$UpdateScheduledNotificationInputFromJson(json);

  static const toJsonFactory = _$UpdateScheduledNotificationInputToJson;
  Map<String, dynamic> toJson() =>
      _$UpdateScheduledNotificationInputToJson(this);

  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'redirectScreen')
  final String? redirectScreen;
  @JsonKey(
    name: 'notificationType',
    toJson: updateScheduledNotificationInputNotificationTypeNullableToJson,
    fromJson: updateScheduledNotificationInputNotificationTypeNullableFromJson,
  )
  final enums.UpdateScheduledNotificationInputNotificationType?
      notificationType;
  @JsonKey(name: 'individualUserId')
  final String? individualUserId;
  @JsonKey(name: 'date')
  final DateTime? date;
  @JsonKey(
    name: 'interval',
    toJson: updateScheduledNotificationInputIntervalNullableToJson,
    fromJson: updateScheduledNotificationInputIntervalNullableFromJson,
  )
  final enums.UpdateScheduledNotificationInputInterval? interval;
  @JsonKey(
    name: 'targetGroup',
    toJson: updateScheduledNotificationInputTargetGroupNullableToJson,
    fromJson: updateScheduledNotificationInputTargetGroupNullableFromJson,
  )
  final enums.UpdateScheduledNotificationInputTargetGroup? targetGroup;
  static const fromJsonFactory = _$UpdateScheduledNotificationInputFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is UpdateScheduledNotificationInput &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.redirectScreen, redirectScreen) ||
                const DeepCollectionEquality()
                    .equals(other.redirectScreen, redirectScreen)) &&
            (identical(other.notificationType, notificationType) ||
                const DeepCollectionEquality()
                    .equals(other.notificationType, notificationType)) &&
            (identical(other.individualUserId, individualUserId) ||
                const DeepCollectionEquality()
                    .equals(other.individualUserId, individualUserId)) &&
            (identical(other.date, date) ||
                const DeepCollectionEquality().equals(other.date, date)) &&
            (identical(other.interval, interval) ||
                const DeepCollectionEquality()
                    .equals(other.interval, interval)) &&
            (identical(other.targetGroup, targetGroup) ||
                const DeepCollectionEquality()
                    .equals(other.targetGroup, targetGroup)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(redirectScreen) ^
      const DeepCollectionEquality().hash(notificationType) ^
      const DeepCollectionEquality().hash(individualUserId) ^
      const DeepCollectionEquality().hash(date) ^
      const DeepCollectionEquality().hash(interval) ^
      const DeepCollectionEquality().hash(targetGroup) ^
      runtimeType.hashCode;
}

extension $UpdateScheduledNotificationInputExtension
    on UpdateScheduledNotificationInput {
  UpdateScheduledNotificationInput copyWith(
      {String? title,
      String? description,
      String? redirectScreen,
      enums.UpdateScheduledNotificationInputNotificationType? notificationType,
      String? individualUserId,
      DateTime? date,
      enums.UpdateScheduledNotificationInputInterval? interval,
      enums.UpdateScheduledNotificationInputTargetGroup? targetGroup}) {
    return UpdateScheduledNotificationInput(
        title: title ?? this.title,
        description: description ?? this.description,
        redirectScreen: redirectScreen ?? this.redirectScreen,
        notificationType: notificationType ?? this.notificationType,
        individualUserId: individualUserId ?? this.individualUserId,
        date: date ?? this.date,
        interval: interval ?? this.interval,
        targetGroup: targetGroup ?? this.targetGroup);
  }

  UpdateScheduledNotificationInput copyWithWrapped(
      {Wrapped<String?>? title,
      Wrapped<String?>? description,
      Wrapped<String?>? redirectScreen,
      Wrapped<enums.UpdateScheduledNotificationInputNotificationType?>?
          notificationType,
      Wrapped<String?>? individualUserId,
      Wrapped<DateTime?>? date,
      Wrapped<enums.UpdateScheduledNotificationInputInterval?>? interval,
      Wrapped<enums.UpdateScheduledNotificationInputTargetGroup?>?
          targetGroup}) {
    return UpdateScheduledNotificationInput(
        title: (title != null ? title.value : this.title),
        description:
            (description != null ? description.value : this.description),
        redirectScreen: (redirectScreen != null
            ? redirectScreen.value
            : this.redirectScreen),
        notificationType: (notificationType != null
            ? notificationType.value
            : this.notificationType),
        individualUserId: (individualUserId != null
            ? individualUserId.value
            : this.individualUserId),
        date: (date != null ? date.value : this.date),
        interval: (interval != null ? interval.value : this.interval),
        targetGroup:
            (targetGroup != null ? targetGroup.value : this.targetGroup));
  }
}

@JsonSerializable(explicitToJson: true)
class ContactFormInput {
  const ContactFormInput({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.message,
  });

  factory ContactFormInput.fromJson(Map<String, dynamic> json) =>
      _$ContactFormInputFromJson(json);

  static const toJsonFactory = _$ContactFormInputToJson;
  Map<String, dynamic> toJson() => _$ContactFormInputToJson(this);

  @JsonKey(name: 'firstName')
  final String firstName;
  @JsonKey(name: 'lastName')
  final String lastName;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'message')
  final String message;
  static const fromJsonFactory = _$ContactFormInputFromJson;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ContactFormInput &&
            (identical(other.firstName, firstName) ||
                const DeepCollectionEquality()
                    .equals(other.firstName, firstName)) &&
            (identical(other.lastName, lastName) ||
                const DeepCollectionEquality()
                    .equals(other.lastName, lastName)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(firstName) ^
      const DeepCollectionEquality().hash(lastName) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(message) ^
      runtimeType.hashCode;
}

extension $ContactFormInputExtension on ContactFormInput {
  ContactFormInput copyWith(
      {String? firstName, String? lastName, String? email, String? message}) {
    return ContactFormInput(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        message: message ?? this.message);
  }

  ContactFormInput copyWithWrapped(
      {Wrapped<String>? firstName,
      Wrapped<String>? lastName,
      Wrapped<String>? email,
      Wrapped<String>? message}) {
    return ContactFormInput(
        firstName: (firstName != null ? firstName.value : this.firstName),
        lastName: (lastName != null ? lastName.value : this.lastName),
        email: (email != null ? email.value : this.email),
        message: (message != null ? message.value : this.message));
  }
}

String? tGMDExceptionResponseOriginNullableToJson(
    enums.TGMDExceptionResponseOrigin? tGMDExceptionResponseOrigin) {
  return tGMDExceptionResponseOrigin?.value;
}

String? tGMDExceptionResponseOriginToJson(
    enums.TGMDExceptionResponseOrigin tGMDExceptionResponseOrigin) {
  return tGMDExceptionResponseOrigin.value;
}

enums.TGMDExceptionResponseOrigin tGMDExceptionResponseOriginFromJson(
  Object? tGMDExceptionResponseOrigin, [
  enums.TGMDExceptionResponseOrigin? defaultValue,
]) {
  return enums.TGMDExceptionResponseOrigin.values
          .firstWhereOrNull((e) => e.value == tGMDExceptionResponseOrigin) ??
      defaultValue ??
      enums.TGMDExceptionResponseOrigin.swaggerGeneratedUnknown;
}

enums.TGMDExceptionResponseOrigin? tGMDExceptionResponseOriginNullableFromJson(
  Object? tGMDExceptionResponseOrigin, [
  enums.TGMDExceptionResponseOrigin? defaultValue,
]) {
  if (tGMDExceptionResponseOrigin == null) {
    return null;
  }
  return enums.TGMDExceptionResponseOrigin.values
          .firstWhereOrNull((e) => e.value == tGMDExceptionResponseOrigin) ??
      defaultValue;
}

String tGMDExceptionResponseOriginExplodedListToJson(
    List<enums.TGMDExceptionResponseOrigin>? tGMDExceptionResponseOrigin) {
  return tGMDExceptionResponseOrigin?.map((e) => e.value!).join(',') ?? '';
}

List<String> tGMDExceptionResponseOriginListToJson(
    List<enums.TGMDExceptionResponseOrigin>? tGMDExceptionResponseOrigin) {
  if (tGMDExceptionResponseOrigin == null) {
    return [];
  }

  return tGMDExceptionResponseOrigin.map((e) => e.value!).toList();
}

List<enums.TGMDExceptionResponseOrigin> tGMDExceptionResponseOriginListFromJson(
  List? tGMDExceptionResponseOrigin, [
  List<enums.TGMDExceptionResponseOrigin>? defaultValue,
]) {
  if (tGMDExceptionResponseOrigin == null) {
    return defaultValue ?? [];
  }

  return tGMDExceptionResponseOrigin
      .map((e) => tGMDExceptionResponseOriginFromJson(e.toString()))
      .toList();
}

List<enums.TGMDExceptionResponseOrigin>?
    tGMDExceptionResponseOriginNullableListFromJson(
  List? tGMDExceptionResponseOrigin, [
  List<enums.TGMDExceptionResponseOrigin>? defaultValue,
]) {
  if (tGMDExceptionResponseOrigin == null) {
    return defaultValue;
  }

  return tGMDExceptionResponseOrigin
      .map((e) => tGMDExceptionResponseOriginFromJson(e.toString()))
      .toList();
}

String? userStatusResponseTypeNullableToJson(
    enums.UserStatusResponseType? userStatusResponseType) {
  return userStatusResponseType?.value;
}

String? userStatusResponseTypeToJson(
    enums.UserStatusResponseType userStatusResponseType) {
  return userStatusResponseType.value;
}

enums.UserStatusResponseType userStatusResponseTypeFromJson(
  Object? userStatusResponseType, [
  enums.UserStatusResponseType? defaultValue,
]) {
  return enums.UserStatusResponseType.values
          .firstWhereOrNull((e) => e.value == userStatusResponseType) ??
      defaultValue ??
      enums.UserStatusResponseType.swaggerGeneratedUnknown;
}

enums.UserStatusResponseType? userStatusResponseTypeNullableFromJson(
  Object? userStatusResponseType, [
  enums.UserStatusResponseType? defaultValue,
]) {
  if (userStatusResponseType == null) {
    return null;
  }
  return enums.UserStatusResponseType.values
          .firstWhereOrNull((e) => e.value == userStatusResponseType) ??
      defaultValue;
}

String userStatusResponseTypeExplodedListToJson(
    List<enums.UserStatusResponseType>? userStatusResponseType) {
  return userStatusResponseType?.map((e) => e.value!).join(',') ?? '';
}

List<String> userStatusResponseTypeListToJson(
    List<enums.UserStatusResponseType>? userStatusResponseType) {
  if (userStatusResponseType == null) {
    return [];
  }

  return userStatusResponseType.map((e) => e.value!).toList();
}

List<enums.UserStatusResponseType> userStatusResponseTypeListFromJson(
  List? userStatusResponseType, [
  List<enums.UserStatusResponseType>? defaultValue,
]) {
  if (userStatusResponseType == null) {
    return defaultValue ?? [];
  }

  return userStatusResponseType
      .map((e) => userStatusResponseTypeFromJson(e.toString()))
      .toList();
}

List<enums.UserStatusResponseType>? userStatusResponseTypeNullableListFromJson(
  List? userStatusResponseType, [
  List<enums.UserStatusResponseType>? defaultValue,
]) {
  if (userStatusResponseType == null) {
    return defaultValue;
  }

  return userStatusResponseType
      .map((e) => userStatusResponseTypeFromJson(e.toString()))
      .toList();
}

String? userResponseGenderNullableToJson(
    enums.UserResponseGender? userResponseGender) {
  return userResponseGender?.value;
}

String? userResponseGenderToJson(enums.UserResponseGender userResponseGender) {
  return userResponseGender.value;
}

enums.UserResponseGender userResponseGenderFromJson(
  Object? userResponseGender, [
  enums.UserResponseGender? defaultValue,
]) {
  return enums.UserResponseGender.values
          .firstWhereOrNull((e) => e.value == userResponseGender) ??
      defaultValue ??
      enums.UserResponseGender.swaggerGeneratedUnknown;
}

enums.UserResponseGender? userResponseGenderNullableFromJson(
  Object? userResponseGender, [
  enums.UserResponseGender? defaultValue,
]) {
  if (userResponseGender == null) {
    return null;
  }
  return enums.UserResponseGender.values
          .firstWhereOrNull((e) => e.value == userResponseGender) ??
      defaultValue;
}

String userResponseGenderExplodedListToJson(
    List<enums.UserResponseGender>? userResponseGender) {
  return userResponseGender?.map((e) => e.value!).join(',') ?? '';
}

List<String> userResponseGenderListToJson(
    List<enums.UserResponseGender>? userResponseGender) {
  if (userResponseGender == null) {
    return [];
  }

  return userResponseGender.map((e) => e.value!).toList();
}

List<enums.UserResponseGender> userResponseGenderListFromJson(
  List? userResponseGender, [
  List<enums.UserResponseGender>? defaultValue,
]) {
  if (userResponseGender == null) {
    return defaultValue ?? [];
  }

  return userResponseGender
      .map((e) => userResponseGenderFromJson(e.toString()))
      .toList();
}

List<enums.UserResponseGender>? userResponseGenderNullableListFromJson(
  List? userResponseGender, [
  List<enums.UserResponseGender>? defaultValue,
]) {
  if (userResponseGender == null) {
    return defaultValue;
  }

  return userResponseGender
      .map((e) => userResponseGenderFromJson(e.toString()))
      .toList();
}

String? userResponseRoleNullableToJson(
    enums.UserResponseRole? userResponseRole) {
  return userResponseRole?.value;
}

String? userResponseRoleToJson(enums.UserResponseRole userResponseRole) {
  return userResponseRole.value;
}

enums.UserResponseRole userResponseRoleFromJson(
  Object? userResponseRole, [
  enums.UserResponseRole? defaultValue,
]) {
  return enums.UserResponseRole.values
          .firstWhereOrNull((e) => e.value == userResponseRole) ??
      defaultValue ??
      enums.UserResponseRole.swaggerGeneratedUnknown;
}

enums.UserResponseRole? userResponseRoleNullableFromJson(
  Object? userResponseRole, [
  enums.UserResponseRole? defaultValue,
]) {
  if (userResponseRole == null) {
    return null;
  }
  return enums.UserResponseRole.values
          .firstWhereOrNull((e) => e.value == userResponseRole) ??
      defaultValue;
}

String userResponseRoleExplodedListToJson(
    List<enums.UserResponseRole>? userResponseRole) {
  return userResponseRole?.map((e) => e.value!).join(',') ?? '';
}

List<String> userResponseRoleListToJson(
    List<enums.UserResponseRole>? userResponseRole) {
  if (userResponseRole == null) {
    return [];
  }

  return userResponseRole.map((e) => e.value!).toList();
}

List<enums.UserResponseRole> userResponseRoleListFromJson(
  List? userResponseRole, [
  List<enums.UserResponseRole>? defaultValue,
]) {
  if (userResponseRole == null) {
    return defaultValue ?? [];
  }

  return userResponseRole
      .map((e) => userResponseRoleFromJson(e.toString()))
      .toList();
}

List<enums.UserResponseRole>? userResponseRoleNullableListFromJson(
  List? userResponseRole, [
  List<enums.UserResponseRole>? defaultValue,
]) {
  if (userResponseRole == null) {
    return defaultValue;
  }

  return userResponseRole
      .map((e) => userResponseRoleFromJson(e.toString()))
      .toList();
}

String? userResponseSignupTypeNullableToJson(
    enums.UserResponseSignupType? userResponseSignupType) {
  return userResponseSignupType?.value;
}

String? userResponseSignupTypeToJson(
    enums.UserResponseSignupType userResponseSignupType) {
  return userResponseSignupType.value;
}

enums.UserResponseSignupType userResponseSignupTypeFromJson(
  Object? userResponseSignupType, [
  enums.UserResponseSignupType? defaultValue,
]) {
  return enums.UserResponseSignupType.values
          .firstWhereOrNull((e) => e.value == userResponseSignupType) ??
      defaultValue ??
      enums.UserResponseSignupType.swaggerGeneratedUnknown;
}

enums.UserResponseSignupType? userResponseSignupTypeNullableFromJson(
  Object? userResponseSignupType, [
  enums.UserResponseSignupType? defaultValue,
]) {
  if (userResponseSignupType == null) {
    return null;
  }
  return enums.UserResponseSignupType.values
          .firstWhereOrNull((e) => e.value == userResponseSignupType) ??
      defaultValue;
}

String userResponseSignupTypeExplodedListToJson(
    List<enums.UserResponseSignupType>? userResponseSignupType) {
  return userResponseSignupType?.map((e) => e.value!).join(',') ?? '';
}

List<String> userResponseSignupTypeListToJson(
    List<enums.UserResponseSignupType>? userResponseSignupType) {
  if (userResponseSignupType == null) {
    return [];
  }

  return userResponseSignupType.map((e) => e.value!).toList();
}

List<enums.UserResponseSignupType> userResponseSignupTypeListFromJson(
  List? userResponseSignupType, [
  List<enums.UserResponseSignupType>? defaultValue,
]) {
  if (userResponseSignupType == null) {
    return defaultValue ?? [];
  }

  return userResponseSignupType
      .map((e) => userResponseSignupTypeFromJson(e.toString()))
      .toList();
}

List<enums.UserResponseSignupType>? userResponseSignupTypeNullableListFromJson(
  List? userResponseSignupType, [
  List<enums.UserResponseSignupType>? defaultValue,
]) {
  if (userResponseSignupType == null) {
    return defaultValue;
  }

  return userResponseSignupType
      .map((e) => userResponseSignupTypeFromJson(e.toString()))
      .toList();
}

String? userResponseTimezoneNullableToJson(
    enums.UserResponseTimezone? userResponseTimezone) {
  return userResponseTimezone?.value;
}

String? userResponseTimezoneToJson(
    enums.UserResponseTimezone userResponseTimezone) {
  return userResponseTimezone.value;
}

enums.UserResponseTimezone userResponseTimezoneFromJson(
  Object? userResponseTimezone, [
  enums.UserResponseTimezone? defaultValue,
]) {
  return enums.UserResponseTimezone.values
          .firstWhereOrNull((e) => e.value == userResponseTimezone) ??
      defaultValue ??
      enums.UserResponseTimezone.swaggerGeneratedUnknown;
}

enums.UserResponseTimezone? userResponseTimezoneNullableFromJson(
  Object? userResponseTimezone, [
  enums.UserResponseTimezone? defaultValue,
]) {
  if (userResponseTimezone == null) {
    return null;
  }
  return enums.UserResponseTimezone.values
          .firstWhereOrNull((e) => e.value == userResponseTimezone) ??
      defaultValue;
}

String userResponseTimezoneExplodedListToJson(
    List<enums.UserResponseTimezone>? userResponseTimezone) {
  return userResponseTimezone?.map((e) => e.value!).join(',') ?? '';
}

List<String> userResponseTimezoneListToJson(
    List<enums.UserResponseTimezone>? userResponseTimezone) {
  if (userResponseTimezone == null) {
    return [];
  }

  return userResponseTimezone.map((e) => e.value!).toList();
}

List<enums.UserResponseTimezone> userResponseTimezoneListFromJson(
  List? userResponseTimezone, [
  List<enums.UserResponseTimezone>? defaultValue,
]) {
  if (userResponseTimezone == null) {
    return defaultValue ?? [];
  }

  return userResponseTimezone
      .map((e) => userResponseTimezoneFromJson(e.toString()))
      .toList();
}

List<enums.UserResponseTimezone>? userResponseTimezoneNullableListFromJson(
  List? userResponseTimezone, [
  List<enums.UserResponseTimezone>? defaultValue,
]) {
  if (userResponseTimezone == null) {
    return defaultValue;
  }

  return userResponseTimezone
      .map((e) => userResponseTimezoneFromJson(e.toString()))
      .toList();
}

String? userGroupResponseKeyNullableToJson(
    enums.UserGroupResponseKey? userGroupResponseKey) {
  return userGroupResponseKey?.value;
}

String? userGroupResponseKeyToJson(
    enums.UserGroupResponseKey userGroupResponseKey) {
  return userGroupResponseKey.value;
}

enums.UserGroupResponseKey userGroupResponseKeyFromJson(
  Object? userGroupResponseKey, [
  enums.UserGroupResponseKey? defaultValue,
]) {
  return enums.UserGroupResponseKey.values
          .firstWhereOrNull((e) => e.value == userGroupResponseKey) ??
      defaultValue ??
      enums.UserGroupResponseKey.swaggerGeneratedUnknown;
}

enums.UserGroupResponseKey? userGroupResponseKeyNullableFromJson(
  Object? userGroupResponseKey, [
  enums.UserGroupResponseKey? defaultValue,
]) {
  if (userGroupResponseKey == null) {
    return null;
  }
  return enums.UserGroupResponseKey.values
          .firstWhereOrNull((e) => e.value == userGroupResponseKey) ??
      defaultValue;
}

String userGroupResponseKeyExplodedListToJson(
    List<enums.UserGroupResponseKey>? userGroupResponseKey) {
  return userGroupResponseKey?.map((e) => e.value!).join(',') ?? '';
}

List<String> userGroupResponseKeyListToJson(
    List<enums.UserGroupResponseKey>? userGroupResponseKey) {
  if (userGroupResponseKey == null) {
    return [];
  }

  return userGroupResponseKey.map((e) => e.value!).toList();
}

List<enums.UserGroupResponseKey> userGroupResponseKeyListFromJson(
  List? userGroupResponseKey, [
  List<enums.UserGroupResponseKey>? defaultValue,
]) {
  if (userGroupResponseKey == null) {
    return defaultValue ?? [];
  }

  return userGroupResponseKey
      .map((e) => userGroupResponseKeyFromJson(e.toString()))
      .toList();
}

List<enums.UserGroupResponseKey>? userGroupResponseKeyNullableListFromJson(
  List? userGroupResponseKey, [
  List<enums.UserGroupResponseKey>? defaultValue,
]) {
  if (userGroupResponseKey == null) {
    return defaultValue;
  }

  return userGroupResponseKey
      .map((e) => userGroupResponseKeyFromJson(e.toString()))
      .toList();
}

String? userGameDataResponseGameNullableToJson(
    enums.UserGameDataResponseGame? userGameDataResponseGame) {
  return userGameDataResponseGame?.value;
}

String? userGameDataResponseGameToJson(
    enums.UserGameDataResponseGame userGameDataResponseGame) {
  return userGameDataResponseGame.value;
}

enums.UserGameDataResponseGame userGameDataResponseGameFromJson(
  Object? userGameDataResponseGame, [
  enums.UserGameDataResponseGame? defaultValue,
]) {
  return enums.UserGameDataResponseGame.values
          .firstWhereOrNull((e) => e.value == userGameDataResponseGame) ??
      defaultValue ??
      enums.UserGameDataResponseGame.swaggerGeneratedUnknown;
}

enums.UserGameDataResponseGame? userGameDataResponseGameNullableFromJson(
  Object? userGameDataResponseGame, [
  enums.UserGameDataResponseGame? defaultValue,
]) {
  if (userGameDataResponseGame == null) {
    return null;
  }
  return enums.UserGameDataResponseGame.values
          .firstWhereOrNull((e) => e.value == userGameDataResponseGame) ??
      defaultValue;
}

String userGameDataResponseGameExplodedListToJson(
    List<enums.UserGameDataResponseGame>? userGameDataResponseGame) {
  return userGameDataResponseGame?.map((e) => e.value!).join(',') ?? '';
}

List<String> userGameDataResponseGameListToJson(
    List<enums.UserGameDataResponseGame>? userGameDataResponseGame) {
  if (userGameDataResponseGame == null) {
    return [];
  }

  return userGameDataResponseGame.map((e) => e.value!).toList();
}

List<enums.UserGameDataResponseGame> userGameDataResponseGameListFromJson(
  List? userGameDataResponseGame, [
  List<enums.UserGameDataResponseGame>? defaultValue,
]) {
  if (userGameDataResponseGame == null) {
    return defaultValue ?? [];
  }

  return userGameDataResponseGame
      .map((e) => userGameDataResponseGameFromJson(e.toString()))
      .toList();
}

List<enums.UserGameDataResponseGame>?
    userGameDataResponseGameNullableListFromJson(
  List? userGameDataResponseGame, [
  List<enums.UserGameDataResponseGame>? defaultValue,
]) {
  if (userGameDataResponseGame == null) {
    return defaultValue;
  }

  return userGameDataResponseGame
      .map((e) => userGameDataResponseGameFromJson(e.toString()))
      .toList();
}

String? userReportResponseReportReasonNullableToJson(
    enums.UserReportResponseReportReason? userReportResponseReportReason) {
  return userReportResponseReportReason?.value;
}

String? userReportResponseReportReasonToJson(
    enums.UserReportResponseReportReason userReportResponseReportReason) {
  return userReportResponseReportReason.value;
}

enums.UserReportResponseReportReason userReportResponseReportReasonFromJson(
  Object? userReportResponseReportReason, [
  enums.UserReportResponseReportReason? defaultValue,
]) {
  return enums.UserReportResponseReportReason.values
          .firstWhereOrNull((e) => e.value == userReportResponseReportReason) ??
      defaultValue ??
      enums.UserReportResponseReportReason.swaggerGeneratedUnknown;
}

enums.UserReportResponseReportReason?
    userReportResponseReportReasonNullableFromJson(
  Object? userReportResponseReportReason, [
  enums.UserReportResponseReportReason? defaultValue,
]) {
  if (userReportResponseReportReason == null) {
    return null;
  }
  return enums.UserReportResponseReportReason.values
          .firstWhereOrNull((e) => e.value == userReportResponseReportReason) ??
      defaultValue;
}

String userReportResponseReportReasonExplodedListToJson(
    List<enums.UserReportResponseReportReason>?
        userReportResponseReportReason) {
  return userReportResponseReportReason?.map((e) => e.value!).join(',') ?? '';
}

List<String> userReportResponseReportReasonListToJson(
    List<enums.UserReportResponseReportReason>?
        userReportResponseReportReason) {
  if (userReportResponseReportReason == null) {
    return [];
  }

  return userReportResponseReportReason.map((e) => e.value!).toList();
}

List<enums.UserReportResponseReportReason>
    userReportResponseReportReasonListFromJson(
  List? userReportResponseReportReason, [
  List<enums.UserReportResponseReportReason>? defaultValue,
]) {
  if (userReportResponseReportReason == null) {
    return defaultValue ?? [];
  }

  return userReportResponseReportReason
      .map((e) => userReportResponseReportReasonFromJson(e.toString()))
      .toList();
}

List<enums.UserReportResponseReportReason>?
    userReportResponseReportReasonNullableListFromJson(
  List? userReportResponseReportReason, [
  List<enums.UserReportResponseReportReason>? defaultValue,
]) {
  if (userReportResponseReportReason == null) {
    return defaultValue;
  }

  return userReportResponseReportReason
      .map((e) => userReportResponseReportReasonFromJson(e.toString()))
      .toList();
}

String? userWarningTypeResponseKeyNullableToJson(
    enums.UserWarningTypeResponseKey? userWarningTypeResponseKey) {
  return userWarningTypeResponseKey?.value;
}

String? userWarningTypeResponseKeyToJson(
    enums.UserWarningTypeResponseKey userWarningTypeResponseKey) {
  return userWarningTypeResponseKey.value;
}

enums.UserWarningTypeResponseKey userWarningTypeResponseKeyFromJson(
  Object? userWarningTypeResponseKey, [
  enums.UserWarningTypeResponseKey? defaultValue,
]) {
  return enums.UserWarningTypeResponseKey.values
          .firstWhereOrNull((e) => e.value == userWarningTypeResponseKey) ??
      defaultValue ??
      enums.UserWarningTypeResponseKey.swaggerGeneratedUnknown;
}

enums.UserWarningTypeResponseKey? userWarningTypeResponseKeyNullableFromJson(
  Object? userWarningTypeResponseKey, [
  enums.UserWarningTypeResponseKey? defaultValue,
]) {
  if (userWarningTypeResponseKey == null) {
    return null;
  }
  return enums.UserWarningTypeResponseKey.values
          .firstWhereOrNull((e) => e.value == userWarningTypeResponseKey) ??
      defaultValue;
}

String userWarningTypeResponseKeyExplodedListToJson(
    List<enums.UserWarningTypeResponseKey>? userWarningTypeResponseKey) {
  return userWarningTypeResponseKey?.map((e) => e.value!).join(',') ?? '';
}

List<String> userWarningTypeResponseKeyListToJson(
    List<enums.UserWarningTypeResponseKey>? userWarningTypeResponseKey) {
  if (userWarningTypeResponseKey == null) {
    return [];
  }

  return userWarningTypeResponseKey.map((e) => e.value!).toList();
}

List<enums.UserWarningTypeResponseKey> userWarningTypeResponseKeyListFromJson(
  List? userWarningTypeResponseKey, [
  List<enums.UserWarningTypeResponseKey>? defaultValue,
]) {
  if (userWarningTypeResponseKey == null) {
    return defaultValue ?? [];
  }

  return userWarningTypeResponseKey
      .map((e) => userWarningTypeResponseKeyFromJson(e.toString()))
      .toList();
}

List<enums.UserWarningTypeResponseKey>?
    userWarningTypeResponseKeyNullableListFromJson(
  List? userWarningTypeResponseKey, [
  List<enums.UserWarningTypeResponseKey>? defaultValue,
]) {
  if (userWarningTypeResponseKey == null) {
    return defaultValue;
  }

  return userWarningTypeResponseKey
      .map((e) => userWarningTypeResponseKeyFromJson(e.toString()))
      .toList();
}

String? userReportTypeResponseKeyNullableToJson(
    enums.UserReportTypeResponseKey? userReportTypeResponseKey) {
  return userReportTypeResponseKey?.value;
}

String? userReportTypeResponseKeyToJson(
    enums.UserReportTypeResponseKey userReportTypeResponseKey) {
  return userReportTypeResponseKey.value;
}

enums.UserReportTypeResponseKey userReportTypeResponseKeyFromJson(
  Object? userReportTypeResponseKey, [
  enums.UserReportTypeResponseKey? defaultValue,
]) {
  return enums.UserReportTypeResponseKey.values
          .firstWhereOrNull((e) => e.value == userReportTypeResponseKey) ??
      defaultValue ??
      enums.UserReportTypeResponseKey.swaggerGeneratedUnknown;
}

enums.UserReportTypeResponseKey? userReportTypeResponseKeyNullableFromJson(
  Object? userReportTypeResponseKey, [
  enums.UserReportTypeResponseKey? defaultValue,
]) {
  if (userReportTypeResponseKey == null) {
    return null;
  }
  return enums.UserReportTypeResponseKey.values
          .firstWhereOrNull((e) => e.value == userReportTypeResponseKey) ??
      defaultValue;
}

String userReportTypeResponseKeyExplodedListToJson(
    List<enums.UserReportTypeResponseKey>? userReportTypeResponseKey) {
  return userReportTypeResponseKey?.map((e) => e.value!).join(',') ?? '';
}

List<String> userReportTypeResponseKeyListToJson(
    List<enums.UserReportTypeResponseKey>? userReportTypeResponseKey) {
  if (userReportTypeResponseKey == null) {
    return [];
  }

  return userReportTypeResponseKey.map((e) => e.value!).toList();
}

List<enums.UserReportTypeResponseKey> userReportTypeResponseKeyListFromJson(
  List? userReportTypeResponseKey, [
  List<enums.UserReportTypeResponseKey>? defaultValue,
]) {
  if (userReportTypeResponseKey == null) {
    return defaultValue ?? [];
  }

  return userReportTypeResponseKey
      .map((e) => userReportTypeResponseKeyFromJson(e.toString()))
      .toList();
}

List<enums.UserReportTypeResponseKey>?
    userReportTypeResponseKeyNullableListFromJson(
  List? userReportTypeResponseKey, [
  List<enums.UserReportTypeResponseKey>? defaultValue,
]) {
  if (userReportTypeResponseKey == null) {
    return defaultValue;
  }

  return userReportTypeResponseKey
      .map((e) => userReportTypeResponseKeyFromJson(e.toString()))
      .toList();
}

String? userWarningInputWarningNullableToJson(
    enums.UserWarningInputWarning? userWarningInputWarning) {
  return userWarningInputWarning?.value;
}

String? userWarningInputWarningToJson(
    enums.UserWarningInputWarning userWarningInputWarning) {
  return userWarningInputWarning.value;
}

enums.UserWarningInputWarning userWarningInputWarningFromJson(
  Object? userWarningInputWarning, [
  enums.UserWarningInputWarning? defaultValue,
]) {
  return enums.UserWarningInputWarning.values
          .firstWhereOrNull((e) => e.value == userWarningInputWarning) ??
      defaultValue ??
      enums.UserWarningInputWarning.swaggerGeneratedUnknown;
}

enums.UserWarningInputWarning? userWarningInputWarningNullableFromJson(
  Object? userWarningInputWarning, [
  enums.UserWarningInputWarning? defaultValue,
]) {
  if (userWarningInputWarning == null) {
    return null;
  }
  return enums.UserWarningInputWarning.values
          .firstWhereOrNull((e) => e.value == userWarningInputWarning) ??
      defaultValue;
}

String userWarningInputWarningExplodedListToJson(
    List<enums.UserWarningInputWarning>? userWarningInputWarning) {
  return userWarningInputWarning?.map((e) => e.value!).join(',') ?? '';
}

List<String> userWarningInputWarningListToJson(
    List<enums.UserWarningInputWarning>? userWarningInputWarning) {
  if (userWarningInputWarning == null) {
    return [];
  }

  return userWarningInputWarning.map((e) => e.value!).toList();
}

List<enums.UserWarningInputWarning> userWarningInputWarningListFromJson(
  List? userWarningInputWarning, [
  List<enums.UserWarningInputWarning>? defaultValue,
]) {
  if (userWarningInputWarning == null) {
    return defaultValue ?? [];
  }

  return userWarningInputWarning
      .map((e) => userWarningInputWarningFromJson(e.toString()))
      .toList();
}

List<enums.UserWarningInputWarning>?
    userWarningInputWarningNullableListFromJson(
  List? userWarningInputWarning, [
  List<enums.UserWarningInputWarning>? defaultValue,
]) {
  if (userWarningInputWarning == null) {
    return defaultValue;
  }

  return userWarningInputWarning
      .map((e) => userWarningInputWarningFromJson(e.toString()))
      .toList();
}

String? authResponseNextStepNullableToJson(
    enums.AuthResponseNextStep? authResponseNextStep) {
  return authResponseNextStep?.value;
}

String? authResponseNextStepToJson(
    enums.AuthResponseNextStep authResponseNextStep) {
  return authResponseNextStep.value;
}

enums.AuthResponseNextStep authResponseNextStepFromJson(
  Object? authResponseNextStep, [
  enums.AuthResponseNextStep? defaultValue,
]) {
  return enums.AuthResponseNextStep.values
          .firstWhereOrNull((e) => e.value == authResponseNextStep) ??
      defaultValue ??
      enums.AuthResponseNextStep.swaggerGeneratedUnknown;
}

enums.AuthResponseNextStep? authResponseNextStepNullableFromJson(
  Object? authResponseNextStep, [
  enums.AuthResponseNextStep? defaultValue,
]) {
  if (authResponseNextStep == null) {
    return null;
  }
  return enums.AuthResponseNextStep.values
          .firstWhereOrNull((e) => e.value == authResponseNextStep) ??
      defaultValue;
}

String authResponseNextStepExplodedListToJson(
    List<enums.AuthResponseNextStep>? authResponseNextStep) {
  return authResponseNextStep?.map((e) => e.value!).join(',') ?? '';
}

List<String> authResponseNextStepListToJson(
    List<enums.AuthResponseNextStep>? authResponseNextStep) {
  if (authResponseNextStep == null) {
    return [];
  }

  return authResponseNextStep.map((e) => e.value!).toList();
}

List<enums.AuthResponseNextStep> authResponseNextStepListFromJson(
  List? authResponseNextStep, [
  List<enums.AuthResponseNextStep>? defaultValue,
]) {
  if (authResponseNextStep == null) {
    return defaultValue ?? [];
  }

  return authResponseNextStep
      .map((e) => authResponseNextStepFromJson(e.toString()))
      .toList();
}

List<enums.AuthResponseNextStep>? authResponseNextStepNullableListFromJson(
  List? authResponseNextStep, [
  List<enums.AuthResponseNextStep>? defaultValue,
]) {
  if (authResponseNextStep == null) {
    return defaultValue;
  }

  return authResponseNextStep
      .map((e) => authResponseNextStepFromJson(e.toString()))
      .toList();
}

String? scheduledNotificationDataResponseTargetGroupNullableToJson(
    enums.ScheduledNotificationDataResponseTargetGroup?
        scheduledNotificationDataResponseTargetGroup) {
  return scheduledNotificationDataResponseTargetGroup?.value;
}

String? scheduledNotificationDataResponseTargetGroupToJson(
    enums.ScheduledNotificationDataResponseTargetGroup
        scheduledNotificationDataResponseTargetGroup) {
  return scheduledNotificationDataResponseTargetGroup.value;
}

enums.ScheduledNotificationDataResponseTargetGroup
    scheduledNotificationDataResponseTargetGroupFromJson(
  Object? scheduledNotificationDataResponseTargetGroup, [
  enums.ScheduledNotificationDataResponseTargetGroup? defaultValue,
]) {
  return enums.ScheduledNotificationDataResponseTargetGroup.values
          .firstWhereOrNull(
              (e) => e.value == scheduledNotificationDataResponseTargetGroup) ??
      defaultValue ??
      enums
          .ScheduledNotificationDataResponseTargetGroup.swaggerGeneratedUnknown;
}

enums.ScheduledNotificationDataResponseTargetGroup?
    scheduledNotificationDataResponseTargetGroupNullableFromJson(
  Object? scheduledNotificationDataResponseTargetGroup, [
  enums.ScheduledNotificationDataResponseTargetGroup? defaultValue,
]) {
  if (scheduledNotificationDataResponseTargetGroup == null) {
    return null;
  }
  return enums.ScheduledNotificationDataResponseTargetGroup.values
          .firstWhereOrNull(
              (e) => e.value == scheduledNotificationDataResponseTargetGroup) ??
      defaultValue;
}

String scheduledNotificationDataResponseTargetGroupExplodedListToJson(
    List<enums.ScheduledNotificationDataResponseTargetGroup>?
        scheduledNotificationDataResponseTargetGroup) {
  return scheduledNotificationDataResponseTargetGroup
          ?.map((e) => e.value!)
          .join(',') ??
      '';
}

List<String> scheduledNotificationDataResponseTargetGroupListToJson(
    List<enums.ScheduledNotificationDataResponseTargetGroup>?
        scheduledNotificationDataResponseTargetGroup) {
  if (scheduledNotificationDataResponseTargetGroup == null) {
    return [];
  }

  return scheduledNotificationDataResponseTargetGroup
      .map((e) => e.value!)
      .toList();
}

List<enums.ScheduledNotificationDataResponseTargetGroup>
    scheduledNotificationDataResponseTargetGroupListFromJson(
  List? scheduledNotificationDataResponseTargetGroup, [
  List<enums.ScheduledNotificationDataResponseTargetGroup>? defaultValue,
]) {
  if (scheduledNotificationDataResponseTargetGroup == null) {
    return defaultValue ?? [];
  }

  return scheduledNotificationDataResponseTargetGroup
      .map((e) =>
          scheduledNotificationDataResponseTargetGroupFromJson(e.toString()))
      .toList();
}

List<enums.ScheduledNotificationDataResponseTargetGroup>?
    scheduledNotificationDataResponseTargetGroupNullableListFromJson(
  List? scheduledNotificationDataResponseTargetGroup, [
  List<enums.ScheduledNotificationDataResponseTargetGroup>? defaultValue,
]) {
  if (scheduledNotificationDataResponseTargetGroup == null) {
    return defaultValue;
  }

  return scheduledNotificationDataResponseTargetGroup
      .map((e) =>
          scheduledNotificationDataResponseTargetGroupFromJson(e.toString()))
      .toList();
}

String? scheduledNotificationDataResponseNotificationTypeNullableToJson(
    enums.ScheduledNotificationDataResponseNotificationType?
        scheduledNotificationDataResponseNotificationType) {
  return scheduledNotificationDataResponseNotificationType?.value;
}

String? scheduledNotificationDataResponseNotificationTypeToJson(
    enums.ScheduledNotificationDataResponseNotificationType
        scheduledNotificationDataResponseNotificationType) {
  return scheduledNotificationDataResponseNotificationType.value;
}

enums.ScheduledNotificationDataResponseNotificationType
    scheduledNotificationDataResponseNotificationTypeFromJson(
  Object? scheduledNotificationDataResponseNotificationType, [
  enums.ScheduledNotificationDataResponseNotificationType? defaultValue,
]) {
  return enums.ScheduledNotificationDataResponseNotificationType.values
          .firstWhereOrNull((e) =>
              e.value == scheduledNotificationDataResponseNotificationType) ??
      defaultValue ??
      enums.ScheduledNotificationDataResponseNotificationType
          .swaggerGeneratedUnknown;
}

enums.ScheduledNotificationDataResponseNotificationType?
    scheduledNotificationDataResponseNotificationTypeNullableFromJson(
  Object? scheduledNotificationDataResponseNotificationType, [
  enums.ScheduledNotificationDataResponseNotificationType? defaultValue,
]) {
  if (scheduledNotificationDataResponseNotificationType == null) {
    return null;
  }
  return enums.ScheduledNotificationDataResponseNotificationType.values
          .firstWhereOrNull((e) =>
              e.value == scheduledNotificationDataResponseNotificationType) ??
      defaultValue;
}

String scheduledNotificationDataResponseNotificationTypeExplodedListToJson(
    List<enums.ScheduledNotificationDataResponseNotificationType>?
        scheduledNotificationDataResponseNotificationType) {
  return scheduledNotificationDataResponseNotificationType
          ?.map((e) => e.value!)
          .join(',') ??
      '';
}

List<String> scheduledNotificationDataResponseNotificationTypeListToJson(
    List<enums.ScheduledNotificationDataResponseNotificationType>?
        scheduledNotificationDataResponseNotificationType) {
  if (scheduledNotificationDataResponseNotificationType == null) {
    return [];
  }

  return scheduledNotificationDataResponseNotificationType
      .map((e) => e.value!)
      .toList();
}

List<enums.ScheduledNotificationDataResponseNotificationType>
    scheduledNotificationDataResponseNotificationTypeListFromJson(
  List? scheduledNotificationDataResponseNotificationType, [
  List<enums.ScheduledNotificationDataResponseNotificationType>? defaultValue,
]) {
  if (scheduledNotificationDataResponseNotificationType == null) {
    return defaultValue ?? [];
  }

  return scheduledNotificationDataResponseNotificationType
      .map((e) => scheduledNotificationDataResponseNotificationTypeFromJson(
          e.toString()))
      .toList();
}

List<enums.ScheduledNotificationDataResponseNotificationType>?
    scheduledNotificationDataResponseNotificationTypeNullableListFromJson(
  List? scheduledNotificationDataResponseNotificationType, [
  List<enums.ScheduledNotificationDataResponseNotificationType>? defaultValue,
]) {
  if (scheduledNotificationDataResponseNotificationType == null) {
    return defaultValue;
  }

  return scheduledNotificationDataResponseNotificationType
      .map((e) => scheduledNotificationDataResponseNotificationTypeFromJson(
          e.toString()))
      .toList();
}

String? notificationTypeResponseKeyNullableToJson(
    enums.NotificationTypeResponseKey? notificationTypeResponseKey) {
  return notificationTypeResponseKey?.value;
}

String? notificationTypeResponseKeyToJson(
    enums.NotificationTypeResponseKey notificationTypeResponseKey) {
  return notificationTypeResponseKey.value;
}

enums.NotificationTypeResponseKey notificationTypeResponseKeyFromJson(
  Object? notificationTypeResponseKey, [
  enums.NotificationTypeResponseKey? defaultValue,
]) {
  return enums.NotificationTypeResponseKey.values
          .firstWhereOrNull((e) => e.value == notificationTypeResponseKey) ??
      defaultValue ??
      enums.NotificationTypeResponseKey.swaggerGeneratedUnknown;
}

enums.NotificationTypeResponseKey? notificationTypeResponseKeyNullableFromJson(
  Object? notificationTypeResponseKey, [
  enums.NotificationTypeResponseKey? defaultValue,
]) {
  if (notificationTypeResponseKey == null) {
    return null;
  }
  return enums.NotificationTypeResponseKey.values
          .firstWhereOrNull((e) => e.value == notificationTypeResponseKey) ??
      defaultValue;
}

String notificationTypeResponseKeyExplodedListToJson(
    List<enums.NotificationTypeResponseKey>? notificationTypeResponseKey) {
  return notificationTypeResponseKey?.map((e) => e.value!).join(',') ?? '';
}

List<String> notificationTypeResponseKeyListToJson(
    List<enums.NotificationTypeResponseKey>? notificationTypeResponseKey) {
  if (notificationTypeResponseKey == null) {
    return [];
  }

  return notificationTypeResponseKey.map((e) => e.value!).toList();
}

List<enums.NotificationTypeResponseKey> notificationTypeResponseKeyListFromJson(
  List? notificationTypeResponseKey, [
  List<enums.NotificationTypeResponseKey>? defaultValue,
]) {
  if (notificationTypeResponseKey == null) {
    return defaultValue ?? [];
  }

  return notificationTypeResponseKey
      .map((e) => notificationTypeResponseKeyFromJson(e.toString()))
      .toList();
}

List<enums.NotificationTypeResponseKey>?
    notificationTypeResponseKeyNullableListFromJson(
  List? notificationTypeResponseKey, [
  List<enums.NotificationTypeResponseKey>? defaultValue,
]) {
  if (notificationTypeResponseKey == null) {
    return defaultValue;
  }

  return notificationTypeResponseKey
      .map((e) => notificationTypeResponseKeyFromJson(e.toString()))
      .toList();
}

String? notificationIntervalResponseKeyNullableToJson(
    enums.NotificationIntervalResponseKey? notificationIntervalResponseKey) {
  return notificationIntervalResponseKey?.value;
}

String? notificationIntervalResponseKeyToJson(
    enums.NotificationIntervalResponseKey notificationIntervalResponseKey) {
  return notificationIntervalResponseKey.value;
}

enums.NotificationIntervalResponseKey notificationIntervalResponseKeyFromJson(
  Object? notificationIntervalResponseKey, [
  enums.NotificationIntervalResponseKey? defaultValue,
]) {
  return enums.NotificationIntervalResponseKey.values.firstWhereOrNull(
          (e) => e.value == notificationIntervalResponseKey) ??
      defaultValue ??
      enums.NotificationIntervalResponseKey.swaggerGeneratedUnknown;
}

enums.NotificationIntervalResponseKey?
    notificationIntervalResponseKeyNullableFromJson(
  Object? notificationIntervalResponseKey, [
  enums.NotificationIntervalResponseKey? defaultValue,
]) {
  if (notificationIntervalResponseKey == null) {
    return null;
  }
  return enums.NotificationIntervalResponseKey.values.firstWhereOrNull(
          (e) => e.value == notificationIntervalResponseKey) ??
      defaultValue;
}

String notificationIntervalResponseKeyExplodedListToJson(
    List<enums.NotificationIntervalResponseKey>?
        notificationIntervalResponseKey) {
  return notificationIntervalResponseKey?.map((e) => e.value!).join(',') ?? '';
}

List<String> notificationIntervalResponseKeyListToJson(
    List<enums.NotificationIntervalResponseKey>?
        notificationIntervalResponseKey) {
  if (notificationIntervalResponseKey == null) {
    return [];
  }

  return notificationIntervalResponseKey.map((e) => e.value!).toList();
}

List<enums.NotificationIntervalResponseKey>
    notificationIntervalResponseKeyListFromJson(
  List? notificationIntervalResponseKey, [
  List<enums.NotificationIntervalResponseKey>? defaultValue,
]) {
  if (notificationIntervalResponseKey == null) {
    return defaultValue ?? [];
  }

  return notificationIntervalResponseKey
      .map((e) => notificationIntervalResponseKeyFromJson(e.toString()))
      .toList();
}

List<enums.NotificationIntervalResponseKey>?
    notificationIntervalResponseKeyNullableListFromJson(
  List? notificationIntervalResponseKey, [
  List<enums.NotificationIntervalResponseKey>? defaultValue,
]) {
  if (notificationIntervalResponseKey == null) {
    return defaultValue;
  }

  return notificationIntervalResponseKey
      .map((e) => notificationIntervalResponseKeyFromJson(e.toString()))
      .toList();
}

String? createScheduledNotificationInputNotificationTypeNullableToJson(
    enums.CreateScheduledNotificationInputNotificationType?
        createScheduledNotificationInputNotificationType) {
  return createScheduledNotificationInputNotificationType?.value;
}

String? createScheduledNotificationInputNotificationTypeToJson(
    enums.CreateScheduledNotificationInputNotificationType
        createScheduledNotificationInputNotificationType) {
  return createScheduledNotificationInputNotificationType.value;
}

enums.CreateScheduledNotificationInputNotificationType
    createScheduledNotificationInputNotificationTypeFromJson(
  Object? createScheduledNotificationInputNotificationType, [
  enums.CreateScheduledNotificationInputNotificationType? defaultValue,
]) {
  return enums.CreateScheduledNotificationInputNotificationType.values
          .firstWhereOrNull((e) =>
              e.value == createScheduledNotificationInputNotificationType) ??
      defaultValue ??
      enums.CreateScheduledNotificationInputNotificationType
          .swaggerGeneratedUnknown;
}

enums.CreateScheduledNotificationInputNotificationType?
    createScheduledNotificationInputNotificationTypeNullableFromJson(
  Object? createScheduledNotificationInputNotificationType, [
  enums.CreateScheduledNotificationInputNotificationType? defaultValue,
]) {
  if (createScheduledNotificationInputNotificationType == null) {
    return null;
  }
  return enums.CreateScheduledNotificationInputNotificationType.values
          .firstWhereOrNull((e) =>
              e.value == createScheduledNotificationInputNotificationType) ??
      defaultValue;
}

String createScheduledNotificationInputNotificationTypeExplodedListToJson(
    List<enums.CreateScheduledNotificationInputNotificationType>?
        createScheduledNotificationInputNotificationType) {
  return createScheduledNotificationInputNotificationType
          ?.map((e) => e.value!)
          .join(',') ??
      '';
}

List<String> createScheduledNotificationInputNotificationTypeListToJson(
    List<enums.CreateScheduledNotificationInputNotificationType>?
        createScheduledNotificationInputNotificationType) {
  if (createScheduledNotificationInputNotificationType == null) {
    return [];
  }

  return createScheduledNotificationInputNotificationType
      .map((e) => e.value!)
      .toList();
}

List<enums.CreateScheduledNotificationInputNotificationType>
    createScheduledNotificationInputNotificationTypeListFromJson(
  List? createScheduledNotificationInputNotificationType, [
  List<enums.CreateScheduledNotificationInputNotificationType>? defaultValue,
]) {
  if (createScheduledNotificationInputNotificationType == null) {
    return defaultValue ?? [];
  }

  return createScheduledNotificationInputNotificationType
      .map((e) => createScheduledNotificationInputNotificationTypeFromJson(
          e.toString()))
      .toList();
}

List<enums.CreateScheduledNotificationInputNotificationType>?
    createScheduledNotificationInputNotificationTypeNullableListFromJson(
  List? createScheduledNotificationInputNotificationType, [
  List<enums.CreateScheduledNotificationInputNotificationType>? defaultValue,
]) {
  if (createScheduledNotificationInputNotificationType == null) {
    return defaultValue;
  }

  return createScheduledNotificationInputNotificationType
      .map((e) => createScheduledNotificationInputNotificationTypeFromJson(
          e.toString()))
      .toList();
}

String? createScheduledNotificationInputIntervalNullableToJson(
    enums.CreateScheduledNotificationInputInterval?
        createScheduledNotificationInputInterval) {
  return createScheduledNotificationInputInterval?.value;
}

String? createScheduledNotificationInputIntervalToJson(
    enums.CreateScheduledNotificationInputInterval
        createScheduledNotificationInputInterval) {
  return createScheduledNotificationInputInterval.value;
}

enums.CreateScheduledNotificationInputInterval
    createScheduledNotificationInputIntervalFromJson(
  Object? createScheduledNotificationInputInterval, [
  enums.CreateScheduledNotificationInputInterval? defaultValue,
]) {
  return enums.CreateScheduledNotificationInputInterval.values.firstWhereOrNull(
          (e) => e.value == createScheduledNotificationInputInterval) ??
      defaultValue ??
      enums.CreateScheduledNotificationInputInterval.swaggerGeneratedUnknown;
}

enums.CreateScheduledNotificationInputInterval?
    createScheduledNotificationInputIntervalNullableFromJson(
  Object? createScheduledNotificationInputInterval, [
  enums.CreateScheduledNotificationInputInterval? defaultValue,
]) {
  if (createScheduledNotificationInputInterval == null) {
    return null;
  }
  return enums.CreateScheduledNotificationInputInterval.values.firstWhereOrNull(
          (e) => e.value == createScheduledNotificationInputInterval) ??
      defaultValue;
}

String createScheduledNotificationInputIntervalExplodedListToJson(
    List<enums.CreateScheduledNotificationInputInterval>?
        createScheduledNotificationInputInterval) {
  return createScheduledNotificationInputInterval
          ?.map((e) => e.value!)
          .join(',') ??
      '';
}

List<String> createScheduledNotificationInputIntervalListToJson(
    List<enums.CreateScheduledNotificationInputInterval>?
        createScheduledNotificationInputInterval) {
  if (createScheduledNotificationInputInterval == null) {
    return [];
  }

  return createScheduledNotificationInputInterval.map((e) => e.value!).toList();
}

List<enums.CreateScheduledNotificationInputInterval>
    createScheduledNotificationInputIntervalListFromJson(
  List? createScheduledNotificationInputInterval, [
  List<enums.CreateScheduledNotificationInputInterval>? defaultValue,
]) {
  if (createScheduledNotificationInputInterval == null) {
    return defaultValue ?? [];
  }

  return createScheduledNotificationInputInterval
      .map(
          (e) => createScheduledNotificationInputIntervalFromJson(e.toString()))
      .toList();
}

List<enums.CreateScheduledNotificationInputInterval>?
    createScheduledNotificationInputIntervalNullableListFromJson(
  List? createScheduledNotificationInputInterval, [
  List<enums.CreateScheduledNotificationInputInterval>? defaultValue,
]) {
  if (createScheduledNotificationInputInterval == null) {
    return defaultValue;
  }

  return createScheduledNotificationInputInterval
      .map(
          (e) => createScheduledNotificationInputIntervalFromJson(e.toString()))
      .toList();
}

String? createScheduledNotificationInputTargetGroupNullableToJson(
    enums.CreateScheduledNotificationInputTargetGroup?
        createScheduledNotificationInputTargetGroup) {
  return createScheduledNotificationInputTargetGroup?.value;
}

String? createScheduledNotificationInputTargetGroupToJson(
    enums.CreateScheduledNotificationInputTargetGroup
        createScheduledNotificationInputTargetGroup) {
  return createScheduledNotificationInputTargetGroup.value;
}

enums.CreateScheduledNotificationInputTargetGroup
    createScheduledNotificationInputTargetGroupFromJson(
  Object? createScheduledNotificationInputTargetGroup, [
  enums.CreateScheduledNotificationInputTargetGroup? defaultValue,
]) {
  return enums.CreateScheduledNotificationInputTargetGroup.values
          .firstWhereOrNull(
              (e) => e.value == createScheduledNotificationInputTargetGroup) ??
      defaultValue ??
      enums.CreateScheduledNotificationInputTargetGroup.swaggerGeneratedUnknown;
}

enums.CreateScheduledNotificationInputTargetGroup?
    createScheduledNotificationInputTargetGroupNullableFromJson(
  Object? createScheduledNotificationInputTargetGroup, [
  enums.CreateScheduledNotificationInputTargetGroup? defaultValue,
]) {
  if (createScheduledNotificationInputTargetGroup == null) {
    return null;
  }
  return enums.CreateScheduledNotificationInputTargetGroup.values
          .firstWhereOrNull(
              (e) => e.value == createScheduledNotificationInputTargetGroup) ??
      defaultValue;
}

String createScheduledNotificationInputTargetGroupExplodedListToJson(
    List<enums.CreateScheduledNotificationInputTargetGroup>?
        createScheduledNotificationInputTargetGroup) {
  return createScheduledNotificationInputTargetGroup
          ?.map((e) => e.value!)
          .join(',') ??
      '';
}

List<String> createScheduledNotificationInputTargetGroupListToJson(
    List<enums.CreateScheduledNotificationInputTargetGroup>?
        createScheduledNotificationInputTargetGroup) {
  if (createScheduledNotificationInputTargetGroup == null) {
    return [];
  }

  return createScheduledNotificationInputTargetGroup
      .map((e) => e.value!)
      .toList();
}

List<enums.CreateScheduledNotificationInputTargetGroup>
    createScheduledNotificationInputTargetGroupListFromJson(
  List? createScheduledNotificationInputTargetGroup, [
  List<enums.CreateScheduledNotificationInputTargetGroup>? defaultValue,
]) {
  if (createScheduledNotificationInputTargetGroup == null) {
    return defaultValue ?? [];
  }

  return createScheduledNotificationInputTargetGroup
      .map((e) =>
          createScheduledNotificationInputTargetGroupFromJson(e.toString()))
      .toList();
}

List<enums.CreateScheduledNotificationInputTargetGroup>?
    createScheduledNotificationInputTargetGroupNullableListFromJson(
  List? createScheduledNotificationInputTargetGroup, [
  List<enums.CreateScheduledNotificationInputTargetGroup>? defaultValue,
]) {
  if (createScheduledNotificationInputTargetGroup == null) {
    return defaultValue;
  }

  return createScheduledNotificationInputTargetGroup
      .map((e) =>
          createScheduledNotificationInputTargetGroupFromJson(e.toString()))
      .toList();
}

String? updateScheduledNotificationInputNotificationTypeNullableToJson(
    enums.UpdateScheduledNotificationInputNotificationType?
        updateScheduledNotificationInputNotificationType) {
  return updateScheduledNotificationInputNotificationType?.value;
}

String? updateScheduledNotificationInputNotificationTypeToJson(
    enums.UpdateScheduledNotificationInputNotificationType
        updateScheduledNotificationInputNotificationType) {
  return updateScheduledNotificationInputNotificationType.value;
}

enums.UpdateScheduledNotificationInputNotificationType
    updateScheduledNotificationInputNotificationTypeFromJson(
  Object? updateScheduledNotificationInputNotificationType, [
  enums.UpdateScheduledNotificationInputNotificationType? defaultValue,
]) {
  return enums.UpdateScheduledNotificationInputNotificationType.values
          .firstWhereOrNull((e) =>
              e.value == updateScheduledNotificationInputNotificationType) ??
      defaultValue ??
      enums.UpdateScheduledNotificationInputNotificationType
          .swaggerGeneratedUnknown;
}

enums.UpdateScheduledNotificationInputNotificationType?
    updateScheduledNotificationInputNotificationTypeNullableFromJson(
  Object? updateScheduledNotificationInputNotificationType, [
  enums.UpdateScheduledNotificationInputNotificationType? defaultValue,
]) {
  if (updateScheduledNotificationInputNotificationType == null) {
    return null;
  }
  return enums.UpdateScheduledNotificationInputNotificationType.values
          .firstWhereOrNull((e) =>
              e.value == updateScheduledNotificationInputNotificationType) ??
      defaultValue;
}

String updateScheduledNotificationInputNotificationTypeExplodedListToJson(
    List<enums.UpdateScheduledNotificationInputNotificationType>?
        updateScheduledNotificationInputNotificationType) {
  return updateScheduledNotificationInputNotificationType
          ?.map((e) => e.value!)
          .join(',') ??
      '';
}

List<String> updateScheduledNotificationInputNotificationTypeListToJson(
    List<enums.UpdateScheduledNotificationInputNotificationType>?
        updateScheduledNotificationInputNotificationType) {
  if (updateScheduledNotificationInputNotificationType == null) {
    return [];
  }

  return updateScheduledNotificationInputNotificationType
      .map((e) => e.value!)
      .toList();
}

List<enums.UpdateScheduledNotificationInputNotificationType>
    updateScheduledNotificationInputNotificationTypeListFromJson(
  List? updateScheduledNotificationInputNotificationType, [
  List<enums.UpdateScheduledNotificationInputNotificationType>? defaultValue,
]) {
  if (updateScheduledNotificationInputNotificationType == null) {
    return defaultValue ?? [];
  }

  return updateScheduledNotificationInputNotificationType
      .map((e) => updateScheduledNotificationInputNotificationTypeFromJson(
          e.toString()))
      .toList();
}

List<enums.UpdateScheduledNotificationInputNotificationType>?
    updateScheduledNotificationInputNotificationTypeNullableListFromJson(
  List? updateScheduledNotificationInputNotificationType, [
  List<enums.UpdateScheduledNotificationInputNotificationType>? defaultValue,
]) {
  if (updateScheduledNotificationInputNotificationType == null) {
    return defaultValue;
  }

  return updateScheduledNotificationInputNotificationType
      .map((e) => updateScheduledNotificationInputNotificationTypeFromJson(
          e.toString()))
      .toList();
}

String? updateScheduledNotificationInputIntervalNullableToJson(
    enums.UpdateScheduledNotificationInputInterval?
        updateScheduledNotificationInputInterval) {
  return updateScheduledNotificationInputInterval?.value;
}

String? updateScheduledNotificationInputIntervalToJson(
    enums.UpdateScheduledNotificationInputInterval
        updateScheduledNotificationInputInterval) {
  return updateScheduledNotificationInputInterval.value;
}

enums.UpdateScheduledNotificationInputInterval
    updateScheduledNotificationInputIntervalFromJson(
  Object? updateScheduledNotificationInputInterval, [
  enums.UpdateScheduledNotificationInputInterval? defaultValue,
]) {
  return enums.UpdateScheduledNotificationInputInterval.values.firstWhereOrNull(
          (e) => e.value == updateScheduledNotificationInputInterval) ??
      defaultValue ??
      enums.UpdateScheduledNotificationInputInterval.swaggerGeneratedUnknown;
}

enums.UpdateScheduledNotificationInputInterval?
    updateScheduledNotificationInputIntervalNullableFromJson(
  Object? updateScheduledNotificationInputInterval, [
  enums.UpdateScheduledNotificationInputInterval? defaultValue,
]) {
  if (updateScheduledNotificationInputInterval == null) {
    return null;
  }
  return enums.UpdateScheduledNotificationInputInterval.values.firstWhereOrNull(
          (e) => e.value == updateScheduledNotificationInputInterval) ??
      defaultValue;
}

String updateScheduledNotificationInputIntervalExplodedListToJson(
    List<enums.UpdateScheduledNotificationInputInterval>?
        updateScheduledNotificationInputInterval) {
  return updateScheduledNotificationInputInterval
          ?.map((e) => e.value!)
          .join(',') ??
      '';
}

List<String> updateScheduledNotificationInputIntervalListToJson(
    List<enums.UpdateScheduledNotificationInputInterval>?
        updateScheduledNotificationInputInterval) {
  if (updateScheduledNotificationInputInterval == null) {
    return [];
  }

  return updateScheduledNotificationInputInterval.map((e) => e.value!).toList();
}

List<enums.UpdateScheduledNotificationInputInterval>
    updateScheduledNotificationInputIntervalListFromJson(
  List? updateScheduledNotificationInputInterval, [
  List<enums.UpdateScheduledNotificationInputInterval>? defaultValue,
]) {
  if (updateScheduledNotificationInputInterval == null) {
    return defaultValue ?? [];
  }

  return updateScheduledNotificationInputInterval
      .map(
          (e) => updateScheduledNotificationInputIntervalFromJson(e.toString()))
      .toList();
}

List<enums.UpdateScheduledNotificationInputInterval>?
    updateScheduledNotificationInputIntervalNullableListFromJson(
  List? updateScheduledNotificationInputInterval, [
  List<enums.UpdateScheduledNotificationInputInterval>? defaultValue,
]) {
  if (updateScheduledNotificationInputInterval == null) {
    return defaultValue;
  }

  return updateScheduledNotificationInputInterval
      .map(
          (e) => updateScheduledNotificationInputIntervalFromJson(e.toString()))
      .toList();
}

String? updateScheduledNotificationInputTargetGroupNullableToJson(
    enums.UpdateScheduledNotificationInputTargetGroup?
        updateScheduledNotificationInputTargetGroup) {
  return updateScheduledNotificationInputTargetGroup?.value;
}

String? updateScheduledNotificationInputTargetGroupToJson(
    enums.UpdateScheduledNotificationInputTargetGroup
        updateScheduledNotificationInputTargetGroup) {
  return updateScheduledNotificationInputTargetGroup.value;
}

enums.UpdateScheduledNotificationInputTargetGroup
    updateScheduledNotificationInputTargetGroupFromJson(
  Object? updateScheduledNotificationInputTargetGroup, [
  enums.UpdateScheduledNotificationInputTargetGroup? defaultValue,
]) {
  return enums.UpdateScheduledNotificationInputTargetGroup.values
          .firstWhereOrNull(
              (e) => e.value == updateScheduledNotificationInputTargetGroup) ??
      defaultValue ??
      enums.UpdateScheduledNotificationInputTargetGroup.swaggerGeneratedUnknown;
}

enums.UpdateScheduledNotificationInputTargetGroup?
    updateScheduledNotificationInputTargetGroupNullableFromJson(
  Object? updateScheduledNotificationInputTargetGroup, [
  enums.UpdateScheduledNotificationInputTargetGroup? defaultValue,
]) {
  if (updateScheduledNotificationInputTargetGroup == null) {
    return null;
  }
  return enums.UpdateScheduledNotificationInputTargetGroup.values
          .firstWhereOrNull(
              (e) => e.value == updateScheduledNotificationInputTargetGroup) ??
      defaultValue;
}

String updateScheduledNotificationInputTargetGroupExplodedListToJson(
    List<enums.UpdateScheduledNotificationInputTargetGroup>?
        updateScheduledNotificationInputTargetGroup) {
  return updateScheduledNotificationInputTargetGroup
          ?.map((e) => e.value!)
          .join(',') ??
      '';
}

List<String> updateScheduledNotificationInputTargetGroupListToJson(
    List<enums.UpdateScheduledNotificationInputTargetGroup>?
        updateScheduledNotificationInputTargetGroup) {
  if (updateScheduledNotificationInputTargetGroup == null) {
    return [];
  }

  return updateScheduledNotificationInputTargetGroup
      .map((e) => e.value!)
      .toList();
}

List<enums.UpdateScheduledNotificationInputTargetGroup>
    updateScheduledNotificationInputTargetGroupListFromJson(
  List? updateScheduledNotificationInputTargetGroup, [
  List<enums.UpdateScheduledNotificationInputTargetGroup>? defaultValue,
]) {
  if (updateScheduledNotificationInputTargetGroup == null) {
    return defaultValue ?? [];
  }

  return updateScheduledNotificationInputTargetGroup
      .map((e) =>
          updateScheduledNotificationInputTargetGroupFromJson(e.toString()))
      .toList();
}

List<enums.UpdateScheduledNotificationInputTargetGroup>?
    updateScheduledNotificationInputTargetGroupNullableListFromJson(
  List? updateScheduledNotificationInputTargetGroup, [
  List<enums.UpdateScheduledNotificationInputTargetGroup>? defaultValue,
]) {
  if (updateScheduledNotificationInputTargetGroup == null) {
    return defaultValue;
  }

  return updateScheduledNotificationInputTargetGroup
      .map((e) =>
          updateScheduledNotificationInputTargetGroupFromJson(e.toString()))
      .toList();
}

String? apiV1UsersGetStatusNullableToJson(
    enums.ApiV1UsersGetStatus? apiV1UsersGetStatus) {
  return apiV1UsersGetStatus?.value;
}

String? apiV1UsersGetStatusToJson(
    enums.ApiV1UsersGetStatus apiV1UsersGetStatus) {
  return apiV1UsersGetStatus.value;
}

enums.ApiV1UsersGetStatus apiV1UsersGetStatusFromJson(
  Object? apiV1UsersGetStatus, [
  enums.ApiV1UsersGetStatus? defaultValue,
]) {
  return enums.ApiV1UsersGetStatus.values
          .firstWhereOrNull((e) => e.value == apiV1UsersGetStatus) ??
      defaultValue ??
      enums.ApiV1UsersGetStatus.swaggerGeneratedUnknown;
}

enums.ApiV1UsersGetStatus? apiV1UsersGetStatusNullableFromJson(
  Object? apiV1UsersGetStatus, [
  enums.ApiV1UsersGetStatus? defaultValue,
]) {
  if (apiV1UsersGetStatus == null) {
    return null;
  }
  return enums.ApiV1UsersGetStatus.values
          .firstWhereOrNull((e) => e.value == apiV1UsersGetStatus) ??
      defaultValue;
}

String apiV1UsersGetStatusExplodedListToJson(
    List<enums.ApiV1UsersGetStatus>? apiV1UsersGetStatus) {
  return apiV1UsersGetStatus?.map((e) => e.value!).join(',') ?? '';
}

List<String> apiV1UsersGetStatusListToJson(
    List<enums.ApiV1UsersGetStatus>? apiV1UsersGetStatus) {
  if (apiV1UsersGetStatus == null) {
    return [];
  }

  return apiV1UsersGetStatus.map((e) => e.value!).toList();
}

List<enums.ApiV1UsersGetStatus> apiV1UsersGetStatusListFromJson(
  List? apiV1UsersGetStatus, [
  List<enums.ApiV1UsersGetStatus>? defaultValue,
]) {
  if (apiV1UsersGetStatus == null) {
    return defaultValue ?? [];
  }

  return apiV1UsersGetStatus
      .map((e) => apiV1UsersGetStatusFromJson(e.toString()))
      .toList();
}

List<enums.ApiV1UsersGetStatus>? apiV1UsersGetStatusNullableListFromJson(
  List? apiV1UsersGetStatus, [
  List<enums.ApiV1UsersGetStatus>? defaultValue,
]) {
  if (apiV1UsersGetStatus == null) {
    return defaultValue;
  }

  return apiV1UsersGetStatus
      .map((e) => apiV1UsersGetStatusFromJson(e.toString()))
      .toList();
}

String? apiV1StatisticsUsersNewUsersRegisteredGetGroupByNullableToJson(
    enums.ApiV1StatisticsUsersNewUsersRegisteredGetGroupBy?
        apiV1StatisticsUsersNewUsersRegisteredGetGroupBy) {
  return apiV1StatisticsUsersNewUsersRegisteredGetGroupBy?.value;
}

String? apiV1StatisticsUsersNewUsersRegisteredGetGroupByToJson(
    enums.ApiV1StatisticsUsersNewUsersRegisteredGetGroupBy
        apiV1StatisticsUsersNewUsersRegisteredGetGroupBy) {
  return apiV1StatisticsUsersNewUsersRegisteredGetGroupBy.value;
}

enums.ApiV1StatisticsUsersNewUsersRegisteredGetGroupBy
    apiV1StatisticsUsersNewUsersRegisteredGetGroupByFromJson(
  Object? apiV1StatisticsUsersNewUsersRegisteredGetGroupBy, [
  enums.ApiV1StatisticsUsersNewUsersRegisteredGetGroupBy? defaultValue,
]) {
  return enums.ApiV1StatisticsUsersNewUsersRegisteredGetGroupBy.values
          .firstWhereOrNull((e) =>
              e.value == apiV1StatisticsUsersNewUsersRegisteredGetGroupBy) ??
      defaultValue ??
      enums.ApiV1StatisticsUsersNewUsersRegisteredGetGroupBy
          .swaggerGeneratedUnknown;
}

enums.ApiV1StatisticsUsersNewUsersRegisteredGetGroupBy?
    apiV1StatisticsUsersNewUsersRegisteredGetGroupByNullableFromJson(
  Object? apiV1StatisticsUsersNewUsersRegisteredGetGroupBy, [
  enums.ApiV1StatisticsUsersNewUsersRegisteredGetGroupBy? defaultValue,
]) {
  if (apiV1StatisticsUsersNewUsersRegisteredGetGroupBy == null) {
    return null;
  }
  return enums.ApiV1StatisticsUsersNewUsersRegisteredGetGroupBy.values
          .firstWhereOrNull((e) =>
              e.value == apiV1StatisticsUsersNewUsersRegisteredGetGroupBy) ??
      defaultValue;
}

String apiV1StatisticsUsersNewUsersRegisteredGetGroupByExplodedListToJson(
    List<enums.ApiV1StatisticsUsersNewUsersRegisteredGetGroupBy>?
        apiV1StatisticsUsersNewUsersRegisteredGetGroupBy) {
  return apiV1StatisticsUsersNewUsersRegisteredGetGroupBy
          ?.map((e) => e.value!)
          .join(',') ??
      '';
}

List<String> apiV1StatisticsUsersNewUsersRegisteredGetGroupByListToJson(
    List<enums.ApiV1StatisticsUsersNewUsersRegisteredGetGroupBy>?
        apiV1StatisticsUsersNewUsersRegisteredGetGroupBy) {
  if (apiV1StatisticsUsersNewUsersRegisteredGetGroupBy == null) {
    return [];
  }

  return apiV1StatisticsUsersNewUsersRegisteredGetGroupBy
      .map((e) => e.value!)
      .toList();
}

List<enums.ApiV1StatisticsUsersNewUsersRegisteredGetGroupBy>
    apiV1StatisticsUsersNewUsersRegisteredGetGroupByListFromJson(
  List? apiV1StatisticsUsersNewUsersRegisteredGetGroupBy, [
  List<enums.ApiV1StatisticsUsersNewUsersRegisteredGetGroupBy>? defaultValue,
]) {
  if (apiV1StatisticsUsersNewUsersRegisteredGetGroupBy == null) {
    return defaultValue ?? [];
  }

  return apiV1StatisticsUsersNewUsersRegisteredGetGroupBy
      .map((e) => apiV1StatisticsUsersNewUsersRegisteredGetGroupByFromJson(
          e.toString()))
      .toList();
}

List<enums.ApiV1StatisticsUsersNewUsersRegisteredGetGroupBy>?
    apiV1StatisticsUsersNewUsersRegisteredGetGroupByNullableListFromJson(
  List? apiV1StatisticsUsersNewUsersRegisteredGetGroupBy, [
  List<enums.ApiV1StatisticsUsersNewUsersRegisteredGetGroupBy>? defaultValue,
]) {
  if (apiV1StatisticsUsersNewUsersRegisteredGetGroupBy == null) {
    return defaultValue;
  }

  return apiV1StatisticsUsersNewUsersRegisteredGetGroupBy
      .map((e) => apiV1StatisticsUsersNewUsersRegisteredGetGroupByFromJson(
          e.toString()))
      .toList();
}

typedef $JsonFactory<T> = T Function(Map<String, dynamic> json);

class $CustomJsonDecoder {
  $CustomJsonDecoder(this.factories);

  final Map<Type, $JsonFactory> factories;

  dynamic decode<T>(dynamic entity) {
    if (entity is Iterable) {
      return _decodeList<T>(entity);
    }

    if (entity is T) {
      return entity;
    }

    if (isTypeOf<T, Map>()) {
      return entity;
    }

    if (isTypeOf<T, Iterable>()) {
      return entity;
    }

    if (entity is Map<String, dynamic>) {
      return _decodeMap<T>(entity);
    }

    return entity;
  }

  T _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! $JsonFactory<T>) {
      return throw "Could not find factory for type $T. Is '$T: $T.fromJsonFactory' included in the CustomJsonDecoder instance creation in bootstrapper.dart?";
    }

    return jsonFactory(values);
  }

  List<T> _decodeList<T>(Iterable values) =>
      values.where((v) => v != null).map<T>((v) => decode<T>(v) as T).toList();
}

class $JsonSerializableConverter extends chopper.JsonConverter {
  @override
  FutureOr<chopper.Response<ResultType>> convertResponse<ResultType, Item>(
      chopper.Response response) async {
    if (response.bodyString.isEmpty) {
      // In rare cases, when let's say 204 (no content) is returned -
      // we cannot decode the missing json with the result type specified
      return chopper.Response(response.base, null, error: response.error);
    }

    if (ResultType == String) {
      return response.copyWith();
    }

    if (ResultType == DateTime) {
      return response.copyWith(
          body: DateTime.parse((response.body as String).replaceAll('"', ''))
              as ResultType);
    }

    final jsonRes = await super.convertResponse(response);
    return jsonRes.copyWith<ResultType>(
        body: $jsonDecoder.decode<Item>(jsonRes.body) as ResultType);
  }
}

final $jsonDecoder = $CustomJsonDecoder(generatedMapping);

// ignore: unused_element
String? _dateToJson(DateTime? date) {
  if (date == null) {
    return null;
  }

  final year = date.year.toString();
  final month = date.month < 10 ? '0${date.month}' : date.month.toString();
  final day = date.day < 10 ? '0${date.day}' : date.day.toString();

  return '$year-$month-$day';
}

class Wrapped<T> {
  final T value;
  const Wrapped.value(this.value);
}
