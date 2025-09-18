import { Inject, Injectable } from '@nestjs/common';
import { FilterQuery } from 'mongoose';
import { WINSTON_MODULE_NEST_PROVIDER, WinstonLogger } from 'nest-winston';

import { S3Config } from 'src/common/config/env.validation';
import {
  ActionType,
  Game,
  ReportReason,
  Role,
  UserNotificationType,
  UserStatusType,
  userGroupsResponse,
  userReportTypeResponse,
} from 'src/common/constants';
import { userWarningTypeResponse } from 'src/common/constants/user-warning-type';
import {
  TGMDConflictException,
  TGMDExternalServiceException,
  TGMDForbiddenException,
  TGMDInternalException,
  TGMDNotFoundException,
} from 'src/common/exceptions/custom.exception';
import { PaginationParams } from 'src/common/pagination/pagination-params';
import { PaginationModel } from 'src/common/pagination/paginaton.model';
import { CryptoUtils } from 'src/common/utils/crypto.utils';
import { StringUtils } from 'src/common/utils/string.utils';
import { AbstractActionRepository } from 'src/modules/action/abstract/action.abstract.repository';
import { AbstractActionService } from 'src/modules/action/abstract/action.abstract.service';
import {
  ChatChatServiceToken,
  ChatUserServiceToken,
  IChatChatService,
  IChatUserService,
} from 'src/modules/chat/interface/chat-service.interface';
import {
  EmailServiceResult,
  EmailServiceToken,
  IEmailService,
} from 'src/modules/email/interface/email-service.interface';
import {
  FileStorageServiceToken,
  IFileStorageService,
} from 'src/modules/file-storage/interface/file-storage.service.interface';
import { AbstractFriendsRepository } from 'src/modules/friends/abstract/friends.abstract.repository';
import { AbstractFriendsService } from 'src/modules/friends/abstract/friends.abstract.service';
import {
  Friend,
  FriendsDocument,
} from 'src/modules/friends/schemas/friends.schema';
import { AbstractMatchService } from 'src/modules/match/abstract/match.abstract.service';
import { AbstractMatchmakingResultService } from 'src/modules/matchmaking-result/abstract/matchmaking-result.service.abstract';
import { AbstractNotificationService } from 'src/modules/notification/abstract/notification.abstract.service';
import { AbstractPotentialMatchService } from 'src/modules/potential-match/abstract/potential-match.abstract.service';
import { AbstractUserGameDataRepository } from 'src/modules/user-game-data/abstract/user-game-data.abstract.repository';
import { AbstractUserGameDataService } from 'src/modules/user-game-data/abstract/user-game-data.abstract.service';
import { UserGameData } from 'src/modules/user-game-data/schemas/user-game-data.schema';

import { AbstractUserRepository } from '../abstract/user.abstract.repository';
import { AbstractUserService } from '../abstract/user.abstract.service';
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
import {
  UserGameResponse,
  UserGamesResponse,
} from '../response/user-games.response';
import { UserGroupResponse } from '../response/user-group.response';
import { UserProfileResponse } from '../response/user-profile.response';
import { UserReportTypeResponse } from '../response/user-report-type.response';
import { UserReportResponse } from '../response/user-report.response';
import { UserSearchResponse } from '../response/user-search.response';
import { UserWarningTypeResponse } from '../response/user-warning-type.response';
import { User } from '../schemas/user.schema';

@Injectable()
export class UserService extends AbstractUserService {
  // eslint-disable-next-line max-params
  constructor(
    private readonly userRepository: AbstractUserRepository,
    private readonly userGameDataRepository: AbstractUserGameDataRepository,
    private readonly actionRepository: AbstractActionRepository,
    private readonly friendsRepository: AbstractFriendsRepository,
    private readonly actionService: AbstractActionService,
    private readonly userGameDataService: AbstractUserGameDataService,
    private readonly friendsService: AbstractFriendsService,
    private readonly notificationService: AbstractNotificationService,
    private readonly matchmakingResultService: AbstractMatchmakingResultService,
    private readonly matchService: AbstractMatchService,
    private readonly potentialMatchService: AbstractPotentialMatchService,
    @Inject(EmailServiceToken) private readonly emailService: IEmailService,
    @Inject(FileStorageServiceToken)
    private readonly fileStorageService: IFileStorageService,
    private readonly s3Config: S3Config,
    @Inject(ChatChatServiceToken)
    private readonly chatChatService: IChatChatService,
    @Inject(WINSTON_MODULE_NEST_PROVIDER)
    private readonly logger: WinstonLogger,
    @Inject(ChatUserServiceToken)
    private readonly chatUserService: IChatUserService,
  ) {
    super();
  }

