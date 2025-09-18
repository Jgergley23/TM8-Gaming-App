import { PaginationParams } from 'src/common/pagination/pagination-params';
import { PaginationModel } from 'src/common/pagination/paginaton.model';
import { UserGameData } from 'src/modules/user-game-data/schemas/user-game-data.schema';

import { ChangeEmailInput } from '../dto/change-email.input';
import { ChangePasswordInput } from '../dto/change-password.input';
import { ChangeUserInfoInput } from '../dto/change-user-info.input';
import { CreateAdminInput } from '../dto/create-admin.input';
import { GetGamePreferencesParams } from '../dto/get-game-preferences.params';
import { ListUserFriendsParams } from '../dto/list-user-friends.params';
import { ListUsersInput } from '../dto/list-users.input';
import { ReportUserInput } from '../dto/report-user.input';
import { UpdateUsernameInput } from '../dto/update-username.input';
import { UserBanInput } from '../dto/user-ban.input';
import { GetUserByIdParams } from '../dto/user-by-id.params';
import { UserNoteInput } from '../dto/user-note.input';
import { UserResetInput } from '../dto/user-reset-input';
import { UserSuspendInput } from '../dto/user-suspend-input';
import { UserWarningInput } from '../dto/user-warning.input';
import { VerifyEmailChangeInput } from '../dto/verify-email-change.input';
import { CheckFriendshipResponse } from '../response/check-friendship.response';
import { CheckBlockStatusResponse } from '../response/check-friendship.response copy';
import { GetMeUserResponse } from '../response/get-me-user.response';
import { SetUserFileResponse } from '../response/set-user-file.response';
import { UserGamesResponse } from '../response/user-games.response';
import { UserGroupResponse } from '../response/user-group.response';
import { UserProfileResponse } from '../response/user-profile.response';
import { UserReportTypeResponse } from '../response/user-report-type.response';
import { UserReportResponse } from '../response/user-report.response';
import { UserSearchResponse } from '../response/user-search.response';
import { UserWarningTypeResponse } from '../response/user-warning-type.response';
import { User } from '../schemas/user.schema';

export abstract class AbstractUserService {
  abstract listUsers(
    listUserInput: ListUsersInput,
    params: PaginationParams,
  ): Promise<PaginationModel<User>>;
  abstract findOne(id: string): Promise<User>;
  abstract getUserGamePreferences(
    getUserByIdParams: GetUserByIdParams,
    getGamePreferencesParams: GetGamePreferencesParams,
  ): Promise<UserGameData[]>;
  abstract warnUsers(userWarningInput: UserWarningInput): Promise<User[]>;
  abstract banUsers(userBanInput: UserBanInput): Promise<User[]>;
  abstract suspendUsers(userSuspendInput: UserSuspendInput): Promise<User[]>;
  abstract resetUsers(userResetInput: UserResetInput): Promise<User[]>;
  abstract getUserWarningTypes(): UserWarningTypeResponse[];
  abstract setUserNote(
    userId: string,
    userNoteInput: UserNoteInput,
  ): Promise<User>;
  abstract getUserReports(userId: string): Promise<UserReportResponse[]>;
  abstract getUserReportTypes(): UserReportTypeResponse[];
  abstract findManyByUsername(username: string): Promise<User[]>;
  abstract getUserGroups(): UserGroupResponse[];
  abstract deleteUsers(userIds: string[]): Promise<void>;
  abstract createAdmin(createAdminInput: CreateAdminInput): Promise<void>;
  abstract addUserGame(userId: string, game: string): Promise<void>;
  abstract deleteUserGame(userId: string, game: string): Promise<void>;
  abstract searchUsers(
    userId: string,
    username: string,
    limit?: number,
  ): Promise<UserSearchResponse[]>;
  abstract userAddFriend(userId: string, friendId: string): Promise<void>;
  abstract userRemoveFriend(userId: string, unfriendId: string): Promise<void>;
  abstract getUserProfile(
    userId: string,
    currentUserId: string,
  ): Promise<UserProfileResponse>;
  abstract checkFriendship(
    currentUserId: string,
    checkUserId: string,
  ): Promise<CheckFriendshipResponse>;
  abstract listUserFriends(
    userId: string,
    listUserFriendsParams: ListUserFriendsParams,
    paginationParams: PaginationParams,
  ): Promise<PaginationModel<User>>;
  abstract getUserGames(userId: string): Promise<UserGamesResponse>;
  abstract reportUser(reportUserInput: ReportUserInput): Promise<void>;
  abstract setUserPhoto(
    userId: string,
    file: Express.Multer.File,
  ): Promise<SetUserFileResponse>;
  abstract getMeUser(userId: string): Promise<GetMeUserResponse>;
  abstract setUserAudioIntro(
    userId: string,
    file: Express.Multer.File,
  ): Promise<SetUserFileResponse>;
  abstract updateUsername(
    userId: string,
    { username }: UpdateUsernameInput,
  ): Promise<void>;
  abstract changeEmail(
    userId: string,
    { email }: ChangeEmailInput,
  ): Promise<void>;
  abstract confirmEmailChange({ code }: VerifyEmailChangeInput): Promise<void>;
  abstract changePassword(
    userId: string,
    changePasswordInput: ChangePasswordInput,
  ): Promise<void>;
  abstract changeUserInfo(
    userId: string,
    changeUserDataInput: ChangeUserInfoInput,
  ): Promise<void>;
  abstract deleteAccount(userId: string): Promise<void>;
  abstract checkBlockStatus(
    currentUserId: string,
    checkUserId: string,
  ): Promise<CheckBlockStatusResponse>;
}
