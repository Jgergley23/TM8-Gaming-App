//Generated code

part of 'swagger.swagger.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$Swagger extends Swagger {
  _$Swagger([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = Swagger;

  @override
  Future<Response<HealthCheckResponse>> _get() {
    final Uri $url = Uri.parse('/');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<HealthCheckResponse, HealthCheckResponse>($request);
  }

  @override
  Future<Response<dynamic>> _exceptionsGet() {
    final Uri $url = Uri.parse('/exceptions');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<UserPaginatedResponse>> _apiV1UsersGet({
    num? page,
    num? limit,
    String? sort,
    String? roles,
    String? username,
    String? name,
    String? status,
  }) {
    final Uri $url = Uri.parse('/api/v1/users');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
      'sort': sort,
      'roles': roles,
      'username': username,
      'name': name,
      'status': status,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<UserPaginatedResponse, UserPaginatedResponse>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1UsersAdminPost(
      {required CreateAdminInput? body}) {
    final Uri $url = Uri.parse('/api/v1/users/admin');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<UserGroupResponse>>> _apiV1UsersGroupsGet() {
    final Uri $url = Uri.parse('/api/v1/users/groups');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<UserGroupResponse>, UserGroupResponse>($request);
  }

  @override
  Future<Response<List<UserResponse>>> _apiV1UsersUsernameUsernameGet(
      {required String? username}) {
    final Uri $url = Uri.parse('/api/v1/users/username/${username}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<UserResponse>, UserResponse>($request);
  }

  @override
  Future<Response<UserResponse>> _apiV1UsersUserIdGet(
      {required String? userId}) {
    final Uri $url = Uri.parse('/api/v1/users/${userId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<UserResponse, UserResponse>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1UsersUserIdDelete({required String? userId}) {
    final Uri $url = Uri.parse('/api/v1/users/${userId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<UserGameDataResponse>>> _apiV1UsersUserIdPreferencesGet({
    required String? userId,
    String? games,
  }) {
    final Uri $url = Uri.parse('/api/v1/users/${userId}/preferences');
    final Map<String, dynamic> $params = <String, dynamic>{'games': games};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<List<UserGameDataResponse>, UserGameDataResponse>($request);
  }

  @override
  Future<Response<UserResponse>> _apiV1UsersUserIdAdminNotePatch({
    required String? userId,
    required UserNoteInput? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/users/${userId}/admin-note');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<UserResponse, UserResponse>($request);
  }

  @override
  Future<Response<List<UserReportResponse>>> _apiV1UsersUserIdReportsGet(
      {required String? userId}) {
    final Uri $url = Uri.parse('/api/v1/users/${userId}/reports');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<UserReportResponse>, UserReportResponse>($request);
  }

  @override
  Future<Response<List<UserWarningTypeResponse>>> _apiV1UsersWarningTypesGet() {
    final Uri $url = Uri.parse('/api/v1/users/warning/types');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<List<UserWarningTypeResponse>, UserWarningTypeResponse>($request);
  }

  @override
  Future<Response<List<UserReportTypeResponse>>> _apiV1UsersReportTypesGet() {
    final Uri $url = Uri.parse('/api/v1/users/report/types');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<List<UserReportTypeResponse>, UserReportTypeResponse>($request);
  }

  @override
  Future<Response<List<UserResponse>>> _apiV1UsersWarningPatch(
      {required UserWarningInput? body}) {
    final Uri $url = Uri.parse('/api/v1/users/warning');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<List<UserResponse>, UserResponse>($request);
  }

  @override
  Future<Response<List<UserResponse>>> _apiV1UsersBanPatch(
      {required UserBanInput? body}) {
    final Uri $url = Uri.parse('/api/v1/users/ban');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<List<UserResponse>, UserResponse>($request);
  }

  @override
  Future<Response<List<UserResponse>>> _apiV1UsersSuspendPatch(
      {required UserSuspendInput? body}) {
    final Uri $url = Uri.parse('/api/v1/users/suspend');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<List<UserResponse>, UserResponse>($request);
  }

  @override
  Future<Response<List<UserResponse>>> _apiV1UsersResetPatch(
      {required UserResetInput? body}) {
    final Uri $url = Uri.parse('/api/v1/users/reset');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<List<UserResponse>, UserResponse>($request);
  }

  @override
  Future<Response<AuthResponse>> _apiV1AuthTokenRefreshPost() {
    final Uri $url = Uri.parse('/api/v1/auth/token/refresh');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<AuthResponse, AuthResponse>($request);
  }

  @override
  Future<Response<AuthResponse>> _apiV1AuthSignInPost(
      {required AuthLoginInput? body}) {
    final Uri $url = Uri.parse('/api/v1/auth/sign-in');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<AuthResponse, AuthResponse>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1AuthForgotPasswordPost(
      {required ForgotPasswordInput? body}) {
    final Uri $url = Uri.parse('/api/v1/auth/forgot-password');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1AuthForgotPasswordVerifyPost(
      {required VerifyCodeInput? body}) {
    final Uri $url = Uri.parse('/api/v1/auth/forgot-password/verify');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<AuthResponse>> _apiV1AuthForgotPasswordResetPost(
      {required ResetPasswordInput? body}) {
    final Uri $url = Uri.parse('/api/v1/auth/forgot-password/reset');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<AuthResponse, AuthResponse>($request);
  }

  @override
  Future<Response<StatisticsTotalCountResponse>>
      _apiV1StatisticsUsersTotalCountGet() {
    final Uri $url = Uri.parse('/api/v1/statistics/users/total-count');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<StatisticsTotalCountResponse,
        StatisticsTotalCountResponse>($request);
  }

  @override
  Future<Response<StatisticsOnboardingCompletionResponse>>
      _apiV1StatisticsUsersOnboardingCompletionGet() {
    final Uri $url =
        Uri.parse('/api/v1/statistics/users/onboarding-completion');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<StatisticsOnboardingCompletionResponse,
        StatisticsOnboardingCompletionResponse>($request);
  }

  @override
  Future<Response<StatisticsNewUsersRegisteredResponse>>
      _apiV1StatisticsUsersNewUsersRegisteredGet({
    required String? groupBy,
    required String? startDate,
    required String? endDate,
  }) {
    final Uri $url = Uri.parse('/api/v1/statistics/users/new-users-registered');
    final Map<String, dynamic> $params = <String, dynamic>{
      'groupBy': groupBy,
      'startDate': startDate,
      'endDate': endDate,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<StatisticsNewUsersRegisteredResponse,
        StatisticsNewUsersRegisteredResponse>($request);
  }

  @override
  Future<Response<UserGroupCountsResponse>> _apiV1StatisticsUsersGroupCountsGet(
      {String? userGroups}) {
    final Uri $url = Uri.parse('/api/v1/statistics/users/group-counts');
    final Map<String, dynamic> $params = <String, dynamic>{
      'userGroups': userGroups
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<UserGroupCountsResponse, UserGroupCountsResponse>($request);
  }

  @override
  Future<Response<ScheduledNotificationPaginatedResponse>>
      _apiV1ScheduledNotificationsGet({
    num? page,
    num? limit,
    String? sort,
    String? title,
    String? userGroups,
    String? types,
  }) {
    final Uri $url = Uri.parse('/api/v1/scheduled-notifications');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
      'sort': sort,
      'title': title,
      'userGroups': userGroups,
      'types': types,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<ScheduledNotificationPaginatedResponse,
        ScheduledNotificationPaginatedResponse>($request);
  }

  @override
  Future<Response<ScheduledNotificationResponse>>
      _apiV1ScheduledNotificationsPost(
          {required CreateScheduledNotificationInput? body}) {
    final Uri $url = Uri.parse('/api/v1/scheduled-notifications');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<ScheduledNotificationResponse,
        ScheduledNotificationResponse>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1ScheduledNotificationsDelete(
      {required DeleteScheduledNotificationsInput? body}) {
    final Uri $url = Uri.parse('/api/v1/scheduled-notifications');
    final $body = body;
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<NotificationTypeResponse>>>
      _apiV1ScheduledNotificationsTypesGet() {
    final Uri $url = Uri.parse('/api/v1/scheduled-notifications/types');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<NotificationTypeResponse>,
        NotificationTypeResponse>($request);
  }

  @override
  Future<Response<List<NotificationIntervalResponse>>>
      _apiV1ScheduledNotificationsIntervalsGet() {
    final Uri $url = Uri.parse('/api/v1/scheduled-notifications/intervals');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<NotificationIntervalResponse>,
        NotificationIntervalResponse>($request);
  }

  @override
  Future<Response<ScheduledNotificationResponse>>
      _apiV1ScheduledNotificationsNotificationIdPatch({
    required String? notificationId,
    required UpdateScheduledNotificationInput? body,
  }) {
    final Uri $url =
        Uri.parse('/api/v1/scheduled-notifications/${notificationId}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<ScheduledNotificationResponse,
        ScheduledNotificationResponse>($request);
  }

  @override
  Future<Response<ScheduledNotificationResponse>>
      _apiV1ScheduledNotificationsNotificationIdGet(
          {required String? notificationId}) {
    final Uri $url =
        Uri.parse('/api/v1/scheduled-notifications/${notificationId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<ScheduledNotificationResponse,
        ScheduledNotificationResponse>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1LandingPageContactFormPost(
      {required ContactFormInput? body}) {
    final Uri $url = Uri.parse('/api/v1/landing-page/contact-form');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }
}