  /**
   * Create admin and send email with password to admin email
   * @param createAdminInput - create admin input
   * @returns void
   */
  async createAdmin(createAdminInput: CreateAdminInput): Promise<void> {
    const { fullName, email } = createAdminInput;

    const user = await this.userRepository.findOneLean({ email });
    if (user)
      throw new TGMDConflictException('User with this email already exists');

    const userPassword = StringUtils.generatePassword(10);

    await this.userRepository.createOne({
      name: fullName,
      email,
      password: userPassword,
      notificationSettings: {},
      role: Role.Admin,
      status: { type: UserStatusType.Active },
    });

    const emailStatus = await this.emailService.sendEmailAdminAccountCreated(
      email,
      fullName,
      userPassword,
    );
    if (emailStatus !== EmailServiceResult.SUCCESS)
      throw new TGMDExternalServiceException('Email sending failed');
  }

  /**
   * Finds user by id
   * @param id - user id
   * @returns - user response
   */
  async findOne(id: string): Promise<User> {
    const user = await this.userRepository.findOneLean({ _id: id });
    if (!user) throw new TGMDNotFoundException('User not found');
    return user;
  }

  /**
   * Finds users by matching username
   * @param id - user id
   * @returns - user response
   */
  async findManyByUsername(username: string): Promise<User[]> {
    const users = await this.userRepository.findManyLean(
      { username: { $regex: username, $options: 'i' } },
      '',
      {
        limit: 15,
      },
    );
    return users;
  }

  /**
   * Lists users based on the input and pagination parameters
   * @param listUserInput - input for listing users
   * @param params - pagination parameters
   * @returns paginated list of users
   */
  async listUsers(
    listUserInput: ListUsersInput,
    params: PaginationParams,
  ): Promise<PaginationModel<User>> {
    const { limit, skip } = params;

    const { sort, username, status, roles, name } = listUserInput;

    const sortObj: Record<string, 1 | -1> = {};

    const sortArray = sort.split(',');

    sortArray.forEach((sortItem) => {
      const match = sortItem.match(/^([+-])(\w+)$/);
      if (match) {
        const [, sign, field] = match;
        sortObj[field] = sign === '-' ? -1 : 1;
      }
    });

    const query: FilterQuery<User> = {
      role: { $in: roles },
    };

    if (username) {
      query.username = { $regex: username, $options: 'i' };
    }

    if (name) {
      query.name = { $regex: name, $options: 'i' };
    }

    if (listUserInput.status) {
      query['status.type'] = status;
    }

    const data = await this.userRepository.findManyLean(query, '', {
      skip: skip,
      limit: limit,
      sort: sortObj,
    });

    const count = await this.userRepository.count(query);

    return new PaginationModel(data, params, count);
  }

  /**
   * Deletes multiple users from the database
   * @param userIds - array of user ids
   * @returns void
   */
  async deleteUsers(userIds: string[]): Promise<void> {
    const users = await this.userRepository.findManyLean({
      _id: { $in: userIds },
    });
    if (users.length < 1) throw new TGMDNotFoundException('Users not found');

    if (users.some((user) => user.role !== Role.Admin)) {
      throw new TGMDConflictException(
        'Only users with admin role can be deleted',
      );
    }

    const deletedCount = await this.userRepository.deleteMany(userIds);
    if (deletedCount !== users.length)
      throw new TGMDExternalServiceException('Some users were not deleted');
  }

  /**
   * Gets user game preferences based on user id and games
   * @param getUserByIdParams - get user by id params
   * @param getGamePreferencesParams - get game preferences params
   * @returns an array of user game data
   */
  async getUserGamePreferences(
    getUserByIdParams: GetUserByIdParams,
    getGamePreferencesParams: GetGamePreferencesParams,
  ): Promise<UserGameData[]> {
    const { userId } = getUserByIdParams;

    let gamesInput: string[];

    getGamePreferencesParams.games
      ? (gamesInput = getGamePreferencesParams.games.split(','))
      : (gamesInput = Object.values(Game).filter(
          (value) => typeof value === 'string',
        ));

    const gamePreferences = await this.userGameDataRepository.findManyLean({
      user: userId,
      game: { $in: gamesInput },
    });
    if (gamePreferences.length < 1) return [];

    return gamePreferences;
  }

  /**
   * Sends warning to users
   * @param userWarningInput - users warning input
   * @returns array of users
   */
  async warnUsers(userWarningInput: UserWarningInput): Promise<User[]> {
    const { userIds, note } = userWarningInput;

    const users = await this.userRepository.findManyLean({
      _id: { $in: userIds },
    });
    if (users.length < 1) throw new TGMDNotFoundException('Users not found');

    const update = await this.userRepository.updateMany(
      { _id: { $in: userIds } },
      { status: { note: note, type: UserStatusType.Active } },
    );
    if (update.modifiedCount < 1)
      throw new TGMDInternalException('Failed to update users');

    /**
     * TODO: Implement user notification for warning
     */

    return await this.userRepository.findManyLean({
      _id: { $in: userIds },
    });
  }

