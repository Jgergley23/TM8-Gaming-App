import { Injectable } from '@nestjs/common';

import { GamePreferenceKey } from 'src/common/constants';
import { UserGameData } from 'src/modules/user-game-data/schemas/user-game-data.schema';

import { AbstractMatchmakingPreferenceFilteringService } from '../abstract/matchmaking-preference-filtering.abstract.service';
import { playingLevel } from '../constants/preference-key-matching.records';
import { GameMatchmakingStrategy } from './game-matchmaking.strategy';

@Injectable()
export class ApexLegendsMatchmakingStrategy implements GameMatchmakingStrategy {
  constructor(
    private readonly matchmakingPreferenceFilteringService: AbstractMatchmakingPreferenceFilteringService,
  ) {}

  /**
   * Filters preferences for Apex Legends
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

    const typeMatchesUserIds =
      this.matchmakingPreferenceFilteringService.getAtLeastOneMatchingPreference(
        userGameData,
        playersGameData,
        GamePreferenceKey.Type,
      );

    const isMixtapeSelected = userGameData.preferences.some(
      (preference) => preference.key === GamePreferenceKey.MixtapeType,
    );

    let mixtapeTypeMatchesUserIds: string[] = [];
    if (isMixtapeSelected) {
      mixtapeTypeMatchesUserIds =
        this.matchmakingPreferenceFilteringService.getAtLeastOneMatchingPreference(
          userGameData,
          playersGameData,
          GamePreferenceKey.MixtapeType,
        );
    }

    const teamSizeMatchesUserIds =
      this.matchmakingPreferenceFilteringService.getAtLeastOneMatchingPreference(
        userGameData,
        playersGameData,
        GamePreferenceKey.TeamSize,
      );

    const rotateMatchesUserIds =
      this.matchmakingPreferenceFilteringService.getAtLeastOneMatchingPreference(
        userGameData,
        playersGameData,
        GamePreferenceKey.Rotate,
      );

    const playingLevelMatchesUserIds =
      this.matchmakingPreferenceFilteringService.getMatchingPreferencesBasedOnMapping(
        userGameData,
        playersGameData,
        playingLevel,
        GamePreferenceKey.PlayingLevel,
      );

    const playStyleMatchesUserIds =
      this.matchmakingPreferenceFilteringService.getPlayStyleMatchingPreference(
        userGameData,
        playersGameData,
      );

    const result = [
      onlineScheduleMatchesUserIds,
      playtimeMatchesUserIds,
      typeMatchesUserIds,
      teamSizeMatchesUserIds,
      rotateMatchesUserIds,
      playingLevelMatchesUserIds,
      playStyleMatchesUserIds,
    ];

    if (mixtapeTypeMatchesUserIds.length > 0) {
      result.push(mixtapeTypeMatchesUserIds);
    }

    return result;
  }
}
