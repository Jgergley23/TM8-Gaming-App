import { Injectable } from '@nestjs/common';

import { Game } from 'src/common/constants';
import { TGMDNotFoundException } from 'src/common/exceptions/custom.exception';
import { PaginationParams } from 'src/common/pagination/pagination-params';
import { PaginationModel } from 'src/common/pagination/paginaton.model';
import { AbstractMatchmakingResultRepository } from 'src/modules/matchmaking-result/abstract/matchmaking-result.abstract.repository';
import { AbstractUserGameDataRepository } from 'src/modules/user-game-data/abstract/user-game-data.abstract.repository';
import { UserGameData } from 'src/modules/user-game-data/schemas/user-game-data.schema';
import { AbstractUserRepository } from 'src/modules/user/abstract/user.abstract.repository';

import { AbstractGameMatchmakingService } from '../abstract/game-matchmaking.abstract.service';
import { AbstractMatchmakingPreferenceFilteringService } from '../abstract/matchmaking-preference-filtering.abstract.service';
import { AbstractMatchmakingUserFilteringService } from '../abstract/matchmaking-user-filtering.abstract.service';
import { AbstractMatchmakingUserSortingService } from '../abstract/matchmaking-user-sorting.abstract.service';
import { AbstractMatchmakingService } from '../abstract/matchmaking.abstract.service';
import { MatchmakingResultUserResponse } from '../response/matchmaking-result-user.response';
import { ApexLegendsMatchmakingStrategy } from './apex-legends-matchmaking.strategy';
import { CallOfDutyMatchmakingStrategy } from './call-of-duty-matchmaking.strategy';
import { FortniteMatchmakingStrategy } from './fortnite-matchmaking.strategy';
import { RocketLeagueMatchmakingStrategy } from './rocket-league-matchmaking.strategy';

@Injectable()
export class MatchmakingService extends AbstractMatchmakingService {
  // eslint-disable-next-line max-params
  constructor(
    private readonly userGameDataRepository: AbstractUserGameDataRepository,
    private readonly userRepository: AbstractUserRepository,
    private readonly matchmakingResultRepository: AbstractMatchmakingResultRepository,
    private readonly matchmakingUserFilteringService: AbstractMatchmakingUserFilteringService,
    private readonly matchmakingPreferenceFilteringService: AbstractMatchmakingPreferenceFilteringService,
    private readonly gameMatchmakingService: AbstractGameMatchmakingService,
    private readonly matchmakingUserSortingService: AbstractMatchmakingUserSortingService,
  ) {
    super();
  }

  private USERS_PER_BATCH = 50;

  /**
   * Calls matchmake method based on the provided game
   * @param userId - current user id
   * @param game - game to matchmake
   * @returns Void
   */
  async matchmake(userId: string, game: Game): Promise<void> {
    switch (game) {
      case Game.CallOfDuty: {
        this.gameMatchmakingService.setStrategy(
          new CallOfDutyMatchmakingStrategy(
            this.matchmakingPreferenceFilteringService,
          ),
        );
        await this.matchmakeGame(userId, game);
        break;
      }
      case Game.RocketLeague: {
        this.gameMatchmakingService.setStrategy(
          new RocketLeagueMatchmakingStrategy(
            this.matchmakingPreferenceFilteringService,
          ),
        );
        await this.matchmakeGame(userId, game);
        break;
      }
      case Game.ApexLegends: {
        this.gameMatchmakingService.setStrategy(
          new ApexLegendsMatchmakingStrategy(
            this.matchmakingPreferenceFilteringService,
          ),
        );
        await this.matchmakeGame(userId, game);
        break;
      }
      case Game.Fortnite: {
        this.gameMatchmakingService.setStrategy(
          new FortniteMatchmakingStrategy(
            this.matchmakingPreferenceFilteringService,
          ),
        );
        await this.matchmakeGame(userId, game);
        break;
      }
      default:
        break;
    }
  }

