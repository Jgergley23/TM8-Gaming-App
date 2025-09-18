import { Injectable } from '@nestjs/common';
import * as moment from 'moment';

import { Game, UserMatchChoice } from 'src/common/constants';
import {
  TGMDConflictException,
  TGMDNotFoundException,
} from 'src/common/exceptions/custom.exception';
import { AbstractMatchRepository } from 'src/modules/match/abstract/match.abstract.repository';
import { AbstractMatchmakingResultRepository } from 'src/modules/matchmaking-result/abstract/matchmaking-result.abstract.repository';
import { MatchmakingResult } from 'src/modules/matchmaking-result/schemas/matchmaking-result.schema';
import { AbstractNotificationService } from 'src/modules/notification/abstract/notification.abstract.service';
import { AcceptPotentialMatchResponse } from 'src/modules/potential-match/response/accept-potential-match.response';
import { AbstractUserRepository } from 'src/modules/user/abstract/user.abstract.repository';

import { AbstractPotentialMatchRepository } from '../abstract/potential-match.abstract.repository';
import { AbstractPotentialMatchService } from '../abstract/potential-match.abstract.service';

@Injectable()
export class PotentialMatchService extends AbstractPotentialMatchService {
  constructor(
    private readonly potentialMatchRepository: AbstractPotentialMatchRepository,
    private readonly matchmakingResultRepository: AbstractMatchmakingResultRepository,
    private readonly matchRepository: AbstractMatchRepository,
    private readonly userRepository: AbstractUserRepository,
    private readonly notificationService: AbstractNotificationService,
  ) {
    super();
  }

  /**
   * Resets user potential matches for a game
   * @param userId - user id
   * @param game - game name
   * @returns Void
   */
  async resetUserPotentialMatches(userId: string, game: Game): Promise<void> {
    const userPotentialMatches =
      await this.potentialMatchRepository.findManyLean({
        game,
        'users.user': userId,
      });
    if (userPotentialMatches.length > 0) {
      const potentialMatchIds = userPotentialMatches.map((match) =>
        match._id.toString(),
      );
      await this.potentialMatchRepository.deleteMany(potentialMatchIds);
    }
  }

  /**
   * Accepts a potential match between users and creates a match or potential match entry
   * @param currentUserId - current user id
   * @param targetUserId - target user id
   * @param game - game name
   * @returns accept potential match response
   */
  async acceptPotentialMatch(
    currentUserId: string,
    targetUserId: string,
    game: Game,
  ): Promise<AcceptPotentialMatchResponse> {
    const existingMatch = await this.matchRepository.findOneLean({
      game,
      $and: [
        { 'players.user': currentUserId },
        { 'players.user': targetUserId },
      ],
    });
    if (existingMatch) {
      throw new TGMDConflictException('Match already exists');
    }

    const matchmakingResult =
      await this.matchmakingResultRepository.findOneLean({
        user: currentUserId,
        game,
      });
    if (!matchmakingResult) {
      throw new TGMDNotFoundException('Matchmaking result not found');
    }

    const userIsInsideMatchmakingResult = matchmakingResult.matches.some(
      (match) => match.toString() === targetUserId,
    );

    if (!userIsInsideMatchmakingResult) {
      throw new TGMDNotFoundException(
        'User not found inside matchmaking results',
      );
    }

    const potentialMatch = await this.potentialMatchRepository.findOneLean({
      $and: [{ 'users.user': currentUserId }, { 'users.user': targetUserId }],
    });

    await this.removePotentialMatchFromMatchmakingResult(
      matchmakingResult,
      targetUserId,
    );

    if (potentialMatch) {
      const otherUser = potentialMatch.users.find((user) => {
        return user.user.toString() === targetUserId;
      });

      if (otherUser.choice === UserMatchChoice.Accepted) {
        await this.matchRepository.createOne({
          players: [
            { user: currentUserId, feedback: null },
            { user: targetUserId, feedback: null },
          ],
          game,
        });

        await this.potentialMatchRepository.deleteOne({
          _id: potentialMatch._id,
        });

        await this.sendMatchNotification(currentUserId, targetUserId);

        return { isMatch: true };
      }
    } else {
      await this.potentialMatchRepository.createOne({
        users: [
          {
            user: currentUserId,
            choice: UserMatchChoice.Accepted,
          },
          {
            user: targetUserId,
            choice: UserMatchChoice.None,
          },
        ],
        game,
      });

      return { isMatch: false };
    }
  }