  /**
   * Bans users
   * @param userBanInput - users ban input
   * @returns array of users
   */
  async banUsers(userBanInput: UserBanInput): Promise<User[]> {
    const { userIds, note } = userBanInput;

    const users = await this.userRepository.findManyLean({
      _id: { $in: userIds },
    });
    if (users.length < 1) throw new TGMDNotFoundException('Users not found');

    const update = await this.userRepository.updateMany(
      { _id: { $in: userIds } },
      { status: { type: UserStatusType.Banned, note } },
    );
    if (update.modifiedCount < 1)
      throw new TGMDInternalException('Failed to update users');

    // Create and send notifications to users about the ban
    await this.notificationService.createAndSendBanNotifications(userIds, note);

    return await this.userRepository.findManyLean({
      _id: { $in: userIds },
    });
  }

  /**
   * Suspends users
   * @param userSuspendInput - user suspend input
   * @returns array of users
   */
  async suspendUsers(userSuspendInput: UserSuspendInput): Promise<User[]> {
    const { userIds, note, until } = userSuspendInput;
    const users = await this.userRepository.findManyLean({
      _id: { $in: userIds },
    });
    if (users.length < 1) throw new TGMDNotFoundException('Users not found');

    const update = await this.userRepository.updateMany(
      { _id: { $in: userIds } },
      { status: { type: UserStatusType.Suspended, note, until } },
    );
    if (update.modifiedCount < 1)
      throw new TGMDInternalException('Failed to update users');

    // Create and send notifications to users about the suspension
    await this.notificationService.createAndSendSuspendNotifications(
      userIds,
      note,
      until,
    );

    return await this.userRepository.findManyLean({
      _id: { $in: userIds },
    });
  }

  /**
   * Resets users status
   * @param userResetInput - user reset input
   * @returns array of users
   */
  async resetUsers(userResetInput: UserResetInput): Promise<User[]> {
    const { userIds } = userResetInput;
    const users = await this.userRepository.findManyLean({
      _id: { $in: userIds },
    });
    if (users.length < 1) throw new TGMDNotFoundException('Users not found');

    const update = await this.userRepository.updateMany(
      { _id: { $in: userIds } },
      { status: { type: UserStatusType.Active, note: '' } },
    );
    if (update.modifiedCount < 1)
      throw new TGMDInternalException('Failed to update users');

    // Remove ban/suspension notifications
    await this.notificationService.removeUserNotificationsOfSpecifiedType(
      userIds,
      [UserNotificationType.Ban, UserNotificationType.Suspend],
    );

    return await this.userRepository.findManyLean({
      _id: { $in: userIds },
    });
  }

  /**
   * Fetches user warning types
   * @returns array of user warning type response
   */
  getUserWarningTypes(): UserWarningTypeResponse[] {
    return userWarningTypeResponse;
  }

  /**
   * Fetches user report types
   * @returns array of user warning type response
   */
  getUserReportTypes(): UserReportTypeResponse[] {
    return userReportTypeResponse;
  }

  /**
   * Sets/updates user note
   * @param userId - user id
   * @param userNoteInput - user note input object
   * @returns user object
   */
  async setUserNote(
    userId: string,
    userNoteInput: UserNoteInput,
  ): Promise<User> {
    const { note } = userNoteInput;
    const user = await this.userRepository.findOneLean({ _id: userId });
    if (!user) throw new TGMDNotFoundException('User not found');
    return await this.userRepository.updateOneById(userId, { note });
  }

  /**
   * Gets reports for user
   * @param userId - user ID
   * @returns user report response array
   */
  async getUserReports(userId: string): Promise<UserReportResponse[]> {
    const actions = await this.actionRepository.findOneLeanWithReporter(userId);
    if (!actions) return [];

    const result: UserReportResponse[] = [];

    type IActionDataRecord = {
      reportReason: ReportReason;
      user: User;
      createdAt?: Date;
      updatedAt?: Date;
    };

    for (const report of actions.actionsFrom as IActionDataRecord[]) {
      result.push({
        reporter: report.user.username,
        reportReason: report.reportReason,
        createdAt: report.createdAt,
      });
    }
    return result;
  }

  /**
   * Fetches user groups
   * @returns array of user group response
   */
  getUserGroups(): UserGroupResponse[] {
    return userGroupsResponse;
  }

