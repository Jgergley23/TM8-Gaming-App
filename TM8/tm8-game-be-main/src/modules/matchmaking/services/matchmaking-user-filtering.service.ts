import { Injectable } from '@nestjs/common';
import * as moment from 'moment';

import {
  Game,
  Region,
  UserMatchChoice,
  UserStatusType,
} from 'src/common/constants';
import { AbstractActionRepository } from 'src/modules/action/abstract/action.abstract.repository';
import { AbstractFriendsRepository } from 'src/modules/friends/abstract/friends.abstract.repository';
import { AbstractMatchRepository } from 'src/modules/match/abstract/match.abstract.repository';
import { AbstractPotentialMatchRepository } from 'src/modules/potential-match/abstract/potential-match.abstract.repository';
import { UserGameData } from 'src/modules/user-game-data/schemas/user-game-data.schema';
import { AbstractUserRepository } from 'src/modules/user/abstract/user.abstract.repository';
import { User } from 'src/modules/user/schemas/user.schema';

import { AbstractMatchmakingUserFilteringService } from '../abstract/matchmaking-user-filtering.abstract.service';

@Injectable()
export class MatchmakingUserFilteringService extends AbstractMatchmakingUserFilteringService {
  constructor(
    private readonly userRepository: AbstractUserRepository,
    private readonly friendsRepository: AbstractFriendsRepository,
    private readonly actionRepository: AbstractActionRepository,
    private readonly potentialMatchRepository: AbstractPotentialMatchRepository,
    private readonly matchRepository: AbstractMatchRepository,
  ) {
    super();
  }

  /**
   * Filters out users who are not eligible for matchmaking
   * @param currentUser - current user object
   * @param otherPlayers - other user game data
   * @returns array of user game data
   */
  filterPlayableUserGameData(
    currentUser: User,
    otherPlayers: UserGameData[],
  ): UserGameData[] {
    otherPlayers = this.excludeCurrentUserFromMatching(
      otherPlayers,
      currentUser._id.toString(),
    );

    otherPlayers = this.filterActiveUsers(otherPlayers);

    otherPlayers = this.filterUsersByAge(currentUser.dateOfBirth, otherPlayers);

    otherPlayers = this.filterPlayersByRegions(
      currentUser.regions,
      otherPlayers,
    );

    return otherPlayers;
  }

  /**
   * Filters out users that the current user cannot be matched with
   * @param currentUser - current user object
   * @param userIds - array of user ids
   * @returns
   */
  async filterUnmatchableUsers(
    currentUser: User,
    userIds: string[],
    game: Game,
  ): Promise<string[]> {
    userIds = await this.filterRejectedUsers(currentUser, userIds, game);
    userIds = await this.filterUserFriends(currentUser._id.toString(), userIds);
    userIds = await this.filterAlreadyMatchedUsers(
      currentUser._id.toString(),
      userIds,
    );
    userIds = await this.filterBlockedOrReportedUsers(
      currentUser._id.toString(),
      userIds,
    );
    return userIds;
  }

  /**
   * Excludes current user from the list of preferences to be matched
   * @param otherPlayers - other user game data
   * @param currentUserId - current user id
   * @returns array of user game data excluding the current user
   */
  private excludeCurrentUserFromMatching(
    otherPlayers: UserGameData[],
    currentUserId: string,
  ): UserGameData[] {
    return otherPlayers.filter((player) => {
      if (player.user && typeof player.user !== 'string') {
        return player.user._id.toString() !== currentUserId;
      }
    });
  }

  /**
   * Filters out users who are not active
   * @param players - array of user game data
   * @returns array of active user game data
   */
  private filterActiveUsers(players: UserGameData[]): UserGameData[] {
    return players.filter((player) => {
      if (typeof player.user !== 'string')
        return player.user.status.type === UserStatusType.Active;
    });
  }

  /**
   * Filters out users who have been rejected by the current user or have rejected the current user
   * @param currentUser - current user object
   * @param userIds - array of user ids
   * @returns Void
   */
  private async filterRejectedUsers(
    currentUser: User,
    userIds: string[],
    game: Game,
  ): Promise<string[]> {
    userIds = userIds.filter((userId) => {
      return !currentUser.rejectedUsers?.some((rejectedUser) => {
        return rejectedUser.user == userId && rejectedUser.game === game;
      });
    });

    const users = await this.userRepository.findManyLean(
      {
        _id: { $in: userIds },
      },
      '_id rejectedUsers',
    );

    const usersThatRejectedCurrentUser = [];
    users.forEach((user) => {
      if (
        user.rejectedUsers?.some((rejectedUser) => {
          return (
            rejectedUser.user == currentUser._id && rejectedUser.game === game
          );
        })
      ) {
        usersThatRejectedCurrentUser.push(user._id.toString());
      }
    });
    userIds = userIds.filter((userId) => {
      return !usersThatRejectedCurrentUser.includes(userId.toString());
    });

    return userIds;
  }