  /**
   * Removes potential match user from matchmaking result
   * @param matchmakingResult - matchmaking result
   * @param targetUserId - target user id
   * @returns Void
   */
  private async removePotentialMatchFromMatchmakingResult(
    matchmakingResult: MatchmakingResult,
    targetUserId: string,
  ): Promise<void> {
    const filteredMatchmakingResults = (
      matchmakingResult.matches as string[]
    ).filter((match) => {
      return match.toString() !== targetUserId;
    });

    await this.matchmakingResultRepository.updateOneById(
      matchmakingResult._id,
      { matches: filteredMatchmakingResults },
    );
  }

  /* Rejects a potential match between users and adds target user to current user rejected users
   * @param currentUserId - current user id
   * @param targetUserId - target user id
   * @param game - game name
   * @returns Void
   */
  async rejectPotentialMatch(
    currentUserId: string,
    targetUserId: string,
    game: Game,
  ): Promise<void> {
    const existingMatch = await this.matchRepository.findOneLean({
      game,
      $and: [
        { 'players.user': currentUserId },
        { 'players.user': targetUserId },
      ],
    });
    if (existingMatch) {
      throw new TGMDConflictException('Match already exists');
    }

    const matchmakingResult =
      await this.matchmakingResultRepository.findOneLean({
        user: currentUserId,
        game,
      });
    if (!matchmakingResult) {
      throw new TGMDNotFoundException('Matchmaking result not found');
    }

    const userIsInsideMatchmakingResult = matchmakingResult.matches.some(
      (match) => match.toString() === targetUserId,
    );

    if (!userIsInsideMatchmakingResult) {
      throw new TGMDNotFoundException(
        'User not found inside matchmaking results',
      );
    }

    const potentialMatch = await this.potentialMatchRepository.findOneLean({
      $and: [{ 'users.user': currentUserId }, { 'users.user': targetUserId }],
    });
    if (potentialMatch) {
      await this.potentialMatchRepository.deleteOne({
        _id: potentialMatch._id,
      });
    }
    await this.removePotentialMatchFromMatchmakingResult(
      matchmakingResult,
      targetUserId,
    );

    await this.addUserToRejectedUsers(currentUserId, targetUserId, game);
  }

  /**
   * Adds a target user to current user rejected users
   * @param currentUserId - current user id
   * @param targetUserId - target user id
   * @param game - game name
   * @returns Void
   */
  private async addUserToRejectedUsers(
    currentUserId: string,
    targetUserId: string,
    game: Game,
  ): Promise<void> {
    const user = await this.userRepository.findOne({ _id: currentUserId });
    user.rejectedUsers.push({
      user: targetUserId,
      until: moment().add(14, 'days').toDate(),
      game,
    });

    await this.userRepository.updateOneById(currentUserId, {
      rejectedUsers: user.rejectedUsers,
    });
  }

  /**
   * Sends a match notification to target user
   * @param currentUserId - current user id
   * @param targetUserId - target user id
   * @returns Void
   */
  private async sendMatchNotification(
    currentUserId: string,
    targetUserId: string,
  ): Promise<void> {
    const users = await this.userRepository.findManyLean(
      { _id: { $in: [currentUserId, targetUserId] } },
      '_id username photoKey',
    );
    if (users.length !== 2) throw new TGMDNotFoundException('Users not found');

    const currentUser = users.find(
      (user) => user._id.toString() === currentUserId,
    );

    const targetUser = users.find(
      (user) => user._id.toString() === targetUserId,
    );

    await this.notificationService.createMatchNotification({
      currentUser,
      targetUser,
      redirectScreen: `match/${currentUser.username}/${currentUserId}`,
    });
  }

  /**
   * Deletes all potential matches where the user is involved
   * @param userId - user id
   * @returns Void
   */
  async deleteUserPotentialMatches(userId: string): Promise<void> {
    const userPotentialMatches =
      await this.potentialMatchRepository.findManyLean({
        'users.user': userId,
      });
    if (userPotentialMatches.length > 0) {
      const userPotentialMatchesIds = userPotentialMatches.map((match) =>
        match._id.toString(),
      );
      await this.potentialMatchRepository.deleteMany(userPotentialMatchesIds);
    }
  }
}