  /**
   * Adds a game to the user
   * @param userId - user ID
   * @param game - game enum
   * @returns Void
   */
  async addUserGame(userId: string, game: string): Promise<void> {
    const user = await this.userRepository.findOneLean({ _id: userId });
    if (!user) throw new TGMDNotFoundException('User not found');

    const userGameData = await this.userGameDataRepository.findOneLean({
      game,
      user: userId,
    });
    if (userGameData)
      throw new TGMDConflictException(
        'Selected game is already added to the user',
      );

    await this.userGameDataRepository.createOne({
      game,
      user: userId,
      preferences: [],
    });
  }

  /**
   * Deletes a game from the user
   * @param userId - user ID
   * @param game - game enum
   * @returns Void
   */
  async deleteUserGame(userId: string, game: string): Promise<void> {
    const userGameData = await this.userGameDataRepository.findOneLean({
      user: userId,
      game,
    });
    if (!userGameData)
      throw new TGMDNotFoundException('Game data for selected user not found');

    await this.userGameDataRepository.deleteOne({
      game,
      user: userId,
    });
  }

  /**
   * Used to convert kebab case string to first uppercase
   * or all uppercase if the string is roman numeral
   * @param string - input string
   * @returns string
   */
  private convertToUppercase(string: string): string {
    // Dictionary to map Roman numerals to their uppercase counterparts
    const romanNumerals: { [key: string]: string } = {
      i: 'I',
      ii: 'II',
      iii: 'III',
      iv: 'IV',
    };

    // Check if the word is a Roman numeral
    if (romanNumerals[string.toLowerCase()]) {
      return romanNumerals[string.toLowerCase()];
    } else {
      return string.charAt(0).toUpperCase() + string.slice(1);
    }
  }

  /**
   * Searches users based on the input username with limit to 15 users
   * @param userId - id of user searching
   * @param username - username that is being searched for
   * @returns user search response
   */
  async searchUsers(
    userId: string,
    username: string,
    limit?: number,
  ): Promise<UserSearchResponse[]> {
    const query: FilterQuery<User> = {
      role: Role.User,
      username: { $regex: username, $options: 'i' },
      _id: { $ne: userId },
    };

    const users = await this.userRepository.findManyLean(query, '', {
      limit,
    });

    const userFriends = await this.friendsRepository.findOneLean({
      user: userId,
    });

    const userBlocks = await this.actionRepository.findOneLean({
      actionType: ActionType.Block,
      user: userId,
    });

    const resultList: UserSearchResponse[] = [];

    for (const user of users) {
      if (
        userBlocks?.actionsTo.some(
          (block) => block.user == user._id.toString(),
        ) ||
        userBlocks?.actionsFrom.some(
          (block) => block.user == user._id.toString(),
        )
      )
        continue;

      if (
        userFriends &&
        userFriends.friends.length > 0 &&
        userFriends.friends.some((friend) => friend.user == user._id.toString())
      ) {
        resultList.push({
          id: user._id,
          username: user.username,
          friend: true,
          photoKey: user.photoKey,
        });
      } else {
        resultList.push({
          id: user._id,
          username: user.username,
          friend: false,
          photoKey: user.photoKey,
        });
      }
    }

    return resultList;
  }

  /**
   * Adds a user to the friend list of user
   * @param userId - id of user requesting the friendship
   * @param friendId - id of user to be added as friend
   */
  async userAddFriend(userId: string, friendId: string): Promise<void> {
    const friend = await this.userRepository.findOneLean({ _id: friendId });
    if (!friend) throw new TGMDNotFoundException('Friend not found');

    let requesterFriends: FriendsDocument;

    requesterFriends = await this.friendsRepository.findOne({
      user: userId,
    });

    if (await this.checkIfUsersAreBlocked(userId, friendId))
      throw new TGMDConflictException('User is blocked');

    if (!requesterFriends) {
      requesterFriends = await this.friendsRepository.createOne({
        user: userId,
        friends: [{ user: friend._id }],
        requests: [],
      });
    } else {
      if (requesterFriends.friends.some((f) => f.user == friendId)) {
        throw new TGMDConflictException('Friend already added');
      }
      requesterFriends.friends.push({ user: friend._id } as Friend);
      await this.friendsRepository.updateOneById(
        requesterFriends.id,
        requesterFriends,
      );
    }
    let requesteeFriends: FriendsDocument;

    requesteeFriends = await this.friendsRepository.findOne({
      user: friend._id,
    });

    if (!requesteeFriends) {
      requesteeFriends = await this.friendsRepository.createOne({
        user: friend._id,
        friends: [{ user: userId }],
        requests: [],
      });
    } else {
      if (requesteeFriends.friends.some((f) => f.user == userId)) {
        throw new TGMDConflictException('Friend already added');
      }
      requesteeFriends.friends.push({ user: userId } as Friend);
      await this.friendsRepository.updateOneById(
        requesteeFriends.id,
        requesteeFriends,
      );

      await this.sendFriendAddedNotification(userId, friendId);
    }
  }

