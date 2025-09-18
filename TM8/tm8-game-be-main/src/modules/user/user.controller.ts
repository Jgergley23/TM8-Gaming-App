import {
  Body,
  Controller,
  Delete,
  Get,
  HttpCode,
  HttpStatus,
  Param,
  ParseFilePipeBuilder,
  Patch,
  Post,
  Query,
  UploadedFile,
  UseGuards,
  UseInterceptors,
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import {
  ApiBody,
  ApiConsumes,
  ApiNoContentResponse,
  ApiOkResponse,
  ApiParam,
  ApiResponse,
  ApiTags,
} from '@nestjs/swagger';

import { Role } from 'src/common/constants';
import {
  CurrentUser,
  IUserTokenData,
} from 'src/common/decorators/current-user.decorator';
import { Roles } from 'src/common/decorators/roles.decorator';
import { TGMDExceptionResponse } from 'src/common/exceptions/custom-exception.response';
import {
  TGMDConflictException,
  TGMDForbiddenException,
} from 'src/common/exceptions/custom.exception';
import { AccessTokenGuard } from 'src/common/guards/access-token.guard';
import { RolesGuard } from 'src/common/guards/roles.guard';
import { UserStatusGuard } from 'src/common/guards/user-status-guard';
import { PaginationParams } from 'src/common/pagination/pagination-params';
import { PaginationModel } from 'src/common/pagination/paginaton.model';

import { AbstractUserGameDataService } from '../user-game-data/abstract/user-game-data.abstract.service';
import { SetApexLegendsPreferencesInput } from '../user-game-data/dto/set-apex-legends-preferences.input';
import { SetCallOfDutyPreferencesInput } from '../user-game-data/dto/set-call-of-duty-preferences.input';
import { SetFortnitePreferencesInput } from '../user-game-data/dto/set-fortnite-preferences.input';
import { SetGamePlaytimeInput } from '../user-game-data/dto/set-game-playtime.input';
import { SetOnlineScheduleInput } from '../user-game-data/dto/set-online-schedule.input';
import { SetRocketLeaguePreferencesInput } from '../user-game-data/dto/set-rocket-league-preferences.input';
import { UserGameDataResponse } from '../user-game-data/response/user-game-data.response';
import { UserGameData } from '../user-game-data/schemas/user-game-data.schema';
import { AbstractUserBlockService } from './abstract/user-block.abstract.service';
import { AbstractUserService } from './abstract/user.abstract.service';
import { ChangeEmailInput } from './dto/change-email.input';
import { ChangePasswordInput } from './dto/change-password.input';
import { ChangeUserInfoInput } from './dto/change-user-info.input';
import { CreateAdminInput } from './dto/create-admin.input';
import { DeleteUsersInput } from './dto/delete-users.input';
import { GetGameByNameParams } from './dto/game-by-name.params';
import { GetGamePreferencesParams } from './dto/get-game-preferences.params';
import { ListUserFriendsParams } from './dto/list-user-friends.params';
import { ListUsersInput } from './dto/list-users.input';
import { ReportUserInput } from './dto/report-user.input';
import { UpdateUsernameInput } from './dto/update-username.input';
import { UserBanInput } from './dto/user-ban.input';
import { GetUserByIdParams } from './dto/user-by-id.params';
import { GetUserByUsernameParams } from './dto/user-by-username.params';
import { UserNoteInput } from './dto/user-note.input';
import { UserResetInput } from './dto/user-reset-input';
import { UserSearchParams } from './dto/user-search.params';
import { UserSuspendInput } from './dto/user-suspend-input';
import { UserWarningInput } from './dto/user-warning.input';
import { GetUsersByIdsParams } from './dto/users-by-ids.params';
import { VerifyEmailChangeInput } from './dto/verify-email-change.input';
import { CheckFriendshipResponse } from './response/check-friendship.response';
import { CheckBlockStatusResponse } from './response/check-friendship.response copy';
import { GetMeUserResponse } from './response/get-me-user.response';
import { SetUserFileResponse } from './response/set-user-file.response';
import { UserGamesResponse } from './response/user-games.response';
import { UserGroupResponse } from './response/user-group.response';
import { UserPaginatedResponse } from './response/user-paginated.response';
import { UserProfileResponse } from './response/user-profile.response';
import { UserReportTypeResponse } from './response/user-report-type.response';
import { UserReportResponse } from './response/user-report.response';
import { UserSearchResponse } from './response/user-search.response';
import { UserWarningTypeResponse } from './response/user-warning-type.response';
import { UserResponse } from './response/user.response';
import { User } from './schemas/user.schema';

const MAX_PHOTO_SIZE = +process.env.S3_MAXPHOTOSIZE;
const MAX_AUDIO_SIZE = +process.env.S3_MAXAUDIOSIZE;

@ApiTags('User')
@Controller('users')
@ApiResponse({
  description: 'Non-2XX response',
  type: TGMDExceptionResponse,
})
@UseGuards(AccessTokenGuard, UserStatusGuard, RolesGuard)
export class UserController {
  constructor(
    private readonly userService: AbstractUserService,
    private readonly userBlockService: AbstractUserBlockService,
    private readonly userGameDataService: AbstractUserGameDataService,
  ) {}

  @Get('')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: UserPaginatedResponse,
  })
  @Roles(Role.Admin, Role.Superadmin)
  listUsers(
    @Query() paginationParams: PaginationParams,
    @Query() listUserInput: ListUsersInput,
  ): Promise<PaginationModel<User>> {
    return this.userService.listUsers(listUserInput, paginationParams);
  }

  @Post('admin')
  @ApiOkResponse({
    status: 201,
    description: 'OK response',
  })
  @Roles(Role.Superadmin)
  createAdmin(@Body() createAdminInput: CreateAdminInput): Promise<void> {
    return this.userService.createAdmin(createAdminInput);
  }

  @Get('groups')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: [UserGroupResponse],
  })
  @Roles(Role.Admin, Role.Superadmin)
  getUserGroups(): UserGroupResponse[] {
    return this.userService.getUserGroups();
  }

  @Get('search')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: [UserSearchResponse],
  })
  @Roles(Role.User)
  searchUsers(
    @CurrentUser() user: IUserTokenData,
    @Query() { username }: UserSearchParams,
    @Query() { limit }: UserSearchParams,
  ): Promise<UserSearchResponse[]> {
    return this.userService.searchUsers(user.sub, username, limit);
  }

  @Get('me')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: GetMeUserResponse,
  })
  @Roles(Role.User)
  getMeUser(@CurrentUser() user: IUserTokenData): Promise<GetMeUserResponse> {
    return this.userService.getMeUser(user.sub);
  }

  @Delete('me')
  @ApiOkResponse({
    status: 204,
    description: 'OK response',
  })
  @HttpCode(204)
  @Roles(Role.User)
  deleteAccount(@CurrentUser() user: IUserTokenData): Promise<void> {
    return this.userService.deleteAccount(user.sub);
  }

  @Get('friends')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: UserPaginatedResponse,
  })
  @Roles(Role.User)
  listUserFriends(
    @CurrentUser() user: IUserTokenData,
    @Query() listFriendsParams: ListUserFriendsParams,
    @Query() paginationParams: PaginationParams,
  ): Promise<PaginationModel<User>> {
    return this.userService.listUserFriends(
      user.sub,
      listFriendsParams,
      paginationParams,
    );
  }

  @Get('blocks')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: UserPaginatedResponse,
  })
  @Roles(Role.User)
  listBlockedUsers(
    @CurrentUser() user: IUserTokenData,
    @Query() paginationParams: PaginationParams,
  ): Promise<PaginationModel<User>> {
    return this.userBlockService.listBlockedUsers(user.sub, paginationParams);
  }

  @Get('username/:username')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: [UserResponse],
  })
  @Roles(Role.Admin, Role.Superadmin)
  findManyByUsername(
    @Param() { username }: GetUserByUsernameParams,
  ): Promise<User[]> {
    return this.userService.findManyByUsername(username);
  }

  @Get(':userId')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: UserResponse,
  })
  @Roles(Role.Admin, Role.Superadmin)
  @ApiParam({ name: 'userId', type: 'string', description: 'User ID' })
  findOne(@Param() { userId }: GetUserByIdParams): Promise<User> {
    return this.userService.findOne(userId);
  }

  @Delete('')
  @ApiOkResponse({
    status: 204,
    description: 'OK response',
  })
  @Roles(Role.Superadmin)
  deleteMany(@Body() { userIds }: DeleteUsersInput): Promise<void> {
    return this.userService.deleteUsers(userIds);
  }

  @Patch('email')
  @ApiOkResponse({
    status: 204,
    description: 'OK response',
  })
  @HttpCode(204)
  @Roles(Role.User)
  changeEmail(
    @CurrentUser() currentUser: IUserTokenData,
    @Body() changeEmailInput: ChangeEmailInput,
  ): Promise<void> {
    return this.userService.changeEmail(currentUser.sub, changeEmailInput);
  }

  @Patch('email/confirm')
  @ApiOkResponse({
    status: 204,
    description: 'OK response',
  })
  @HttpCode(204)
  @Roles(Role.User)
  confirmEmailChange(
    @Body() verifyEmailChangeInput: VerifyEmailChangeInput,
  ): Promise<void> {
    return this.userService.confirmEmailChange(verifyEmailChangeInput);
  }

  @Patch('email/confirm')
  @ApiOkResponse({
    status: 204,
    description: 'OK response',
  })
  @HttpCode(204)
  @Roles(Role.User)
  confirmEmailUpdate(
    @Body() verifyEmailChangeInput: VerifyEmailChangeInput,
  ): Promise<void> {
    return this.userService.confirmEmailChange(verifyEmailChangeInput);
  }

  @Patch('password')
  @ApiOkResponse({
    status: 204,
    description: 'OK response',
  })
  @HttpCode(204)
  @Roles(Role.User)
  changePassword(
    @CurrentUser() currentUser: IUserTokenData,
    @Body() changePasswordInput: ChangePasswordInput,
  ): Promise<void> {
    return this.userService.changePassword(
      currentUser.sub,
      changePasswordInput,
    );
  }

  @Get(':userId/preferences')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: [UserGameDataResponse],
  })
  @Roles(Role.Admin, Role.Superadmin, Role.User)
  getUserGamePreferences(
    @Param() { userId }: GetUserByIdParams,
    @Query() getGamePreferencesParams: GetGamePreferencesParams,
    @CurrentUser() user: IUserTokenData,
  ): Promise<UserGameData[]> {
    if (user.role === Role.User && user.sub !== userId)
      throw new TGMDForbiddenException('Cannot see preferences for this user');
    return this.userService.getUserGamePreferences(
      { userId },
      getGamePreferencesParams,
    );
  }

  @Patch(':userId/admin-note')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: UserResponse,
  })
  @Roles(Role.Admin, Role.Superadmin)
  setUserNote(
    @Param() { userId }: GetUserByIdParams,
    @Body() userNoteInput: UserNoteInput,
  ): Promise<User> {
    return this.userService.setUserNote(userId, userNoteInput);
  }

  @Get(':userId/reports')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: [UserReportResponse],
  })
  @Roles(Role.Admin, Role.Superadmin)
  getUserReports(
    @Param() { userId }: GetUserByIdParams,
  ): Promise<UserReportResponse[]> {
    return this.userService.getUserReports(userId);
  }

  @Get('warning/types')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: [UserWarningTypeResponse],
  })
  @Roles(Role.Admin, Role.Superadmin)
  getUserWarningTypes(): UserWarningTypeResponse[] {
    return this.userService.getUserWarningTypes();
  }

  @Get('report/types')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: [UserReportTypeResponse],
  })
  getUserReportTypes(): UserReportTypeResponse[] {
    return this.userService.getUserReportTypes();
  }

  @Patch('warning')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: [UserResponse],
  })
  @Roles(Role.Admin, Role.Superadmin)
  warnUsers(@Body() userWarningInput: UserWarningInput): Promise<User[]> {
    return this.userService.warnUsers(userWarningInput);
  }

  @Patch('ban')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: [UserResponse],
  })
  @Roles(Role.Admin, Role.Superadmin)
  banUsers(@Body() userBanInput: UserBanInput): Promise<User[]> {
    return this.userService.banUsers(userBanInput);
  }

  @Patch('suspend')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: [UserResponse],
  })
  @Roles(Role.Admin, Role.Superadmin)
  suspendUsers(@Body() userSuspendInput: UserSuspendInput): Promise<User[]> {
    return this.userService.suspendUsers(userSuspendInput);
  }

  @Patch('reset')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: [UserResponse],
  })
  @Roles(Role.Admin, Role.Superadmin)
  resetUsers(@Body() userResetInput: UserResetInput): Promise<User[]> {
    return this.userService.resetUsers(userResetInput);
  }

  @Patch('username')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
  })
  @HttpCode(204)
  @Roles(Role.User)
  updateUsername(
    @CurrentUser() currentUser: IUserTokenData,
    @Body() userResetInput: UpdateUsernameInput,
  ): Promise<void> {
    return this.userService.updateUsername(currentUser.sub, userResetInput);
  }

  @Patch('info')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
  })
  @HttpCode(204)
  @Roles(Role.User)
  updateDescription(
    @CurrentUser() currentUser: IUserTokenData,
    @Body() changeUserInfoInput: ChangeUserInfoInput,
  ): Promise<void> {
    return this.userService.changeUserInfo(
      currentUser.sub,
      changeUserInfoInput,
    );
  }

  @Patch('image')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: SetUserFileResponse,
  })
  @Roles(Role.User)
  @ApiConsumes('multipart/form-data')
  @ApiBody({
    schema: {
      type: 'object',
      properties: {
        file: {
          type: 'string',
          format: 'binary',
        },
      },
    },
  })
  @UseInterceptors(FileInterceptor('file'))
  async manageProfilePhoto(
    @CurrentUser() currentUser: IUserTokenData,
    @UploadedFile(
      new ParseFilePipeBuilder()
        .addFileTypeValidator({
          fileType: /(jpg|jpeg|png|heic)$/,
        })
        .addMaxSizeValidator({ maxSize: MAX_PHOTO_SIZE })
        .build({
          errorHttpStatusCode: HttpStatus.UNPROCESSABLE_ENTITY,
        }),
    )
    file: Express.Multer.File,
  ): Promise<SetUserFileResponse> {
    return this.userService.setUserPhoto(currentUser.sub, file);
  }

  @Patch('audio-intro')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: SetUserFileResponse,
  })
  @Roles(Role.User)
  @ApiConsumes('multipart/form-data')
  @ApiBody({
    schema: {
      type: 'object',
      properties: {
        file: {
          type: 'string',
          format: 'binary',
        },
      },
    },
  })
  @UseInterceptors(FileInterceptor('file'))
  async manageAudioIntro(
    @CurrentUser() currentUser: IUserTokenData,
    @UploadedFile(
      new ParseFilePipeBuilder()
        .addFileTypeValidator({
          fileType: /audio\/mpeg$/,
        })
        .addMaxSizeValidator({ maxSize: MAX_AUDIO_SIZE })
        .build({
          errorHttpStatusCode: HttpStatus.UNPROCESSABLE_ENTITY,
        }),
    )
    file: Express.Multer.File,
  ): Promise<SetUserFileResponse> {
    return this.userService.setUserAudioIntro(currentUser.sub, file);
  }

  @Post(':userId/game/:game')
  @ApiOkResponse({
    status: 201,
    description: 'OK response',
  })
  @HttpCode(201)
  @Roles(Role.User)
  addUserGame(
    @Param() { userId }: GetUserByIdParams,
    @Param() { game }: GetGameByNameParams,
    @CurrentUser() user: IUserTokenData,
  ): Promise<void> {
    if (userId !== user.sub)
      throw new TGMDForbiddenException('Cannot add game for this user');
    return this.userService.addUserGame(userId, game);
  }

  @Delete(':userId/game/:game')
  @ApiOkResponse({
    status: 204,
    description: 'OK response',
  })
  @HttpCode(204)
  @Roles(Role.User)
  deleteUserGame(
    @Param() { userId }: GetUserByIdParams,
    @Param() { game }: GetGameByNameParams,
    @CurrentUser() user: IUserTokenData,
  ): Promise<void> {
    if (userId !== user.sub)
      throw new TGMDForbiddenException('Cannot delete game for this user');
    return this.userService.deleteUserGame(userId, game);
  }

  @Patch('preferences/call-of-duty')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: UserGameDataResponse,
  })
  @Roles(Role.User)
  setCallOfDutyPreferences(
    @Body() preferenceInput: SetCallOfDutyPreferencesInput,
    @CurrentUser() user: IUserTokenData,
  ): Promise<UserGameData> {
    return this.userGameDataService.setCallOfDutyPreferences(
      user.sub,
      preferenceInput,
    );
  }

  @Patch('preferences/apex-legends')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: UserGameDataResponse,
  })
  @Roles(Role.User)
  setApexLegendsPreferences(
    @Body() preferenceInput: SetApexLegendsPreferencesInput,
    @CurrentUser() user: IUserTokenData,
  ): Promise<UserGameData> {
    return this.userGameDataService.setApexLegendsPreferences(
      user.sub,
      preferenceInput,
    );
  }

  @Patch('preferences/rocket-league')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: UserGameDataResponse,
  })
  @Roles(Role.User)
  setRocketLeaguePreferences(
    @Body() preferenceInput: SetRocketLeaguePreferencesInput,
    @CurrentUser() user: IUserTokenData,
  ): Promise<UserGameData> {
    return this.userGameDataService.setRocketLeaguePreferences(
      user.sub,
      preferenceInput,
    );
  }

  @Patch('preferences/fortnite')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: UserGameDataResponse,
  })
  @Roles(Role.User)
  setFortnitePreferences(
    @Body() preferenceInput: SetFortnitePreferencesInput,
    @CurrentUser() user: IUserTokenData,
  ): Promise<UserGameData> {
    return this.userGameDataService.setFortnitePreferences(
      user.sub,
      preferenceInput,
    );
  }

  @Patch('preferences/:game/playtime')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
  })
  @Roles(Role.User)
  setGamePlaytime(
    @Param() { game }: GetGameByNameParams,
    @CurrentUser() user: IUserTokenData,
    @Body() setGamePlaytimeInput: SetGamePlaytimeInput,
  ): Promise<void> {
    return this.userGameDataService.setGamePlaytime(
      user.sub,
      game,
      setGamePlaytimeInput,
    );
  }

  @Patch('preferences/:game/online-schedule')
  @HttpCode(HttpStatus.NO_CONTENT)
  @ApiNoContentResponse({
    status: 204,
    description: 'OK response',
  })
  @Roles(Role.User)
  setOnlineSchedule(
    @Param() { game }: GetGameByNameParams,
    @CurrentUser() user: IUserTokenData,
    @Body() setOnlineScheduleInput: SetOnlineScheduleInput,
  ): Promise<void> {
    return this.userGameDataService.setOnlineSchedule(
      user.sub,
      game,
      setOnlineScheduleInput,
    );
  }

  @Delete('preferences/:game/online-schedule')
  @HttpCode(HttpStatus.NO_CONTENT)
  @ApiNoContentResponse({
    status: 204,
    description: 'Resource deleted',
  })
  @Roles(Role.User)
  deleteOnlineSchedule(
    @Param() { game }: GetGameByNameParams,
    @CurrentUser() user: IUserTokenData,
  ): Promise<void> {
    return this.userGameDataService.deleteOnlineSchedule(user.sub, game);
  }

  @Post(':userId/friend')
  @ApiOkResponse({
    status: 204,
    description: 'OK response',
  })
  @HttpCode(204)
  @Roles(Role.User)
  userAddFriend(
    @CurrentUser() currentUser: IUserTokenData,
    @Param() { userId }: GetUserByIdParams,
  ): Promise<void> {
    if (currentUser.sub === userId)
      throw new TGMDConflictException('Cannot add yourself as a friend');
    return this.userService.userAddFriend(currentUser.sub, userId);
  }

  @Delete(':userId/friend')
  @ApiOkResponse({
    status: 204,
    description: 'OK response',
  })
  @HttpCode(204)
  @Roles(Role.User)
  userRemoveFriend(
    @CurrentUser() currentUser: IUserTokenData,
    @Param() { userId }: GetUserByIdParams,
  ): Promise<void> {
    if (currentUser.sub === userId)
      throw new TGMDConflictException('Cannot remove yourself from friends');
    return this.userService.userRemoveFriend(currentUser.sub, userId);
  }

  @Get(':userId/friend/check')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: CheckFriendshipResponse,
  })
  @Roles(Role.User)
  checkFriendship(
    @CurrentUser() currentUser: IUserTokenData,
    @Param() { userId }: GetUserByIdParams,
  ): Promise<CheckFriendshipResponse> {
    if (currentUser.sub === userId)
      throw new TGMDConflictException('Cannot check friendship with yourself');
    return this.userService.checkFriendship(currentUser.sub, userId);
  }

  @Get(':userId/block/check')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: CheckBlockStatusResponse,
  })
  @Roles(Role.User)
  checkBlockStatus(
    @CurrentUser() currentUser: IUserTokenData,
    @Param() { userId }: GetUserByIdParams,
  ): Promise<CheckBlockStatusResponse> {
    if (currentUser.sub === userId)
      throw new TGMDConflictException(
        'Cannot check block status with yourself',
      );
    return this.userService.checkBlockStatus(currentUser.sub, userId);
  }

  @Get(':userId/profile')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: UserProfileResponse,
  })
  @Roles(Role.User)
  getUserProfile(
    @CurrentUser() currentUser: IUserTokenData,
    @Param() { userId }: GetUserByIdParams,
  ): Promise<UserProfileResponse> {
    if (currentUser.sub === userId)
      throw new TGMDConflictException('Cannot get profile for yourself');
    return this.userService.getUserProfile(userId, currentUser.sub);
  }

  @Get(':userId/games')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: UserGamesResponse,
  })
  @Roles(Role.User, Role.Admin, Role.Superadmin)
  getUserGames(
    @Param() { userId }: GetUserByIdParams,
  ): Promise<UserGamesResponse> {
    return this.userService.getUserGames(userId);
  }

  @Post(':userId/block')
  @ApiOkResponse({
    status: 204,
    description: 'OK response',
  })
  @HttpCode(204)
  @Roles(Role.User)
  blockUser(
    @CurrentUser() currentUser: IUserTokenData,
    @Param() { userId }: GetUserByIdParams,
  ): Promise<void> {
    if (currentUser.sub === userId)
      throw new TGMDConflictException('Cannot block yourself');
    return this.userBlockService.blockUser(currentUser.sub, userId);
  }

  @Delete('blocks')
  @ApiOkResponse({
    status: 204,
    description: 'OK response',
  })
  @HttpCode(204)
  @Roles(Role.User)
  unblockUsers(
    @CurrentUser() currentUser: IUserTokenData,
    @Body() { userIds }: GetUsersByIdsParams,
  ): Promise<void> {
    if (userIds.some((id) => id === currentUser.sub))
      throw new TGMDConflictException('Cannot block and unblock yourself');
    return this.userBlockService.unblockUsers(currentUser.sub, userIds);
  }

  @Post(':userId/report')
  @ApiOkResponse({
    status: 204,
    description: 'OK response',
  })
  @HttpCode(204)
  @Roles(Role.User)
  reportUser(
    @CurrentUser() currentUser: IUserTokenData,
    @Param() { userId }: GetUserByIdParams,
    @Body() { reportReason }: ReportUserInput,
  ): Promise<void> {
    if (currentUser.sub === userId)
      throw new TGMDConflictException('Cannot report yourself');
    return this.userService.reportUser({
      reporterId: currentUser.sub,
      targetId: userId,
      reportReason,
    });
  }
}