  /**
   * Matchmakes game players and creates a pool of algorithm results
   * @param userId - current user id
   * @returns Void
   */
  private async matchmakeGame(userId: string, game: Game): Promise<void> {
    const user = await this.userRepository.findOneLean({ _id: userId });

    const userGameData = await this.userGameDataRepository.findOneLean({
      user: userId,
      game,
    });
    if (!userGameData || userGameData.preferences.length < 1) {
      throw new TGMDNotFoundException(
        'User has no preferences set for the game.',
      );
    }

    const userMatchmakingResult =
      await this.matchmakingResultRepository.findOrCreate(
        {
          user: userId,
          game,
        },
        { user: userId, game },
      );

    let gamePlayers =
      await this.userGameDataRepository.getUserGameDataWithUserMatchmakingData({
        game: game,
        preferences: { $ne: [] },
      });

    gamePlayers =
      this.matchmakingUserFilteringService.filterPlayableUserGameData(
        user,
        gamePlayers,
      );

    if (gamePlayers.length < 1) {
      await this.matchmakingResultRepository.updateOneById(
        userMatchmakingResult._id,
        {
          matches: [],
        },
      );
      return;
    }

    const preferenceArrays = this.gameMatchmakingService.filterPreferences(
      userGameData,
      gamePlayers,
    );

    let finalMatchUserIds =
      this.matchmakingPreferenceFilteringService.getAllMatchingUsers(
        preferenceArrays,
      );

    finalMatchUserIds =
      await this.matchmakingUserFilteringService.filterUnmatchableUsers(
        user,
        finalMatchUserIds,
        game,
      );

    finalMatchUserIds =
      await this.matchmakingUserFilteringService.checkMatchmakingResultsForExistingPotentialMatch(
        user._id,
        game,
        finalMatchUserIds,
      );

    finalMatchUserIds =
      await this.matchmakingUserSortingService.sortMatchmakingResultsByOnlineStatus(
        finalMatchUserIds,
      );

    await this.matchmakingResultRepository.updateOneById(
      userMatchmakingResult._id,
      {
        matches: finalMatchUserIds
          ?.slice(0, this.USERS_PER_BATCH)
          .map((id) => id.toString()),
      },
    );
  }

  /**
   * Lists matchmaking results
   * @param userId - current user id
   * @param game - game to list matchmaking results for
   * @param params - pagination parameters
   * @returns paginated list of matchmaking user result
   */
  async listMatchmakingResults(
    userId: string,
    game: Game,
    params: PaginationParams,
  ): Promise<PaginationModel<MatchmakingResultUserResponse>> {
    const { limit, skip } = params;

    const matchmakingResults =
      await this.matchmakingResultRepository.findOneLean({
        user: userId,
        game,
      });
    const count = matchmakingResults.matches.length;
    const matchmakingResultResponseList: MatchmakingResultUserResponse[] = [];

    if (!matchmakingResults || skip >= count || count === 0) {
      return new PaginationModel(matchmakingResultResponseList, params, count);
    }
    const adjustedLimit = Math.min(limit, count);

    const slicedMatches = matchmakingResults.matches.slice(
      skip,
      skip + adjustedLimit,
    );

    const matchmakingResultsUserIds: string[] = [];

    for (const user of slicedMatches) {
      matchmakingResultsUserIds.push(user.toString());
    }

    let gamePreferences =
      await this.userGameDataRepository.getUserGameDataWithMatchmakingResultUserDetails(
        {
          user: { $in: matchmakingResultsUserIds },
          game,
        },
      );

    // Sort the game preferences based on the order of the matchmaking results
    gamePreferences = gamePreferences.sort((a, b) => {
      return (
        matchmakingResultsUserIds.indexOf(
          typeof a.user === 'string'
            ? a.user.toString()
            : a.user['_id'].toString(),
        ) -
        matchmakingResultsUserIds.indexOf(
          typeof b.user === 'string'
            ? b.user.toString()
            : b.user['_id'].toString(),
        )
      );
    });

    this.populateMatchmakingResultResponseList(
      matchmakingResultResponseList,
      gamePreferences,
    );

    return new PaginationModel(matchmakingResultResponseList, params, count);
  }

  /**
   * Iterates through the game preferences and populates the matchmaking result response list
   * @param matchmakingResultResponseList - list of matchmaking result responses
   * @param gamePreferences - list of game preferences
   * @returns Void
   */
  private populateMatchmakingResultResponseList(
    matchmakingResultResponseList: MatchmakingResultUserResponse[],
    gamePreferences: UserGameData[],
  ): void {
    for (const matchmakingResult of gamePreferences) {
      if (typeof matchmakingResult.user !== 'string') {
        matchmakingResultResponseList.push({
          id: matchmakingResult.user._id,
          photoKey: matchmakingResult?.user?.photoKey || null,
          audioKey: matchmakingResult?.user?.audioKey || null,
          username: matchmakingResult?.user?.username,
          dateOfBirth: matchmakingResult?.user.dateOfBirth,
          country: matchmakingResult?.user.country,
          preferences: matchmakingResult.preferences,
        });
      }
    }
  }
}