  /**
   * Removes a user from friends of the user who requested the removal
   * @param userId - id of user requesting the friendship removal
   * @param unfriendId - id of user to be removed from friends
   */
  async userRemoveFriend(userId: string, unfriendId: string): Promise<void> {
    const removalRequester = await this.userRepository.findOneLean({
      _id: userId,
    });
    if (!removalRequester) throw new TGMDNotFoundException('User not found');

    const removalRequestee = await this.userRepository.findOneLean({
      _id: unfriendId,
    });
    if (!removalRequestee)
      throw new TGMDNotFoundException('User to be removed not found');

    const requesterFriends = await this.friendsRepository.findOneLean({
      user: removalRequester._id,
    });
    if (!requesterFriends)
      throw new TGMDNotFoundException(
        'User not found in requester friends list',
      );

    if (
      !requesterFriends.friends.some(
        (f) => f.user.toString() === removalRequestee._id.toString(),
      )
    )
      throw new TGMDNotFoundException(
        'Requestee not found in requester friends list',
      );

    requesterFriends.friends = requesterFriends.friends.filter(
      (f) => f.user.toString() !== removalRequestee._id.toString(),
    );

    await this.friendsRepository.updateOneById(
      requesterFriends._id,
      requesterFriends,
    );

    const requesteeFriends = await this.friendsRepository.findOneLean({
      user: removalRequestee._id,
    });
    if (!requesteeFriends)
      throw new TGMDNotFoundException(
        'User not found in requestee friends list',
      );

    if (
      !requesteeFriends.friends.some(
        (f) => f.user.toString() === removalRequester._id.toString(),
      )
    )
      throw new TGMDNotFoundException(
        "Requester not found in requestee's friends list",
      );

    requesteeFriends.friends = requesteeFriends.friends.filter(
      (f) => f.user.toString() !== removalRequester._id.toString(),
    );

    await this.friendsRepository.updateOneById(
      requesteeFriends._id,
      requesteeFriends,
    );
  }

  /**
   * Fetches user profile data based on the user fetching the profile
   * @param userId - id of user whose profile is being fetched
   * @param currentUserId - id of user fetching the profile
   * @returns user profile response
   */
  async getUserProfile(
    userId: string,
    currentUserId: string,
  ): Promise<UserProfileResponse> {
    const user = await this.userRepository.findOneLean({ _id: userId });
    if (!user) throw new TGMDNotFoundException('User not found');

    if (await this.checkIfUsersAreBlocked(userId, currentUserId))
      throw new TGMDForbiddenException('User is blocked');

    let isFriend = false;
    let sentFriendRequest = false;
    let receivedFriendRequest = false;
    let friendsCount = 0;

    const userFriends = await this.friendsRepository.findOneLean({
      user: user._id,
    });
    if (userFriends) friendsCount = userFriends.friends.length;

    isFriend = await this.checkIfUsersAreFriends(userId, currentUserId);

    if (!isFriend) {
      sentFriendRequest = await this.checkIfFriendRequestPending(
        userId,
        currentUserId,
      );
      if (!sentFriendRequest) {
        receivedFriendRequest = await this.checkIfFriendRequestPending(
          currentUserId,
          userId,
        );
      }
    }

    return {
      username: user.username,
      photo: user.photoKey,
      audio: user.audioKey,
      description: user.description,
      friendsCount,
      isFriend,
      sentFriendRequest,
      receivedFriendRequest,
    };
  }

  /**
   * Checks if one of the users blocked another
   * @param userOneId - user one id
   * @param userTwoId - user two id
   * @returns boolean
   */
  private async checkIfUsersAreBlocked(
    userOneId: string,
    userTwoId: string,
  ): Promise<boolean> {
    const userOneActions = await this.actionRepository.findOneLean({
      user: userOneId,
      actionType: ActionType.Block,
    });
    const userTwoActions = await this.actionRepository.findOneLean({
      user: userTwoId,
      actionType: ActionType.Block,
    });
    if (!userOneActions || !userTwoActions) return false;
    if (
      userOneActions.actionsTo.some((f) => f.user.toString() === userTwoId) ||
      userOneActions.actionsFrom.some((f) => f.user.toString() === userTwoId) ||
      userTwoActions.actionsTo.some((f) => f.user.toString() === userOneId) ||
      userTwoActions.actionsFrom.some((f) => f.user.toString() === userOneId)
    )
      return true;

    return false;
  }

