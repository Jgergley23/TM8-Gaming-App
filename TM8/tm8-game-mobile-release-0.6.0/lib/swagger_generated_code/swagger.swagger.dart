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
    required List<String>? roles,
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
    @Query('roles') required List<String>? roles,
    @Query('username') String? username,
    @Query('name') String? name,
    @Query('status') String? status,
  });

  ///
  Future<chopper.Response> apiV1UsersDelete({required DeleteUsersInput? body}) {
    return _apiV1UsersDelete(body: body);
  }

  ///
  @Delete(path: '/api/v1/users')
  Future<chopper.Response> _apiV1UsersDelete(
      {@Body() required DeleteUsersInput? body});

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
  ///@param username
  ///@param limit
  Future<chopper.Response<List<UserSearchResponse>>> apiV1UsersSearchGet({
    required String? username,
    num? limit,
  }) {
    generatedMapping.putIfAbsent(
        UserSearchResponse, () => UserSearchResponse.fromJsonFactory);

    return _apiV1UsersSearchGet(username: username, limit: limit);
  }

  ///
  ///@param username
  ///@param limit
  @Get(path: '/api/v1/users/search')
  Future<chopper.Response<List<UserSearchResponse>>> _apiV1UsersSearchGet({
    @Query('username') required String? username,
    @Query('limit') num? limit,
  });

  ///
  Future<chopper.Response<GetMeUserResponse>> apiV1UsersMeGet() {
    generatedMapping.putIfAbsent(
        GetMeUserResponse, () => GetMeUserResponse.fromJsonFactory);

    return _apiV1UsersMeGet();
  }

  ///
  @Get(path: '/api/v1/users/me')
  Future<chopper.Response<GetMeUserResponse>> _apiV1UsersMeGet();

  ///
  Future<chopper.Response> apiV1UsersMeDelete() {
    return _apiV1UsersMeDelete();
  }

  ///
  @Delete(path: '/api/v1/users/me')
  Future<chopper.Response> _apiV1UsersMeDelete();

  ///
  ///@param username Username filter
  ///@param page Page number
  ///@param limit Page size
  Future<chopper.Response<UserPaginatedResponse>> apiV1UsersFriendsGet({
    String? username,
    num? page,
    num? limit,
  }) {
    generatedMapping.putIfAbsent(
        UserPaginatedResponse, () => UserPaginatedResponse.fromJsonFactory);

    return _apiV1UsersFriendsGet(username: username, page: page, limit: limit);
  }

  ///
  ///@param username Username filter
  ///@param page Page number
  ///@param limit Page size
  @Get(path: '/api/v1/users/friends')
  Future<chopper.Response<UserPaginatedResponse>> _apiV1UsersFriendsGet({
    @Query('username') String? username,
    @Query('page') num? page,
    @Query('limit') num? limit,
  });

  ///
  ///@param page Page number
  ///@param limit Page size
  Future<chopper.Response<UserPaginatedResponse>> apiV1UsersBlocksGet({
    num? page,
    num? limit,
  }) {
    generatedMapping.putIfAbsent(
        UserPaginatedResponse, () => UserPaginatedResponse.fromJsonFactory);

    return _apiV1UsersBlocksGet(page: page, limit: limit);
  }

  ///
  ///@param page Page number
  ///@param limit Page size
  @Get(path: '/api/v1/users/blocks')
  Future<chopper.Response<UserPaginatedResponse>> _apiV1UsersBlocksGet({
    @Query('page') num? page,
    @Query('limit') num? limit,
  });

  ///
  Future<chopper.Response> apiV1UsersBlocksDelete(
      {required GetUsersByIdsParams? body}) {
    return _apiV1UsersBlocksDelete(body: body);
  }

  ///
  @Delete(path: '/api/v1/users/blocks')
  Future<chopper.Response> _apiV1UsersBlocksDelete(
      {@Body() required GetUsersByIdsParams? body});

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
  Future<chopper.Response> apiV1UsersEmailPatch(
      {required ChangeEmailInput? body}) {
    return _apiV1UsersEmailPatch(body: body);
  }

  ///
  @Patch(
    path: '/api/v1/users/email',
    optionalBody: true,
  )
  Future<chopper.Response> _apiV1UsersEmailPatch(
      {@Body() required ChangeEmailInput? body});

  ///
  Future<chopper.Response> apiV1UsersEmailConfirmPatch(
      {required VerifyEmailChangeInput? body}) {
    return _apiV1UsersEmailConfirmPatch(body: body);
  }

  ///
  @Patch(
    path: '/api/v1/users/email/confirm',
    optionalBody: true,
  )
  Future<chopper.Response> _apiV1UsersEmailConfirmPatch(
      {@Body() required VerifyEmailChangeInput? body});

  ///
  Future<chopper.Response> apiV1UsersPasswordPatch(
      {required ChangePasswordInput? body}) {
    return _apiV1UsersPasswordPatch(body: body);
  }

  ///
  @Patch(
    path: '/api/v1/users/password',
    optionalBody: true,
  )
  Future<chopper.Response> _apiV1UsersPasswordPatch(
      {@Body() required ChangePasswordInput? body});

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
  Future<chopper.Response> apiV1UsersUsernamePatch(
      {required UpdateUsernameInput? body}) {
    return _apiV1UsersUsernamePatch(body: body);
  }

  ///
  @Patch(
    path: '/api/v1/users/username',
    optionalBody: true,
  )
  Future<chopper.Response> _apiV1UsersUsernamePatch(
      {@Body() required UpdateUsernameInput? body});

  ///
  Future<chopper.Response> apiV1UsersInfoPatch(
      {required ChangeUserInfoInput? body}) {
    return _apiV1UsersInfoPatch(body: body);
  }

  ///
  @Patch(
    path: '/api/v1/users/info',
    optionalBody: true,
  )
  Future<chopper.Response> _apiV1UsersInfoPatch(
      {@Body() required ChangeUserInfoInput? body});

  ///
  Future<chopper.Response<SetUserFileResponse>> apiV1UsersImagePatch(
      {List<int>? file}) {
    generatedMapping.putIfAbsent(
        SetUserFileResponse, () => SetUserFileResponse.fromJsonFactory);

    return _apiV1UsersImagePatch(file: file);
  }

  ///
  @Patch(
    path: '/api/v1/users/image',
    optionalBody: true,
  )
  @Multipart()
  Future<chopper.Response<SetUserFileResponse>> _apiV1UsersImagePatch(
      {@PartFile() List<int>? file});

  ///
  Future<chopper.Response<SetUserFileResponse>> apiV1UsersAudioIntroPatch(
      {List<int>? file}) {
    generatedMapping.putIfAbsent(
        SetUserFileResponse, () => SetUserFileResponse.fromJsonFactory);

    return _apiV1UsersAudioIntroPatch(file: file);
  }

  ///
  @Patch(
    path: '/api/v1/users/audio-intro',
    optionalBody: true,
  )
  @Multipart()
  Future<chopper.Response<SetUserFileResponse>> _apiV1UsersAudioIntroPatch(
      {@PartFile() List<int>? file});

  ///
  ///@param userId User ID
  ///@param game Game name
  Future<chopper.Response> apiV1UsersUserIdGameGamePost({
    required String? userId,
    required String? game,
  }) {
    return _apiV1UsersUserIdGameGamePost(userId: userId, game: game);
  }

  ///
  ///@param userId User ID
  ///@param game Game name
  @Post(
    path: '/api/v1/users/{userId}/game/{game}',
    optionalBody: true,
  )
  Future<chopper.Response> _apiV1UsersUserIdGameGamePost({
    @Path('userId') required String? userId,
    @Path('game') required String? game,
  });

  ///
  ///@param userId User ID
  ///@param game Game name
  Future<chopper.Response> apiV1UsersUserIdGameGameDelete({
    required String? userId,
    required String? game,
  }) {
    return _apiV1UsersUserIdGameGameDelete(userId: userId, game: game);
  }

  ///
  ///@param userId User ID
  ///@param game Game name
  @Delete(path: '/api/v1/users/{userId}/game/{game}')
  Future<chopper.Response> _apiV1UsersUserIdGameGameDelete({
    @Path('userId') required String? userId,
    @Path('game') required String? game,
  });

  ///
  Future<chopper.Response<UserGameDataResponse>>
      apiV1UsersPreferencesCallOfDutyPatch(
          {required SetCallOfDutyPreferencesInput? body}) {
    generatedMapping.putIfAbsent(
        UserGameDataResponse, () => UserGameDataResponse.fromJsonFactory);

    return _apiV1UsersPreferencesCallOfDutyPatch(body: body);
  }

  ///
  @Patch(
    path: '/api/v1/users/preferences/call-of-duty',
    optionalBody: true,
  )
  Future<chopper.Response<UserGameDataResponse>>
      _apiV1UsersPreferencesCallOfDutyPatch(
          {@Body() required SetCallOfDutyPreferencesInput? body});

  ///
  Future<chopper.Response<UserGameDataResponse>>
      apiV1UsersPreferencesApexLegendsPatch(
          {required SetApexLegendsPreferencesInput? body}) {
    generatedMapping.putIfAbsent(
        UserGameDataResponse, () => UserGameDataResponse.fromJsonFactory);

    return _apiV1UsersPreferencesApexLegendsPatch(body: body);
  }

  ///
  @Patch(
    path: '/api/v1/users/preferences/apex-legends',
    optionalBody: true,
  )
  Future<chopper.Response<UserGameDataResponse>>
      _apiV1UsersPreferencesApexLegendsPatch(
          {@Body() required SetApexLegendsPreferencesInput? body});

  ///
  Future<chopper.Response<UserGameDataResponse>>
      apiV1UsersPreferencesRocketLeaguePatch(
          {required SetRocketLeaguePreferencesInput? body}) {
    generatedMapping.putIfAbsent(
        UserGameDataResponse, () => UserGameDataResponse.fromJsonFactory);

    return _apiV1UsersPreferencesRocketLeaguePatch(body: body);
  }

  ///
  @Patch(
    path: '/api/v1/users/preferences/rocket-league',
    optionalBody: true,
  )
  Future<chopper.Response<UserGameDataResponse>>
      _apiV1UsersPreferencesRocketLeaguePatch(
          {@Body() required SetRocketLeaguePreferencesInput? body});

  ///
  Future<chopper.Response<UserGameDataResponse>>
      apiV1UsersPreferencesFortnitePatch(
          {required SetFortnitePreferencesInput? body}) {
    generatedMapping.putIfAbsent(
        UserGameDataResponse, () => UserGameDataResponse.fromJsonFactory);

    return _apiV1UsersPreferencesFortnitePatch(body: body);
  }

  ///
  @Patch(
    path: '/api/v1/users/preferences/fortnite',
    optionalBody: true,
  )
  Future<chopper.Response<UserGameDataResponse>>
      _apiV1UsersPreferencesFortnitePatch(
          {@Body() required SetFortnitePreferencesInput? body});

  ///
  ///@param game Game name
  Future<chopper.Response> apiV1UsersPreferencesGamePlaytimePatch({
    required String? game,
    required SetGamePlaytimeInput? body,
  }) {
    return _apiV1UsersPreferencesGamePlaytimePatch(game: game, body: body);
  }

  ///
  ///@param game Game name
  @Patch(
    path: '/api/v1/users/preferences/{game}/playtime',
    optionalBody: true,
  )
  Future<chopper.Response> _apiV1UsersPreferencesGamePlaytimePatch({
    @Path('game') required String? game,
    @Body() required SetGamePlaytimeInput? body,
  });

  ///
  ///@param game Game name
  Future<chopper.Response> apiV1UsersPreferencesGameOnlineSchedulePatch({
    required String? game,
    required SetOnlineScheduleInput? body,
  }) {
    return _apiV1UsersPreferencesGameOnlineSchedulePatch(
        game: game, body: body);
  }

  ///
  ///@param game Game name
  @Patch(
    path: '/api/v1/users/preferences/{game}/online-schedule',
    optionalBody: true,
  )
  Future<chopper.Response> _apiV1UsersPreferencesGameOnlineSchedulePatch({
    @Path('game') required String? game,
    @Body() required SetOnlineScheduleInput? body,
  });

  ///
  ///@param game Game name
  Future<chopper.Response> apiV1UsersPreferencesGameOnlineScheduleDelete(
      {required String? game}) {
    return _apiV1UsersPreferencesGameOnlineScheduleDelete(game: game);
  }

  ///
  ///@param game Game name
  @Delete(path: '/api/v1/users/preferences/{game}/online-schedule')
  Future<chopper.Response> _apiV1UsersPreferencesGameOnlineScheduleDelete(
      {@Path('game') required String? game});

  ///
  ///@param userId User ID
  Future<chopper.Response> apiV1UsersUserIdFriendPost(
      {required String? userId}) {
    return _apiV1UsersUserIdFriendPost(userId: userId);
  }

  ///
  ///@param userId User ID
  @Post(
    path: '/api/v1/users/{userId}/friend',
    optionalBody: true,
  )
  Future<chopper.Response> _apiV1UsersUserIdFriendPost(
      {@Path('userId') required String? userId});

  ///
  ///@param userId User ID
  Future<chopper.Response> apiV1UsersUserIdFriendDelete(
      {required String? userId}) {
    return _apiV1UsersUserIdFriendDelete(userId: userId);
  }

  ///
  ///@param userId User ID
  @Delete(path: '/api/v1/users/{userId}/friend')
  Future<chopper.Response> _apiV1UsersUserIdFriendDelete(
      {@Path('userId') required String? userId});

  ///
  ///@param userId User ID
  Future<chopper.Response<CheckFriendshipResponse>>
      apiV1UsersUserIdFriendCheckGet({required String? userId}) {
    generatedMapping.putIfAbsent(
        CheckFriendshipResponse, () => CheckFriendshipResponse.fromJsonFactory);

    return _apiV1UsersUserIdFriendCheckGet(userId: userId);
  }

  ///
  ///@param userId User ID
  @Get(path: '/api/v1/users/{userId}/friend/check')
  Future<chopper.Response<CheckFriendshipResponse>>
      _apiV1UsersUserIdFriendCheckGet(
          {@Path('userId') required String? userId});

  ///
  ///@param userId User ID
  Future<chopper.Response<CheckBlockStatusResponse>>
      apiV1UsersUserIdBlockCheckGet({required String? userId}) {
    generatedMapping.putIfAbsent(CheckBlockStatusResponse,
        () => CheckBlockStatusResponse.fromJsonFactory);

    return _apiV1UsersUserIdBlockCheckGet(userId: userId);
  }

  ///
  ///@param userId User ID
  @Get(path: '/api/v1/users/{userId}/block/check')
  Future<chopper.Response<CheckBlockStatusResponse>>
      _apiV1UsersUserIdBlockCheckGet({@Path('userId') required String? userId});

  ///
  ///@param userId User ID
  Future<chopper.Response<UserProfileResponse>> apiV1UsersUserIdProfileGet(
      {required String? userId}) {
    generatedMapping.putIfAbsent(
        UserProfileResponse, () => UserProfileResponse.fromJsonFactory);

    return _apiV1UsersUserIdProfileGet(userId: userId);
  }

  ///
  ///@param userId User ID
  @Get(path: '/api/v1/users/{userId}/profile')
  Future<chopper.Response<UserProfileResponse>> _apiV1UsersUserIdProfileGet(
      {@Path('userId') required String? userId});

  ///
  ///@param userId User ID
  Future<chopper.Response<UserGamesResponse>> apiV1UsersUserIdGamesGet(
      {required String? userId}) {
    generatedMapping.putIfAbsent(
        UserGamesResponse, () => UserGamesResponse.fromJsonFactory);

    return _apiV1UsersUserIdGamesGet(userId: userId);
  }

  ///
  ///@param userId User ID
  @Get(path: '/api/v1/users/{userId}/games')
  Future<chopper.Response<UserGamesResponse>> _apiV1UsersUserIdGamesGet(
      {@Path('userId') required String? userId});

  ///
  ///@param userId User ID
  Future<chopper.Response> apiV1UsersUserIdBlockPost(
      {required String? userId}) {
    return _apiV1UsersUserIdBlockPost(userId: userId);
  }

  ///
  ///@param userId User ID
  @Post(
    path: '/api/v1/users/{userId}/block',
    optionalBody: true,
  )
  Future<chopper.Response> _apiV1UsersUserIdBlockPost(
      {@Path('userId') required String? userId});

  ///
  ///@param userId User ID
  Future<chopper.Response> apiV1UsersUserIdReportPost({
    required String? userId,
    required ReportUserInput? body,
  }) {
    return _apiV1UsersUserIdReportPost(userId: userId, body: body);
  }

  ///
  ///@param userId User ID
  @Post(
    path: '/api/v1/users/{userId}/report',
    optionalBody: true,
  )
  Future<chopper.Response> _apiV1UsersUserIdReportPost({
    @Path('userId') required String? userId,
    @Body() required ReportUserInput? body,
  });

  ///
  Future<chopper.Response> apiV1NotificationsTokenRefreshPost(
      {required NotificationRefreshTokenDto? body}) {
    return _apiV1NotificationsTokenRefreshPost(body: body);
  }

  ///
  @Post(
    path: '/api/v1/notifications/token/refresh',
    optionalBody: true,
  )
  Future<chopper.Response> _apiV1NotificationsTokenRefreshPost(
      {@Body() required NotificationRefreshTokenDto? body});

  ///
  Future<chopper.Response> apiV1NotificationsMessagePost(
      {required CreateMessageNotificationDto? body}) {
    return _apiV1NotificationsMessagePost(body: body);
  }

  ///
  @Post(
    path: '/api/v1/notifications/message',
    optionalBody: true,
  )
  Future<chopper.Response> _apiV1NotificationsMessagePost(
      {@Body() required CreateMessageNotificationDto? body});

  ///
  Future<chopper.Response> apiV1NotificationsCallPost(
      {required CreateCallNotificationDto? body}) {
    return _apiV1NotificationsCallPost(body: body);
  }

  ///
  @Post(
    path: '/api/v1/notifications/call',
    optionalBody: true,
  )
  Future<chopper.Response> _apiV1NotificationsCallPost(
      {@Body() required CreateCallNotificationDto? body});

  ///
  Future<chopper.Response<UnreadNotificationsResponse>>
      apiV1NotificationsUnreadCountGet() {
    generatedMapping.putIfAbsent(UnreadNotificationsResponse,
        () => UnreadNotificationsResponse.fromJsonFactory);

    return _apiV1NotificationsUnreadCountGet();
  }

  ///
  @Get(path: '/api/v1/notifications/unread/count')
  Future<chopper.Response<UnreadNotificationsResponse>>
      _apiV1NotificationsUnreadCountGet();

  ///
  ///@param page Page number
  ///@param limit Page size
  Future<chopper.Response<NotificationPaginatedResponse>>
      apiV1NotificationsGet({
    num? page,
    num? limit,
  }) {
    generatedMapping.putIfAbsent(NotificationPaginatedResponse,
        () => NotificationPaginatedResponse.fromJsonFactory);

    return _apiV1NotificationsGet(page: page, limit: limit);
  }

  ///
  ///@param page Page number
  ///@param limit Page size
  @Get(path: '/api/v1/notifications')
  Future<chopper.Response<NotificationPaginatedResponse>>
      _apiV1NotificationsGet({
    @Query('page') num? page,
    @Query('limit') num? limit,
  });

  ///
  Future<chopper.Response> apiV1NotificationsSettingsPatch(
      {required UpdateNotificationSettingsDto? body}) {
    return _apiV1NotificationsSettingsPatch(body: body);
  }

  ///
  @Patch(
    path: '/api/v1/notifications/settings',
    optionalBody: true,
  )
  Future<chopper.Response> _apiV1NotificationsSettingsPatch(
      {@Body() required UpdateNotificationSettingsDto? body});

  ///
  Future<chopper.Response<List<NotificationSettingsOptionResponse>>>
      apiV1NotificationsSettingsOptionsGet() {
    generatedMapping.putIfAbsent(NotificationSettingsOptionResponse,
        () => NotificationSettingsOptionResponse.fromJsonFactory);

    return _apiV1NotificationsSettingsOptionsGet();
  }

  ///
  @Get(path: '/api/v1/notifications/settings/options')
  Future<chopper.Response<List<NotificationSettingsOptionResponse>>>
      _apiV1NotificationsSettingsOptionsGet();

  ///
  ///@param notificationId Notification ID
  Future<chopper.Response> apiV1NotificationsNotificationIdDelete(
      {required String? notificationId}) {
    return _apiV1NotificationsNotificationIdDelete(
        notificationId: notificationId);
  }

  ///
  ///@param notificationId Notification ID
  @Delete(path: '/api/v1/notifications/{notificationId}')
  Future<chopper.Response> _apiV1NotificationsNotificationIdDelete(
      {@Path('notificationId') required String? notificationId});

  ///
  ///@param notificationId Notification ID
  Future<chopper.Response<NotificationResponse>>
      apiV1NotificationsNotificationIdGet({required String? notificationId}) {
    generatedMapping.putIfAbsent(
        NotificationResponse, () => NotificationResponse.fromJsonFactory);

    return _apiV1NotificationsNotificationIdGet(notificationId: notificationId);
  }

  ///
  ///@param notificationId Notification ID
  @Get(path: '/api/v1/notifications/{notificationId}')
  Future<chopper.Response<NotificationResponse>>
      _apiV1NotificationsNotificationIdGet(
          {@Path('notificationId') required String? notificationId});

  ///
  ///@param notificationId Notification ID
  Future<chopper.Response> apiV1NotificationsNotificationIdReadPatch(
      {required String? notificationId}) {
    return _apiV1NotificationsNotificationIdReadPatch(
        notificationId: notificationId);
  }

  ///
  ///@param notificationId Notification ID
  @Patch(
    path: '/api/v1/notifications/{notificationId}/read',
    optionalBody: true,
  )
  Future<chopper.Response> _apiV1NotificationsNotificationIdReadPatch(
      {@Path('notificationId') required String? notificationId});

  ///
  ///@param matchId Match ID
  ///@param rating Rating
  Future<chopper.Response> apiV1MatchesMatchIdFeedbackRatingPost({
    required String? matchId,
    required num? rating,
  }) {
    return _apiV1MatchesMatchIdFeedbackRatingPost(
        matchId: matchId, rating: rating);
  }

  ///
  ///@param matchId Match ID
  ///@param rating Rating
  @Post(
    path: '/api/v1/matches/{matchId}/feedback/{rating}',
    optionalBody: true,
  )
  Future<chopper.Response> _apiV1MatchesMatchIdFeedbackRatingPost({
    @Path('matchId') required String? matchId,
    @Path('rating') required num? rating,
  });

  ///
  ///@param userId User ID
  Future<chopper.Response<CheckFeedbackGivenResponse>>
      apiV1MatchesFeedbackUsersUserIdCheckGet({required String? userId}) {
    generatedMapping.putIfAbsent(CheckFeedbackGivenResponse,
        () => CheckFeedbackGivenResponse.fromJsonFactory);

    return _apiV1MatchesFeedbackUsersUserIdCheckGet(userId: userId);
  }

  ///
  ///@param userId User ID
  @Get(path: '/api/v1/matches/feedback/users/{userId}/check')
  Future<chopper.Response<CheckFeedbackGivenResponse>>
      _apiV1MatchesFeedbackUsersUserIdCheckGet(
          {@Path('userId') required String? userId});

  ///
  ///@param userId User ID
  Future<chopper.Response<CheckMatchExistsResponse>> apiV1MatchesCheckUserIdGet(
      {required String? userId}) {
    generatedMapping.putIfAbsent(CheckMatchExistsResponse,
        () => CheckMatchExistsResponse.fromJsonFactory);

    return _apiV1MatchesCheckUserIdGet(userId: userId);
  }

  ///
  ///@param userId User ID
  @Get(path: '/api/v1/matches/check/{userId}')
  Future<chopper.Response<CheckMatchExistsResponse>>
      _apiV1MatchesCheckUserIdGet({@Path('userId') required String? userId});

  ///
  ///@param game Game name
  Future<chopper.Response> apiV1MatchmakingGamePost({required String? game}) {
    return _apiV1MatchmakingGamePost(game: game);
  }

  ///
  ///@param game Game name
  @Post(
    path: '/api/v1/matchmaking/{game}',
    optionalBody: true,
  )
  Future<chopper.Response> _apiV1MatchmakingGamePost(
      {@Path('game') required String? game});

  ///
  ///@param page Page number
  ///@param limit Page size
  ///@param game Game name
  Future<chopper.Response<MatchmakingResultPaginatedResponse>>
      apiV1MatchmakingGameResultsGet({
    num? page,
    num? limit,
    required String? game,
  }) {
    generatedMapping.putIfAbsent(MatchmakingResultPaginatedResponse,
        () => MatchmakingResultPaginatedResponse.fromJsonFactory);

    return _apiV1MatchmakingGameResultsGet(
        page: page, limit: limit, game: game);
  }

  ///
  ///@param page Page number
  ///@param limit Page size
  ///@param game Game name
  @Get(path: '/api/v1/matchmaking/{game}/results')
  Future<chopper.Response<MatchmakingResultPaginatedResponse>>
      _apiV1MatchmakingGameResultsGet({
    @Query('page') num? page,
    @Query('limit') num? limit,
    @Path('game') required String? game,
  });

  ///
  ///@param game Game name
  Future<chopper.Response<AcceptPotentialMatchResponse>>
      apiV1MatchmakingGameAcceptPost({
    required String? game,
    required GetUserByIdParams? body,
  }) {
    generatedMapping.putIfAbsent(AcceptPotentialMatchResponse,
        () => AcceptPotentialMatchResponse.fromJsonFactory);

    return _apiV1MatchmakingGameAcceptPost(game: game, body: body);
  }

  ///
  ///@param game Game name
  @Post(
    path: '/api/v1/matchmaking/{game}/accept',
    optionalBody: true,
  )
  Future<chopper.Response<AcceptPotentialMatchResponse>>
      _apiV1MatchmakingGameAcceptPost({
    @Path('game') required String? game,
    @Body() required GetUserByIdParams? body,
  });

  ///
  ///@param game Game name
  Future<chopper.Response> apiV1MatchmakingGameRejectPost({
    required String? game,
    required GetUserByIdParams? body,
  }) {
    return _apiV1MatchmakingGameRejectPost(game: game, body: body);
  }

  ///
  ///@param game Game name
  @Post(
    path: '/api/v1/matchmaking/{game}/reject',
    optionalBody: true,
  )
  Future<chopper.Response> _apiV1MatchmakingGameRejectPost({
    @Path('game') required String? game,
    @Body() required GetUserByIdParams? body,
  });

  ///
  Future<chopper.Response<CreateChannelResponse>> apiV1ChatChannelPost(
      {required CreateChannelInput? body}) {
    generatedMapping.putIfAbsent(
        CreateChannelResponse, () => CreateChannelResponse.fromJsonFactory);

    return _apiV1ChatChannelPost(body: body);
  }

  ///
  @Post(
    path: '/api/v1/chat/channel',
    optionalBody: true,
  )
  Future<chopper.Response<CreateChannelResponse>> _apiV1ChatChannelPost(
      {@Body() required CreateChannelInput? body});

  ///
  ///@param page Page number
  ///@param limit Page size
  ///@param username
  Future<chopper.Response<ChatChannelPaginatedResponse>>
      apiV1ChatUserChannelsGet({
    num? page,
    num? limit,
    String? username,
  }) {
    generatedMapping.putIfAbsent(ChatChannelPaginatedResponse,
        () => ChatChannelPaginatedResponse.fromJsonFactory);

    return _apiV1ChatUserChannelsGet(
        page: page, limit: limit, username: username);
  }

  ///
  ///@param page Page number
  ///@param limit Page size
  ///@param username
  @Get(path: '/api/v1/chat/user/channels')
  Future<chopper.Response<ChatChannelPaginatedResponse>>
      _apiV1ChatUserChannelsGet({
    @Query('page') num? page,
    @Query('limit') num? limit,
    @Query('username') String? username,
  });

  ///
  Future<chopper.Response<ChatRefreshTokenResponse>>
      apiV1ChatTokenRefreshPost() {
    generatedMapping.putIfAbsent(ChatRefreshTokenResponse,
        () => ChatRefreshTokenResponse.fromJsonFactory);

    return _apiV1ChatTokenRefreshPost();
  }

  ///
  @Post(
    path: '/api/v1/chat/token/refresh',
    optionalBody: true,
  )
  Future<chopper.Response<ChatRefreshTokenResponse>>
      _apiV1ChatTokenRefreshPost();

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
  Future<chopper.Response<UserResponse>> apiV1AuthRegisterPost(
      {required RegisterInput? body}) {
    generatedMapping.putIfAbsent(
        UserResponse, () => UserResponse.fromJsonFactory);

    return _apiV1AuthRegisterPost(body: body);
  }

  ///
  @Post(
    path: '/api/v1/auth/register',
    optionalBody: true,
  )
  Future<chopper.Response<UserResponse>> _apiV1AuthRegisterPost(
      {@Body() required RegisterInput? body});

  ///
  Future<chopper.Response<AuthResponse>> apiV1AuthVerifyPhonePost(
      {required VerifyCodeInput? body}) {
    generatedMapping.putIfAbsent(
        AuthResponse, () => AuthResponse.fromJsonFactory);

    return _apiV1AuthVerifyPhonePost(body: body);
  }

  ///
  @Post(
    path: '/api/v1/auth/verify-phone',
    optionalBody: true,
  )
  Future<chopper.Response<AuthResponse>> _apiV1AuthVerifyPhonePost(
      {@Body() required VerifyCodeInput? body});

  ///
  Future<chopper.Response> apiV1AuthResendCodePost(
      {required PhoneVerificationInput? body}) {
    return _apiV1AuthResendCodePost(body: body);
  }

  ///
  @Post(
    path: '/api/v1/auth/resend-code',
    optionalBody: true,
  )
  Future<chopper.Response> _apiV1AuthResendCodePost(
      {@Body() required PhoneVerificationInput? body});

  ///
  Future<chopper.Response<AuthResponse>> apiV1AuthGoogleVerifyPost(
      {required VerifyGoogleIdInput? body}) {
    generatedMapping.putIfAbsent(
        AuthResponse, () => AuthResponse.fromJsonFactory);

    return _apiV1AuthGoogleVerifyPost(body: body);
  }

  ///
  @Post(
    path: '/api/v1/auth/google/verify',
    optionalBody: true,
  )
  Future<chopper.Response<AuthResponse>> _apiV1AuthGoogleVerifyPost(
      {@Body() required VerifyGoogleIdInput? body});

  ///
  Future<chopper.Response> apiV1AuthEpicGamesSignInGet() {
    return _apiV1AuthEpicGamesSignInGet();
  }

  ///
  @Get(path: '/api/v1/auth/epic-games/sign-in')
  Future<chopper.Response> _apiV1AuthEpicGamesSignInGet();

  ///
  Future<chopper.Response> apiV1AuthEpicGamesVerifyPost(
      {required EpicGamesVerifyInput? body}) {
    return _apiV1AuthEpicGamesVerifyPost(body: body);
  }

  ///
  @Post(
    path: '/api/v1/auth/epic-games/verify',
    optionalBody: true,
  )
  Future<chopper.Response> _apiV1AuthEpicGamesVerifyPost(
      {@Body() required EpicGamesVerifyInput? body});

  ///
  Future<chopper.Response> apiV1AuthEpicGamesDelete() {
    return _apiV1AuthEpicGamesDelete();
  }

  ///
  @Delete(path: '/api/v1/auth/epic-games')
  Future<chopper.Response> _apiV1AuthEpicGamesDelete();

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
  Future<chopper.Response> apiV1AuthDateOfBirthPatch(
      {required SetDateOfBirthInput? body}) {
    return _apiV1AuthDateOfBirthPatch(body: body);
  }

  ///
  @Patch(
    path: '/api/v1/auth/date-of-birth',
    optionalBody: true,
  )
  Future<chopper.Response> _apiV1AuthDateOfBirthPatch(
      {@Body() required SetDateOfBirthInput? body});

  ///
  Future<chopper.Response<UserResponse>> apiV1AuthSetPhoneNumberPatch(
      {required SetUserPhoneInput? body}) {
    generatedMapping.putIfAbsent(
        UserResponse, () => UserResponse.fromJsonFactory);

    return _apiV1AuthSetPhoneNumberPatch(body: body);
  }

  ///
  @Patch(
    path: '/api/v1/auth/set-phone-number',
    optionalBody: true,
  )
  Future<chopper.Response<UserResponse>> _apiV1AuthSetPhoneNumberPatch(
      {@Body() required SetUserPhoneInput? body});

  ///
  Future<chopper.Response<AuthResponse>> apiV1AuthAppleVerifyPost(
      {required VerifyAppleIdInput? body}) {
    generatedMapping.putIfAbsent(
        AuthResponse, () => AuthResponse.fromJsonFactory);

    return _apiV1AuthAppleVerifyPost(body: body);
  }

  ///
  @Post(
    path: '/api/v1/auth/apple/verify',
    optionalBody: true,
  )
  Future<chopper.Response<AuthResponse>> _apiV1AuthAppleVerifyPost(
      {@Body() required VerifyAppleIdInput? body});

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

  ///
  Future<chopper.Response<List<GameResponse>>> apiV1GamesGet() {
    generatedMapping.putIfAbsent(
        GameResponse, () => GameResponse.fromJsonFactory);

    return _apiV1GamesGet();
  }

  ///
  @Get(path: '/api/v1/games')
  Future<chopper.Response<List<GameResponse>>> _apiV1GamesGet();

  ///
  ///@param game Game name
  Future<chopper.Response<List<GamePreferenceInputResponse>>>
      apiV1GamesGamePreferenceFormGet({required String? game}) {
    generatedMapping.putIfAbsent(GamePreferenceInputResponse,
        () => GamePreferenceInputResponse.fromJsonFactory);

    return _apiV1GamesGamePreferenceFormGet(game: game);
  }

  ///
  ///@param game Game name
  @Get(path: '/api/v1/games/{game}/preference-form')
  Future<chopper.Response<List<GamePreferenceInputResponse>>>
      _apiV1GamesGamePreferenceFormGet({@Path('game') required String? game});
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

  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  @JsonKey(name: 'description', includeIfNull: false)
  final String description;
  @JsonKey(name: 'version', includeIfNull: false)
  final String version;
  static const fromJsonFactory = _$HealthCheckResponseFromJson;

  @override
  bool operator ==(Object other) {
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

  @JsonKey(name: 'title', includeIfNull: false)
  final String title;
  @JsonKey(name: 'description', includeIfNull: false)
  final String description;
  @JsonKey(
    name: 'targetGroup',
    includeIfNull: false,
    toJson: scheduledNotificationDataResponseTargetGroupToJson,
    fromJson: scheduledNotificationDataResponseTargetGroupFromJson,
  )
  final enums.ScheduledNotificationDataResponseTargetGroup targetGroup;
  @JsonKey(
    name: 'notificationType',
    includeIfNull: false,
    toJson: scheduledNotificationDataResponseNotificationTypeToJson,
    fromJson: scheduledNotificationDataResponseNotificationTypeFromJson,
  )
  final enums.ScheduledNotificationDataResponseNotificationType
      notificationType;
  static const fromJsonFactory = _$ScheduledNotificationDataResponseFromJson;

  @override
  bool operator ==(Object other) {
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

  @JsonKey(name: '_id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'date', includeIfNull: false)
  final DateTime date;
  @JsonKey(name: 'interval', includeIfNull: false)
  final String interval;
  @JsonKey(name: 'openedBy', includeIfNull: false)
  final double openedBy;
  @JsonKey(name: 'receivedBy', includeIfNull: false)
  final double receivedBy;
  @JsonKey(name: 'uniqueId', includeIfNull: false)
  final String uniqueId;
  @JsonKey(name: 'users', includeIfNull: false, defaultValue: <String>[])
  final List<String> users;
  @JsonKey(name: 'createdAt', includeIfNull: false)
  final DateTime createdAt;
  @JsonKey(name: 'updatedAt', includeIfNull: false)
  final DateTime updatedAt;
  @JsonKey(name: 'data', includeIfNull: false)
  final ScheduledNotificationDataResponse data;
  static const fromJsonFactory = _$ScheduledNotificationResponseFromJson;

  @override
  bool operator ==(Object other) {
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

  @JsonKey(name: 'page', includeIfNull: false)
  final double page;
  @JsonKey(name: 'limit', includeIfNull: false)
  final double limit;
  @JsonKey(name: 'itemCount', includeIfNull: false)
  final double itemCount;
  @JsonKey(name: 'pageCount', includeIfNull: false)
  final double pageCount;
  @JsonKey(name: 'hasPreviousPage', includeIfNull: false)
  final bool hasPreviousPage;
  @JsonKey(name: 'hasNextPage', includeIfNull: false)
  final bool hasNextPage;
  static const fromJsonFactory = _$PaginationMetaResponseFromJson;

  @override
  bool operator ==(Object other) {
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

  @JsonKey(
      name: 'items',
      includeIfNull: false,
      defaultValue: <ScheduledNotificationResponse>[])
  final List<ScheduledNotificationResponse> items;
  @JsonKey(name: 'meta', includeIfNull: false)
  final PaginationMetaResponse meta;
  static const fromJsonFactory =
      _$ScheduledNotificationPaginatedResponseFromJson;

  @override
  bool operator ==(Object other) {
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
    includeIfNull: false,
    toJson: notificationTypeResponseKeyToJson,
    fromJson: notificationTypeResponseKeyFromJson,
  )
  final enums.NotificationTypeResponseKey key;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  static const fromJsonFactory = _$NotificationTypeResponseFromJson;

  @override
  bool operator ==(Object other) {
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
    includeIfNull: false,
    toJson: notificationIntervalResponseKeyToJson,
    fromJson: notificationIntervalResponseKeyFromJson,
  )
  final enums.NotificationIntervalResponseKey key;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  static const fromJsonFactory = _$NotificationIntervalResponseFromJson;

  @override
  bool operator ==(Object other) {
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

  @JsonKey(name: 'title', includeIfNull: false)
  final String title;
  @JsonKey(name: 'description', includeIfNull: false)
  final String description;
  @JsonKey(name: 'redirectScreen', includeIfNull: false)
  final String redirectScreen;
  @JsonKey(
    name: 'notificationType',
    includeIfNull: false,
    toJson: createScheduledNotificationInputNotificationTypeToJson,
    fromJson: createScheduledNotificationInputNotificationTypeFromJson,
  )
  final enums.CreateScheduledNotificationInputNotificationType notificationType;
  @JsonKey(name: 'individualUserId', includeIfNull: false)
  final String? individualUserId;
  @JsonKey(name: 'date', includeIfNull: false)
  final String date;
  @JsonKey(
    name: 'interval',
    includeIfNull: false,
    toJson: createScheduledNotificationInputIntervalToJson,
    fromJson: createScheduledNotificationInputIntervalFromJson,
  )
  final enums.CreateScheduledNotificationInputInterval interval;
  @JsonKey(
    name: 'targetGroup',
    includeIfNull: false,
    toJson: createScheduledNotificationInputTargetGroupToJson,
    fromJson: createScheduledNotificationInputTargetGroupFromJson,
  )
  final enums.CreateScheduledNotificationInputTargetGroup targetGroup;
  static const fromJsonFactory = _$CreateScheduledNotificationInputFromJson;

  @override
  bool operator ==(Object other) {
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
      String? date,
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
      Wrapped<String>? date,
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

  @JsonKey(
      name: 'notificationIds', includeIfNull: false, defaultValue: <String>[])
  final List<String> notificationIds;
  static const fromJsonFactory = _$DeleteScheduledNotificationsInputFromJson;

  @override
  bool operator ==(Object other) {
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

  @JsonKey(name: 'title', includeIfNull: false)
  final String? title;
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'redirectScreen', includeIfNull: false)
  final String? redirectScreen;
  @JsonKey(
    name: 'notificationType',
    includeIfNull: false,
    toJson: updateScheduledNotificationInputNotificationTypeNullableToJson,
    fromJson: updateScheduledNotificationInputNotificationTypeNullableFromJson,
  )
  final enums.UpdateScheduledNotificationInputNotificationType?
      notificationType;
  @JsonKey(name: 'individualUserId', includeIfNull: false)
  final String? individualUserId;
  @JsonKey(name: 'date', includeIfNull: false)
  final DateTime? date;
  @JsonKey(
    name: 'interval',
    includeIfNull: false,
    toJson: updateScheduledNotificationInputIntervalNullableToJson,
    fromJson: updateScheduledNotificationInputIntervalNullableFromJson,
  )
  final enums.UpdateScheduledNotificationInputInterval? interval;
  @JsonKey(
    name: 'targetGroup',
    includeIfNull: false,
    toJson: updateScheduledNotificationInputTargetGroupNullableToJson,
    fromJson: updateScheduledNotificationInputTargetGroupNullableFromJson,
  )
  final enums.UpdateScheduledNotificationInputTargetGroup? targetGroup;
  static const fromJsonFactory = _$UpdateScheduledNotificationInputFromJson;

  @override
  bool operator ==(Object other) {
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
    includeIfNull: false,
    toJson: tGMDExceptionResponseOriginToJson,
    fromJson: tGMDExceptionResponseOriginFromJson,
  )
  final enums.TGMDExceptionResponseOrigin origin;
  @JsonKey(name: 'status', includeIfNull: false)
  final double status;
  @JsonKey(name: 'code', includeIfNull: false)
  final String code;
  @JsonKey(name: 'exception', includeIfNull: false)
  final String exception;
  @JsonKey(name: 'detail', includeIfNull: false)
  final String detail;
  static const fromJsonFactory = _$TGMDExceptionResponseFromJson;

  @override
  bool operator ==(Object other) {
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
    includeIfNull: false,
    toJson: userStatusResponseTypeToJson,
    fromJson: userStatusResponseTypeFromJson,
  )
  final enums.UserStatusResponseType type;
  @JsonKey(name: 'note', includeIfNull: false)
  final String? note;
  @JsonKey(name: 'until', includeIfNull: false)
  final DateTime? until;
  static const fromJsonFactory = _$UserStatusResponseFromJson;

  @override
  bool operator ==(Object other) {
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
class UserRatingResponse {
  const UserRatingResponse({
    required this.average,
    required this.ratings,
  });

  factory UserRatingResponse.fromJson(Map<String, dynamic> json) =>
      _$UserRatingResponseFromJson(json);

  static const toJsonFactory = _$UserRatingResponseToJson;
  Map<String, dynamic> toJson() => _$UserRatingResponseToJson(this);

  @JsonKey(name: 'average', includeIfNull: false)
  final double average;
  @JsonKey(name: 'ratings', includeIfNull: false, defaultValue: <double>[])
  final List<double> ratings;
  static const fromJsonFactory = _$UserRatingResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserRatingResponse &&
            (identical(other.average, average) ||
                const DeepCollectionEquality()
                    .equals(other.average, average)) &&
            (identical(other.ratings, ratings) ||
                const DeepCollectionEquality().equals(other.ratings, ratings)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(average) ^
      const DeepCollectionEquality().hash(ratings) ^
      runtimeType.hashCode;
}

extension $UserRatingResponseExtension on UserRatingResponse {
  UserRatingResponse copyWith({double? average, List<double>? ratings}) {
    return UserRatingResponse(
        average: average ?? this.average, ratings: ratings ?? this.ratings);
  }

  UserRatingResponse copyWithWrapped(
      {Wrapped<double>? average, Wrapped<List<double>>? ratings}) {
    return UserRatingResponse(
        average: (average != null ? average.value : this.average),
        ratings: (ratings != null ? ratings.value : this.ratings));
  }
}

@JsonSerializable(explicitToJson: true)
class UserResponse {
  const UserResponse({
    required this.id,
    this.name,
    this.email,
    this.description,
    this.username,
    this.gender,
    this.role,
    this.signupType,
    this.timezone,
    this.country,
    this.note,
    this.photoKey,
    this.audioKey,
    this.phoneNumber,
    this.epicGamesUsername,
    this.phoneVerified,
    this.createdAt,
    this.updatedAt,
    this.dateOfBirth,
    this.lastLogin,
    this.status,
    this.rating,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  static const toJsonFactory = _$UserResponseToJson;
  Map<String, dynamic> toJson() => _$UserResponseToJson(this);

  @JsonKey(name: '_id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'email', includeIfNull: false)
  final String? email;
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'username', includeIfNull: false)
  final String? username;
  @JsonKey(
    name: 'gender',
    includeIfNull: false,
    toJson: userResponseGenderNullableToJson,
    fromJson: userResponseGenderNullableFromJson,
  )
  final enums.UserResponseGender? gender;
  @JsonKey(
    name: 'role',
    includeIfNull: false,
    toJson: userResponseRoleNullableToJson,
    fromJson: userResponseRoleNullableFromJson,
  )
  final enums.UserResponseRole? role;
  @JsonKey(
    name: 'signupType',
    includeIfNull: false,
    toJson: userResponseSignupTypeNullableToJson,
    fromJson: userResponseSignupTypeNullableFromJson,
  )
  final enums.UserResponseSignupType? signupType;
  @JsonKey(name: 'timezone', includeIfNull: false)
  final String? timezone;
  @JsonKey(name: 'country', includeIfNull: false)
  final String? country;
  @JsonKey(name: 'note', includeIfNull: false)
  final String? note;
  @JsonKey(name: 'photoKey', includeIfNull: false)
  final String? photoKey;
  @JsonKey(name: 'audioKey', includeIfNull: false)
  final String? audioKey;
  @JsonKey(name: 'phoneNumber', includeIfNull: false)
  final String? phoneNumber;
  @JsonKey(name: 'epicGamesUsername', includeIfNull: false)
  final String? epicGamesUsername;
  @JsonKey(name: 'phoneVerified', includeIfNull: false)
  final bool? phoneVerified;
  @JsonKey(name: 'createdAt', includeIfNull: false)
  final DateTime? createdAt;
  @JsonKey(name: 'updatedAt', includeIfNull: false)
  final DateTime? updatedAt;
  @JsonKey(name: 'dateOfBirth', includeIfNull: false)
  final DateTime? dateOfBirth;
  @JsonKey(name: 'lastLogin', includeIfNull: false)
  final DateTime? lastLogin;
  @JsonKey(name: 'status', includeIfNull: false)
  final UserStatusResponse? status;
  @JsonKey(name: 'rating', includeIfNull: false)
  final UserRatingResponse? rating;
  static const fromJsonFactory = _$UserResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserResponse &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
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
            (identical(other.audioKey, audioKey) ||
                const DeepCollectionEquality()
                    .equals(other.audioKey, audioKey)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality()
                    .equals(other.phoneNumber, phoneNumber)) &&
            (identical(other.epicGamesUsername, epicGamesUsername) ||
                const DeepCollectionEquality()
                    .equals(other.epicGamesUsername, epicGamesUsername)) &&
            (identical(other.phoneVerified, phoneVerified) ||
                const DeepCollectionEquality()
                    .equals(other.phoneVerified, phoneVerified)) &&
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
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.rating, rating) ||
                const DeepCollectionEquality().equals(other.rating, rating)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(gender) ^
      const DeepCollectionEquality().hash(role) ^
      const DeepCollectionEquality().hash(signupType) ^
      const DeepCollectionEquality().hash(timezone) ^
      const DeepCollectionEquality().hash(country) ^
      const DeepCollectionEquality().hash(note) ^
      const DeepCollectionEquality().hash(photoKey) ^
      const DeepCollectionEquality().hash(audioKey) ^
      const DeepCollectionEquality().hash(phoneNumber) ^
      const DeepCollectionEquality().hash(epicGamesUsername) ^
      const DeepCollectionEquality().hash(phoneVerified) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(dateOfBirth) ^
      const DeepCollectionEquality().hash(lastLogin) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(rating) ^
      runtimeType.hashCode;
}

extension $UserResponseExtension on UserResponse {
  UserResponse copyWith(
      {String? id,
      String? name,
      String? email,
      String? description,
      String? username,
      enums.UserResponseGender? gender,
      enums.UserResponseRole? role,
      enums.UserResponseSignupType? signupType,
      String? timezone,
      String? country,
      String? note,
      String? photoKey,
      String? audioKey,
      String? phoneNumber,
      String? epicGamesUsername,
      bool? phoneVerified,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? dateOfBirth,
      DateTime? lastLogin,
      UserStatusResponse? status,
      UserRatingResponse? rating}) {
    return UserResponse(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        description: description ?? this.description,
        username: username ?? this.username,
        gender: gender ?? this.gender,
        role: role ?? this.role,
        signupType: signupType ?? this.signupType,
        timezone: timezone ?? this.timezone,
        country: country ?? this.country,
        note: note ?? this.note,
        photoKey: photoKey ?? this.photoKey,
        audioKey: audioKey ?? this.audioKey,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        epicGamesUsername: epicGamesUsername ?? this.epicGamesUsername,
        phoneVerified: phoneVerified ?? this.phoneVerified,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        lastLogin: lastLogin ?? this.lastLogin,
        status: status ?? this.status,
        rating: rating ?? this.rating);
  }

  UserResponse copyWithWrapped(
      {Wrapped<String>? id,
      Wrapped<String?>? name,
      Wrapped<String?>? email,
      Wrapped<String?>? description,
      Wrapped<String?>? username,
      Wrapped<enums.UserResponseGender?>? gender,
      Wrapped<enums.UserResponseRole?>? role,
      Wrapped<enums.UserResponseSignupType?>? signupType,
      Wrapped<String?>? timezone,
      Wrapped<String?>? country,
      Wrapped<String?>? note,
      Wrapped<String?>? photoKey,
      Wrapped<String?>? audioKey,
      Wrapped<String?>? phoneNumber,
      Wrapped<String?>? epicGamesUsername,
      Wrapped<bool?>? phoneVerified,
      Wrapped<DateTime?>? createdAt,
      Wrapped<DateTime?>? updatedAt,
      Wrapped<DateTime?>? dateOfBirth,
      Wrapped<DateTime?>? lastLogin,
      Wrapped<UserStatusResponse?>? status,
      Wrapped<UserRatingResponse?>? rating}) {
    return UserResponse(
        id: (id != null ? id.value : this.id),
        name: (name != null ? name.value : this.name),
        email: (email != null ? email.value : this.email),
        description:
            (description != null ? description.value : this.description),
        username: (username != null ? username.value : this.username),
        gender: (gender != null ? gender.value : this.gender),
        role: (role != null ? role.value : this.role),
        signupType: (signupType != null ? signupType.value : this.signupType),
        timezone: (timezone != null ? timezone.value : this.timezone),
        country: (country != null ? country.value : this.country),
        note: (note != null ? note.value : this.note),
        photoKey: (photoKey != null ? photoKey.value : this.photoKey),
        audioKey: (audioKey != null ? audioKey.value : this.audioKey),
        phoneNumber:
            (phoneNumber != null ? phoneNumber.value : this.phoneNumber),
        epicGamesUsername: (epicGamesUsername != null
            ? epicGamesUsername.value
            : this.epicGamesUsername),
        phoneVerified:
            (phoneVerified != null ? phoneVerified.value : this.phoneVerified),
        createdAt: (createdAt != null ? createdAt.value : this.createdAt),
        updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
        dateOfBirth:
            (dateOfBirth != null ? dateOfBirth.value : this.dateOfBirth),
        lastLogin: (lastLogin != null ? lastLogin.value : this.lastLogin),
        status: (status != null ? status.value : this.status),
        rating: (rating != null ? rating.value : this.rating));
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

  @JsonKey(name: 'items', includeIfNull: false, defaultValue: <UserResponse>[])
  final List<UserResponse> items;
  @JsonKey(name: 'meta', includeIfNull: false)
  final PaginationMetaResponse meta;
  static const fromJsonFactory = _$UserPaginatedResponseFromJson;

  @override
  bool operator ==(Object other) {
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

  @JsonKey(name: 'fullName', includeIfNull: false)
  final String fullName;
  @JsonKey(name: 'email', includeIfNull: false)
  final String email;
  static const fromJsonFactory = _$CreateAdminInputFromJson;

  @override
  bool operator ==(Object other) {
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
    includeIfNull: false,
    toJson: userGroupResponseKeyToJson,
    fromJson: userGroupResponseKeyFromJson,
  )
  final enums.UserGroupResponseKey key;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  static const fromJsonFactory = _$UserGroupResponseFromJson;

  @override
  bool operator ==(Object other) {
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
class UserSearchResponse {
  const UserSearchResponse({
    required this.id,
    required this.username,
    required this.friend,
    this.photoKey,
  });

  factory UserSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$UserSearchResponseFromJson(json);

  static const toJsonFactory = _$UserSearchResponseToJson;
  Map<String, dynamic> toJson() => _$UserSearchResponseToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'username', includeIfNull: false)
  final String username;
  @JsonKey(name: 'friend', includeIfNull: false)
  final bool friend;
  @JsonKey(name: 'photoKey', includeIfNull: false)
  final String? photoKey;
  static const fromJsonFactory = _$UserSearchResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserSearchResponse &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.friend, friend) ||
                const DeepCollectionEquality().equals(other.friend, friend)) &&
            (identical(other.photoKey, photoKey) ||
                const DeepCollectionEquality()
                    .equals(other.photoKey, photoKey)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(friend) ^
      const DeepCollectionEquality().hash(photoKey) ^
      runtimeType.hashCode;
}

extension $UserSearchResponseExtension on UserSearchResponse {
  UserSearchResponse copyWith(
      {String? id, String? username, bool? friend, String? photoKey}) {
    return UserSearchResponse(
        id: id ?? this.id,
        username: username ?? this.username,
        friend: friend ?? this.friend,
        photoKey: photoKey ?? this.photoKey);
  }

  UserSearchResponse copyWithWrapped(
      {Wrapped<String>? id,
      Wrapped<String>? username,
      Wrapped<bool>? friend,
      Wrapped<String?>? photoKey}) {
    return UserSearchResponse(
        id: (id != null ? id.value : this.id),
        username: (username != null ? username.value : this.username),
        friend: (friend != null ? friend.value : this.friend),
        photoKey: (photoKey != null ? photoKey.value : this.photoKey));
  }
}

@JsonSerializable(explicitToJson: true)
class UserNotificationSettingsResponse {
  const UserNotificationSettingsResponse({
    required this.enabled,
    required this.match,
    required this.message,
    required this.friendAdded,
    required this.news,
    required this.reminders,
  });

  factory UserNotificationSettingsResponse.fromJson(
          Map<String, dynamic> json) =>
      _$UserNotificationSettingsResponseFromJson(json);

  static const toJsonFactory = _$UserNotificationSettingsResponseToJson;
  Map<String, dynamic> toJson() =>
      _$UserNotificationSettingsResponseToJson(this);

  @JsonKey(name: 'enabled', includeIfNull: false)
  final bool enabled;
  @JsonKey(name: 'match', includeIfNull: false)
  final bool match;
  @JsonKey(name: 'message', includeIfNull: false)
  final bool message;
  @JsonKey(name: 'friendAdded', includeIfNull: false)
  final bool friendAdded;
  @JsonKey(name: 'news', includeIfNull: false)
  final bool news;
  @JsonKey(name: 'reminders', includeIfNull: false)
  final bool reminders;
  static const fromJsonFactory = _$UserNotificationSettingsResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserNotificationSettingsResponse &&
            (identical(other.enabled, enabled) ||
                const DeepCollectionEquality()
                    .equals(other.enabled, enabled)) &&
            (identical(other.match, match) ||
                const DeepCollectionEquality().equals(other.match, match)) &&
            (identical(other.message, message) ||
                const DeepCollectionEquality()
                    .equals(other.message, message)) &&
            (identical(other.friendAdded, friendAdded) ||
                const DeepCollectionEquality()
                    .equals(other.friendAdded, friendAdded)) &&
            (identical(other.news, news) ||
                const DeepCollectionEquality().equals(other.news, news)) &&
            (identical(other.reminders, reminders) ||
                const DeepCollectionEquality()
                    .equals(other.reminders, reminders)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(enabled) ^
      const DeepCollectionEquality().hash(match) ^
      const DeepCollectionEquality().hash(message) ^
      const DeepCollectionEquality().hash(friendAdded) ^
      const DeepCollectionEquality().hash(news) ^
      const DeepCollectionEquality().hash(reminders) ^
      runtimeType.hashCode;
}

extension $UserNotificationSettingsResponseExtension
    on UserNotificationSettingsResponse {
  UserNotificationSettingsResponse copyWith(
      {bool? enabled,
      bool? match,
      bool? message,
      bool? friendAdded,
      bool? news,
      bool? reminders}) {
    return UserNotificationSettingsResponse(
        enabled: enabled ?? this.enabled,
        match: match ?? this.match,
        message: message ?? this.message,
        friendAdded: friendAdded ?? this.friendAdded,
        news: news ?? this.news,
        reminders: reminders ?? this.reminders);
  }

  UserNotificationSettingsResponse copyWithWrapped(
      {Wrapped<bool>? enabled,
      Wrapped<bool>? match,
      Wrapped<bool>? message,
      Wrapped<bool>? friendAdded,
      Wrapped<bool>? news,
      Wrapped<bool>? reminders}) {
    return UserNotificationSettingsResponse(
        enabled: (enabled != null ? enabled.value : this.enabled),
        match: (match != null ? match.value : this.match),
        message: (message != null ? message.value : this.message),
        friendAdded:
            (friendAdded != null ? friendAdded.value : this.friendAdded),
        news: (news != null ? news.value : this.news),
        reminders: (reminders != null ? reminders.value : this.reminders));
  }
}

@JsonSerializable(explicitToJson: true)
class GetMeUserResponse {
  const GetMeUserResponse({
    required this.id,
    required this.username,
    this.photoKey,
    this.audioKey,
    required this.games,
    required this.friends,
    required this.email,
    this.description,
    this.gender,
    this.regions,
    this.dateOfBirth,
    this.country,
    this.language,
    this.epicGamesUsername,
    required this.notificationSettings,
  });

  factory GetMeUserResponse.fromJson(Map<String, dynamic> json) =>
      _$GetMeUserResponseFromJson(json);

  static const toJsonFactory = _$GetMeUserResponseToJson;
  Map<String, dynamic> toJson() => _$GetMeUserResponseToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'username', includeIfNull: false)
  final String username;
  @JsonKey(name: 'photoKey', includeIfNull: false)
  final String? photoKey;
  @JsonKey(name: 'audioKey', includeIfNull: false)
  final String? audioKey;
  @JsonKey(name: 'games', includeIfNull: false, defaultValue: <String>[])
  final List<String> games;
  @JsonKey(name: 'friends', includeIfNull: false)
  final double friends;
  @JsonKey(name: 'email', includeIfNull: false)
  final String email;
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'gender', includeIfNull: false)
  final String? gender;
  @JsonKey(name: 'regions', includeIfNull: false, defaultValue: <String>[])
  final List<String>? regions;
  @JsonKey(name: 'dateOfBirth', includeIfNull: false)
  final DateTime? dateOfBirth;
  @JsonKey(name: 'country', includeIfNull: false)
  final String? country;
  @JsonKey(name: 'language', includeIfNull: false)
  final String? language;
  @JsonKey(name: 'epicGamesUsername', includeIfNull: false)
  final String? epicGamesUsername;
  @JsonKey(name: 'notificationSettings', includeIfNull: false)
  final UserNotificationSettingsResponse notificationSettings;
  static const fromJsonFactory = _$GetMeUserResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is GetMeUserResponse &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.photoKey, photoKey) ||
                const DeepCollectionEquality()
                    .equals(other.photoKey, photoKey)) &&
            (identical(other.audioKey, audioKey) ||
                const DeepCollectionEquality()
                    .equals(other.audioKey, audioKey)) &&
            (identical(other.games, games) ||
                const DeepCollectionEquality().equals(other.games, games)) &&
            (identical(other.friends, friends) ||
                const DeepCollectionEquality()
                    .equals(other.friends, friends)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.gender, gender) ||
                const DeepCollectionEquality().equals(other.gender, gender)) &&
            (identical(other.regions, regions) ||
                const DeepCollectionEquality()
                    .equals(other.regions, regions)) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                const DeepCollectionEquality()
                    .equals(other.dateOfBirth, dateOfBirth)) &&
            (identical(other.country, country) ||
                const DeepCollectionEquality()
                    .equals(other.country, country)) &&
            (identical(other.language, language) ||
                const DeepCollectionEquality()
                    .equals(other.language, language)) &&
            (identical(other.epicGamesUsername, epicGamesUsername) ||
                const DeepCollectionEquality()
                    .equals(other.epicGamesUsername, epicGamesUsername)) &&
            (identical(other.notificationSettings, notificationSettings) ||
                const DeepCollectionEquality()
                    .equals(other.notificationSettings, notificationSettings)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(photoKey) ^
      const DeepCollectionEquality().hash(audioKey) ^
      const DeepCollectionEquality().hash(games) ^
      const DeepCollectionEquality().hash(friends) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(gender) ^
      const DeepCollectionEquality().hash(regions) ^
      const DeepCollectionEquality().hash(dateOfBirth) ^
      const DeepCollectionEquality().hash(country) ^
      const DeepCollectionEquality().hash(language) ^
      const DeepCollectionEquality().hash(epicGamesUsername) ^
      const DeepCollectionEquality().hash(notificationSettings) ^
      runtimeType.hashCode;
}

extension $GetMeUserResponseExtension on GetMeUserResponse {
  GetMeUserResponse copyWith(
      {String? id,
      String? username,
      String? photoKey,
      String? audioKey,
      List<String>? games,
      double? friends,
      String? email,
      String? description,
      String? gender,
      List<String>? regions,
      DateTime? dateOfBirth,
      String? country,
      String? language,
      String? epicGamesUsername,
      UserNotificationSettingsResponse? notificationSettings}) {
    return GetMeUserResponse(
        id: id ?? this.id,
        username: username ?? this.username,
        photoKey: photoKey ?? this.photoKey,
        audioKey: audioKey ?? this.audioKey,
        games: games ?? this.games,
        friends: friends ?? this.friends,
        email: email ?? this.email,
        description: description ?? this.description,
        gender: gender ?? this.gender,
        regions: regions ?? this.regions,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        country: country ?? this.country,
        language: language ?? this.language,
        epicGamesUsername: epicGamesUsername ?? this.epicGamesUsername,
        notificationSettings:
            notificationSettings ?? this.notificationSettings);
  }

  GetMeUserResponse copyWithWrapped(
      {Wrapped<String>? id,
      Wrapped<String>? username,
      Wrapped<String?>? photoKey,
      Wrapped<String?>? audioKey,
      Wrapped<List<String>>? games,
      Wrapped<double>? friends,
      Wrapped<String>? email,
      Wrapped<String?>? description,
      Wrapped<String?>? gender,
      Wrapped<List<String>?>? regions,
      Wrapped<DateTime?>? dateOfBirth,
      Wrapped<String?>? country,
      Wrapped<String?>? language,
      Wrapped<String?>? epicGamesUsername,
      Wrapped<UserNotificationSettingsResponse>? notificationSettings}) {
    return GetMeUserResponse(
        id: (id != null ? id.value : this.id),
        username: (username != null ? username.value : this.username),
        photoKey: (photoKey != null ? photoKey.value : this.photoKey),
        audioKey: (audioKey != null ? audioKey.value : this.audioKey),
        games: (games != null ? games.value : this.games),
        friends: (friends != null ? friends.value : this.friends),
        email: (email != null ? email.value : this.email),
        description:
            (description != null ? description.value : this.description),
        gender: (gender != null ? gender.value : this.gender),
        regions: (regions != null ? regions.value : this.regions),
        dateOfBirth:
            (dateOfBirth != null ? dateOfBirth.value : this.dateOfBirth),
        country: (country != null ? country.value : this.country),
        language: (language != null ? language.value : this.language),
        epicGamesUsername: (epicGamesUsername != null
            ? epicGamesUsername.value
            : this.epicGamesUsername),
        notificationSettings: (notificationSettings != null
            ? notificationSettings.value
            : this.notificationSettings));
  }
}

@JsonSerializable(explicitToJson: true)
class DeleteUsersInput {
  const DeleteUsersInput({
    required this.userIds,
  });

  factory DeleteUsersInput.fromJson(Map<String, dynamic> json) =>
      _$DeleteUsersInputFromJson(json);

  static const toJsonFactory = _$DeleteUsersInputToJson;
  Map<String, dynamic> toJson() => _$DeleteUsersInputToJson(this);

  @JsonKey(name: 'userIds', includeIfNull: false, defaultValue: <String>[])
  final List<String> userIds;
  static const fromJsonFactory = _$DeleteUsersInputFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is DeleteUsersInput &&
            (identical(other.userIds, userIds) ||
                const DeepCollectionEquality().equals(other.userIds, userIds)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(userIds) ^ runtimeType.hashCode;
}

extension $DeleteUsersInputExtension on DeleteUsersInput {
  DeleteUsersInput copyWith({List<String>? userIds}) {
    return DeleteUsersInput(userIds: userIds ?? this.userIds);
  }

  DeleteUsersInput copyWithWrapped({Wrapped<List<String>>? userIds}) {
    return DeleteUsersInput(
        userIds: (userIds != null ? userIds.value : this.userIds));
  }
}

@JsonSerializable(explicitToJson: true)
class ChangeEmailInput {
  const ChangeEmailInput({
    required this.email,
  });

  factory ChangeEmailInput.fromJson(Map<String, dynamic> json) =>
      _$ChangeEmailInputFromJson(json);

  static const toJsonFactory = _$ChangeEmailInputToJson;
  Map<String, dynamic> toJson() => _$ChangeEmailInputToJson(this);

  @JsonKey(name: 'email', includeIfNull: false)
  final String email;
  static const fromJsonFactory = _$ChangeEmailInputFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ChangeEmailInput &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(email) ^ runtimeType.hashCode;
}

extension $ChangeEmailInputExtension on ChangeEmailInput {
  ChangeEmailInput copyWith({String? email}) {
    return ChangeEmailInput(email: email ?? this.email);
  }

  ChangeEmailInput copyWithWrapped({Wrapped<String>? email}) {
    return ChangeEmailInput(email: (email != null ? email.value : this.email));
  }
}

@JsonSerializable(explicitToJson: true)
class VerifyEmailChangeInput {
  const VerifyEmailChangeInput({
    required this.code,
  });

  factory VerifyEmailChangeInput.fromJson(Map<String, dynamic> json) =>
      _$VerifyEmailChangeInputFromJson(json);

  static const toJsonFactory = _$VerifyEmailChangeInputToJson;
  Map<String, dynamic> toJson() => _$VerifyEmailChangeInputToJson(this);

  @JsonKey(name: 'code', includeIfNull: false)
  final String code;
  static const fromJsonFactory = _$VerifyEmailChangeInputFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is VerifyEmailChangeInput &&
            (identical(other.code, code) ||
                const DeepCollectionEquality().equals(other.code, code)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(code) ^ runtimeType.hashCode;
}

extension $VerifyEmailChangeInputExtension on VerifyEmailChangeInput {
  VerifyEmailChangeInput copyWith({String? code}) {
    return VerifyEmailChangeInput(code: code ?? this.code);
  }

  VerifyEmailChangeInput copyWithWrapped({Wrapped<String>? code}) {
    return VerifyEmailChangeInput(
        code: (code != null ? code.value : this.code));
  }
}

@JsonSerializable(explicitToJson: true)
class ChangePasswordInput {
  const ChangePasswordInput({
    required this.oldPassword,
    required this.newPassword,
  });

  factory ChangePasswordInput.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordInputFromJson(json);

  static const toJsonFactory = _$ChangePasswordInputToJson;
  Map<String, dynamic> toJson() => _$ChangePasswordInputToJson(this);

  @JsonKey(name: 'oldPassword', includeIfNull: false)
  final String oldPassword;
  @JsonKey(name: 'newPassword', includeIfNull: false)
  final String newPassword;
  static const fromJsonFactory = _$ChangePasswordInputFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ChangePasswordInput &&
            (identical(other.oldPassword, oldPassword) ||
                const DeepCollectionEquality()
                    .equals(other.oldPassword, oldPassword)) &&
            (identical(other.newPassword, newPassword) ||
                const DeepCollectionEquality()
                    .equals(other.newPassword, newPassword)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(oldPassword) ^
      const DeepCollectionEquality().hash(newPassword) ^
      runtimeType.hashCode;
}

extension $ChangePasswordInputExtension on ChangePasswordInput {
  ChangePasswordInput copyWith({String? oldPassword, String? newPassword}) {
    return ChangePasswordInput(
        oldPassword: oldPassword ?? this.oldPassword,
        newPassword: newPassword ?? this.newPassword);
  }

  ChangePasswordInput copyWithWrapped(
      {Wrapped<String>? oldPassword, Wrapped<String>? newPassword}) {
    return ChangePasswordInput(
        oldPassword:
            (oldPassword != null ? oldPassword.value : this.oldPassword),
        newPassword:
            (newPassword != null ? newPassword.value : this.newPassword));
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

  @JsonKey(name: 'key', includeIfNull: false)
  final String key;
  @JsonKey(name: 'selectedValue', includeIfNull: false)
  final String? selectedValue;
  @JsonKey(name: 'numericValue', includeIfNull: false)
  final double? numericValue;
  @JsonKey(name: 'numericDisplay', includeIfNull: false)
  final String? numericDisplay;
  static const fromJsonFactory = _$GamePreferenceValueResponseFromJson;

  @override
  bool operator ==(Object other) {
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

  @JsonKey(name: 'key', includeIfNull: false)
  final String key;
  @JsonKey(
      name: 'values',
      includeIfNull: false,
      defaultValue: <GamePreferenceValueResponse>[])
  final List<GamePreferenceValueResponse> values;
  @JsonKey(name: 'title', includeIfNull: false)
  final String title;
  static const fromJsonFactory = _$GamePreferenceResponseFromJson;

  @override
  bool operator ==(Object other) {
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

  @JsonKey(name: '_id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'user', includeIfNull: false)
  final dynamic user;
  @JsonKey(
    name: 'game',
    includeIfNull: false,
    toJson: userGameDataResponseGameToJson,
    fromJson: userGameDataResponseGameFromJson,
  )
  final enums.UserGameDataResponseGame game;
  @JsonKey(
      name: 'preferences',
      includeIfNull: false,
      defaultValue: <GamePreferenceResponse>[])
  final List<GamePreferenceResponse> preferences;
  static const fromJsonFactory = _$UserGameDataResponseFromJson;

  @override
  bool operator ==(Object other) {
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

  @JsonKey(name: 'note', includeIfNull: false)
  final String note;
  static const fromJsonFactory = _$UserNoteInputFromJson;

  @override
  bool operator ==(Object other) {
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

  @JsonKey(name: 'reporter', includeIfNull: false)
  final String reporter;
  @JsonKey(
    name: 'reportReason',
    includeIfNull: false,
    toJson: userReportResponseReportReasonToJson,
    fromJson: userReportResponseReportReasonFromJson,
  )
  final enums.UserReportResponseReportReason reportReason;
  @JsonKey(name: 'createdAt', includeIfNull: false)
  final DateTime createdAt;
  static const fromJsonFactory = _$UserReportResponseFromJson;

  @override
  bool operator ==(Object other) {
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
    includeIfNull: false,
    toJson: userWarningTypeResponseKeyToJson,
    fromJson: userWarningTypeResponseKeyFromJson,
  )
  final enums.UserWarningTypeResponseKey key;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  static const fromJsonFactory = _$UserWarningTypeResponseFromJson;

  @override
  bool operator ==(Object other) {
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
    includeIfNull: false,
    toJson: userReportTypeResponseKeyToJson,
    fromJson: userReportTypeResponseKeyFromJson,
  )
  final enums.UserReportTypeResponseKey key;
  @JsonKey(name: 'name', includeIfNull: false)
  final String name;
  static const fromJsonFactory = _$UserReportTypeResponseFromJson;

  @override
  bool operator ==(Object other) {
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

  @JsonKey(name: 'userIds', includeIfNull: false, defaultValue: <String>[])
  final List<String> userIds;
  @JsonKey(name: 'note', includeIfNull: false)
  final String note;
  @JsonKey(
    name: 'warning',
    includeIfNull: false,
    toJson: userWarningInputWarningToJson,
    fromJson: userWarningInputWarningFromJson,
  )
  final enums.UserWarningInputWarning warning;
  static const fromJsonFactory = _$UserWarningInputFromJson;

  @override
  bool operator ==(Object other) {
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

  @JsonKey(name: 'userIds', includeIfNull: false, defaultValue: <String>[])
  final List<String> userIds;
  @JsonKey(name: 'note', includeIfNull: false)
  final String note;
  static const fromJsonFactory = _$UserBanInputFromJson;

  @override
  bool operator ==(Object other) {
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

  @JsonKey(name: 'userIds', includeIfNull: false, defaultValue: <String>[])
  final List<String> userIds;
  @JsonKey(name: 'until', includeIfNull: false)
  final DateTime until;
  @JsonKey(name: 'note', includeIfNull: false)
  final String note;
  static const fromJsonFactory = _$UserSuspendInputFromJson;

  @override
  bool operator ==(Object other) {
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

  @JsonKey(name: 'userIds', includeIfNull: false, defaultValue: <String>[])
  final List<String> userIds;
  static const fromJsonFactory = _$UserResetInputFromJson;

  @override
  bool operator ==(Object other) {
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
class UpdateUsernameInput {
  const UpdateUsernameInput({
    required this.username,
  });

  factory UpdateUsernameInput.fromJson(Map<String, dynamic> json) =>
      _$UpdateUsernameInputFromJson(json);

  static const toJsonFactory = _$UpdateUsernameInputToJson;
  Map<String, dynamic> toJson() => _$UpdateUsernameInputToJson(this);

  @JsonKey(name: 'username', includeIfNull: false)
  final String username;
  static const fromJsonFactory = _$UpdateUsernameInputFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UpdateUsernameInput &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(username) ^ runtimeType.hashCode;
}

extension $UpdateUsernameInputExtension on UpdateUsernameInput {
  UpdateUsernameInput copyWith({String? username}) {
    return UpdateUsernameInput(username: username ?? this.username);
  }

  UpdateUsernameInput copyWithWrapped({Wrapped<String>? username}) {
    return UpdateUsernameInput(
        username: (username != null ? username.value : this.username));
  }
}

@JsonSerializable(explicitToJson: true)
class ChangeUserInfoInput {
  const ChangeUserInfoInput({
    this.country,
    this.dateOfBirth,
    this.gender,
    this.regions,
    this.language,
    this.description,
  });

  factory ChangeUserInfoInput.fromJson(Map<String, dynamic> json) =>
      _$ChangeUserInfoInputFromJson(json);

  static const toJsonFactory = _$ChangeUserInfoInputToJson;
  Map<String, dynamic> toJson() => _$ChangeUserInfoInputToJson(this);

  @JsonKey(name: 'country', includeIfNull: false)
  final String? country;
  @JsonKey(name: 'dateOfBirth', includeIfNull: false)
  final String? dateOfBirth;
  @JsonKey(name: 'gender', includeIfNull: false)
  final String? gender;
  @JsonKey(name: 'regions', includeIfNull: false, defaultValue: <String>[])
  final List<String>? regions;
  @JsonKey(name: 'language', includeIfNull: false)
  final String? language;
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  static const fromJsonFactory = _$ChangeUserInfoInputFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ChangeUserInfoInput &&
            (identical(other.country, country) ||
                const DeepCollectionEquality()
                    .equals(other.country, country)) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                const DeepCollectionEquality()
                    .equals(other.dateOfBirth, dateOfBirth)) &&
            (identical(other.gender, gender) ||
                const DeepCollectionEquality().equals(other.gender, gender)) &&
            (identical(other.regions, regions) ||
                const DeepCollectionEquality()
                    .equals(other.regions, regions)) &&
            (identical(other.language, language) ||
                const DeepCollectionEquality()
                    .equals(other.language, language)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(country) ^
      const DeepCollectionEquality().hash(dateOfBirth) ^
      const DeepCollectionEquality().hash(gender) ^
      const DeepCollectionEquality().hash(regions) ^
      const DeepCollectionEquality().hash(language) ^
      const DeepCollectionEquality().hash(description) ^
      runtimeType.hashCode;
}

extension $ChangeUserInfoInputExtension on ChangeUserInfoInput {
  ChangeUserInfoInput copyWith(
      {String? country,
      String? dateOfBirth,
      String? gender,
      List<String>? regions,
      String? language,
      String? description}) {
    return ChangeUserInfoInput(
        country: country ?? this.country,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        gender: gender ?? this.gender,
        regions: regions ?? this.regions,
        language: language ?? this.language,
        description: description ?? this.description);
  }

  ChangeUserInfoInput copyWithWrapped(
      {Wrapped<String?>? country,
      Wrapped<String?>? dateOfBirth,
      Wrapped<String?>? gender,
      Wrapped<List<String>?>? regions,
      Wrapped<String?>? language,
      Wrapped<String?>? description}) {
    return ChangeUserInfoInput(
        country: (country != null ? country.value : this.country),
        dateOfBirth:
            (dateOfBirth != null ? dateOfBirth.value : this.dateOfBirth),
        gender: (gender != null ? gender.value : this.gender),
        regions: (regions != null ? regions.value : this.regions),
        language: (language != null ? language.value : this.language),
        description:
            (description != null ? description.value : this.description));
  }
}

@JsonSerializable(explicitToJson: true)
class SetUserFileResponse {
  const SetUserFileResponse({
    required this.key,
  });

  factory SetUserFileResponse.fromJson(Map<String, dynamic> json) =>
      _$SetUserFileResponseFromJson(json);

  static const toJsonFactory = _$SetUserFileResponseToJson;
  Map<String, dynamic> toJson() => _$SetUserFileResponseToJson(this);

  @JsonKey(name: 'key', includeIfNull: false)
  final String key;
  static const fromJsonFactory = _$SetUserFileResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SetUserFileResponse &&
            (identical(other.key, key) ||
                const DeepCollectionEquality().equals(other.key, key)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(key) ^ runtimeType.hashCode;
}

extension $SetUserFileResponseExtension on SetUserFileResponse {
  SetUserFileResponse copyWith({String? key}) {
    return SetUserFileResponse(key: key ?? this.key);
  }

  SetUserFileResponse copyWithWrapped({Wrapped<String>? key}) {
    return SetUserFileResponse(key: (key != null ? key.value : this.key));
  }
}

@JsonSerializable(explicitToJson: true)
class SetCallOfDutyPreferencesInput {
  const SetCallOfDutyPreferencesInput({
    required this.gameModes,
    required this.rotations,
    required this.teamSizes,
    required this.playingLevel,
    required this.agression,
    required this.teamWork,
    required this.gameplayStyle,
  });

  factory SetCallOfDutyPreferencesInput.fromJson(Map<String, dynamic> json) =>
      _$SetCallOfDutyPreferencesInputFromJson(json);

  static const toJsonFactory = _$SetCallOfDutyPreferencesInputToJson;
  Map<String, dynamic> toJson() => _$SetCallOfDutyPreferencesInputToJson(this);

  @JsonKey(name: 'gameModes', includeIfNull: false, defaultValue: <String>[])
  final List<String> gameModes;
  @JsonKey(name: 'rotations', includeIfNull: false, defaultValue: <String>[])
  final List<String> rotations;
  @JsonKey(name: 'teamSizes', includeIfNull: false, defaultValue: <String>[])
  final List<String> teamSizes;
  @JsonKey(name: 'playingLevel', includeIfNull: false)
  final String playingLevel;
  @JsonKey(name: 'agression', includeIfNull: false)
  final double agression;
  @JsonKey(name: 'teamWork', includeIfNull: false)
  final double teamWork;
  @JsonKey(name: 'gameplayStyle', includeIfNull: false)
  final double gameplayStyle;
  static const fromJsonFactory = _$SetCallOfDutyPreferencesInputFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SetCallOfDutyPreferencesInput &&
            (identical(other.gameModes, gameModes) ||
                const DeepCollectionEquality()
                    .equals(other.gameModes, gameModes)) &&
            (identical(other.rotations, rotations) ||
                const DeepCollectionEquality()
                    .equals(other.rotations, rotations)) &&
            (identical(other.teamSizes, teamSizes) ||
                const DeepCollectionEquality()
                    .equals(other.teamSizes, teamSizes)) &&
            (identical(other.playingLevel, playingLevel) ||
                const DeepCollectionEquality()
                    .equals(other.playingLevel, playingLevel)) &&
            (identical(other.agression, agression) ||
                const DeepCollectionEquality()
                    .equals(other.agression, agression)) &&
            (identical(other.teamWork, teamWork) ||
                const DeepCollectionEquality()
                    .equals(other.teamWork, teamWork)) &&
            (identical(other.gameplayStyle, gameplayStyle) ||
                const DeepCollectionEquality()
                    .equals(other.gameplayStyle, gameplayStyle)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(gameModes) ^
      const DeepCollectionEquality().hash(rotations) ^
      const DeepCollectionEquality().hash(teamSizes) ^
      const DeepCollectionEquality().hash(playingLevel) ^
      const DeepCollectionEquality().hash(agression) ^
      const DeepCollectionEquality().hash(teamWork) ^
      const DeepCollectionEquality().hash(gameplayStyle) ^
      runtimeType.hashCode;
}

extension $SetCallOfDutyPreferencesInputExtension
    on SetCallOfDutyPreferencesInput {
  SetCallOfDutyPreferencesInput copyWith(
      {List<String>? gameModes,
      List<String>? rotations,
      List<String>? teamSizes,
      String? playingLevel,
      double? agression,
      double? teamWork,
      double? gameplayStyle}) {
    return SetCallOfDutyPreferencesInput(
        gameModes: gameModes ?? this.gameModes,
        rotations: rotations ?? this.rotations,
        teamSizes: teamSizes ?? this.teamSizes,
        playingLevel: playingLevel ?? this.playingLevel,
        agression: agression ?? this.agression,
        teamWork: teamWork ?? this.teamWork,
        gameplayStyle: gameplayStyle ?? this.gameplayStyle);
  }

  SetCallOfDutyPreferencesInput copyWithWrapped(
      {Wrapped<List<String>>? gameModes,
      Wrapped<List<String>>? rotations,
      Wrapped<List<String>>? teamSizes,
      Wrapped<String>? playingLevel,
      Wrapped<double>? agression,
      Wrapped<double>? teamWork,
      Wrapped<double>? gameplayStyle}) {
    return SetCallOfDutyPreferencesInput(
        gameModes: (gameModes != null ? gameModes.value : this.gameModes),
        rotations: (rotations != null ? rotations.value : this.rotations),
        teamSizes: (teamSizes != null ? teamSizes.value : this.teamSizes),
        playingLevel:
            (playingLevel != null ? playingLevel.value : this.playingLevel),
        agression: (agression != null ? agression.value : this.agression),
        teamWork: (teamWork != null ? teamWork.value : this.teamWork),
        gameplayStyle:
            (gameplayStyle != null ? gameplayStyle.value : this.gameplayStyle));
  }
}

@JsonSerializable(explicitToJson: true)
class SetApexLegendsPreferencesInput {
  const SetApexLegendsPreferencesInput({
    required this.types,
    required this.classifications,
    required this.playingLevel,
    this.mixtapeTypes,
    required this.rotations,
    required this.teamSizes,
    required this.agression,
    required this.teamWork,
    required this.gameplayStyle,
  });

  factory SetApexLegendsPreferencesInput.fromJson(Map<String, dynamic> json) =>
      _$SetApexLegendsPreferencesInputFromJson(json);

  static const toJsonFactory = _$SetApexLegendsPreferencesInputToJson;
  Map<String, dynamic> toJson() => _$SetApexLegendsPreferencesInputToJson(this);

  @JsonKey(name: 'types', includeIfNull: false, defaultValue: <String>[])
  final List<String> types;
  @JsonKey(
      name: 'classifications', includeIfNull: false, defaultValue: <String>[])
  final List<String> classifications;
  @JsonKey(name: 'playingLevel', includeIfNull: false)
  final String playingLevel;
  @JsonKey(name: 'mixtapeTypes', includeIfNull: false, defaultValue: <String>[])
  final List<String>? mixtapeTypes;
  @JsonKey(name: 'rotations', includeIfNull: false, defaultValue: <String>[])
  final List<String> rotations;
  @JsonKey(name: 'teamSizes', includeIfNull: false, defaultValue: <String>[])
  final List<String> teamSizes;
  @JsonKey(name: 'agression', includeIfNull: false)
  final double agression;
  @JsonKey(name: 'teamWork', includeIfNull: false)
  final double teamWork;
  @JsonKey(name: 'gameplayStyle', includeIfNull: false)
  final double gameplayStyle;
  static const fromJsonFactory = _$SetApexLegendsPreferencesInputFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SetApexLegendsPreferencesInput &&
            (identical(other.types, types) ||
                const DeepCollectionEquality().equals(other.types, types)) &&
            (identical(other.classifications, classifications) ||
                const DeepCollectionEquality()
                    .equals(other.classifications, classifications)) &&
            (identical(other.playingLevel, playingLevel) ||
                const DeepCollectionEquality()
                    .equals(other.playingLevel, playingLevel)) &&
            (identical(other.mixtapeTypes, mixtapeTypes) ||
                const DeepCollectionEquality()
                    .equals(other.mixtapeTypes, mixtapeTypes)) &&
            (identical(other.rotations, rotations) ||
                const DeepCollectionEquality()
                    .equals(other.rotations, rotations)) &&
            (identical(other.teamSizes, teamSizes) ||
                const DeepCollectionEquality()
                    .equals(other.teamSizes, teamSizes)) &&
            (identical(other.agression, agression) ||
                const DeepCollectionEquality()
                    .equals(other.agression, agression)) &&
            (identical(other.teamWork, teamWork) ||
                const DeepCollectionEquality()
                    .equals(other.teamWork, teamWork)) &&
            (identical(other.gameplayStyle, gameplayStyle) ||
                const DeepCollectionEquality()
                    .equals(other.gameplayStyle, gameplayStyle)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(types) ^
      const DeepCollectionEquality().hash(classifications) ^
      const DeepCollectionEquality().hash(playingLevel) ^
      const DeepCollectionEquality().hash(mixtapeTypes) ^
      const DeepCollectionEquality().hash(rotations) ^
      const DeepCollectionEquality().hash(teamSizes) ^
      const DeepCollectionEquality().hash(agression) ^
      const DeepCollectionEquality().hash(teamWork) ^
      const DeepCollectionEquality().hash(gameplayStyle) ^
      runtimeType.hashCode;
}

extension $SetApexLegendsPreferencesInputExtension
    on SetApexLegendsPreferencesInput {
  SetApexLegendsPreferencesInput copyWith(
      {List<String>? types,
      List<String>? classifications,
      String? playingLevel,
      List<String>? mixtapeTypes,
      List<String>? rotations,
      List<String>? teamSizes,
      double? agression,
      double? teamWork,
      double? gameplayStyle}) {
    return SetApexLegendsPreferencesInput(
        types: types ?? this.types,
        classifications: classifications ?? this.classifications,
        playingLevel: playingLevel ?? this.playingLevel,
        mixtapeTypes: mixtapeTypes ?? this.mixtapeTypes,
        rotations: rotations ?? this.rotations,
        teamSizes: teamSizes ?? this.teamSizes,
        agression: agression ?? this.agression,
        teamWork: teamWork ?? this.teamWork,
        gameplayStyle: gameplayStyle ?? this.gameplayStyle);
  }

  SetApexLegendsPreferencesInput copyWithWrapped(
      {Wrapped<List<String>>? types,
      Wrapped<List<String>>? classifications,
      Wrapped<String>? playingLevel,
      Wrapped<List<String>?>? mixtapeTypes,
      Wrapped<List<String>>? rotations,
      Wrapped<List<String>>? teamSizes,
      Wrapped<double>? agression,
      Wrapped<double>? teamWork,
      Wrapped<double>? gameplayStyle}) {
    return SetApexLegendsPreferencesInput(
        types: (types != null ? types.value : this.types),
        classifications: (classifications != null
            ? classifications.value
            : this.classifications),
        playingLevel:
            (playingLevel != null ? playingLevel.value : this.playingLevel),
        mixtapeTypes:
            (mixtapeTypes != null ? mixtapeTypes.value : this.mixtapeTypes),
        rotations: (rotations != null ? rotations.value : this.rotations),
        teamSizes: (teamSizes != null ? teamSizes.value : this.teamSizes),
        agression: (agression != null ? agression.value : this.agression),
        teamWork: (teamWork != null ? teamWork.value : this.teamWork),
        gameplayStyle:
            (gameplayStyle != null ? gameplayStyle.value : this.gameplayStyle));
  }
}

@JsonSerializable(explicitToJson: true)
class SetRocketLeaguePreferencesInput {
  const SetRocketLeaguePreferencesInput({
    required this.gameModes,
    required this.playingLevel,
    required this.playStyle,
    required this.teamSizes,
    required this.gameplays,
  });

  factory SetRocketLeaguePreferencesInput.fromJson(Map<String, dynamic> json) =>
      _$SetRocketLeaguePreferencesInputFromJson(json);

  static const toJsonFactory = _$SetRocketLeaguePreferencesInputToJson;
  Map<String, dynamic> toJson() =>
      _$SetRocketLeaguePreferencesInputToJson(this);

  @JsonKey(name: 'gameModes', includeIfNull: false, defaultValue: <String>[])
  final List<String> gameModes;
  @JsonKey(name: 'playingLevel', includeIfNull: false)
  final String playingLevel;
  @JsonKey(name: 'playStyle', includeIfNull: false)
  final String playStyle;
  @JsonKey(name: 'teamSizes', includeIfNull: false, defaultValue: <String>[])
  final List<String> teamSizes;
  @JsonKey(name: 'gameplays', includeIfNull: false, defaultValue: <String>[])
  final List<String> gameplays;
  static const fromJsonFactory = _$SetRocketLeaguePreferencesInputFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SetRocketLeaguePreferencesInput &&
            (identical(other.gameModes, gameModes) ||
                const DeepCollectionEquality()
                    .equals(other.gameModes, gameModes)) &&
            (identical(other.playingLevel, playingLevel) ||
                const DeepCollectionEquality()
                    .equals(other.playingLevel, playingLevel)) &&
            (identical(other.playStyle, playStyle) ||
                const DeepCollectionEquality()
                    .equals(other.playStyle, playStyle)) &&
            (identical(other.teamSizes, teamSizes) ||
                const DeepCollectionEquality()
                    .equals(other.teamSizes, teamSizes)) &&
            (identical(other.gameplays, gameplays) ||
                const DeepCollectionEquality()
                    .equals(other.gameplays, gameplays)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(gameModes) ^
      const DeepCollectionEquality().hash(playingLevel) ^
      const DeepCollectionEquality().hash(playStyle) ^
      const DeepCollectionEquality().hash(teamSizes) ^
      const DeepCollectionEquality().hash(gameplays) ^
      runtimeType.hashCode;
}

extension $SetRocketLeaguePreferencesInputExtension
    on SetRocketLeaguePreferencesInput {
  SetRocketLeaguePreferencesInput copyWith(
      {List<String>? gameModes,
      String? playingLevel,
      String? playStyle,
      List<String>? teamSizes,
      List<String>? gameplays}) {
    return SetRocketLeaguePreferencesInput(
        gameModes: gameModes ?? this.gameModes,
        playingLevel: playingLevel ?? this.playingLevel,
        playStyle: playStyle ?? this.playStyle,
        teamSizes: teamSizes ?? this.teamSizes,
        gameplays: gameplays ?? this.gameplays);
  }

  SetRocketLeaguePreferencesInput copyWithWrapped(
      {Wrapped<List<String>>? gameModes,
      Wrapped<String>? playingLevel,
      Wrapped<String>? playStyle,
      Wrapped<List<String>>? teamSizes,
      Wrapped<List<String>>? gameplays}) {
    return SetRocketLeaguePreferencesInput(
        gameModes: (gameModes != null ? gameModes.value : this.gameModes),
        playingLevel:
            (playingLevel != null ? playingLevel.value : this.playingLevel),
        playStyle: (playStyle != null ? playStyle.value : this.playStyle),
        teamSizes: (teamSizes != null ? teamSizes.value : this.teamSizes),
        gameplays: (gameplays != null ? gameplays.value : this.gameplays));
  }
}

@JsonSerializable(explicitToJson: true)
class SetFortnitePreferencesInput {
  const SetFortnitePreferencesInput({
    required this.gameModes,
    required this.rotations,
    required this.playingLevel,
    required this.teamSizes,
    required this.agression,
    required this.teamWork,
    required this.gameplayStyle,
  });

  factory SetFortnitePreferencesInput.fromJson(Map<String, dynamic> json) =>
      _$SetFortnitePreferencesInputFromJson(json);

  static const toJsonFactory = _$SetFortnitePreferencesInputToJson;
  Map<String, dynamic> toJson() => _$SetFortnitePreferencesInputToJson(this);

  @JsonKey(name: 'gameModes', includeIfNull: false, defaultValue: <String>[])
  final List<String> gameModes;
  @JsonKey(name: 'rotations', includeIfNull: false, defaultValue: <String>[])
  final List<String> rotations;
  @JsonKey(name: 'playingLevel', includeIfNull: false)
  final String playingLevel;
  @JsonKey(name: 'teamSizes', includeIfNull: false, defaultValue: <String>[])
  final List<String> teamSizes;
  @JsonKey(name: 'agression', includeIfNull: false)
  final double agression;
  @JsonKey(name: 'teamWork', includeIfNull: false)
  final double teamWork;
  @JsonKey(name: 'gameplayStyle', includeIfNull: false)
  final double gameplayStyle;
  static const fromJsonFactory = _$SetFortnitePreferencesInputFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SetFortnitePreferencesInput &&
            (identical(other.gameModes, gameModes) ||
                const DeepCollectionEquality()
                    .equals(other.gameModes, gameModes)) &&
            (identical(other.rotations, rotations) ||
                const DeepCollectionEquality()
                    .equals(other.rotations, rotations)) &&
            (identical(other.playingLevel, playingLevel) ||
                const DeepCollectionEquality()
                    .equals(other.playingLevel, playingLevel)) &&
            (identical(other.teamSizes, teamSizes) ||
                const DeepCollectionEquality()
                    .equals(other.teamSizes, teamSizes)) &&
            (identical(other.agression, agression) ||
                const DeepCollectionEquality()
                    .equals(other.agression, agression)) &&
            (identical(other.teamWork, teamWork) ||
                const DeepCollectionEquality()
                    .equals(other.teamWork, teamWork)) &&
            (identical(other.gameplayStyle, gameplayStyle) ||
                const DeepCollectionEquality()
                    .equals(other.gameplayStyle, gameplayStyle)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(gameModes) ^
      const DeepCollectionEquality().hash(rotations) ^
      const DeepCollectionEquality().hash(playingLevel) ^
      const DeepCollectionEquality().hash(teamSizes) ^
      const DeepCollectionEquality().hash(agression) ^
      const DeepCollectionEquality().hash(teamWork) ^
      const DeepCollectionEquality().hash(gameplayStyle) ^
      runtimeType.hashCode;
}

extension $SetFortnitePreferencesInputExtension on SetFortnitePreferencesInput {
  SetFortnitePreferencesInput copyWith(
      {List<String>? gameModes,
      List<String>? rotations,
      String? playingLevel,
      List<String>? teamSizes,
      double? agression,
      double? teamWork,
      double? gameplayStyle}) {
    return SetFortnitePreferencesInput(
        gameModes: gameModes ?? this.gameModes,
        rotations: rotations ?? this.rotations,
        playingLevel: playingLevel ?? this.playingLevel,
        teamSizes: teamSizes ?? this.teamSizes,
        agression: agression ?? this.agression,
        teamWork: teamWork ?? this.teamWork,
        gameplayStyle: gameplayStyle ?? this.gameplayStyle);
  }

  SetFortnitePreferencesInput copyWithWrapped(
      {Wrapped<List<String>>? gameModes,
      Wrapped<List<String>>? rotations,
      Wrapped<String>? playingLevel,
      Wrapped<List<String>>? teamSizes,
      Wrapped<double>? agression,
      Wrapped<double>? teamWork,
      Wrapped<double>? gameplayStyle}) {
    return SetFortnitePreferencesInput(
        gameModes: (gameModes != null ? gameModes.value : this.gameModes),
        rotations: (rotations != null ? rotations.value : this.rotations),
        playingLevel:
            (playingLevel != null ? playingLevel.value : this.playingLevel),
        teamSizes: (teamSizes != null ? teamSizes.value : this.teamSizes),
        agression: (agression != null ? agression.value : this.agression),
        teamWork: (teamWork != null ? teamWork.value : this.teamWork),
        gameplayStyle:
            (gameplayStyle != null ? gameplayStyle.value : this.gameplayStyle));
  }
}

@JsonSerializable(explicitToJson: true)
class SetGamePlaytimeInput {
  const SetGamePlaytimeInput({
    required this.playtime,
  });

  factory SetGamePlaytimeInput.fromJson(Map<String, dynamic> json) =>
      _$SetGamePlaytimeInputFromJson(json);

  static const toJsonFactory = _$SetGamePlaytimeInputToJson;
  Map<String, dynamic> toJson() => _$SetGamePlaytimeInputToJson(this);

  @JsonKey(name: 'playtime', includeIfNull: false)
  final String playtime;
  static const fromJsonFactory = _$SetGamePlaytimeInputFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SetGamePlaytimeInput &&
            (identical(other.playtime, playtime) ||
                const DeepCollectionEquality()
                    .equals(other.playtime, playtime)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(playtime) ^ runtimeType.hashCode;
}

extension $SetGamePlaytimeInputExtension on SetGamePlaytimeInput {
  SetGamePlaytimeInput copyWith({String? playtime}) {
    return SetGamePlaytimeInput(playtime: playtime ?? this.playtime);
  }

  SetGamePlaytimeInput copyWithWrapped({Wrapped<String>? playtime}) {
    return SetGamePlaytimeInput(
        playtime: (playtime != null ? playtime.value : this.playtime));
  }
}

@JsonSerializable(explicitToJson: true)
class SetOnlineScheduleInput {
  const SetOnlineScheduleInput({
    required this.startingTimestamp,
    required this.endingTimestamp,
  });

  factory SetOnlineScheduleInput.fromJson(Map<String, dynamic> json) =>
      _$SetOnlineScheduleInputFromJson(json);

  static const toJsonFactory = _$SetOnlineScheduleInputToJson;
  Map<String, dynamic> toJson() => _$SetOnlineScheduleInputToJson(this);

  @JsonKey(name: 'startingTimestamp', includeIfNull: false)
  final DateTime startingTimestamp;
  @JsonKey(name: 'endingTimestamp', includeIfNull: false)
  final DateTime endingTimestamp;
  static const fromJsonFactory = _$SetOnlineScheduleInputFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SetOnlineScheduleInput &&
            (identical(other.startingTimestamp, startingTimestamp) ||
                const DeepCollectionEquality()
                    .equals(other.startingTimestamp, startingTimestamp)) &&
            (identical(other.endingTimestamp, endingTimestamp) ||
                const DeepCollectionEquality()
                    .equals(other.endingTimestamp, endingTimestamp)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(startingTimestamp) ^
      const DeepCollectionEquality().hash(endingTimestamp) ^
      runtimeType.hashCode;
}

extension $SetOnlineScheduleInputExtension on SetOnlineScheduleInput {
  SetOnlineScheduleInput copyWith(
      {DateTime? startingTimestamp, DateTime? endingTimestamp}) {
    return SetOnlineScheduleInput(
        startingTimestamp: startingTimestamp ?? this.startingTimestamp,
        endingTimestamp: endingTimestamp ?? this.endingTimestamp);
  }

  SetOnlineScheduleInput copyWithWrapped(
      {Wrapped<DateTime>? startingTimestamp,
      Wrapped<DateTime>? endingTimestamp}) {
    return SetOnlineScheduleInput(
        startingTimestamp: (startingTimestamp != null
            ? startingTimestamp.value
            : this.startingTimestamp),
        endingTimestamp: (endingTimestamp != null
            ? endingTimestamp.value
            : this.endingTimestamp));
  }
}

@JsonSerializable(explicitToJson: true)
class CheckFriendshipResponse {
  const CheckFriendshipResponse({
    required this.isFriend,
  });

  factory CheckFriendshipResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckFriendshipResponseFromJson(json);

  static const toJsonFactory = _$CheckFriendshipResponseToJson;
  Map<String, dynamic> toJson() => _$CheckFriendshipResponseToJson(this);

  @JsonKey(name: 'isFriend', includeIfNull: false)
  final bool isFriend;
  static const fromJsonFactory = _$CheckFriendshipResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CheckFriendshipResponse &&
            (identical(other.isFriend, isFriend) ||
                const DeepCollectionEquality()
                    .equals(other.isFriend, isFriend)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(isFriend) ^ runtimeType.hashCode;
}

extension $CheckFriendshipResponseExtension on CheckFriendshipResponse {
  CheckFriendshipResponse copyWith({bool? isFriend}) {
    return CheckFriendshipResponse(isFriend: isFriend ?? this.isFriend);
  }

  CheckFriendshipResponse copyWithWrapped({Wrapped<bool>? isFriend}) {
    return CheckFriendshipResponse(
        isFriend: (isFriend != null ? isFriend.value : this.isFriend));
  }
}

@JsonSerializable(explicitToJson: true)
class CheckBlockStatusResponse {
  const CheckBlockStatusResponse({
    required this.isBlocked,
  });

  factory CheckBlockStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckBlockStatusResponseFromJson(json);

  static const toJsonFactory = _$CheckBlockStatusResponseToJson;
  Map<String, dynamic> toJson() => _$CheckBlockStatusResponseToJson(this);

  @JsonKey(name: 'isBlocked', includeIfNull: false)
  final bool isBlocked;
  static const fromJsonFactory = _$CheckBlockStatusResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CheckBlockStatusResponse &&
            (identical(other.isBlocked, isBlocked) ||
                const DeepCollectionEquality()
                    .equals(other.isBlocked, isBlocked)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(isBlocked) ^ runtimeType.hashCode;
}

extension $CheckBlockStatusResponseExtension on CheckBlockStatusResponse {
  CheckBlockStatusResponse copyWith({bool? isBlocked}) {
    return CheckBlockStatusResponse(isBlocked: isBlocked ?? this.isBlocked);
  }

  CheckBlockStatusResponse copyWithWrapped({Wrapped<bool>? isBlocked}) {
    return CheckBlockStatusResponse(
        isBlocked: (isBlocked != null ? isBlocked.value : this.isBlocked));
  }
}

@JsonSerializable(explicitToJson: true)
class UserProfileResponse {
  const UserProfileResponse({
    required this.username,
    this.description,
    this.photo,
    this.audio,
    required this.friendsCount,
    this.isFriend,
    this.sentFriendRequest,
    this.receivedFriendRequest,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$UserProfileResponseFromJson(json);

  static const toJsonFactory = _$UserProfileResponseToJson;
  Map<String, dynamic> toJson() => _$UserProfileResponseToJson(this);

  @JsonKey(name: 'username', includeIfNull: false)
  final String username;
  @JsonKey(name: 'description', includeIfNull: false)
  final String? description;
  @JsonKey(name: 'photo', includeIfNull: false)
  final String? photo;
  @JsonKey(name: 'audio', includeIfNull: false)
  final String? audio;
  @JsonKey(name: 'friendsCount', includeIfNull: false)
  final double friendsCount;
  @JsonKey(name: 'isFriend', includeIfNull: false)
  final bool? isFriend;
  @JsonKey(name: 'sentFriendRequest', includeIfNull: false)
  final bool? sentFriendRequest;
  @JsonKey(name: 'receivedFriendRequest', includeIfNull: false)
  final bool? receivedFriendRequest;
  static const fromJsonFactory = _$UserProfileResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserProfileResponse &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.photo, photo) ||
                const DeepCollectionEquality().equals(other.photo, photo)) &&
            (identical(other.audio, audio) ||
                const DeepCollectionEquality().equals(other.audio, audio)) &&
            (identical(other.friendsCount, friendsCount) ||
                const DeepCollectionEquality()
                    .equals(other.friendsCount, friendsCount)) &&
            (identical(other.isFriend, isFriend) ||
                const DeepCollectionEquality()
                    .equals(other.isFriend, isFriend)) &&
            (identical(other.sentFriendRequest, sentFriendRequest) ||
                const DeepCollectionEquality()
                    .equals(other.sentFriendRequest, sentFriendRequest)) &&
            (identical(other.receivedFriendRequest, receivedFriendRequest) ||
                const DeepCollectionEquality().equals(
                    other.receivedFriendRequest, receivedFriendRequest)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(photo) ^
      const DeepCollectionEquality().hash(audio) ^
      const DeepCollectionEquality().hash(friendsCount) ^
      const DeepCollectionEquality().hash(isFriend) ^
      const DeepCollectionEquality().hash(sentFriendRequest) ^
      const DeepCollectionEquality().hash(receivedFriendRequest) ^
      runtimeType.hashCode;
}

extension $UserProfileResponseExtension on UserProfileResponse {
  UserProfileResponse copyWith(
      {String? username,
      String? description,
      String? photo,
      String? audio,
      double? friendsCount,
      bool? isFriend,
      bool? sentFriendRequest,
      bool? receivedFriendRequest}) {
    return UserProfileResponse(
        username: username ?? this.username,
        description: description ?? this.description,
        photo: photo ?? this.photo,
        audio: audio ?? this.audio,
        friendsCount: friendsCount ?? this.friendsCount,
        isFriend: isFriend ?? this.isFriend,
        sentFriendRequest: sentFriendRequest ?? this.sentFriendRequest,
        receivedFriendRequest:
            receivedFriendRequest ?? this.receivedFriendRequest);
  }

  UserProfileResponse copyWithWrapped(
      {Wrapped<String>? username,
      Wrapped<String?>? description,
      Wrapped<String?>? photo,
      Wrapped<String?>? audio,
      Wrapped<double>? friendsCount,
      Wrapped<bool?>? isFriend,
      Wrapped<bool?>? sentFriendRequest,
      Wrapped<bool?>? receivedFriendRequest}) {
    return UserProfileResponse(
        username: (username != null ? username.value : this.username),
        description:
            (description != null ? description.value : this.description),
        photo: (photo != null ? photo.value : this.photo),
        audio: (audio != null ? audio.value : this.audio),
        friendsCount:
            (friendsCount != null ? friendsCount.value : this.friendsCount),
        isFriend: (isFriend != null ? isFriend.value : this.isFriend),
        sentFriendRequest: (sentFriendRequest != null
            ? sentFriendRequest.value
            : this.sentFriendRequest),
        receivedFriendRequest: (receivedFriendRequest != null
            ? receivedFriendRequest.value
            : this.receivedFriendRequest));
  }
}

@JsonSerializable(explicitToJson: true)
class UserGameResponse {
  const UserGameResponse({
    required this.displayName,
    required this.game,
  });

  factory UserGameResponse.fromJson(Map<String, dynamic> json) =>
      _$UserGameResponseFromJson(json);

  static const toJsonFactory = _$UserGameResponseToJson;
  Map<String, dynamic> toJson() => _$UserGameResponseToJson(this);

  @JsonKey(name: 'displayName', includeIfNull: false)
  final String displayName;
  @JsonKey(
    name: 'game',
    includeIfNull: false,
    toJson: userGameResponseGameToJson,
    fromJson: userGameResponseGameFromJson,
  )
  final enums.UserGameResponseGame game;
  static const fromJsonFactory = _$UserGameResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserGameResponse &&
            (identical(other.displayName, displayName) ||
                const DeepCollectionEquality()
                    .equals(other.displayName, displayName)) &&
            (identical(other.game, game) ||
                const DeepCollectionEquality().equals(other.game, game)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(displayName) ^
      const DeepCollectionEquality().hash(game) ^
      runtimeType.hashCode;
}

extension $UserGameResponseExtension on UserGameResponse {
  UserGameResponse copyWith(
      {String? displayName, enums.UserGameResponseGame? game}) {
    return UserGameResponse(
        displayName: displayName ?? this.displayName, game: game ?? this.game);
  }

  UserGameResponse copyWithWrapped(
      {Wrapped<String>? displayName,
      Wrapped<enums.UserGameResponseGame>? game}) {
    return UserGameResponse(
        displayName:
            (displayName != null ? displayName.value : this.displayName),
        game: (game != null ? game.value : this.game));
  }
}

@JsonSerializable(explicitToJson: true)
class UserGamesResponse {
  const UserGamesResponse({
    required this.userId,
    required this.games,
  });

  factory UserGamesResponse.fromJson(Map<String, dynamic> json) =>
      _$UserGamesResponseFromJson(json);

  static const toJsonFactory = _$UserGamesResponseToJson;
  Map<String, dynamic> toJson() => _$UserGamesResponseToJson(this);

  @JsonKey(name: 'userId', includeIfNull: false)
  final String userId;
  @JsonKey(
      name: 'games', includeIfNull: false, defaultValue: <UserGameResponse>[])
  final List<UserGameResponse> games;
  static const fromJsonFactory = _$UserGamesResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserGamesResponse &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)) &&
            (identical(other.games, games) ||
                const DeepCollectionEquality().equals(other.games, games)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(userId) ^
      const DeepCollectionEquality().hash(games) ^
      runtimeType.hashCode;
}

extension $UserGamesResponseExtension on UserGamesResponse {
  UserGamesResponse copyWith({String? userId, List<UserGameResponse>? games}) {
    return UserGamesResponse(
        userId: userId ?? this.userId, games: games ?? this.games);
  }

  UserGamesResponse copyWithWrapped(
      {Wrapped<String>? userId, Wrapped<List<UserGameResponse>>? games}) {
    return UserGamesResponse(
        userId: (userId != null ? userId.value : this.userId),
        games: (games != null ? games.value : this.games));
  }
}

@JsonSerializable(explicitToJson: true)
class GetUsersByIdsParams {
  const GetUsersByIdsParams({
    required this.userIds,
  });

  factory GetUsersByIdsParams.fromJson(Map<String, dynamic> json) =>
      _$GetUsersByIdsParamsFromJson(json);

  static const toJsonFactory = _$GetUsersByIdsParamsToJson;
  Map<String, dynamic> toJson() => _$GetUsersByIdsParamsToJson(this);

  @JsonKey(name: 'userIds', includeIfNull: false, defaultValue: <String>[])
  final List<String> userIds;
  static const fromJsonFactory = _$GetUsersByIdsParamsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is GetUsersByIdsParams &&
            (identical(other.userIds, userIds) ||
                const DeepCollectionEquality().equals(other.userIds, userIds)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(userIds) ^ runtimeType.hashCode;
}

extension $GetUsersByIdsParamsExtension on GetUsersByIdsParams {
  GetUsersByIdsParams copyWith({List<String>? userIds}) {
    return GetUsersByIdsParams(userIds: userIds ?? this.userIds);
  }

  GetUsersByIdsParams copyWithWrapped({Wrapped<List<String>>? userIds}) {
    return GetUsersByIdsParams(
        userIds: (userIds != null ? userIds.value : this.userIds));
  }
}

@JsonSerializable(explicitToJson: true)
class ReportUserInput {
  const ReportUserInput({
    required this.reportReason,
  });

  factory ReportUserInput.fromJson(Map<String, dynamic> json) =>
      _$ReportUserInputFromJson(json);

  static const toJsonFactory = _$ReportUserInputToJson;
  Map<String, dynamic> toJson() => _$ReportUserInputToJson(this);

  @JsonKey(name: 'reportReason', includeIfNull: false)
  final String reportReason;
  static const fromJsonFactory = _$ReportUserInputFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ReportUserInput &&
            (identical(other.reportReason, reportReason) ||
                const DeepCollectionEquality()
                    .equals(other.reportReason, reportReason)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(reportReason) ^ runtimeType.hashCode;
}

extension $ReportUserInputExtension on ReportUserInput {
  ReportUserInput copyWith({String? reportReason}) {
    return ReportUserInput(reportReason: reportReason ?? this.reportReason);
  }

  ReportUserInput copyWithWrapped({Wrapped<String>? reportReason}) {
    return ReportUserInput(
        reportReason:
            (reportReason != null ? reportReason.value : this.reportReason));
  }
}

@JsonSerializable(explicitToJson: true)
class NotificationRefreshTokenDto {
  const NotificationRefreshTokenDto({
    required this.token,
  });

  factory NotificationRefreshTokenDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationRefreshTokenDtoFromJson(json);

  static const toJsonFactory = _$NotificationRefreshTokenDtoToJson;
  Map<String, dynamic> toJson() => _$NotificationRefreshTokenDtoToJson(this);

  @JsonKey(name: 'token', includeIfNull: false)
  final String token;
  static const fromJsonFactory = _$NotificationRefreshTokenDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is NotificationRefreshTokenDto &&
            (identical(other.token, token) ||
                const DeepCollectionEquality().equals(other.token, token)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(token) ^ runtimeType.hashCode;
}

extension $NotificationRefreshTokenDtoExtension on NotificationRefreshTokenDto {
  NotificationRefreshTokenDto copyWith({String? token}) {
    return NotificationRefreshTokenDto(token: token ?? this.token);
  }

  NotificationRefreshTokenDto copyWithWrapped({Wrapped<String>? token}) {
    return NotificationRefreshTokenDto(
        token: (token != null ? token.value : this.token));
  }
}

@JsonSerializable(explicitToJson: true)
class CreateMessageNotificationDto {
  const CreateMessageNotificationDto({
    required this.senderUsername,
    required this.message,
    required this.recipientId,
    required this.redirectScreen,
  });

  factory CreateMessageNotificationDto.fromJson(Map<String, dynamic> json) =>
      _$CreateMessageNotificationDtoFromJson(json);

  static const toJsonFactory = _$CreateMessageNotificationDtoToJson;
  Map<String, dynamic> toJson() => _$CreateMessageNotificationDtoToJson(this);

  @JsonKey(name: 'senderUsername', includeIfNull: false)
  final String senderUsername;
  @JsonKey(name: 'message', includeIfNull: false)
  final String message;
  @JsonKey(name: 'recipientId', includeIfNull: false)
  final String recipientId;
  @JsonKey(name: 'redirectScreen', includeIfNull: false)
  final String redirectScreen;
  static const fromJsonFactory = _$CreateMessageNotificationDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CreateMessageNotificationDto &&
            (identical(other.senderUsername, senderUsername) ||
                const DeepCollectionEquality()
                    .equals(other.senderUsername, senderUsername)) &&
            (identical(other.message, message) ||
                const DeepCollectionEquality()
                    .equals(other.message, message)) &&
            (identical(other.recipientId, recipientId) ||
                const DeepCollectionEquality()
                    .equals(other.recipientId, recipientId)) &&
            (identical(other.redirectScreen, redirectScreen) ||
                const DeepCollectionEquality()
                    .equals(other.redirectScreen, redirectScreen)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(senderUsername) ^
      const DeepCollectionEquality().hash(message) ^
      const DeepCollectionEquality().hash(recipientId) ^
      const DeepCollectionEquality().hash(redirectScreen) ^
      runtimeType.hashCode;
}

extension $CreateMessageNotificationDtoExtension
    on CreateMessageNotificationDto {
  CreateMessageNotificationDto copyWith(
      {String? senderUsername,
      String? message,
      String? recipientId,
      String? redirectScreen}) {
    return CreateMessageNotificationDto(
        senderUsername: senderUsername ?? this.senderUsername,
        message: message ?? this.message,
        recipientId: recipientId ?? this.recipientId,
        redirectScreen: redirectScreen ?? this.redirectScreen);
  }

  CreateMessageNotificationDto copyWithWrapped(
      {Wrapped<String>? senderUsername,
      Wrapped<String>? message,
      Wrapped<String>? recipientId,
      Wrapped<String>? redirectScreen}) {
    return CreateMessageNotificationDto(
        senderUsername: (senderUsername != null
            ? senderUsername.value
            : this.senderUsername),
        message: (message != null ? message.value : this.message),
        recipientId:
            (recipientId != null ? recipientId.value : this.recipientId),
        redirectScreen: (redirectScreen != null
            ? redirectScreen.value
            : this.redirectScreen));
  }
}

@JsonSerializable(explicitToJson: true)
class CreateCallNotificationDto {
  const CreateCallNotificationDto({
    required this.callerUsername,
    required this.recipientId,
    required this.redirectScreen,
  });

  factory CreateCallNotificationDto.fromJson(Map<String, dynamic> json) =>
      _$CreateCallNotificationDtoFromJson(json);

  static const toJsonFactory = _$CreateCallNotificationDtoToJson;
  Map<String, dynamic> toJson() => _$CreateCallNotificationDtoToJson(this);

  @JsonKey(name: 'callerUsername', includeIfNull: false)
  final String callerUsername;
  @JsonKey(name: 'recipientId', includeIfNull: false)
  final String recipientId;
  @JsonKey(name: 'redirectScreen', includeIfNull: false)
  final String redirectScreen;
  static const fromJsonFactory = _$CreateCallNotificationDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CreateCallNotificationDto &&
            (identical(other.callerUsername, callerUsername) ||
                const DeepCollectionEquality()
                    .equals(other.callerUsername, callerUsername)) &&
            (identical(other.recipientId, recipientId) ||
                const DeepCollectionEquality()
                    .equals(other.recipientId, recipientId)) &&
            (identical(other.redirectScreen, redirectScreen) ||
                const DeepCollectionEquality()
                    .equals(other.redirectScreen, redirectScreen)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(callerUsername) ^
      const DeepCollectionEquality().hash(recipientId) ^
      const DeepCollectionEquality().hash(redirectScreen) ^
      runtimeType.hashCode;
}

extension $CreateCallNotificationDtoExtension on CreateCallNotificationDto {
  CreateCallNotificationDto copyWith(
      {String? callerUsername, String? recipientId, String? redirectScreen}) {
    return CreateCallNotificationDto(
        callerUsername: callerUsername ?? this.callerUsername,
        recipientId: recipientId ?? this.recipientId,
        redirectScreen: redirectScreen ?? this.redirectScreen);
  }

  CreateCallNotificationDto copyWithWrapped(
      {Wrapped<String>? callerUsername,
      Wrapped<String>? recipientId,
      Wrapped<String>? redirectScreen}) {
    return CreateCallNotificationDto(
        callerUsername: (callerUsername != null
            ? callerUsername.value
            : this.callerUsername),
        recipientId:
            (recipientId != null ? recipientId.value : this.recipientId),
        redirectScreen: (redirectScreen != null
            ? redirectScreen.value
            : this.redirectScreen));
  }
}

@JsonSerializable(explicitToJson: true)
class UnreadNotificationsResponse {
  const UnreadNotificationsResponse({
    required this.unread,
    this.count,
  });

  factory UnreadNotificationsResponse.fromJson(Map<String, dynamic> json) =>
      _$UnreadNotificationsResponseFromJson(json);

  static const toJsonFactory = _$UnreadNotificationsResponseToJson;
  Map<String, dynamic> toJson() => _$UnreadNotificationsResponseToJson(this);

  @JsonKey(name: 'unread', includeIfNull: false)
  final bool unread;
  @JsonKey(name: 'count', includeIfNull: false)
  final double? count;
  static const fromJsonFactory = _$UnreadNotificationsResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UnreadNotificationsResponse &&
            (identical(other.unread, unread) ||
                const DeepCollectionEquality().equals(other.unread, unread)) &&
            (identical(other.count, count) ||
                const DeepCollectionEquality().equals(other.count, count)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(unread) ^
      const DeepCollectionEquality().hash(count) ^
      runtimeType.hashCode;
}

extension $UnreadNotificationsResponseExtension on UnreadNotificationsResponse {
  UnreadNotificationsResponse copyWith({bool? unread, double? count}) {
    return UnreadNotificationsResponse(
        unread: unread ?? this.unread, count: count ?? this.count);
  }

  UnreadNotificationsResponse copyWithWrapped(
      {Wrapped<bool>? unread, Wrapped<double?>? count}) {
    return UnreadNotificationsResponse(
        unread: (unread != null ? unread.value : this.unread),
        count: (count != null ? count.value : this.count));
  }
}

@JsonSerializable(explicitToJson: true)
class NotificationDataResponse {
  const NotificationDataResponse({
    required this.title,
    required this.description,
    required this.redirectScreen,
    required this.isRead,
    required this.notificationType,
  });

  factory NotificationDataResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataResponseFromJson(json);

  static const toJsonFactory = _$NotificationDataResponseToJson;
  Map<String, dynamic> toJson() => _$NotificationDataResponseToJson(this);

  @JsonKey(name: 'title', includeIfNull: false)
  final String title;
  @JsonKey(name: 'description', includeIfNull: false)
  final String description;
  @JsonKey(name: 'redirectScreen', includeIfNull: false)
  final String redirectScreen;
  @JsonKey(name: 'isRead', includeIfNull: false)
  final bool isRead;
  @JsonKey(
    name: 'notificationType',
    includeIfNull: false,
    toJson: notificationDataResponseNotificationTypeToJson,
    fromJson: notificationDataResponseNotificationTypeFromJson,
  )
  final enums.NotificationDataResponseNotificationType notificationType;
  static const fromJsonFactory = _$NotificationDataResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is NotificationDataResponse &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.redirectScreen, redirectScreen) ||
                const DeepCollectionEquality()
                    .equals(other.redirectScreen, redirectScreen)) &&
            (identical(other.isRead, isRead) ||
                const DeepCollectionEquality().equals(other.isRead, isRead)) &&
            (identical(other.notificationType, notificationType) ||
                const DeepCollectionEquality()
                    .equals(other.notificationType, notificationType)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(redirectScreen) ^
      const DeepCollectionEquality().hash(isRead) ^
      const DeepCollectionEquality().hash(notificationType) ^
      runtimeType.hashCode;
}

extension $NotificationDataResponseExtension on NotificationDataResponse {
  NotificationDataResponse copyWith(
      {String? title,
      String? description,
      String? redirectScreen,
      bool? isRead,
      enums.NotificationDataResponseNotificationType? notificationType}) {
    return NotificationDataResponse(
        title: title ?? this.title,
        description: description ?? this.description,
        redirectScreen: redirectScreen ?? this.redirectScreen,
        isRead: isRead ?? this.isRead,
        notificationType: notificationType ?? this.notificationType);
  }

  NotificationDataResponse copyWithWrapped(
      {Wrapped<String>? title,
      Wrapped<String>? description,
      Wrapped<String>? redirectScreen,
      Wrapped<bool>? isRead,
      Wrapped<enums.NotificationDataResponseNotificationType>?
          notificationType}) {
    return NotificationDataResponse(
        title: (title != null ? title.value : this.title),
        description:
            (description != null ? description.value : this.description),
        redirectScreen: (redirectScreen != null
            ? redirectScreen.value
            : this.redirectScreen),
        isRead: (isRead != null ? isRead.value : this.isRead),
        notificationType: (notificationType != null
            ? notificationType.value
            : this.notificationType));
  }
}

@JsonSerializable(explicitToJson: true)
class NotificationResponse {
  const NotificationResponse({
    required this.id,
    required this.user,
    required this.since,
    required this.until,
    required this.data,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationResponseFromJson(json);

  static const toJsonFactory = _$NotificationResponseToJson;
  Map<String, dynamic> toJson() => _$NotificationResponseToJson(this);

  @JsonKey(name: '_id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'user', includeIfNull: false)
  final String user;
  @JsonKey(name: 'since', includeIfNull: false)
  final DateTime since;
  @JsonKey(name: 'until', includeIfNull: false)
  final DateTime until;
  @JsonKey(name: 'data', includeIfNull: false)
  final NotificationDataResponse data;
  @JsonKey(name: 'createdAt', includeIfNull: false)
  final DateTime createdAt;
  @JsonKey(name: 'updatedAt', includeIfNull: false)
  final DateTime updatedAt;
  static const fromJsonFactory = _$NotificationResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is NotificationResponse &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.since, since) ||
                const DeepCollectionEquality().equals(other.since, since)) &&
            (identical(other.until, until) ||
                const DeepCollectionEquality().equals(other.until, until)) &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(user) ^
      const DeepCollectionEquality().hash(since) ^
      const DeepCollectionEquality().hash(until) ^
      const DeepCollectionEquality().hash(data) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      runtimeType.hashCode;
}

extension $NotificationResponseExtension on NotificationResponse {
  NotificationResponse copyWith(
      {String? id,
      String? user,
      DateTime? since,
      DateTime? until,
      NotificationDataResponse? data,
      DateTime? createdAt,
      DateTime? updatedAt}) {
    return NotificationResponse(
        id: id ?? this.id,
        user: user ?? this.user,
        since: since ?? this.since,
        until: until ?? this.until,
        data: data ?? this.data,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }

  NotificationResponse copyWithWrapped(
      {Wrapped<String>? id,
      Wrapped<String>? user,
      Wrapped<DateTime>? since,
      Wrapped<DateTime>? until,
      Wrapped<NotificationDataResponse>? data,
      Wrapped<DateTime>? createdAt,
      Wrapped<DateTime>? updatedAt}) {
    return NotificationResponse(
        id: (id != null ? id.value : this.id),
        user: (user != null ? user.value : this.user),
        since: (since != null ? since.value : this.since),
        until: (until != null ? until.value : this.until),
        data: (data != null ? data.value : this.data),
        createdAt: (createdAt != null ? createdAt.value : this.createdAt),
        updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt));
  }
}

@JsonSerializable(explicitToJson: true)
class NotificationPaginatedResponse {
  const NotificationPaginatedResponse({
    required this.items,
    required this.meta,
  });

  factory NotificationPaginatedResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationPaginatedResponseFromJson(json);

  static const toJsonFactory = _$NotificationPaginatedResponseToJson;
  Map<String, dynamic> toJson() => _$NotificationPaginatedResponseToJson(this);

  @JsonKey(
      name: 'items',
      includeIfNull: false,
      defaultValue: <NotificationResponse>[])
  final List<NotificationResponse> items;
  @JsonKey(name: 'meta', includeIfNull: false)
  final PaginationMetaResponse meta;
  static const fromJsonFactory = _$NotificationPaginatedResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is NotificationPaginatedResponse &&
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

extension $NotificationPaginatedResponseExtension
    on NotificationPaginatedResponse {
  NotificationPaginatedResponse copyWith(
      {List<NotificationResponse>? items, PaginationMetaResponse? meta}) {
    return NotificationPaginatedResponse(
        items: items ?? this.items, meta: meta ?? this.meta);
  }

  NotificationPaginatedResponse copyWithWrapped(
      {Wrapped<List<NotificationResponse>>? items,
      Wrapped<PaginationMetaResponse>? meta}) {
    return NotificationPaginatedResponse(
        items: (items != null ? items.value : this.items),
        meta: (meta != null ? meta.value : this.meta));
  }
}

@JsonSerializable(explicitToJson: true)
class UpdateNotificationSettingsDto {
  const UpdateNotificationSettingsDto({
    this.enabled,
    this.match,
    this.friendAdded,
    this.message,
    this.reminders,
    this.news,
  });

  factory UpdateNotificationSettingsDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateNotificationSettingsDtoFromJson(json);

  static const toJsonFactory = _$UpdateNotificationSettingsDtoToJson;
  Map<String, dynamic> toJson() => _$UpdateNotificationSettingsDtoToJson(this);

  @JsonKey(name: 'enabled', includeIfNull: false)
  final bool? enabled;
  @JsonKey(name: 'match', includeIfNull: false)
  final bool? match;
  @JsonKey(name: 'friendAdded', includeIfNull: false)
  final bool? friendAdded;
  @JsonKey(name: 'message', includeIfNull: false)
  final bool? message;
  @JsonKey(name: 'reminders', includeIfNull: false)
  final bool? reminders;
  @JsonKey(name: 'news', includeIfNull: false)
  final bool? news;
  static const fromJsonFactory = _$UpdateNotificationSettingsDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UpdateNotificationSettingsDto &&
            (identical(other.enabled, enabled) ||
                const DeepCollectionEquality()
                    .equals(other.enabled, enabled)) &&
            (identical(other.match, match) ||
                const DeepCollectionEquality().equals(other.match, match)) &&
            (identical(other.friendAdded, friendAdded) ||
                const DeepCollectionEquality()
                    .equals(other.friendAdded, friendAdded)) &&
            (identical(other.message, message) ||
                const DeepCollectionEquality()
                    .equals(other.message, message)) &&
            (identical(other.reminders, reminders) ||
                const DeepCollectionEquality()
                    .equals(other.reminders, reminders)) &&
            (identical(other.news, news) ||
                const DeepCollectionEquality().equals(other.news, news)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(enabled) ^
      const DeepCollectionEquality().hash(match) ^
      const DeepCollectionEquality().hash(friendAdded) ^
      const DeepCollectionEquality().hash(message) ^
      const DeepCollectionEquality().hash(reminders) ^
      const DeepCollectionEquality().hash(news) ^
      runtimeType.hashCode;
}

extension $UpdateNotificationSettingsDtoExtension
    on UpdateNotificationSettingsDto {
  UpdateNotificationSettingsDto copyWith(
      {bool? enabled,
      bool? match,
      bool? friendAdded,
      bool? message,
      bool? reminders,
      bool? news}) {
    return UpdateNotificationSettingsDto(
        enabled: enabled ?? this.enabled,
        match: match ?? this.match,
        friendAdded: friendAdded ?? this.friendAdded,
        message: message ?? this.message,
        reminders: reminders ?? this.reminders,
        news: news ?? this.news);
  }

  UpdateNotificationSettingsDto copyWithWrapped(
      {Wrapped<bool?>? enabled,
      Wrapped<bool?>? match,
      Wrapped<bool?>? friendAdded,
      Wrapped<bool?>? message,
      Wrapped<bool?>? reminders,
      Wrapped<bool?>? news}) {
    return UpdateNotificationSettingsDto(
        enabled: (enabled != null ? enabled.value : this.enabled),
        match: (match != null ? match.value : this.match),
        friendAdded:
            (friendAdded != null ? friendAdded.value : this.friendAdded),
        message: (message != null ? message.value : this.message),
        reminders: (reminders != null ? reminders.value : this.reminders),
        news: (news != null ? news.value : this.news));
  }
}

@JsonSerializable(explicitToJson: true)
class NotificationSettingsOptionResponse {
  const NotificationSettingsOptionResponse({
    required this.keyValue,
    required this.displayValue,
  });

  factory NotificationSettingsOptionResponse.fromJson(
          Map<String, dynamic> json) =>
      _$NotificationSettingsOptionResponseFromJson(json);

  static const toJsonFactory = _$NotificationSettingsOptionResponseToJson;
  Map<String, dynamic> toJson() =>
      _$NotificationSettingsOptionResponseToJson(this);

  @JsonKey(name: 'keyValue', includeIfNull: false)
  final String keyValue;
  @JsonKey(name: 'displayValue', includeIfNull: false)
  final String displayValue;
  static const fromJsonFactory = _$NotificationSettingsOptionResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is NotificationSettingsOptionResponse &&
            (identical(other.keyValue, keyValue) ||
                const DeepCollectionEquality()
                    .equals(other.keyValue, keyValue)) &&
            (identical(other.displayValue, displayValue) ||
                const DeepCollectionEquality()
                    .equals(other.displayValue, displayValue)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(keyValue) ^
      const DeepCollectionEquality().hash(displayValue) ^
      runtimeType.hashCode;
}

extension $NotificationSettingsOptionResponseExtension
    on NotificationSettingsOptionResponse {
  NotificationSettingsOptionResponse copyWith(
      {String? keyValue, String? displayValue}) {
    return NotificationSettingsOptionResponse(
        keyValue: keyValue ?? this.keyValue,
        displayValue: displayValue ?? this.displayValue);
  }

  NotificationSettingsOptionResponse copyWithWrapped(
      {Wrapped<String>? keyValue, Wrapped<String>? displayValue}) {
    return NotificationSettingsOptionResponse(
        keyValue: (keyValue != null ? keyValue.value : this.keyValue),
        displayValue:
            (displayValue != null ? displayValue.value : this.displayValue));
  }
}

@JsonSerializable(explicitToJson: true)
class CheckFeedbackGivenResponse {
  const CheckFeedbackGivenResponse({
    required this.feedbackGiven,
  });

  factory CheckFeedbackGivenResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckFeedbackGivenResponseFromJson(json);

  static const toJsonFactory = _$CheckFeedbackGivenResponseToJson;
  Map<String, dynamic> toJson() => _$CheckFeedbackGivenResponseToJson(this);

  @JsonKey(name: 'feedbackGiven', includeIfNull: false)
  final bool feedbackGiven;
  static const fromJsonFactory = _$CheckFeedbackGivenResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CheckFeedbackGivenResponse &&
            (identical(other.feedbackGiven, feedbackGiven) ||
                const DeepCollectionEquality()
                    .equals(other.feedbackGiven, feedbackGiven)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(feedbackGiven) ^ runtimeType.hashCode;
}

extension $CheckFeedbackGivenResponseExtension on CheckFeedbackGivenResponse {
  CheckFeedbackGivenResponse copyWith({bool? feedbackGiven}) {
    return CheckFeedbackGivenResponse(
        feedbackGiven: feedbackGiven ?? this.feedbackGiven);
  }

  CheckFeedbackGivenResponse copyWithWrapped({Wrapped<bool>? feedbackGiven}) {
    return CheckFeedbackGivenResponse(
        feedbackGiven:
            (feedbackGiven != null ? feedbackGiven.value : this.feedbackGiven));
  }
}

@JsonSerializable(explicitToJson: true)
class CheckMatchExistsResponse {
  const CheckMatchExistsResponse({
    required this.matchExists,
    this.matchId,
  });

  factory CheckMatchExistsResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckMatchExistsResponseFromJson(json);

  static const toJsonFactory = _$CheckMatchExistsResponseToJson;
  Map<String, dynamic> toJson() => _$CheckMatchExistsResponseToJson(this);

  @JsonKey(name: 'matchExists', includeIfNull: false)
  final bool matchExists;
  @JsonKey(name: 'matchId', includeIfNull: false)
  final String? matchId;
  static const fromJsonFactory = _$CheckMatchExistsResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CheckMatchExistsResponse &&
            (identical(other.matchExists, matchExists) ||
                const DeepCollectionEquality()
                    .equals(other.matchExists, matchExists)) &&
            (identical(other.matchId, matchId) ||
                const DeepCollectionEquality().equals(other.matchId, matchId)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(matchExists) ^
      const DeepCollectionEquality().hash(matchId) ^
      runtimeType.hashCode;
}

extension $CheckMatchExistsResponseExtension on CheckMatchExistsResponse {
  CheckMatchExistsResponse copyWith({bool? matchExists, String? matchId}) {
    return CheckMatchExistsResponse(
        matchExists: matchExists ?? this.matchExists,
        matchId: matchId ?? this.matchId);
  }

  CheckMatchExistsResponse copyWithWrapped(
      {Wrapped<bool>? matchExists, Wrapped<String?>? matchId}) {
    return CheckMatchExistsResponse(
        matchExists:
            (matchExists != null ? matchExists.value : this.matchExists),
        matchId: (matchId != null ? matchId.value : this.matchId));
  }
}

@JsonSerializable(explicitToJson: true)
class MatchmakingResultUserResponse {
  const MatchmakingResultUserResponse({
    required this.id,
    this.photoKey,
    this.audioKey,
    required this.username,
    required this.dateOfBirth,
    this.country,
    required this.preferences,
  });

  factory MatchmakingResultUserResponse.fromJson(Map<String, dynamic> json) =>
      _$MatchmakingResultUserResponseFromJson(json);

  static const toJsonFactory = _$MatchmakingResultUserResponseToJson;
  Map<String, dynamic> toJson() => _$MatchmakingResultUserResponseToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'photoKey', includeIfNull: false)
  final String? photoKey;
  @JsonKey(name: 'audioKey', includeIfNull: false)
  final String? audioKey;
  @JsonKey(name: 'username', includeIfNull: false)
  final String username;
  @JsonKey(name: 'dateOfBirth', includeIfNull: false)
  final DateTime dateOfBirth;
  @JsonKey(name: 'country', includeIfNull: false)
  final String? country;
  @JsonKey(
      name: 'preferences',
      includeIfNull: false,
      defaultValue: <GamePreferenceResponse>[])
  final List<GamePreferenceResponse> preferences;
  static const fromJsonFactory = _$MatchmakingResultUserResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MatchmakingResultUserResponse &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.photoKey, photoKey) ||
                const DeepCollectionEquality()
                    .equals(other.photoKey, photoKey)) &&
            (identical(other.audioKey, audioKey) ||
                const DeepCollectionEquality()
                    .equals(other.audioKey, audioKey)) &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                const DeepCollectionEquality()
                    .equals(other.dateOfBirth, dateOfBirth)) &&
            (identical(other.country, country) ||
                const DeepCollectionEquality()
                    .equals(other.country, country)) &&
            (identical(other.preferences, preferences) ||
                const DeepCollectionEquality()
                    .equals(other.preferences, preferences)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(photoKey) ^
      const DeepCollectionEquality().hash(audioKey) ^
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(dateOfBirth) ^
      const DeepCollectionEquality().hash(country) ^
      const DeepCollectionEquality().hash(preferences) ^
      runtimeType.hashCode;
}

extension $MatchmakingResultUserResponseExtension
    on MatchmakingResultUserResponse {
  MatchmakingResultUserResponse copyWith(
      {String? id,
      String? photoKey,
      String? audioKey,
      String? username,
      DateTime? dateOfBirth,
      String? country,
      List<GamePreferenceResponse>? preferences}) {
    return MatchmakingResultUserResponse(
        id: id ?? this.id,
        photoKey: photoKey ?? this.photoKey,
        audioKey: audioKey ?? this.audioKey,
        username: username ?? this.username,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        country: country ?? this.country,
        preferences: preferences ?? this.preferences);
  }

  MatchmakingResultUserResponse copyWithWrapped(
      {Wrapped<String>? id,
      Wrapped<String?>? photoKey,
      Wrapped<String?>? audioKey,
      Wrapped<String>? username,
      Wrapped<DateTime>? dateOfBirth,
      Wrapped<String?>? country,
      Wrapped<List<GamePreferenceResponse>>? preferences}) {
    return MatchmakingResultUserResponse(
        id: (id != null ? id.value : this.id),
        photoKey: (photoKey != null ? photoKey.value : this.photoKey),
        audioKey: (audioKey != null ? audioKey.value : this.audioKey),
        username: (username != null ? username.value : this.username),
        dateOfBirth:
            (dateOfBirth != null ? dateOfBirth.value : this.dateOfBirth),
        country: (country != null ? country.value : this.country),
        preferences:
            (preferences != null ? preferences.value : this.preferences));
  }
}

@JsonSerializable(explicitToJson: true)
class MatchmakingResultPaginatedResponse {
  const MatchmakingResultPaginatedResponse({
    required this.items,
    required this.meta,
  });

  factory MatchmakingResultPaginatedResponse.fromJson(
          Map<String, dynamic> json) =>
      _$MatchmakingResultPaginatedResponseFromJson(json);

  static const toJsonFactory = _$MatchmakingResultPaginatedResponseToJson;
  Map<String, dynamic> toJson() =>
      _$MatchmakingResultPaginatedResponseToJson(this);

  @JsonKey(
      name: 'items',
      includeIfNull: false,
      defaultValue: <MatchmakingResultUserResponse>[])
  final List<MatchmakingResultUserResponse> items;
  @JsonKey(name: 'meta', includeIfNull: false)
  final PaginationMetaResponse meta;
  static const fromJsonFactory = _$MatchmakingResultPaginatedResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MatchmakingResultPaginatedResponse &&
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

extension $MatchmakingResultPaginatedResponseExtension
    on MatchmakingResultPaginatedResponse {
  MatchmakingResultPaginatedResponse copyWith(
      {List<MatchmakingResultUserResponse>? items,
      PaginationMetaResponse? meta}) {
    return MatchmakingResultPaginatedResponse(
        items: items ?? this.items, meta: meta ?? this.meta);
  }

  MatchmakingResultPaginatedResponse copyWithWrapped(
      {Wrapped<List<MatchmakingResultUserResponse>>? items,
      Wrapped<PaginationMetaResponse>? meta}) {
    return MatchmakingResultPaginatedResponse(
        items: (items != null ? items.value : this.items),
        meta: (meta != null ? meta.value : this.meta));
  }
}

@JsonSerializable(explicitToJson: true)
class GetUserByIdParams {
  const GetUserByIdParams({
    required this.userId,
  });

  factory GetUserByIdParams.fromJson(Map<String, dynamic> json) =>
      _$GetUserByIdParamsFromJson(json);

  static const toJsonFactory = _$GetUserByIdParamsToJson;
  Map<String, dynamic> toJson() => _$GetUserByIdParamsToJson(this);

  @JsonKey(name: 'userId', includeIfNull: false)
  final String userId;
  static const fromJsonFactory = _$GetUserByIdParamsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is GetUserByIdParams &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(userId) ^ runtimeType.hashCode;
}

extension $GetUserByIdParamsExtension on GetUserByIdParams {
  GetUserByIdParams copyWith({String? userId}) {
    return GetUserByIdParams(userId: userId ?? this.userId);
  }

  GetUserByIdParams copyWithWrapped({Wrapped<String>? userId}) {
    return GetUserByIdParams(
        userId: (userId != null ? userId.value : this.userId));
  }
}

@JsonSerializable(explicitToJson: true)
class AcceptPotentialMatchResponse {
  const AcceptPotentialMatchResponse({
    required this.isMatch,
  });

  factory AcceptPotentialMatchResponse.fromJson(Map<String, dynamic> json) =>
      _$AcceptPotentialMatchResponseFromJson(json);

  static const toJsonFactory = _$AcceptPotentialMatchResponseToJson;
  Map<String, dynamic> toJson() => _$AcceptPotentialMatchResponseToJson(this);

  @JsonKey(name: 'isMatch', includeIfNull: false)
  final bool isMatch;
  static const fromJsonFactory = _$AcceptPotentialMatchResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AcceptPotentialMatchResponse &&
            (identical(other.isMatch, isMatch) ||
                const DeepCollectionEquality().equals(other.isMatch, isMatch)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(isMatch) ^ runtimeType.hashCode;
}

extension $AcceptPotentialMatchResponseExtension
    on AcceptPotentialMatchResponse {
  AcceptPotentialMatchResponse copyWith({bool? isMatch}) {
    return AcceptPotentialMatchResponse(isMatch: isMatch ?? this.isMatch);
  }

  AcceptPotentialMatchResponse copyWithWrapped({Wrapped<bool>? isMatch}) {
    return AcceptPotentialMatchResponse(
        isMatch: (isMatch != null ? isMatch.value : this.isMatch));
  }
}

@JsonSerializable(explicitToJson: true)
class CreateChannelInput {
  const CreateChannelInput({
    required this.members,
  });

  factory CreateChannelInput.fromJson(Map<String, dynamic> json) =>
      _$CreateChannelInputFromJson(json);

  static const toJsonFactory = _$CreateChannelInputToJson;
  Map<String, dynamic> toJson() => _$CreateChannelInputToJson(this);

  @JsonKey(name: 'members', includeIfNull: false, defaultValue: <String>[])
  final List<String> members;
  static const fromJsonFactory = _$CreateChannelInputFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CreateChannelInput &&
            (identical(other.members, members) ||
                const DeepCollectionEquality().equals(other.members, members)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(members) ^ runtimeType.hashCode;
}

extension $CreateChannelInputExtension on CreateChannelInput {
  CreateChannelInput copyWith({List<String>? members}) {
    return CreateChannelInput(members: members ?? this.members);
  }

  CreateChannelInput copyWithWrapped({Wrapped<List<String>>? members}) {
    return CreateChannelInput(
        members: (members != null ? members.value : this.members));
  }
}

@JsonSerializable(explicitToJson: true)
class CreateChannelResponse {
  const CreateChannelResponse({
    required this.id,
  });

  factory CreateChannelResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateChannelResponseFromJson(json);

  static const toJsonFactory = _$CreateChannelResponseToJson;
  Map<String, dynamic> toJson() => _$CreateChannelResponseToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  static const fromJsonFactory = _$CreateChannelResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CreateChannelResponse &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^ runtimeType.hashCode;
}

extension $CreateChannelResponseExtension on CreateChannelResponse {
  CreateChannelResponse copyWith({String? id}) {
    return CreateChannelResponse(id: id ?? this.id);
  }

  CreateChannelResponse copyWithWrapped({Wrapped<String>? id}) {
    return CreateChannelResponse(id: (id != null ? id.value : this.id));
  }
}

@JsonSerializable(explicitToJson: true)
class ChatChattingWithResponse {
  const ChatChattingWithResponse({
    required this.id,
    required this.username,
    required this.online,
    this.avatar,
  });

  factory ChatChattingWithResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatChattingWithResponseFromJson(json);

  static const toJsonFactory = _$ChatChattingWithResponseToJson;
  Map<String, dynamic> toJson() => _$ChatChattingWithResponseToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'username', includeIfNull: false)
  final String username;
  @JsonKey(name: 'online', includeIfNull: false)
  final bool online;
  @JsonKey(name: 'avatar', includeIfNull: false)
  final String? avatar;
  static const fromJsonFactory = _$ChatChattingWithResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ChatChattingWithResponse &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.online, online) ||
                const DeepCollectionEquality().equals(other.online, online)) &&
            (identical(other.avatar, avatar) ||
                const DeepCollectionEquality().equals(other.avatar, avatar)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(online) ^
      const DeepCollectionEquality().hash(avatar) ^
      runtimeType.hashCode;
}

extension $ChatChattingWithResponseExtension on ChatChattingWithResponse {
  ChatChattingWithResponse copyWith(
      {String? id, String? username, bool? online, String? avatar}) {
    return ChatChattingWithResponse(
        id: id ?? this.id,
        username: username ?? this.username,
        online: online ?? this.online,
        avatar: avatar ?? this.avatar);
  }

  ChatChattingWithResponse copyWithWrapped(
      {Wrapped<String>? id,
      Wrapped<String>? username,
      Wrapped<bool>? online,
      Wrapped<String?>? avatar}) {
    return ChatChattingWithResponse(
        id: (id != null ? id.value : this.id),
        username: (username != null ? username.value : this.username),
        online: (online != null ? online.value : this.online),
        avatar: (avatar != null ? avatar.value : this.avatar));
  }
}

@JsonSerializable(explicitToJson: true)
class ChatChannelResponse {
  const ChatChannelResponse({
    required this.id,
    required this.chattingWith,
    required this.lastMessage,
  });

  factory ChatChannelResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatChannelResponseFromJson(json);

  static const toJsonFactory = _$ChatChannelResponseToJson;
  Map<String, dynamic> toJson() => _$ChatChannelResponseToJson(this);

  @JsonKey(name: 'id', includeIfNull: false)
  final String id;
  @JsonKey(name: 'chattingWith', includeIfNull: false)
  final ChatChattingWithResponse chattingWith;
  @JsonKey(name: 'lastMessage', includeIfNull: false)
  final String lastMessage;
  static const fromJsonFactory = _$ChatChannelResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ChatChannelResponse &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.chattingWith, chattingWith) ||
                const DeepCollectionEquality()
                    .equals(other.chattingWith, chattingWith)) &&
            (identical(other.lastMessage, lastMessage) ||
                const DeepCollectionEquality()
                    .equals(other.lastMessage, lastMessage)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(chattingWith) ^
      const DeepCollectionEquality().hash(lastMessage) ^
      runtimeType.hashCode;
}

extension $ChatChannelResponseExtension on ChatChannelResponse {
  ChatChannelResponse copyWith(
      {String? id,
      ChatChattingWithResponse? chattingWith,
      String? lastMessage}) {
    return ChatChannelResponse(
        id: id ?? this.id,
        chattingWith: chattingWith ?? this.chattingWith,
        lastMessage: lastMessage ?? this.lastMessage);
  }

  ChatChannelResponse copyWithWrapped(
      {Wrapped<String>? id,
      Wrapped<ChatChattingWithResponse>? chattingWith,
      Wrapped<String>? lastMessage}) {
    return ChatChannelResponse(
        id: (id != null ? id.value : this.id),
        chattingWith:
            (chattingWith != null ? chattingWith.value : this.chattingWith),
        lastMessage:
            (lastMessage != null ? lastMessage.value : this.lastMessage));
  }
}

@JsonSerializable(explicitToJson: true)
class ChatChannelPaginatedResponse {
  const ChatChannelPaginatedResponse({
    required this.items,
    required this.meta,
  });

  factory ChatChannelPaginatedResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatChannelPaginatedResponseFromJson(json);

  static const toJsonFactory = _$ChatChannelPaginatedResponseToJson;
  Map<String, dynamic> toJson() => _$ChatChannelPaginatedResponseToJson(this);

  @JsonKey(
      name: 'items',
      includeIfNull: false,
      defaultValue: <ChatChannelResponse>[])
  final List<ChatChannelResponse> items;
  @JsonKey(name: 'meta', includeIfNull: false)
  final PaginationMetaResponse meta;
  static const fromJsonFactory = _$ChatChannelPaginatedResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ChatChannelPaginatedResponse &&
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

extension $ChatChannelPaginatedResponseExtension
    on ChatChannelPaginatedResponse {
  ChatChannelPaginatedResponse copyWith(
      {List<ChatChannelResponse>? items, PaginationMetaResponse? meta}) {
    return ChatChannelPaginatedResponse(
        items: items ?? this.items, meta: meta ?? this.meta);
  }

  ChatChannelPaginatedResponse copyWithWrapped(
      {Wrapped<List<ChatChannelResponse>>? items,
      Wrapped<PaginationMetaResponse>? meta}) {
    return ChatChannelPaginatedResponse(
        items: (items != null ? items.value : this.items),
        meta: (meta != null ? meta.value : this.meta));
  }
}

@JsonSerializable(explicitToJson: true)
class ChatRefreshTokenResponse {
  const ChatRefreshTokenResponse({
    required this.chatToken,
  });

  factory ChatRefreshTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatRefreshTokenResponseFromJson(json);

  static const toJsonFactory = _$ChatRefreshTokenResponseToJson;
  Map<String, dynamic> toJson() => _$ChatRefreshTokenResponseToJson(this);

  @JsonKey(name: 'chatToken', includeIfNull: false)
  final String chatToken;
  static const fromJsonFactory = _$ChatRefreshTokenResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ChatRefreshTokenResponse &&
            (identical(other.chatToken, chatToken) ||
                const DeepCollectionEquality()
                    .equals(other.chatToken, chatToken)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(chatToken) ^ runtimeType.hashCode;
}

extension $ChatRefreshTokenResponseExtension on ChatRefreshTokenResponse {
  ChatRefreshTokenResponse copyWith({String? chatToken}) {
    return ChatRefreshTokenResponse(chatToken: chatToken ?? this.chatToken);
  }

  ChatRefreshTokenResponse copyWithWrapped({Wrapped<String>? chatToken}) {
    return ChatRefreshTokenResponse(
        chatToken: (chatToken != null ? chatToken.value : this.chatToken));
  }
}

@JsonSerializable(explicitToJson: true)
class AuthResponse {
  const AuthResponse({
    this.accessToken,
    this.phoneVerificationRequired,
    this.refreshToken,
    required this.success,
    this.username,
    this.name,
    this.role,
    this.id,
    this.signupType,
    this.chatToken,
    this.dateOfBirth,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  static const toJsonFactory = _$AuthResponseToJson;
  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);

  @JsonKey(name: 'accessToken', includeIfNull: false)
  final String? accessToken;
  @JsonKey(name: 'phoneVerificationRequired', includeIfNull: false)
  final bool? phoneVerificationRequired;
  @JsonKey(name: 'refreshToken', includeIfNull: false)
  final String? refreshToken;
  @JsonKey(name: 'success', includeIfNull: false)
  final bool success;
  @JsonKey(name: 'username', includeIfNull: false)
  final String? username;
  @JsonKey(name: 'name', includeIfNull: false)
  final String? name;
  @JsonKey(name: 'role', includeIfNull: false)
  final String? role;
  @JsonKey(name: 'id', includeIfNull: false)
  final String? id;
  @JsonKey(name: 'signupType', includeIfNull: false)
  final String? signupType;
  @JsonKey(name: 'chatToken', includeIfNull: false)
  final String? chatToken;
  @JsonKey(name: 'dateOfBirth', includeIfNull: false)
  final DateTime? dateOfBirth;
  static const fromJsonFactory = _$AuthResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AuthResponse &&
            (identical(other.accessToken, accessToken) ||
                const DeepCollectionEquality()
                    .equals(other.accessToken, accessToken)) &&
            (identical(other.phoneVerificationRequired,
                    phoneVerificationRequired) ||
                const DeepCollectionEquality().equals(
                    other.phoneVerificationRequired,
                    phoneVerificationRequired)) &&
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
            (identical(other.role, role) ||
                const DeepCollectionEquality().equals(other.role, role)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.signupType, signupType) ||
                const DeepCollectionEquality()
                    .equals(other.signupType, signupType)) &&
            (identical(other.chatToken, chatToken) ||
                const DeepCollectionEquality()
                    .equals(other.chatToken, chatToken)) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                const DeepCollectionEquality()
                    .equals(other.dateOfBirth, dateOfBirth)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(accessToken) ^
      const DeepCollectionEquality().hash(phoneVerificationRequired) ^
      const DeepCollectionEquality().hash(refreshToken) ^
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(role) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(signupType) ^
      const DeepCollectionEquality().hash(chatToken) ^
      const DeepCollectionEquality().hash(dateOfBirth) ^
      runtimeType.hashCode;
}

extension $AuthResponseExtension on AuthResponse {
  AuthResponse copyWith(
      {String? accessToken,
      bool? phoneVerificationRequired,
      String? refreshToken,
      bool? success,
      String? username,
      String? name,
      String? role,
      String? id,
      String? signupType,
      String? chatToken,
      DateTime? dateOfBirth}) {
    return AuthResponse(
        accessToken: accessToken ?? this.accessToken,
        phoneVerificationRequired:
            phoneVerificationRequired ?? this.phoneVerificationRequired,
        refreshToken: refreshToken ?? this.refreshToken,
        success: success ?? this.success,
        username: username ?? this.username,
        name: name ?? this.name,
        role: role ?? this.role,
        id: id ?? this.id,
        signupType: signupType ?? this.signupType,
        chatToken: chatToken ?? this.chatToken,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth);
  }

  AuthResponse copyWithWrapped(
      {Wrapped<String?>? accessToken,
      Wrapped<bool?>? phoneVerificationRequired,
      Wrapped<String?>? refreshToken,
      Wrapped<bool>? success,
      Wrapped<String?>? username,
      Wrapped<String?>? name,
      Wrapped<String?>? role,
      Wrapped<String?>? id,
      Wrapped<String?>? signupType,
      Wrapped<String?>? chatToken,
      Wrapped<DateTime?>? dateOfBirth}) {
    return AuthResponse(
        accessToken:
            (accessToken != null ? accessToken.value : this.accessToken),
        phoneVerificationRequired: (phoneVerificationRequired != null
            ? phoneVerificationRequired.value
            : this.phoneVerificationRequired),
        refreshToken:
            (refreshToken != null ? refreshToken.value : this.refreshToken),
        success: (success != null ? success.value : this.success),
        username: (username != null ? username.value : this.username),
        name: (name != null ? name.value : this.name),
        role: (role != null ? role.value : this.role),
        id: (id != null ? id.value : this.id),
        signupType: (signupType != null ? signupType.value : this.signupType),
        chatToken: (chatToken != null ? chatToken.value : this.chatToken),
        dateOfBirth:
            (dateOfBirth != null ? dateOfBirth.value : this.dateOfBirth));
  }
}

@JsonSerializable(explicitToJson: true)
class AuthLoginInput {
  const AuthLoginInput({
    required this.email,
    required this.password,
    this.notificationToken,
  });

  factory AuthLoginInput.fromJson(Map<String, dynamic> json) =>
      _$AuthLoginInputFromJson(json);

  static const toJsonFactory = _$AuthLoginInputToJson;
  Map<String, dynamic> toJson() => _$AuthLoginInputToJson(this);

  @JsonKey(name: 'email', includeIfNull: false)
  final String email;
  @JsonKey(name: 'password', includeIfNull: false)
  final String password;
  @JsonKey(name: 'notificationToken', includeIfNull: false)
  final String? notificationToken;
  static const fromJsonFactory = _$AuthLoginInputFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AuthLoginInput &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality()
                    .equals(other.password, password)) &&
            (identical(other.notificationToken, notificationToken) ||
                const DeepCollectionEquality()
                    .equals(other.notificationToken, notificationToken)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(password) ^
      const DeepCollectionEquality().hash(notificationToken) ^
      runtimeType.hashCode;
}

extension $AuthLoginInputExtension on AuthLoginInput {
  AuthLoginInput copyWith(
      {String? email, String? password, String? notificationToken}) {
    return AuthLoginInput(
        email: email ?? this.email,
        password: password ?? this.password,
        notificationToken: notificationToken ?? this.notificationToken);
  }

  AuthLoginInput copyWithWrapped(
      {Wrapped<String>? email,
      Wrapped<String>? password,
      Wrapped<String?>? notificationToken}) {
    return AuthLoginInput(
        email: (email != null ? email.value : this.email),
        password: (password != null ? password.value : this.password),
        notificationToken: (notificationToken != null
            ? notificationToken.value
            : this.notificationToken));
  }
}

@JsonSerializable(explicitToJson: true)
class RegisterInput {
  const RegisterInput({
    required this.email,
    required this.username,
    required this.dateOfBirth,
    required this.password,
    this.timezone,
    this.country,
    this.notificationToken,
  });

  factory RegisterInput.fromJson(Map<String, dynamic> json) =>
      _$RegisterInputFromJson(json);

  static const toJsonFactory = _$RegisterInputToJson;
  Map<String, dynamic> toJson() => _$RegisterInputToJson(this);

  @JsonKey(name: 'email', includeIfNull: false)
  final String email;
  @JsonKey(name: 'username', includeIfNull: false)
  final String username;
  @JsonKey(name: 'dateOfBirth', includeIfNull: false)
  final String dateOfBirth;
  @JsonKey(name: 'password', includeIfNull: false)
  final String password;
  @JsonKey(name: 'timezone', includeIfNull: false)
  final String? timezone;
  @JsonKey(name: 'country', includeIfNull: false)
  final String? country;
  @JsonKey(name: 'notificationToken', includeIfNull: false)
  final String? notificationToken;
  static const fromJsonFactory = _$RegisterInputFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is RegisterInput &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                const DeepCollectionEquality()
                    .equals(other.dateOfBirth, dateOfBirth)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality()
                    .equals(other.password, password)) &&
            (identical(other.timezone, timezone) ||
                const DeepCollectionEquality()
                    .equals(other.timezone, timezone)) &&
            (identical(other.country, country) ||
                const DeepCollectionEquality()
                    .equals(other.country, country)) &&
            (identical(other.notificationToken, notificationToken) ||
                const DeepCollectionEquality()
                    .equals(other.notificationToken, notificationToken)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(dateOfBirth) ^
      const DeepCollectionEquality().hash(password) ^
      const DeepCollectionEquality().hash(timezone) ^
      const DeepCollectionEquality().hash(country) ^
      const DeepCollectionEquality().hash(notificationToken) ^
      runtimeType.hashCode;
}

extension $RegisterInputExtension on RegisterInput {
  RegisterInput copyWith(
      {String? email,
      String? username,
      String? dateOfBirth,
      String? password,
      String? timezone,
      String? country,
      String? notificationToken}) {
    return RegisterInput(
        email: email ?? this.email,
        username: username ?? this.username,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        password: password ?? this.password,
        timezone: timezone ?? this.timezone,
        country: country ?? this.country,
        notificationToken: notificationToken ?? this.notificationToken);
  }

  RegisterInput copyWithWrapped(
      {Wrapped<String>? email,
      Wrapped<String>? username,
      Wrapped<String>? dateOfBirth,
      Wrapped<String>? password,
      Wrapped<String?>? timezone,
      Wrapped<String?>? country,
      Wrapped<String?>? notificationToken}) {
    return RegisterInput(
        email: (email != null ? email.value : this.email),
        username: (username != null ? username.value : this.username),
        dateOfBirth:
            (dateOfBirth != null ? dateOfBirth.value : this.dateOfBirth),
        password: (password != null ? password.value : this.password),
        timezone: (timezone != null ? timezone.value : this.timezone),
        country: (country != null ? country.value : this.country),
        notificationToken: (notificationToken != null
            ? notificationToken.value
            : this.notificationToken));
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

  @JsonKey(name: 'code', includeIfNull: false)
  final double code;
  static const fromJsonFactory = _$VerifyCodeInputFromJson;

  @override
  bool operator ==(Object other) {
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
class PhoneVerificationInput {
  const PhoneVerificationInput({
    required this.phoneNumber,
  });

  factory PhoneVerificationInput.fromJson(Map<String, dynamic> json) =>
      _$PhoneVerificationInputFromJson(json);

  static const toJsonFactory = _$PhoneVerificationInputToJson;
  Map<String, dynamic> toJson() => _$PhoneVerificationInputToJson(this);

  @JsonKey(name: 'phoneNumber', includeIfNull: false)
  final String phoneNumber;
  static const fromJsonFactory = _$PhoneVerificationInputFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PhoneVerificationInput &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality()
                    .equals(other.phoneNumber, phoneNumber)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(phoneNumber) ^ runtimeType.hashCode;
}

extension $PhoneVerificationInputExtension on PhoneVerificationInput {
  PhoneVerificationInput copyWith({String? phoneNumber}) {
    return PhoneVerificationInput(phoneNumber: phoneNumber ?? this.phoneNumber);
  }

  PhoneVerificationInput copyWithWrapped({Wrapped<String>? phoneNumber}) {
    return PhoneVerificationInput(
        phoneNumber:
            (phoneNumber != null ? phoneNumber.value : this.phoneNumber));
  }
}

@JsonSerializable(explicitToJson: true)
class VerifyGoogleIdInput {
  const VerifyGoogleIdInput({
    required this.token,
    this.fullName,
    this.notificationToken,
  });

  factory VerifyGoogleIdInput.fromJson(Map<String, dynamic> json) =>
      _$VerifyGoogleIdInputFromJson(json);

  static const toJsonFactory = _$VerifyGoogleIdInputToJson;
  Map<String, dynamic> toJson() => _$VerifyGoogleIdInputToJson(this);

  @JsonKey(name: 'token', includeIfNull: false)
  final String token;
  @JsonKey(name: 'fullName', includeIfNull: false)
  final String? fullName;
  @JsonKey(name: 'notificationToken', includeIfNull: false)
  final String? notificationToken;
  static const fromJsonFactory = _$VerifyGoogleIdInputFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is VerifyGoogleIdInput &&
            (identical(other.token, token) ||
                const DeepCollectionEquality().equals(other.token, token)) &&
            (identical(other.fullName, fullName) ||
                const DeepCollectionEquality()
                    .equals(other.fullName, fullName)) &&
            (identical(other.notificationToken, notificationToken) ||
                const DeepCollectionEquality()
                    .equals(other.notificationToken, notificationToken)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(token) ^
      const DeepCollectionEquality().hash(fullName) ^
      const DeepCollectionEquality().hash(notificationToken) ^
      runtimeType.hashCode;
}

extension $VerifyGoogleIdInputExtension on VerifyGoogleIdInput {
  VerifyGoogleIdInput copyWith(
      {String? token, String? fullName, String? notificationToken}) {
    return VerifyGoogleIdInput(
        token: token ?? this.token,
        fullName: fullName ?? this.fullName,
        notificationToken: notificationToken ?? this.notificationToken);
  }

  VerifyGoogleIdInput copyWithWrapped(
      {Wrapped<String>? token,
      Wrapped<String?>? fullName,
      Wrapped<String?>? notificationToken}) {
    return VerifyGoogleIdInput(
        token: (token != null ? token.value : this.token),
        fullName: (fullName != null ? fullName.value : this.fullName),
        notificationToken: (notificationToken != null
            ? notificationToken.value
            : this.notificationToken));
  }
}

@JsonSerializable(explicitToJson: true)
class EpicGamesVerifyInput {
  const EpicGamesVerifyInput({
    required this.code,
    required this.userId,
  });

  factory EpicGamesVerifyInput.fromJson(Map<String, dynamic> json) =>
      _$EpicGamesVerifyInputFromJson(json);

  static const toJsonFactory = _$EpicGamesVerifyInputToJson;
  Map<String, dynamic> toJson() => _$EpicGamesVerifyInputToJson(this);

  @JsonKey(name: 'code', includeIfNull: false)
  final String code;
  @JsonKey(name: 'userId', includeIfNull: false)
  final String userId;
  static const fromJsonFactory = _$EpicGamesVerifyInputFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is EpicGamesVerifyInput &&
            (identical(other.code, code) ||
                const DeepCollectionEquality().equals(other.code, code)) &&
            (identical(other.userId, userId) ||
                const DeepCollectionEquality().equals(other.userId, userId)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(code) ^
      const DeepCollectionEquality().hash(userId) ^
      runtimeType.hashCode;
}

extension $EpicGamesVerifyInputExtension on EpicGamesVerifyInput {
  EpicGamesVerifyInput copyWith({String? code, String? userId}) {
    return EpicGamesVerifyInput(
        code: code ?? this.code, userId: userId ?? this.userId);
  }

  EpicGamesVerifyInput copyWithWrapped(
      {Wrapped<String>? code, Wrapped<String>? userId}) {
    return EpicGamesVerifyInput(
        code: (code != null ? code.value : this.code),
        userId: (userId != null ? userId.value : this.userId));
  }
}

@JsonSerializable(explicitToJson: true)
class ForgotPasswordInput {
  const ForgotPasswordInput({
    this.email,
    this.phoneNumber,
  });

  factory ForgotPasswordInput.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordInputFromJson(json);

  static const toJsonFactory = _$ForgotPasswordInputToJson;
  Map<String, dynamic> toJson() => _$ForgotPasswordInputToJson(this);

  @JsonKey(name: 'email', includeIfNull: false)
  final String? email;
  @JsonKey(name: 'phoneNumber', includeIfNull: false)
  final String? phoneNumber;
  static const fromJsonFactory = _$ForgotPasswordInputFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ForgotPasswordInput &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality()
                    .equals(other.phoneNumber, phoneNumber)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(phoneNumber) ^
      runtimeType.hashCode;
}

extension $ForgotPasswordInputExtension on ForgotPasswordInput {
  ForgotPasswordInput copyWith({String? email, String? phoneNumber}) {
    return ForgotPasswordInput(
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber);
  }

  ForgotPasswordInput copyWithWrapped(
      {Wrapped<String?>? email, Wrapped<String?>? phoneNumber}) {
    return ForgotPasswordInput(
        email: (email != null ? email.value : this.email),
        phoneNumber:
            (phoneNumber != null ? phoneNumber.value : this.phoneNumber));
  }
}

@JsonSerializable(explicitToJson: true)
class ResetPasswordInput {
  const ResetPasswordInput({
    this.email,
    this.phoneNumber,
    required this.password,
  });

  factory ResetPasswordInput.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordInputFromJson(json);

  static const toJsonFactory = _$ResetPasswordInputToJson;
  Map<String, dynamic> toJson() => _$ResetPasswordInputToJson(this);

  @JsonKey(name: 'email', includeIfNull: false)
  final String? email;
  @JsonKey(name: 'phoneNumber', includeIfNull: false)
  final String? phoneNumber;
  @JsonKey(name: 'password', includeIfNull: false)
  final String password;
  static const fromJsonFactory = _$ResetPasswordInputFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ResetPasswordInput &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality()
                    .equals(other.phoneNumber, phoneNumber)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality()
                    .equals(other.password, password)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(phoneNumber) ^
      const DeepCollectionEquality().hash(password) ^
      runtimeType.hashCode;
}

extension $ResetPasswordInputExtension on ResetPasswordInput {
  ResetPasswordInput copyWith(
      {String? email, String? phoneNumber, String? password}) {
    return ResetPasswordInput(
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        password: password ?? this.password);
  }

  ResetPasswordInput copyWithWrapped(
      {Wrapped<String?>? email,
      Wrapped<String?>? phoneNumber,
      Wrapped<String>? password}) {
    return ResetPasswordInput(
        email: (email != null ? email.value : this.email),
        phoneNumber:
            (phoneNumber != null ? phoneNumber.value : this.phoneNumber),
        password: (password != null ? password.value : this.password));
  }
}

@JsonSerializable(explicitToJson: true)
class SetDateOfBirthInput {
  const SetDateOfBirthInput({
    required this.dateOfBirth,
  });

  factory SetDateOfBirthInput.fromJson(Map<String, dynamic> json) =>
      _$SetDateOfBirthInputFromJson(json);

  static const toJsonFactory = _$SetDateOfBirthInputToJson;
  Map<String, dynamic> toJson() => _$SetDateOfBirthInputToJson(this);

  @JsonKey(name: 'dateOfBirth', includeIfNull: false)
  final String dateOfBirth;
  static const fromJsonFactory = _$SetDateOfBirthInputFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SetDateOfBirthInput &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                const DeepCollectionEquality()
                    .equals(other.dateOfBirth, dateOfBirth)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(dateOfBirth) ^ runtimeType.hashCode;
}

extension $SetDateOfBirthInputExtension on SetDateOfBirthInput {
  SetDateOfBirthInput copyWith({String? dateOfBirth}) {
    return SetDateOfBirthInput(dateOfBirth: dateOfBirth ?? this.dateOfBirth);
  }

  SetDateOfBirthInput copyWithWrapped({Wrapped<String>? dateOfBirth}) {
    return SetDateOfBirthInput(
        dateOfBirth:
            (dateOfBirth != null ? dateOfBirth.value : this.dateOfBirth));
  }
}

@JsonSerializable(explicitToJson: true)
class SetUserPhoneInput {
  const SetUserPhoneInput({
    required this.email,
    required this.phoneNumber,
  });

  factory SetUserPhoneInput.fromJson(Map<String, dynamic> json) =>
      _$SetUserPhoneInputFromJson(json);

  static const toJsonFactory = _$SetUserPhoneInputToJson;
  Map<String, dynamic> toJson() => _$SetUserPhoneInputToJson(this);

  @JsonKey(name: 'email', includeIfNull: false)
  final String email;
  @JsonKey(name: 'phoneNumber', includeIfNull: false)
  final String phoneNumber;
  static const fromJsonFactory = _$SetUserPhoneInputFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SetUserPhoneInput &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality()
                    .equals(other.phoneNumber, phoneNumber)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(phoneNumber) ^
      runtimeType.hashCode;
}

extension $SetUserPhoneInputExtension on SetUserPhoneInput {
  SetUserPhoneInput copyWith({String? email, String? phoneNumber}) {
    return SetUserPhoneInput(
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber);
  }

  SetUserPhoneInput copyWithWrapped(
      {Wrapped<String>? email, Wrapped<String>? phoneNumber}) {
    return SetUserPhoneInput(
        email: (email != null ? email.value : this.email),
        phoneNumber:
            (phoneNumber != null ? phoneNumber.value : this.phoneNumber));
  }
}

@JsonSerializable(explicitToJson: true)
class VerifyAppleIdInput {
  const VerifyAppleIdInput({
    required this.token,
    this.email,
    this.fullName,
    this.notificationToken,
  });

  factory VerifyAppleIdInput.fromJson(Map<String, dynamic> json) =>
      _$VerifyAppleIdInputFromJson(json);

  static const toJsonFactory = _$VerifyAppleIdInputToJson;
  Map<String, dynamic> toJson() => _$VerifyAppleIdInputToJson(this);

  @JsonKey(name: 'token', includeIfNull: false)
  final String token;
  @JsonKey(name: 'email', includeIfNull: false)
  final String? email;
  @JsonKey(name: 'fullName', includeIfNull: false)
  final String? fullName;
  @JsonKey(name: 'notificationToken', includeIfNull: false)
  final String? notificationToken;
  static const fromJsonFactory = _$VerifyAppleIdInputFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is VerifyAppleIdInput &&
            (identical(other.token, token) ||
                const DeepCollectionEquality().equals(other.token, token)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.fullName, fullName) ||
                const DeepCollectionEquality()
                    .equals(other.fullName, fullName)) &&
            (identical(other.notificationToken, notificationToken) ||
                const DeepCollectionEquality()
                    .equals(other.notificationToken, notificationToken)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(token) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(fullName) ^
      const DeepCollectionEquality().hash(notificationToken) ^
      runtimeType.hashCode;
}

extension $VerifyAppleIdInputExtension on VerifyAppleIdInput {
  VerifyAppleIdInput copyWith(
      {String? token,
      String? email,
      String? fullName,
      String? notificationToken}) {
    return VerifyAppleIdInput(
        token: token ?? this.token,
        email: email ?? this.email,
        fullName: fullName ?? this.fullName,
        notificationToken: notificationToken ?? this.notificationToken);
  }

  VerifyAppleIdInput copyWithWrapped(
      {Wrapped<String>? token,
      Wrapped<String?>? email,
      Wrapped<String?>? fullName,
      Wrapped<String?>? notificationToken}) {
    return VerifyAppleIdInput(
        token: (token != null ? token.value : this.token),
        email: (email != null ? email.value : this.email),
        fullName: (fullName != null ? fullName.value : this.fullName),
        notificationToken: (notificationToken != null
            ? notificationToken.value
            : this.notificationToken));
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

  @JsonKey(name: 'total', includeIfNull: false)
  final double total;
  @JsonKey(name: 'currentWeek', includeIfNull: false)
  final double currentWeek;
  static const fromJsonFactory = _$StatisticsTotalCountResponseFromJson;

  @override
  bool operator ==(Object other) {
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

  @JsonKey(name: 'onboardingPct', includeIfNull: false)
  final double onboardingPct;
  @JsonKey(name: 'currentWeek', includeIfNull: false)
  final double currentWeek;
  static const fromJsonFactory =
      _$StatisticsOnboardingCompletionResponseFromJson;

  @override
  bool operator ==(Object other) {
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

  @JsonKey(name: 'date', includeIfNull: false)
  final String date;
  @JsonKey(name: 'quantity', includeIfNull: false)
  final double quantity;
  static const fromJsonFactory = _$NewUsersRegisteredObjectResponseFromJson;

  @override
  bool operator ==(Object other) {
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

  @JsonKey(
      name: 'chart',
      includeIfNull: false,
      defaultValue: <NewUsersRegisteredObjectResponse>[])
  final List<NewUsersRegisteredObjectResponse> chart;
  static const fromJsonFactory = _$StatisticsNewUsersRegisteredResponseFromJson;

  @override
  bool operator ==(Object other) {
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

  @JsonKey(name: 'allUsers', includeIfNull: false)
  final double? allUsers;
  @JsonKey(name: 'apexLegendsPlayers', includeIfNull: false)
  final double? apexLegendsPlayers;
  @JsonKey(name: 'callOfDutyPlayers', includeIfNull: false)
  final double? callOfDutyPlayers;
  @JsonKey(name: 'fortnitePlayers', includeIfNull: false)
  final double? fortnitePlayers;
  @JsonKey(name: 'rocketLeaguePlayers', includeIfNull: false)
  final double? rocketLeaguePlayers;
  static const fromJsonFactory = _$UserGroupCountsResponseFromJson;

  @override
  bool operator ==(Object other) {
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

  @JsonKey(name: 'firstName', includeIfNull: false)
  final String firstName;
  @JsonKey(name: 'lastName', includeIfNull: false)
  final String lastName;
  @JsonKey(name: 'email', includeIfNull: false)
  final String email;
  @JsonKey(name: 'message', includeIfNull: false)
  final String message;
  static const fromJsonFactory = _$ContactFormInputFromJson;

  @override
  bool operator ==(Object other) {
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

@JsonSerializable(explicitToJson: true)
class GameResponse {
  const GameResponse({
    required this.display,
    required this.game,
    required this.iconKey,
  });

  factory GameResponse.fromJson(Map<String, dynamic> json) =>
      _$GameResponseFromJson(json);

  static const toJsonFactory = _$GameResponseToJson;
  Map<String, dynamic> toJson() => _$GameResponseToJson(this);

  @JsonKey(name: 'display', includeIfNull: false)
  final String display;
  @JsonKey(
    name: 'game',
    includeIfNull: false,
    toJson: gameResponseGameToJson,
    fromJson: gameResponseGameFromJson,
  )
  final enums.GameResponseGame game;
  @JsonKey(name: 'iconKey', includeIfNull: false)
  final String iconKey;
  static const fromJsonFactory = _$GameResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is GameResponse &&
            (identical(other.display, display) ||
                const DeepCollectionEquality()
                    .equals(other.display, display)) &&
            (identical(other.game, game) ||
                const DeepCollectionEquality().equals(other.game, game)) &&
            (identical(other.iconKey, iconKey) ||
                const DeepCollectionEquality().equals(other.iconKey, iconKey)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(display) ^
      const DeepCollectionEquality().hash(game) ^
      const DeepCollectionEquality().hash(iconKey) ^
      runtimeType.hashCode;
}

extension $GameResponseExtension on GameResponse {
  GameResponse copyWith(
      {String? display, enums.GameResponseGame? game, String? iconKey}) {
    return GameResponse(
        display: display ?? this.display,
        game: game ?? this.game,
        iconKey: iconKey ?? this.iconKey);
  }

  GameResponse copyWithWrapped(
      {Wrapped<String>? display,
      Wrapped<enums.GameResponseGame>? game,
      Wrapped<String>? iconKey}) {
    return GameResponse(
        display: (display != null ? display.value : this.display),
        game: (game != null ? game.value : this.game),
        iconKey: (iconKey != null ? iconKey.value : this.iconKey));
  }
}

@JsonSerializable(explicitToJson: true)
class SliderOptionResponse {
  const SliderOptionResponse({
    required this.minValue,
    required this.maxValue,
    required this.attribute,
  });

  factory SliderOptionResponse.fromJson(Map<String, dynamic> json) =>
      _$SliderOptionResponseFromJson(json);

  static const toJsonFactory = _$SliderOptionResponseToJson;
  Map<String, dynamic> toJson() => _$SliderOptionResponseToJson(this);

  @JsonKey(name: 'minValue', includeIfNull: false)
  final String minValue;
  @JsonKey(name: 'maxValue', includeIfNull: false)
  final String maxValue;
  @JsonKey(
    name: 'attribute',
    includeIfNull: false,
    toJson: sliderOptionResponseAttributeToJson,
    fromJson: sliderOptionResponseAttributeFromJson,
  )
  final enums.SliderOptionResponseAttribute attribute;
  static const fromJsonFactory = _$SliderOptionResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SliderOptionResponse &&
            (identical(other.minValue, minValue) ||
                const DeepCollectionEquality()
                    .equals(other.minValue, minValue)) &&
            (identical(other.maxValue, maxValue) ||
                const DeepCollectionEquality()
                    .equals(other.maxValue, maxValue)) &&
            (identical(other.attribute, attribute) ||
                const DeepCollectionEquality()
                    .equals(other.attribute, attribute)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(minValue) ^
      const DeepCollectionEquality().hash(maxValue) ^
      const DeepCollectionEquality().hash(attribute) ^
      runtimeType.hashCode;
}

extension $SliderOptionResponseExtension on SliderOptionResponse {
  SliderOptionResponse copyWith(
      {String? minValue,
      String? maxValue,
      enums.SliderOptionResponseAttribute? attribute}) {
    return SliderOptionResponse(
        minValue: minValue ?? this.minValue,
        maxValue: maxValue ?? this.maxValue,
        attribute: attribute ?? this.attribute);
  }

  SliderOptionResponse copyWithWrapped(
      {Wrapped<String>? minValue,
      Wrapped<String>? maxValue,
      Wrapped<enums.SliderOptionResponseAttribute>? attribute}) {
    return SliderOptionResponse(
        minValue: (minValue != null ? minValue.value : this.minValue),
        maxValue: (maxValue != null ? maxValue.value : this.maxValue),
        attribute: (attribute != null ? attribute.value : this.attribute));
  }
}

@JsonSerializable(explicitToJson: true)
class DropdownOptionResponse {
  const DropdownOptionResponse({
    required this.display,
    required this.attribute,
  });

  factory DropdownOptionResponse.fromJson(Map<String, dynamic> json) =>
      _$DropdownOptionResponseFromJson(json);

  static const toJsonFactory = _$DropdownOptionResponseToJson;
  Map<String, dynamic> toJson() => _$DropdownOptionResponseToJson(this);

  @JsonKey(name: 'display', includeIfNull: false)
  final String display;
  @JsonKey(name: 'attribute', includeIfNull: false)
  final String attribute;
  static const fromJsonFactory = _$DropdownOptionResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is DropdownOptionResponse &&
            (identical(other.display, display) ||
                const DeepCollectionEquality()
                    .equals(other.display, display)) &&
            (identical(other.attribute, attribute) ||
                const DeepCollectionEquality()
                    .equals(other.attribute, attribute)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(display) ^
      const DeepCollectionEquality().hash(attribute) ^
      runtimeType.hashCode;
}

extension $DropdownOptionResponseExtension on DropdownOptionResponse {
  DropdownOptionResponse copyWith({String? display, String? attribute}) {
    return DropdownOptionResponse(
        display: display ?? this.display,
        attribute: attribute ?? this.attribute);
  }

  DropdownOptionResponse copyWithWrapped(
      {Wrapped<String>? display, Wrapped<String>? attribute}) {
    return DropdownOptionResponse(
        display: (display != null ? display.value : this.display),
        attribute: (attribute != null ? attribute.value : this.attribute));
  }
}

@JsonSerializable(explicitToJson: true)
class GamePreferenceInputResponse {
  const GamePreferenceInputResponse({
    required this.title,
    required this.type,
    this.sliderOptions,
    this.selectOptions,
    this.dropdownOptions,
  });

  factory GamePreferenceInputResponse.fromJson(Map<String, dynamic> json) =>
      _$GamePreferenceInputResponseFromJson(json);

  static const toJsonFactory = _$GamePreferenceInputResponseToJson;
  Map<String, dynamic> toJson() => _$GamePreferenceInputResponseToJson(this);

  @JsonKey(name: 'title', includeIfNull: false)
  final String title;
  @JsonKey(
    name: 'type',
    includeIfNull: false,
    toJson: gamePreferenceInputResponseTypeToJson,
    fromJson: gamePreferenceInputResponseTypeFromJson,
  )
  final enums.GamePreferenceInputResponseType type;
  @JsonKey(
      name: 'sliderOptions',
      includeIfNull: false,
      defaultValue: <SliderOptionResponse>[])
  final List<SliderOptionResponse>? sliderOptions;
  @JsonKey(
      name: 'selectOptions',
      includeIfNull: false,
      defaultValue: <SelectOptionResponse>[])
  final List<SelectOptionResponse>? selectOptions;
  @JsonKey(
      name: 'dropdownOptions',
      includeIfNull: false,
      defaultValue: <DropdownOptionResponse>[])
  final List<DropdownOptionResponse>? dropdownOptions;
  static const fromJsonFactory = _$GamePreferenceInputResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is GamePreferenceInputResponse &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.sliderOptions, sliderOptions) ||
                const DeepCollectionEquality()
                    .equals(other.sliderOptions, sliderOptions)) &&
            (identical(other.selectOptions, selectOptions) ||
                const DeepCollectionEquality()
                    .equals(other.selectOptions, selectOptions)) &&
            (identical(other.dropdownOptions, dropdownOptions) ||
                const DeepCollectionEquality()
                    .equals(other.dropdownOptions, dropdownOptions)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(sliderOptions) ^
      const DeepCollectionEquality().hash(selectOptions) ^
      const DeepCollectionEquality().hash(dropdownOptions) ^
      runtimeType.hashCode;
}

extension $GamePreferenceInputResponseExtension on GamePreferenceInputResponse {
  GamePreferenceInputResponse copyWith(
      {String? title,
      enums.GamePreferenceInputResponseType? type,
      List<SliderOptionResponse>? sliderOptions,
      List<SelectOptionResponse>? selectOptions,
      List<DropdownOptionResponse>? dropdownOptions}) {
    return GamePreferenceInputResponse(
        title: title ?? this.title,
        type: type ?? this.type,
        sliderOptions: sliderOptions ?? this.sliderOptions,
        selectOptions: selectOptions ?? this.selectOptions,
        dropdownOptions: dropdownOptions ?? this.dropdownOptions);
  }

  GamePreferenceInputResponse copyWithWrapped(
      {Wrapped<String>? title,
      Wrapped<enums.GamePreferenceInputResponseType>? type,
      Wrapped<List<SliderOptionResponse>?>? sliderOptions,
      Wrapped<List<SelectOptionResponse>?>? selectOptions,
      Wrapped<List<DropdownOptionResponse>?>? dropdownOptions}) {
    return GamePreferenceInputResponse(
        title: (title != null ? title.value : this.title),
        type: (type != null ? type.value : this.type),
        sliderOptions:
            (sliderOptions != null ? sliderOptions.value : this.sliderOptions),
        selectOptions:
            (selectOptions != null ? selectOptions.value : this.selectOptions),
        dropdownOptions: (dropdownOptions != null
            ? dropdownOptions.value
            : this.dropdownOptions));
  }
}

@JsonSerializable(explicitToJson: true)
class SelectOptionResponse {
  const SelectOptionResponse({
    required this.display,
    required this.attribute,
    this.cascade,
  });

  factory SelectOptionResponse.fromJson(Map<String, dynamic> json) =>
      _$SelectOptionResponseFromJson(json);

  static const toJsonFactory = _$SelectOptionResponseToJson;
  Map<String, dynamic> toJson() => _$SelectOptionResponseToJson(this);

  @JsonKey(name: 'display', includeIfNull: false)
  final String display;
  @JsonKey(
    name: 'attribute',
    includeIfNull: false,
    toJson: selectOptionResponseAttributeToJson,
    fromJson: selectOptionResponseAttributeFromJson,
  )
  final enums.SelectOptionResponseAttribute attribute;
  @JsonKey(name: 'cascade', includeIfNull: false)
  final GamePreferenceInputResponse? cascade;
  static const fromJsonFactory = _$SelectOptionResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SelectOptionResponse &&
            (identical(other.display, display) ||
                const DeepCollectionEquality()
                    .equals(other.display, display)) &&
            (identical(other.attribute, attribute) ||
                const DeepCollectionEquality()
                    .equals(other.attribute, attribute)) &&
            (identical(other.cascade, cascade) ||
                const DeepCollectionEquality().equals(other.cascade, cascade)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(display) ^
      const DeepCollectionEquality().hash(attribute) ^
      const DeepCollectionEquality().hash(cascade) ^
      runtimeType.hashCode;
}

extension $SelectOptionResponseExtension on SelectOptionResponse {
  SelectOptionResponse copyWith(
      {String? display,
      enums.SelectOptionResponseAttribute? attribute,
      GamePreferenceInputResponse? cascade}) {
    return SelectOptionResponse(
        display: display ?? this.display,
        attribute: attribute ?? this.attribute,
        cascade: cascade ?? this.cascade);
  }

  SelectOptionResponse copyWithWrapped(
      {Wrapped<String>? display,
      Wrapped<enums.SelectOptionResponseAttribute>? attribute,
      Wrapped<GamePreferenceInputResponse?>? cascade}) {
    return SelectOptionResponse(
        display: (display != null ? display.value : this.display),
        attribute: (attribute != null ? attribute.value : this.attribute),
        cascade: (cascade != null ? cascade.value : this.cascade));
  }
}

@JsonSerializable(explicitToJson: true)
class ApiV1UsersImagePatch$RequestBody {
  const ApiV1UsersImagePatch$RequestBody({
    this.file,
  });

  factory ApiV1UsersImagePatch$RequestBody.fromJson(
          Map<String, dynamic> json) =>
      _$ApiV1UsersImagePatch$RequestBodyFromJson(json);

  static const toJsonFactory = _$ApiV1UsersImagePatch$RequestBodyToJson;
  Map<String, dynamic> toJson() =>
      _$ApiV1UsersImagePatch$RequestBodyToJson(this);

  @JsonKey(name: 'file', includeIfNull: false)
  final String? file;
  static const fromJsonFactory = _$ApiV1UsersImagePatch$RequestBodyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ApiV1UsersImagePatch$RequestBody &&
            (identical(other.file, file) ||
                const DeepCollectionEquality().equals(other.file, file)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(file) ^ runtimeType.hashCode;
}

extension $ApiV1UsersImagePatch$RequestBodyExtension
    on ApiV1UsersImagePatch$RequestBody {
  ApiV1UsersImagePatch$RequestBody copyWith({String? file}) {
    return ApiV1UsersImagePatch$RequestBody(file: file ?? this.file);
  }

  ApiV1UsersImagePatch$RequestBody copyWithWrapped({Wrapped<String?>? file}) {
    return ApiV1UsersImagePatch$RequestBody(
        file: (file != null ? file.value : this.file));
  }
}

@JsonSerializable(explicitToJson: true)
class ApiV1UsersAudioIntroPatch$RequestBody {
  const ApiV1UsersAudioIntroPatch$RequestBody({
    this.file,
  });

  factory ApiV1UsersAudioIntroPatch$RequestBody.fromJson(
          Map<String, dynamic> json) =>
      _$ApiV1UsersAudioIntroPatch$RequestBodyFromJson(json);

  static const toJsonFactory = _$ApiV1UsersAudioIntroPatch$RequestBodyToJson;
  Map<String, dynamic> toJson() =>
      _$ApiV1UsersAudioIntroPatch$RequestBodyToJson(this);

  @JsonKey(name: 'file', includeIfNull: false)
  final String? file;
  static const fromJsonFactory =
      _$ApiV1UsersAudioIntroPatch$RequestBodyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ApiV1UsersAudioIntroPatch$RequestBody &&
            (identical(other.file, file) ||
                const DeepCollectionEquality().equals(other.file, file)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(file) ^ runtimeType.hashCode;
}

extension $ApiV1UsersAudioIntroPatch$RequestBodyExtension
    on ApiV1UsersAudioIntroPatch$RequestBody {
  ApiV1UsersAudioIntroPatch$RequestBody copyWith({String? file}) {
    return ApiV1UsersAudioIntroPatch$RequestBody(file: file ?? this.file);
  }

  ApiV1UsersAudioIntroPatch$RequestBody copyWithWrapped(
      {Wrapped<String?>? file}) {
    return ApiV1UsersAudioIntroPatch$RequestBody(
        file: (file != null ? file.value : this.file));
  }
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

String? userGameResponseGameNullableToJson(
    enums.UserGameResponseGame? userGameResponseGame) {
  return userGameResponseGame?.value;
}

String? userGameResponseGameToJson(
    enums.UserGameResponseGame userGameResponseGame) {
  return userGameResponseGame.value;
}

enums.UserGameResponseGame userGameResponseGameFromJson(
  Object? userGameResponseGame, [
  enums.UserGameResponseGame? defaultValue,
]) {
  return enums.UserGameResponseGame.values
          .firstWhereOrNull((e) => e.value == userGameResponseGame) ??
      defaultValue ??
      enums.UserGameResponseGame.swaggerGeneratedUnknown;
}

enums.UserGameResponseGame? userGameResponseGameNullableFromJson(
  Object? userGameResponseGame, [
  enums.UserGameResponseGame? defaultValue,
]) {
  if (userGameResponseGame == null) {
    return null;
  }
  return enums.UserGameResponseGame.values
          .firstWhereOrNull((e) => e.value == userGameResponseGame) ??
      defaultValue;
}

String userGameResponseGameExplodedListToJson(
    List<enums.UserGameResponseGame>? userGameResponseGame) {
  return userGameResponseGame?.map((e) => e.value!).join(',') ?? '';
}

List<String> userGameResponseGameListToJson(
    List<enums.UserGameResponseGame>? userGameResponseGame) {
  if (userGameResponseGame == null) {
    return [];
  }

  return userGameResponseGame.map((e) => e.value!).toList();
}

List<enums.UserGameResponseGame> userGameResponseGameListFromJson(
  List? userGameResponseGame, [
  List<enums.UserGameResponseGame>? defaultValue,
]) {
  if (userGameResponseGame == null) {
    return defaultValue ?? [];
  }

  return userGameResponseGame
      .map((e) => userGameResponseGameFromJson(e.toString()))
      .toList();
}

List<enums.UserGameResponseGame>? userGameResponseGameNullableListFromJson(
  List? userGameResponseGame, [
  List<enums.UserGameResponseGame>? defaultValue,
]) {
  if (userGameResponseGame == null) {
    return defaultValue;
  }

  return userGameResponseGame
      .map((e) => userGameResponseGameFromJson(e.toString()))
      .toList();
}

String? notificationDataResponseNotificationTypeNullableToJson(
    enums.NotificationDataResponseNotificationType?
        notificationDataResponseNotificationType) {
  return notificationDataResponseNotificationType?.value;
}

String? notificationDataResponseNotificationTypeToJson(
    enums.NotificationDataResponseNotificationType
        notificationDataResponseNotificationType) {
  return notificationDataResponseNotificationType.value;
}

enums.NotificationDataResponseNotificationType
    notificationDataResponseNotificationTypeFromJson(
  Object? notificationDataResponseNotificationType, [
  enums.NotificationDataResponseNotificationType? defaultValue,
]) {
  return enums.NotificationDataResponseNotificationType.values.firstWhereOrNull(
          (e) => e.value == notificationDataResponseNotificationType) ??
      defaultValue ??
      enums.NotificationDataResponseNotificationType.swaggerGeneratedUnknown;
}

enums.NotificationDataResponseNotificationType?
    notificationDataResponseNotificationTypeNullableFromJson(
  Object? notificationDataResponseNotificationType, [
  enums.NotificationDataResponseNotificationType? defaultValue,
]) {
  if (notificationDataResponseNotificationType == null) {
    return null;
  }
  return enums.NotificationDataResponseNotificationType.values.firstWhereOrNull(
          (e) => e.value == notificationDataResponseNotificationType) ??
      defaultValue;
}

String notificationDataResponseNotificationTypeExplodedListToJson(
    List<enums.NotificationDataResponseNotificationType>?
        notificationDataResponseNotificationType) {
  return notificationDataResponseNotificationType
          ?.map((e) => e.value!)
          .join(',') ??
      '';
}

List<String> notificationDataResponseNotificationTypeListToJson(
    List<enums.NotificationDataResponseNotificationType>?
        notificationDataResponseNotificationType) {
  if (notificationDataResponseNotificationType == null) {
    return [];
  }

  return notificationDataResponseNotificationType.map((e) => e.value!).toList();
}

List<enums.NotificationDataResponseNotificationType>
    notificationDataResponseNotificationTypeListFromJson(
  List? notificationDataResponseNotificationType, [
  List<enums.NotificationDataResponseNotificationType>? defaultValue,
]) {
  if (notificationDataResponseNotificationType == null) {
    return defaultValue ?? [];
  }

  return notificationDataResponseNotificationType
      .map(
          (e) => notificationDataResponseNotificationTypeFromJson(e.toString()))
      .toList();
}

List<enums.NotificationDataResponseNotificationType>?
    notificationDataResponseNotificationTypeNullableListFromJson(
  List? notificationDataResponseNotificationType, [
  List<enums.NotificationDataResponseNotificationType>? defaultValue,
]) {
  if (notificationDataResponseNotificationType == null) {
    return defaultValue;
  }

  return notificationDataResponseNotificationType
      .map(
          (e) => notificationDataResponseNotificationTypeFromJson(e.toString()))
      .toList();
}

String? gameResponseGameNullableToJson(
    enums.GameResponseGame? gameResponseGame) {
  return gameResponseGame?.value;
}

String? gameResponseGameToJson(enums.GameResponseGame gameResponseGame) {
  return gameResponseGame.value;
}

enums.GameResponseGame gameResponseGameFromJson(
  Object? gameResponseGame, [
  enums.GameResponseGame? defaultValue,
]) {
  return enums.GameResponseGame.values
          .firstWhereOrNull((e) => e.value == gameResponseGame) ??
      defaultValue ??
      enums.GameResponseGame.swaggerGeneratedUnknown;
}

enums.GameResponseGame? gameResponseGameNullableFromJson(
  Object? gameResponseGame, [
  enums.GameResponseGame? defaultValue,
]) {
  if (gameResponseGame == null) {
    return null;
  }
  return enums.GameResponseGame.values
          .firstWhereOrNull((e) => e.value == gameResponseGame) ??
      defaultValue;
}

String gameResponseGameExplodedListToJson(
    List<enums.GameResponseGame>? gameResponseGame) {
  return gameResponseGame?.map((e) => e.value!).join(',') ?? '';
}

List<String> gameResponseGameListToJson(
    List<enums.GameResponseGame>? gameResponseGame) {
  if (gameResponseGame == null) {
    return [];
  }

  return gameResponseGame.map((e) => e.value!).toList();
}

List<enums.GameResponseGame> gameResponseGameListFromJson(
  List? gameResponseGame, [
  List<enums.GameResponseGame>? defaultValue,
]) {
  if (gameResponseGame == null) {
    return defaultValue ?? [];
  }

  return gameResponseGame
      .map((e) => gameResponseGameFromJson(e.toString()))
      .toList();
}

List<enums.GameResponseGame>? gameResponseGameNullableListFromJson(
  List? gameResponseGame, [
  List<enums.GameResponseGame>? defaultValue,
]) {
  if (gameResponseGame == null) {
    return defaultValue;
  }

  return gameResponseGame
      .map((e) => gameResponseGameFromJson(e.toString()))
      .toList();
}

String? sliderOptionResponseAttributeNullableToJson(
    enums.SliderOptionResponseAttribute? sliderOptionResponseAttribute) {
  return sliderOptionResponseAttribute?.value;
}

String? sliderOptionResponseAttributeToJson(
    enums.SliderOptionResponseAttribute sliderOptionResponseAttribute) {
  return sliderOptionResponseAttribute.value;
}

enums.SliderOptionResponseAttribute sliderOptionResponseAttributeFromJson(
  Object? sliderOptionResponseAttribute, [
  enums.SliderOptionResponseAttribute? defaultValue,
]) {
  return enums.SliderOptionResponseAttribute.values
          .firstWhereOrNull((e) => e.value == sliderOptionResponseAttribute) ??
      defaultValue ??
      enums.SliderOptionResponseAttribute.swaggerGeneratedUnknown;
}

enums.SliderOptionResponseAttribute?
    sliderOptionResponseAttributeNullableFromJson(
  Object? sliderOptionResponseAttribute, [
  enums.SliderOptionResponseAttribute? defaultValue,
]) {
  if (sliderOptionResponseAttribute == null) {
    return null;
  }
  return enums.SliderOptionResponseAttribute.values
          .firstWhereOrNull((e) => e.value == sliderOptionResponseAttribute) ??
      defaultValue;
}

String sliderOptionResponseAttributeExplodedListToJson(
    List<enums.SliderOptionResponseAttribute>? sliderOptionResponseAttribute) {
  return sliderOptionResponseAttribute?.map((e) => e.value!).join(',') ?? '';
}

List<String> sliderOptionResponseAttributeListToJson(
    List<enums.SliderOptionResponseAttribute>? sliderOptionResponseAttribute) {
  if (sliderOptionResponseAttribute == null) {
    return [];
  }

  return sliderOptionResponseAttribute.map((e) => e.value!).toList();
}

List<enums.SliderOptionResponseAttribute>
    sliderOptionResponseAttributeListFromJson(
  List? sliderOptionResponseAttribute, [
  List<enums.SliderOptionResponseAttribute>? defaultValue,
]) {
  if (sliderOptionResponseAttribute == null) {
    return defaultValue ?? [];
  }

  return sliderOptionResponseAttribute
      .map((e) => sliderOptionResponseAttributeFromJson(e.toString()))
      .toList();
}

List<enums.SliderOptionResponseAttribute>?
    sliderOptionResponseAttributeNullableListFromJson(
  List? sliderOptionResponseAttribute, [
  List<enums.SliderOptionResponseAttribute>? defaultValue,
]) {
  if (sliderOptionResponseAttribute == null) {
    return defaultValue;
  }

  return sliderOptionResponseAttribute
      .map((e) => sliderOptionResponseAttributeFromJson(e.toString()))
      .toList();
}

String? gamePreferenceInputResponseTypeNullableToJson(
    enums.GamePreferenceInputResponseType? gamePreferenceInputResponseType) {
  return gamePreferenceInputResponseType?.value;
}

String? gamePreferenceInputResponseTypeToJson(
    enums.GamePreferenceInputResponseType gamePreferenceInputResponseType) {
  return gamePreferenceInputResponseType.value;
}

enums.GamePreferenceInputResponseType gamePreferenceInputResponseTypeFromJson(
  Object? gamePreferenceInputResponseType, [
  enums.GamePreferenceInputResponseType? defaultValue,
]) {
  return enums.GamePreferenceInputResponseType.values.firstWhereOrNull(
          (e) => e.value == gamePreferenceInputResponseType) ??
      defaultValue ??
      enums.GamePreferenceInputResponseType.swaggerGeneratedUnknown;
}

enums.GamePreferenceInputResponseType?
    gamePreferenceInputResponseTypeNullableFromJson(
  Object? gamePreferenceInputResponseType, [
  enums.GamePreferenceInputResponseType? defaultValue,
]) {
  if (gamePreferenceInputResponseType == null) {
    return null;
  }
  return enums.GamePreferenceInputResponseType.values.firstWhereOrNull(
          (e) => e.value == gamePreferenceInputResponseType) ??
      defaultValue;
}

String gamePreferenceInputResponseTypeExplodedListToJson(
    List<enums.GamePreferenceInputResponseType>?
        gamePreferenceInputResponseType) {
  return gamePreferenceInputResponseType?.map((e) => e.value!).join(',') ?? '';
}

List<String> gamePreferenceInputResponseTypeListToJson(
    List<enums.GamePreferenceInputResponseType>?
        gamePreferenceInputResponseType) {
  if (gamePreferenceInputResponseType == null) {
    return [];
  }

  return gamePreferenceInputResponseType.map((e) => e.value!).toList();
}

List<enums.GamePreferenceInputResponseType>
    gamePreferenceInputResponseTypeListFromJson(
  List? gamePreferenceInputResponseType, [
  List<enums.GamePreferenceInputResponseType>? defaultValue,
]) {
  if (gamePreferenceInputResponseType == null) {
    return defaultValue ?? [];
  }

  return gamePreferenceInputResponseType
      .map((e) => gamePreferenceInputResponseTypeFromJson(e.toString()))
      .toList();
}

List<enums.GamePreferenceInputResponseType>?
    gamePreferenceInputResponseTypeNullableListFromJson(
  List? gamePreferenceInputResponseType, [
  List<enums.GamePreferenceInputResponseType>? defaultValue,
]) {
  if (gamePreferenceInputResponseType == null) {
    return defaultValue;
  }

  return gamePreferenceInputResponseType
      .map((e) => gamePreferenceInputResponseTypeFromJson(e.toString()))
      .toList();
}

String? selectOptionResponseAttributeNullableToJson(
    enums.SelectOptionResponseAttribute? selectOptionResponseAttribute) {
  return selectOptionResponseAttribute?.value;
}

String? selectOptionResponseAttributeToJson(
    enums.SelectOptionResponseAttribute selectOptionResponseAttribute) {
  return selectOptionResponseAttribute.value;
}

enums.SelectOptionResponseAttribute selectOptionResponseAttributeFromJson(
  Object? selectOptionResponseAttribute, [
  enums.SelectOptionResponseAttribute? defaultValue,
]) {
  return enums.SelectOptionResponseAttribute.values
          .firstWhereOrNull((e) => e.value == selectOptionResponseAttribute) ??
      defaultValue ??
      enums.SelectOptionResponseAttribute.swaggerGeneratedUnknown;
}

enums.SelectOptionResponseAttribute?
    selectOptionResponseAttributeNullableFromJson(
  Object? selectOptionResponseAttribute, [
  enums.SelectOptionResponseAttribute? defaultValue,
]) {
  if (selectOptionResponseAttribute == null) {
    return null;
  }
  return enums.SelectOptionResponseAttribute.values
          .firstWhereOrNull((e) => e.value == selectOptionResponseAttribute) ??
      defaultValue;
}

String selectOptionResponseAttributeExplodedListToJson(
    List<enums.SelectOptionResponseAttribute>? selectOptionResponseAttribute) {
  return selectOptionResponseAttribute?.map((e) => e.value!).join(',') ?? '';
}

List<String> selectOptionResponseAttributeListToJson(
    List<enums.SelectOptionResponseAttribute>? selectOptionResponseAttribute) {
  if (selectOptionResponseAttribute == null) {
    return [];
  }

  return selectOptionResponseAttribute.map((e) => e.value!).toList();
}

List<enums.SelectOptionResponseAttribute>
    selectOptionResponseAttributeListFromJson(
  List? selectOptionResponseAttribute, [
  List<enums.SelectOptionResponseAttribute>? defaultValue,
]) {
  if (selectOptionResponseAttribute == null) {
    return defaultValue ?? [];
  }

  return selectOptionResponseAttribute
      .map((e) => selectOptionResponseAttributeFromJson(e.toString()))
      .toList();
}

List<enums.SelectOptionResponseAttribute>?
    selectOptionResponseAttributeNullableListFromJson(
  List? selectOptionResponseAttribute, [
  List<enums.SelectOptionResponseAttribute>? defaultValue,
]) {
  if (selectOptionResponseAttribute == null) {
    return defaultValue;
  }

  return selectOptionResponseAttribute
      .map((e) => selectOptionResponseAttributeFromJson(e.toString()))
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