  /**
   * Filters out user friends from the array of user ids
   * @param currentUserId - current user id
   * @param userIds - array of user ids
   * @returns Void
   */
  private async filterUserFriends(
    currentUserId: string,
    userIds: string[],
  ): Promise<string[]> {
    const userFriends = await this.friendsRepository.findOneLean(
      {
        user: currentUserId,
      },
      '_id user friends',
    );
    if (userFriends) {
      const friends = userFriends.friends.map((friend) =>
        friend.user.toString(),
      );
      userIds = userIds.filter((userId) => {
        return !friends.includes(userId.toString());
      });
    }
    return userIds;
  }

  /**
   * Filters out blocked or reported users from the array of user ids
   * @param currentUserId - current user id
   * @param userIds - array of user ids
   * @returns Void
   */
  private async filterBlockedOrReportedUsers(
    currentUserId: string,
    userIds: string[],
  ): Promise<string[]> {
    const actions = await this.actionRepository.findManyLean({
      user: currentUserId,
    });
    if (actions && actions.length > 0) {
      userIds = userIds?.filter((userId) => {
        const foundInActions = actions.some((action) => {
          const actionsFromUserIds = action.actionsFrom.map((actionFrom) =>
            actionFrom.user.toString(),
          );
          const actionsToUserIds = action.actionsTo.map((actionTo) =>
            actionTo.user.toString(),
          );
          return (
            actionsFromUserIds.includes(userId) ||
            actionsToUserIds.includes(userId)
          );
        });
        return !foundInActions;
      });
    }
    return userIds;
  }

  /**
   * Checks if user is underage and adjusts the filter query accordingly
   * @param dateOfBirth - current user date of birth
   * @param filter - filter object
   * @returns Void
   */
  private filterUsersByAge(
    dateOfBirth: Date,
    userGameData: UserGameData[],
  ): UserGameData[] {
    const currentDate = moment();
    const eighteenYearsAgo = currentDate.clone().subtract(18, 'years').toDate();
    const thirteenYearsAgo = currentDate.clone().subtract(13, 'years').toDate();

    if (dateOfBirth > eighteenYearsAgo) {
      return userGameData.filter((player) => {
        if (typeof player.user !== 'string') {
          const playerDOB = moment(player.user.dateOfBirth).toDate();
          return playerDOB >= thirteenYearsAgo;
        }
      });
    } else {
      return userGameData.filter((player) => {
        if (typeof player.user !== 'string') {
          const playerDOB = moment(player.user.dateOfBirth).toDate();
          return playerDOB < eighteenYearsAgo;
        }
      });
    }
  }

  /**
   * Filters out players who don't play in the same region as the current user
   * @param regions - array of regions
   * @param userGameDatas - array of game user data
   * @returns Void
   */
  private filterPlayersByRegions(
    regions: Region[],
    userGameDatas: UserGameData[],
  ): UserGameData[] {
    return userGameDatas.filter((player) => {
      if (typeof player.user !== 'string') {
        return player.user.regions.some((region) => regions.includes(region));
      }
    });
  }

  /**
   * Checks if there are existing potential matches and moves them to the start of the matchmaking results
   * @param userId - current user id
   * @param game - game name
   * @param matchmakingResults - array of matchmaking result user ids
   * @returns - array of user ids with potential matches moved to the start
   */
  async checkMatchmakingResultsForExistingPotentialMatch(
    userId: string,
    game: string,
    matchmakingResults: string[],
  ): Promise<string[]> {
    const userPotentialMatches =
      await this.potentialMatchRepository.findManyLean({
        users: { $in: [userId] },
        game,
      });

    const usersWaitingToMatch: string[] = [];

    userPotentialMatches.forEach((potentialMatch) => {
      const otherUser = potentialMatch.users.find(
        (user) => user._id !== userId,
      );
      if (
        matchmakingResults.includes(otherUser.user.toString()) &&
        otherUser.choice === UserMatchChoice.Accepted
      ) {
        usersWaitingToMatch.push(otherUser.user.toString());
      }
    });

    // Move usersWaitingToMatch to the start of matchakingResults for better matchmaking
    matchmakingResults = usersWaitingToMatch.concat(
      matchmakingResults?.filter((id) => !usersWaitingToMatch.includes(id)),
    );

    return matchmakingResults;
  }

  /**
   * Filters out already matched users from the list of potential matches
   * @param currentUserId - current user id
   * @param userIds - array of user ids
   * @returns - array of user ids with already matched users removed
   */
  private async filterAlreadyMatchedUsers(
    currentUserId: string,
    userIds: string[],
  ): Promise<string[]> {
    const currentUserMatches = await this.matchRepository.findManyLean({
      'players.user': currentUserId,
    });
    if (currentUserMatches.length > 0) {
      const matchedUserIds = currentUserMatches.flatMap((match) =>
        match.players.map((player) => player.user.toString()),
      );
      userIds = userIds.filter((userId) => {
        return !matchedUserIds.includes(userId.toString());
      });
    }
    return userIds;
  }
}