  /**
   * Checks if user is a friend of another user
   * @param userOneId - id of user to check
   * @param userTwoId - id of user to check against
   * @returns boolean
   */
  private async checkIfUsersAreFriends(
    userOneId: string,
    userTwoId: string,
  ): Promise<boolean> {
    const userOneFriends = await this.friendsRepository.findOneLean({
      user: userOneId,
    });
    if (!userOneFriends) return false;
    if (userOneFriends.friends.some((f) => f.user.toString() === userTwoId))
      return true;

    return false;
  }

  /**
   * Checks if a user sent a friend request to another user
   * @param requesterId - id of user to check
   * @param requesteeId - id of user to check against
   * @returns boolean
   */
  private async checkIfFriendRequestPending(
    requesterId: string,
    requesteeId: string,
  ): Promise<boolean> {
    const requesteeFriends = await this.friendsRepository.findOneLean({
      user: requesteeId,
    });
    if (!requesteeFriends) return false;
    if (
      requesteeFriends.requests.some((f) => f.user.toString() === requesterId)
    )
      return true;

    return false;
  }

  /**
   * Checks if a current user is a friend of a target user
   * @param currentUserId - id of user performing the check
   * @param checkUserId - id of user on who the check is performed
   * @returns check friendship response
   */
  async checkFriendship(
    currentUserId: string,
    checkUserId: string,
  ): Promise<CheckFriendshipResponse> {
    const user = await this.userRepository.findOneLean({ _id: checkUserId });
    if (!user) throw new TGMDNotFoundException('User not found');

    const result: CheckFriendshipResponse = { isFriend: true };

    const currentUserFriends = await this.friendsRepository.findOneLean({
      user: currentUserId,
    });
    if (
      !currentUserFriends ||
      !currentUserFriends.friends ||
      !currentUserFriends.friends.some((f) => f.user.toString() === checkUserId)
    )
      result.isFriend = false;

    return result;
  }

  /**
   * Checks if provided users are blocked by either of them
   * @param currentUserId - id of user performing the check
   * @param checkUserId - id of user on who the check is performed
   * @returns check block status response
   */
  async checkBlockStatus(
    currentUserId: string,
    checkUserId: string,
  ): Promise<CheckBlockStatusResponse> {
    const user = await this.userRepository.findOneLean({ _id: checkUserId });
    if (!user) throw new TGMDNotFoundException('User not found');

    const result: CheckBlockStatusResponse = {
      isBlocked: await this.checkIfUsersAreBlocked(currentUserId, checkUserId),
    };

    return result;
  }

  /*
   * Fetches user games based on the user id
   * @param userId - user ID
   * @returns user games response
   */
  async getUserGames(userId: string): Promise<UserGamesResponse> {
    const user = await this.userRepository.findOneLean({ _id: userId });
    if (!user) throw new TGMDNotFoundException('User not found');

    const userGameData = await this.userGameDataRepository.findManyLean({
      user: userId,
    });
    if (userGameData.length < 1) return { userId, games: [] };

    const games = userGameData.map((game) => game.game);
    const gamesResponse: UserGameResponse[] = games.map((game) => {
      return {
        displayName: game
          .split('-')
          .map((word) => this.convertToUppercase(word))
          .join(' '),
        game: game,
      };
    });
    const result: UserGamesResponse = {
      userId,
      games: gamesResponse,
    };

    return result;
  }

  /**
   * List user friends based on the user id and input parameters
   * @param userId - user id
   * @param listUserFriendsParams - list user friends params
   * @param paginationParams - pagination params
   * @returns paginated list of users
   */
  async listUserFriends(
    userId: string,
    listUserFriendsParams: ListUserFriendsParams,
    paginationParams: PaginationParams,
  ): Promise<PaginationModel<User>> {
    const { username } = listUserFriendsParams;
    const { limit, skip } = paginationParams;
    const userFriends = await this.friendsRepository.findOneLean({
      user: userId,
    });
    if (!userFriends) return new PaginationModel([], paginationParams, 0);

    const query: FilterQuery<User> = {
      _id: { $in: userFriends.friends.map((f) => f.user.toString()) },
    };

    if (username) query.username = { $regex: username, $options: 'i' };

    const friends = await this.userRepository.findManyLean(
      query,
      '_id username photoKey',
      { limit: limit, skip: skip },
    );

    const count = await this.userRepository.count(query);

    return new PaginationModel(friends, paginationParams, count);
  }

  /**
   * Adds a report to target user and reporter user
   * @param reportUserInput - report user input
   * @returns Void
   */
  async reportUser(reportUserInput: ReportUserInput): Promise<void> {
    const user = await this.userRepository.findOneLean({
      _id: reportUserInput.targetId,
    });
    if (!user) throw new TGMDNotFoundException('User not found');

    await this.addReportToReporter(reportUserInput);

    await this.addReportToTargetUser(reportUserInput);
  }

