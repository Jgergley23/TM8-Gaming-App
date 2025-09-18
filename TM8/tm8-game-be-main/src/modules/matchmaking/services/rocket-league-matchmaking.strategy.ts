import { Injectable } from '@nestjs/common';

import { GamePreferenceKey } from 'src/common/constants';
import { UserGameData } from 'src/modules/user-game-data/schemas/user-game-data.schema';

import { AbstractMatchmakingPreferenceFilteringService } from '../abstract/matchmaking-preference-filtering.abstract.service';
import {
  playingLevel,
  rocketLeagueGameplay,
  rocketLeaguePlaystyle,
} from '../constants/preference-key-matching.records';
import { GameMatchmakingStrategy } from './game-matchmaking.strategy';

@Injectable()
export class RocketLeagueMatchmakingStrategy
  implements GameMatchmakingStrategy
{
  constructor(
    private readonly matchmakingPreferenceFilteringService: AbstractMatchmakingPreferenceFilteringService,
  ) {}

  /**
   * Filters preferences for Rocket League
   * @param userGameData - current user game data
   * @param playersGameData - players game data
   * @returns - array of matching preference user ids array
   */
  filterPreferences(
    userGameData: UserGameData,
    playersGameData: UserGameData[],
  ): string[][] {
    const onlineScheduleMatchesUserIds =
      this.matchmakingPreferenceFilteringService.getMatchingOnlineSchedulePreferences(
        userGameData,
        playersGameData,
      );

    const playtimeMatchesUserIds =
      this.matchmakingPreferenceFilteringService.getAtLeastOneMatchingPreference(
        userGameData,
        playersGameData,
        GamePreferenceKey.Playtime,
      );

    const gameModeMatchesUserIds =
      this.matchmakingPreferenceFilteringService.getAtLeastOneMatchingPreference(
        userGameData,
        playersGameData,
        GamePreferenceKey.GameMode,
      );

    const teamSizeMatchesUserIds =
      this.matchmakingPreferenceFilteringService.getAtLeastOneMatchingPreference(
        userGameData,
        playersGameData,
        GamePreferenceKey.TeamSize,
      );

    const playstyleMatchesUserIds =
      this.matchmakingPreferenceFilteringService.getMatchingPreferencesBasedOnMapping(
        userGameData,
        playersGameData,
        rocketLeaguePlaystyle,
        GamePreferenceKey.PlayStyle,
      );

    const gameplayMatchesUserIds =
      this.matchmakingPreferenceFilteringService.getMatchingPreferencesBasedOnMapping(
        userGameData,
        playersGameData,
        rocketLeagueGameplay,
        GamePreferenceKey.Gameplay,
      );

    const playingLevelMatchesUserIds =
      this.matchmakingPreferenceFilteringService.getMatchingPreferencesBasedOnMapping(
        userGameData,
        playersGameData,
        playingLevel,
        GamePreferenceKey.PlayingLevel,
      );

    return [
      onlineScheduleMatchesUserIds,
      playtimeMatchesUserIds,
      gameplayMatchesUserIds,
      teamSizeMatchesUserIds,
      gameModeMatchesUserIds,
      playingLevelMatchesUserIds,
      playstyleMatchesUserIds,
    ];
  }
}
