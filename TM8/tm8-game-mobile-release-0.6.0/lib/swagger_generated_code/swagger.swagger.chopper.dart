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
  Future<Response<UserPaginatedResponse>> _apiV1UsersGet({
    num? page,
    num? limit,
    String? sort,
    required List<String>? roles,
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
  Future<Response<dynamic>> _apiV1UsersDelete(
      {required DeleteUsersInput? body}) {
    final Uri $url = Uri.parse('/api/v1/users');
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
  Future<Response<List<UserSearchResponse>>> _apiV1UsersSearchGet({
    required String? username,
    num? limit,
  }) {
    final Uri $url = Uri.parse('/api/v1/users/search');
    final Map<String, dynamic> $params = <String, dynamic>{
      'username': username,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<List<UserSearchResponse>, UserSearchResponse>($request);
  }

  @override
  Future<Response<GetMeUserResponse>> _apiV1UsersMeGet() {
    final Uri $url = Uri.parse('/api/v1/users/me');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<GetMeUserResponse, GetMeUserResponse>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1UsersMeDelete() {
    final Uri $url = Uri.parse('/api/v1/users/me');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<UserPaginatedResponse>> _apiV1UsersFriendsGet({
    String? username,
    num? page,
    num? limit,
  }) {
    final Uri $url = Uri.parse('/api/v1/users/friends');
    final Map<String, dynamic> $params = <String, dynamic>{
      'username': username,
      'page': page,
      'limit': limit,
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
  Future<Response<UserPaginatedResponse>> _apiV1UsersBlocksGet({
    num? page,
    num? limit,
  }) {
    final Uri $url = Uri.parse('/api/v1/users/blocks');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
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
  Future<Response<dynamic>> _apiV1UsersBlocksDelete(
      {required GetUsersByIdsParams? body}) {
    final Uri $url = Uri.parse('/api/v1/users/blocks');
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
  Future<Response<dynamic>> _apiV1UsersEmailPatch(
      {required ChangeEmailInput? body}) {
    final Uri $url = Uri.parse('/api/v1/users/email');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1UsersEmailConfirmPatch(
      {required VerifyEmailChangeInput? body}) {
    final Uri $url = Uri.parse('/api/v1/users/email/confirm');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1UsersPasswordPatch(
      {required ChangePasswordInput? body}) {
    final Uri $url = Uri.parse('/api/v1/users/password');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
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
  Future<Response<dynamic>> _apiV1UsersUsernamePatch(
      {required UpdateUsernameInput? body}) {
    final Uri $url = Uri.parse('/api/v1/users/username');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1UsersInfoPatch(
      {required ChangeUserInfoInput? body}) {
    final Uri $url = Uri.parse('/api/v1/users/info');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<SetUserFileResponse>> _apiV1UsersImagePatch(
      {List<int>? file}) {
    final Uri $url = Uri.parse('/api/v1/users/image');
    final List<PartValue> $parts = <PartValue>[
      PartValueFile<List<int>?>(
        'file',
        file,
      )
    ];
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
    );
    return client.send<SetUserFileResponse, SetUserFileResponse>($request);
  }

  @override
  Future<Response<SetUserFileResponse>> _apiV1UsersAudioIntroPatch(
      {List<int>? file}) {
    final Uri $url = Uri.parse('/api/v1/users/audio-intro');
    final List<PartValue> $parts = <PartValue>[
      PartValueFile<List<int>?>(
        'file',
        file,
      )
    ];
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
    );
    return client.send<SetUserFileResponse, SetUserFileResponse>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1UsersUserIdGameGamePost({
    required String? userId,
    required String? game,
  }) {
    final Uri $url = Uri.parse('/api/v1/users/${userId}/game/${game}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1UsersUserIdGameGameDelete({
    required String? userId,
    required String? game,
  }) {
    final Uri $url = Uri.parse('/api/v1/users/${userId}/game/${game}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<UserGameDataResponse>> _apiV1UsersPreferencesCallOfDutyPatch(
      {required SetCallOfDutyPreferencesInput? body}) {
    final Uri $url = Uri.parse('/api/v1/users/preferences/call-of-duty');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<UserGameDataResponse, UserGameDataResponse>($request);
  }

  @override
  Future<Response<UserGameDataResponse>> _apiV1UsersPreferencesApexLegendsPatch(
      {required SetApexLegendsPreferencesInput? body}) {
    final Uri $url = Uri.parse('/api/v1/users/preferences/apex-legends');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<UserGameDataResponse, UserGameDataResponse>($request);
  }

  @override
  Future<Response<UserGameDataResponse>>
      _apiV1UsersPreferencesRocketLeaguePatch(
          {required SetRocketLeaguePreferencesInput? body}) {
    final Uri $url = Uri.parse('/api/v1/users/preferences/rocket-league');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<UserGameDataResponse, UserGameDataResponse>($request);
  }

  @override
  Future<Response<UserGameDataResponse>> _apiV1UsersPreferencesFortnitePatch(
      {required SetFortnitePreferencesInput? body}) {
    final Uri $url = Uri.parse('/api/v1/users/preferences/fortnite');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<UserGameDataResponse, UserGameDataResponse>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1UsersPreferencesGamePlaytimePatch({
    required String? game,
    required SetGamePlaytimeInput? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/users/preferences/${game}/playtime');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1UsersPreferencesGameOnlineSchedulePatch({
    required String? game,
    required SetOnlineScheduleInput? body,
  }) {
    final Uri $url =
        Uri.parse('/api/v1/users/preferences/${game}/online-schedule');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1UsersPreferencesGameOnlineScheduleDelete(
      {required String? game}) {
    final Uri $url =
        Uri.parse('/api/v1/users/preferences/${game}/online-schedule');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1UsersUserIdFriendPost(
      {required String? userId}) {
    final Uri $url = Uri.parse('/api/v1/users/${userId}/friend');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1UsersUserIdFriendDelete(
      {required String? userId}) {
    final Uri $url = Uri.parse('/api/v1/users/${userId}/friend');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<CheckFriendshipResponse>> _apiV1UsersUserIdFriendCheckGet(
      {required String? userId}) {
    final Uri $url = Uri.parse('/api/v1/users/${userId}/friend/check');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<CheckFriendshipResponse, CheckFriendshipResponse>($request);
  }

  @override
  Future<Response<CheckBlockStatusResponse>> _apiV1UsersUserIdBlockCheckGet(
      {required String? userId}) {
    final Uri $url = Uri.parse('/api/v1/users/${userId}/block/check');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<CheckBlockStatusResponse, CheckBlockStatusResponse>($request);
  }

  @override
  Future<Response<UserProfileResponse>> _apiV1UsersUserIdProfileGet(
      {required String? userId}) {
    final Uri $url = Uri.parse('/api/v1/users/${userId}/profile');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<UserProfileResponse, UserProfileResponse>($request);
  }

  @override
  Future<Response<UserGamesResponse>> _apiV1UsersUserIdGamesGet(
      {required String? userId}) {
    final Uri $url = Uri.parse('/api/v1/users/${userId}/games');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<UserGamesResponse, UserGamesResponse>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1UsersUserIdBlockPost(
      {required String? userId}) {
    final Uri $url = Uri.parse('/api/v1/users/${userId}/block');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1UsersUserIdReportPost({
    required String? userId,
    required ReportUserInput? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/users/${userId}/report');
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
  Future<Response<dynamic>> _apiV1NotificationsTokenRefreshPost(
      {required NotificationRefreshTokenDto? body}) {
    final Uri $url = Uri.parse('/api/v1/notifications/token/refresh');
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
  Future<Response<dynamic>> _apiV1NotificationsMessagePost(
      {required CreateMessageNotificationDto? body}) {
    final Uri $url = Uri.parse('/api/v1/notifications/message');
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
  Future<Response<dynamic>> _apiV1NotificationsCallPost(
      {required CreateCallNotificationDto? body}) {
    final Uri $url = Uri.parse('/api/v1/notifications/call');
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
  Future<Response<UnreadNotificationsResponse>>
      _apiV1NotificationsUnreadCountGet() {
    final Uri $url = Uri.parse('/api/v1/notifications/unread/count');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<UnreadNotificationsResponse,
        UnreadNotificationsResponse>($request);
  }

  @override
  Future<Response<NotificationPaginatedResponse>> _apiV1NotificationsGet({
    num? page,
    num? limit,
  }) {
    final Uri $url = Uri.parse('/api/v1/notifications');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<NotificationPaginatedResponse,
        NotificationPaginatedResponse>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1NotificationsSettingsPatch(
      {required UpdateNotificationSettingsDto? body}) {
    final Uri $url = Uri.parse('/api/v1/notifications/settings');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<NotificationSettingsOptionResponse>>>
      _apiV1NotificationsSettingsOptionsGet() {
    final Uri $url = Uri.parse('/api/v1/notifications/settings/options');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<NotificationSettingsOptionResponse>,
        NotificationSettingsOptionResponse>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1NotificationsNotificationIdDelete(
      {required String? notificationId}) {
    final Uri $url = Uri.parse('/api/v1/notifications/${notificationId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<NotificationResponse>> _apiV1NotificationsNotificationIdGet(
      {required String? notificationId}) {
    final Uri $url = Uri.parse('/api/v1/notifications/${notificationId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<NotificationResponse, NotificationResponse>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1NotificationsNotificationIdReadPatch(
      {required String? notificationId}) {
    final Uri $url = Uri.parse('/api/v1/notifications/${notificationId}/read');
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1MatchesMatchIdFeedbackRatingPost({
    required String? matchId,
    required num? rating,
  }) {
    final Uri $url = Uri.parse('/api/v1/matches/${matchId}/feedback/${rating}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<CheckFeedbackGivenResponse>>
      _apiV1MatchesFeedbackUsersUserIdCheckGet({required String? userId}) {
    final Uri $url =
        Uri.parse('/api/v1/matches/feedback/users/${userId}/check');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<CheckFeedbackGivenResponse, CheckFeedbackGivenResponse>($request);
  }

  @override
  Future<Response<CheckMatchExistsResponse>> _apiV1MatchesCheckUserIdGet(
      {required String? userId}) {
    final Uri $url = Uri.parse('/api/v1/matches/check/${userId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<CheckMatchExistsResponse, CheckMatchExistsResponse>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1MatchmakingGamePost({required String? game}) {
    final Uri $url = Uri.parse('/api/v1/matchmaking/${game}');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<MatchmakingResultPaginatedResponse>>
      _apiV1MatchmakingGameResultsGet({
    num? page,
    num? limit,
    required String? game,
  }) {
    final Uri $url = Uri.parse('/api/v1/matchmaking/${game}/results');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<MatchmakingResultPaginatedResponse,
        MatchmakingResultPaginatedResponse>($request);
  }

  @override
  Future<Response<AcceptPotentialMatchResponse>>
      _apiV1MatchmakingGameAcceptPost({
    required String? game,
    required GetUserByIdParams? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/matchmaking/${game}/accept');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<AcceptPotentialMatchResponse,
        AcceptPotentialMatchResponse>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1MatchmakingGameRejectPost({
    required String? game,
    required GetUserByIdParams? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/matchmaking/${game}/reject');
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
  Future<Response<CreateChannelResponse>> _apiV1ChatChannelPost(
      {required CreateChannelInput? body}) {
    final Uri $url = Uri.parse('/api/v1/chat/channel');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<CreateChannelResponse, CreateChannelResponse>($request);
  }

  @override
  Future<Response<ChatChannelPaginatedResponse>> _apiV1ChatUserChannelsGet({
    num? page,
    num? limit,
    String? username,
  }) {
    final Uri $url = Uri.parse('/api/v1/chat/user/channels');
    final Map<String, dynamic> $params = <String, dynamic>{
      'page': page,
      'limit': limit,
      'username': username,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<ChatChannelPaginatedResponse,
        ChatChannelPaginatedResponse>($request);
  }

  @override
  Future<Response<ChatRefreshTokenResponse>> _apiV1ChatTokenRefreshPost() {
    final Uri $url = Uri.parse('/api/v1/chat/token/refresh');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client
        .send<ChatRefreshTokenResponse, ChatRefreshTokenResponse>($request);
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
  Future<Response<UserResponse>> _apiV1AuthRegisterPost(
      {required RegisterInput? body}) {
    final Uri $url = Uri.parse('/api/v1/auth/register');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<UserResponse, UserResponse>($request);
  }

  @override
  Future<Response<AuthResponse>> _apiV1AuthVerifyPhonePost(
      {required VerifyCodeInput? body}) {
    final Uri $url = Uri.parse('/api/v1/auth/verify-phone');
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
  Future<Response<dynamic>> _apiV1AuthResendCodePost(
      {required PhoneVerificationInput? body}) {
    final Uri $url = Uri.parse('/api/v1/auth/resend-code');
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
  Future<Response<AuthResponse>> _apiV1AuthGoogleVerifyPost(
      {required VerifyGoogleIdInput? body}) {
    final Uri $url = Uri.parse('/api/v1/auth/google/verify');
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
  Future<Response<dynamic>> _apiV1AuthEpicGamesSignInGet() {
    final Uri $url = Uri.parse('/api/v1/auth/epic-games/sign-in');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1AuthEpicGamesVerifyPost(
      {required EpicGamesVerifyInput? body}) {
    final Uri $url = Uri.parse('/api/v1/auth/epic-games/verify');
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
  Future<Response<dynamic>> _apiV1AuthEpicGamesDelete() {
    final Uri $url = Uri.parse('/api/v1/auth/epic-games');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
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
  Future<Response<dynamic>> _apiV1AuthDateOfBirthPatch(
      {required SetDateOfBirthInput? body}) {
    final Uri $url = Uri.parse('/api/v1/auth/date-of-birth');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<UserResponse>> _apiV1AuthSetPhoneNumberPatch(
      {required SetUserPhoneInput? body}) {
    final Uri $url = Uri.parse('/api/v1/auth/set-phone-number');
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
  Future<Response<AuthResponse>> _apiV1AuthAppleVerifyPost(
      {required VerifyAppleIdInput? body}) {
    final Uri $url = Uri.parse('/api/v1/auth/apple/verify');
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

  @override
  Future<Response<List<GameResponse>>> _apiV1GamesGet() {
    final Uri $url = Uri.parse('/api/v1/games');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<GameResponse>, GameResponse>($request);
  }

  @override
  Future<Response<List<GamePreferenceInputResponse>>>
      _apiV1GamesGamePreferenceFormGet({required String? game}) {
    final Uri $url = Uri.parse('/api/v1/games/${game}/preference-form');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<GamePreferenceInputResponse>,
        GamePreferenceInputResponse>($request);
  }
}