  /**
   * Adds a report to reporter user
   * @param reportUserInput - report user input
   * @returns Void
   */
  private async addReportToReporter(
    reportUserInput: ReportUserInput,
  ): Promise<void> {
    const { reporterId, targetId, reportReason } = reportUserInput;
    const reporterUserActions = await this.actionRepository.findOrCreate(
      {
        user: reporterId,
        actionType: ActionType.Report,
        actionsFrom: [],
        actionsTo: [],
      },
      { user: reporterId },
    );
    reporterUserActions.actionsTo.push({
      user: targetId,
      reportReason: reportReason,
    });
    await this.actionRepository.updateOneById(reporterUserActions._id, {
      actionsTo: reporterUserActions.actionsTo,
    });
  }

  /**
   * Adds a report to target user
   * @param reportUserInput - report user input
   * @returns Void
   */
  private async addReportToTargetUser(
    reportUserInput: ReportUserInput,
  ): Promise<void> {
    const { reporterId, targetId, reportReason } = reportUserInput;

    const targetUserActions = await this.actionRepository.findOrCreate(
      {
        user: targetId,
        actionType: ActionType.Report,
        actionsFrom: [],
        actionsTo: [],
      },
      { user: targetId },
    );
    targetUserActions.actionsFrom.push({
      user: reporterId,
      reportReason: reportReason,
    });
    await this.actionRepository.updateOneById(targetUserActions._id, {
      actionsFrom: targetUserActions.actionsFrom,
    });
  }

  /**
   * Sets user photo and deletes the previous photo if it exists
   * @param userId - user id
   * @param file - file to be uploaded
   * @returns set user photo response
   */
  async setUserPhoto(
    userId: string,
    file: Express.Multer.File,
  ): Promise<SetUserFileResponse> {
    const user = await this.userRepository.findOneLean({ _id: userId });

    if (user.photoKey) {
      await this.fileStorageService.delete(user.photoKey);
    }

    const photoKey = `profile-photos/${user._id}-${Date.now()}`;

    await this.fileStorageService.upload({
      Key: photoKey,
      Body: file.buffer,
    });
    await this.userRepository.updateOneById(user._id, {
      photoKey,
    });

    // Upsert user in chat service
    await this.chatUserService.upsertUser({
      id: user._id.toString(),
      role: 'user',
      image: photoKey,
      username: user.username,
    });

    return { key: photoKey };
  }

  /**
   * Sets user photo and deletes the previous photo if it exists
   * @param userId - user id
   * @param file - file to be uploaded
   * @returns set user photo response
   */
  async setUserAudioIntro(
    userId: string,
    file: Express.Multer.File,
  ): Promise<SetUserFileResponse> {
    const user = await this.userRepository.findOneLean({ _id: userId });

    if (user.audioKey) {
      await this.fileStorageService.delete(user.audioKey);
    }

    const audioKey = `audio-intros/${user._id}-${Date.now()}.${
      this.s3Config.AUDIOFORMAT
    }`;

    await this.fileStorageService.upload({
      Key: audioKey,
      Body: file.buffer,
    });
    await this.userRepository.updateOneById(user._id, {
      audioKey,
    });
    return { key: audioKey };
  }

  /**
   * Fetches current user profile data
   * @param userId - user id
   * @returns get me user response
   */
  async getMeUser(userId: string): Promise<GetMeUserResponse> {
    const result = new GetMeUserResponse();

    const user = await this.userRepository.findOneLean({ _id: userId });
    result.id = user._id;
    result.username = user.username;
    result.audioKey = user.audioKey;
    result.photoKey = user.photoKey;
    result.description = user.description;
    result.country = user.country;
    result.email = user.email;
    result.regions = user.regions?.map((region) =>
      StringUtils.kebabCaseToCapitalized(region),
    );
    result.language = user.language;
    result.dateOfBirth = user.dateOfBirth;
    result.gender = user.gender;
    result.epicGamesUsername = user.epicGamesUsername;
    result.notificationSettings = user.notificationSettings;
    result.games = [];

    const friends = await this.friendsRepository.findOneLean({ user: userId });
    result.friends = friends ? friends.friends.length : 0;

    const games = await this.userGameDataRepository.findManyLean({
      user: userId,
    });
    if (games) {
      for (const game of games) {
        const gameName = StringUtils.kebabCaseToCapitalized(game.game);
        result.games.push(gameName);
      }
    }

    return result;
  }

