import { Injectable } from '@nestjs/common';

import {
  TGMDConflictException,
  TGMDNotFoundException,
} from 'src/common/exceptions/custom.exception';
import { AbstractUserRepository } from 'src/modules/user/abstract/user.abstract.repository';

import { AbstractMatchRepository } from '../abstract/match.abstract.repository';
import { AbstractMatchService } from '../abstract/match.abstract.service';
import { CheckFeedbackGivenResponse } from '../response/check-feedback-given.response';
import { CheckMatchExistsResponse } from '../response/check-match-exists.response';

@Injectable()
export class MatchService extends AbstractMatchService {
  constructor(
    private readonly matchRepository: AbstractMatchRepository,
    private readonly userRepository: AbstractUserRepository,
  ) {
    super();
  }

  /**
   * Gives feedback for matched user
   * @param currentUserId - current user id
   * @param matchId - match id
   * @param rating - rating
   */
  async giveMatchUserFeedback(
    currentUserId: string,
    matchId: string,
    rating: number,
  ): Promise<void> {
    const existingMatch = await this.matchRepository.findOneLean({
      _id: matchId,
      'players.user': currentUserId,
    });
    if (!existingMatch) {
      throw new TGMDNotFoundException('Existing match not found');
    }

    const currentUserMatchFeedback = existingMatch.players.find(
      (player) => player.user.toString() === currentUserId,
    )?.feedback;

    if (currentUserMatchFeedback) {
      throw new TGMDConflictException('Feedback already given for this match');
    }

    await this.matchRepository.updateOne(
      {
        _id: existingMatch._id,
        'players.user': currentUserId,
      },
      {
        $set: { 'players.$.feedback': rating },
      },
    );

    const matchedUserId = existingMatch.players
      .find((player) => player.user.toString() !== currentUserId)
      .user.toString();

    const matchedUser = await this.userRepository.findOne({
      _id: matchedUserId,
    });
    if (!matchedUser) {
      throw new TGMDNotFoundException('Matched user not found');
    }

    matchedUser.rating.ratings.push(rating);
    await matchedUser.save();
  }

  /**
   * Checks if user game match feedback
   * @param currentUserId - current user id
   * @param matchedUserId - matched user id
   * @returns check feedback given response
   */
  async checkIfMatchFeedbackGiven(
    currentUserId: string,
    matchedUserId: string,
  ): Promise<CheckFeedbackGivenResponse> {
    const existingMatch = await this.matchRepository.findOneLean({
      $and: [
        { 'players.user': currentUserId },
        { 'players.user': matchedUserId },
      ],
    });
    if (!existingMatch) {
      throw new TGMDNotFoundException('Match not found');
    }

    const currentUserMatchFeedback = existingMatch.players.find(
      (player) => player.user.toString() === currentUserId,
    )?.feedback;

    if (currentUserMatchFeedback) {
      return { feedbackGiven: true };
    } else {
      return { feedbackGiven: false };
    }
  }

  /**
   * Deletes all matches where the user is involved
   * @param userId - user id
   * @returns Void
   */
  async deleteUserMatches(userId: string): Promise<void> {
    const userMatches = await this.matchRepository.findManyLean({
      'players.user': userId,
    });
    if (userMatches.length > 0) {
      const userMatchesIds = userMatches.map((match) => match._id.toString());
      await this.matchRepository.deleteMany(userMatchesIds);
    }
  }

  /**
   * Checks if there is an existing match between two users
   * @param currentUserId - current user id
   * @param checkUserId - check user id
   * @returns check match exists response
   */
  async checkForExistingMatch(
    currentUserId: string,
    checkUserId: string,
  ): Promise<CheckMatchExistsResponse> {
    const existingMatch = await this.matchRepository.findOneLean({
      $and: [
        { 'players.user': currentUserId },
        { 'players.user': checkUserId },
      ],
    });
    if (existingMatch) {
      return { matchExists: true, matchId: existingMatch._id.toString() };
    } else {
      return { matchExists: false };
    }
  }
}