  /**
   * Updates user username
   * @param userId - user id
   * @param username - new username
   * @returns Void
   */
  async updateUsername(
    userId: string,
    { username }: UpdateUsernameInput,
  ): Promise<void> {
    const user = await this.userRepository.findOneLean({ _id: userId });
    if (user.username === username)
      throw new TGMDConflictException('This is your current username');

    const existingUsername = await this.userRepository.findOneLean({
      username,
    });
    if (existingUsername)
      throw new TGMDConflictException('This username is already in use');

    await this.userRepository.updateOneById(userId, { username });

    // Upsert user in chat service
    await this.chatUserService.upsertUser({
      id: user._id.toString(),
      role: 'user',
      image: user.photoKey,
      username: username,
    });
  }

  /**
   * Starts user email update flow and sends email with verification link
   * @param userId - user id
   * @param description - new description
   * @returns Void
   */
  async changeEmail(
    userId: string,
    { email }: ChangeEmailInput,
  ): Promise<void> {
    const user = await this.userRepository.findOneLean({ _id: userId });
    if (user.email === email)
      throw new TGMDConflictException('This is your current email');

    const existingEmail = await this.userRepository.findOneLean({
      email,
    });
    if (existingEmail)
      throw new TGMDConflictException('This email is already in use');

    const verificationCode = StringUtils.generateSevenDigitAlphaNumericCode();

    await this.emailService.sendEmailUserEmailChange(
      email,
      verificationCode,
      user.username,
    );

    await this.userRepository.updateOneById(userId, {
      newEmail: email,
      emailChangeCode: verificationCode,
      changeEmailRequested: true,
    });
  }

  /**
   * Confirms user email update by verification code
   * @param code - verification code
   * @returns Void
   */
  async confirmEmailChange({ code }: VerifyEmailChangeInput): Promise<void> {
    const user = await this.userRepository.findOneLean({
      emailChangeCode: code,
      changeEmailRequested: true,
    });
    if (!user) throw new TGMDNotFoundException('User not found');

    await this.userRepository.updateOneById(user._id, {
      email: user.newEmail,
      changeEmailRequested: false,
      emailChangeCode: null,
      newEmail: null,
    });
  }

  /**
   * Changes user password
   * @param userId - user id
   * @param changePasswordInput - change password input
   * @returns Void
   */
  async changePassword(
    userId: string,
    changePasswordInput: ChangePasswordInput,
  ): Promise<void> {
    const { oldPassword, newPassword } = changePasswordInput;
    const user = await this.userRepository.findOne(
      { _id: userId },
      '_id password',
    );
    const oldPasswordCorrect = await CryptoUtils.validateHash(
      oldPassword,
      user.password,
    );
    if (!oldPasswordCorrect)
      throw new TGMDForbiddenException('Old password is incorrect');

    user.password = newPassword;
    await user.save();
  }

  /**
   * Changes user info
   * @param userId - user id
   * @param changeUserInfoInput - change user info input
   * @returns Void
   */
  async changeUserInfo(
    userId: string,
    changeUserDataInput: ChangeUserInfoInput,
  ): Promise<void> {
    const { language, country, gender, description, dateOfBirth, regions } =
      changeUserDataInput;

    await this.userRepository.updateOneById(userId, {
      language,
      country,
      gender,
      description,
      dateOfBirth,
      regions,
    });
  }

  /**
   * Deletes current user account
   * @param userId - current user id
   * @returns Void
   */
  async deleteAccount(userId: string): Promise<void> {
    await this.chatChatService.deleteUserChannels(userId);
    await this.friendsService.deleteAccountFriends(userId);
    await this.actionService.deleteUserRelatedInboundActions(userId);
    await this.actionService.deleteUserRelatedOutboundActions(userId);
    await this.actionService.deleteUserActions(userId);
    await this.userGameDataService.deleteUserGameData(userId);
    await this.notificationService.deleteUserNotifications(userId);
    await this.matchService.deleteUserMatches(userId);
    await this.potentialMatchService.deleteUserPotentialMatches(userId);
    await this.matchmakingResultService.deleteUserMatchmakingResults(userId);
    await this.userRepository.deleteOne({ _id: userId });
  }

  /**
   * Sends friend added notification to target user
   * @param currentUserId - current user id
   * @param targetUserId - target user id
   * @returns Void
   */
  private async sendFriendAddedNotification(
    currentUserId: string,
    targetUserId: string,
  ): Promise<void> {
    const currentUser = await this.userRepository.findOneLean(
      { _id: currentUserId },
      '_id username',
    );
    if (!currentUser) throw new TGMDNotFoundException('User not found');

    await this.notificationService.createFriendAddedNotification({
      friendUsername: currentUser.username,
      recipientId: targetUserId,
      redirectScreen: `friend/${currentUserId}`,
    });
  }
}
