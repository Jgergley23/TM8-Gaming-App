import { Injectable } from '@nestjs/common';

import { Game, GamePreferenceKey } from 'src/common/constants';
import { GamePreferenceValue } from 'src/common/constants/game-preference-value.enum';
import {
  TGMDBadRequestException,
  TGMDNotFoundException,
} from 'src/common/exceptions/custom.exception';
import { StringUtils } from 'src/common/utils/string.utils';
import { AbstractMatchmakingResultService } from 'src/modules/matchmaking-result/abstract/matchmaking-result.service.abstract';
import { AbstractPotentialMatchService } from 'src/modules/potential-match/abstract/potential-match.abstract.service';
import { SetGamePlaytimeInput } from 'src/modules/user-game-data/dto/set-game-playtime.input';

import { AbstractUserGameDataRepository } from '../abstract/user-game-data.abstract.repository';
import { AbstractUserGameDataService } from '../abstract/user-game-data.abstract.service';
import { SetApexLegendsPreferencesInput } from '../dto/set-apex-legends-preferences.input';
import { SetCallOfDutyPreferencesInput } from '../dto/set-call-of-duty-preferences.input';
import { SetFortnitePreferencesInput } from '../dto/set-fortnite-preferences.input';
import { SetOnlineScheduleInput } from '../dto/set-online-schedule.input';
import { SetRocketLeaguePreferencesInput } from '../dto/set-rocket-league-preferences.input';
import { UserGameData } from '../schemas/user-game-data.schema';
import { UserGamePreference } from '../schemas/user-game-preference.schema';

@Injectable()
export class UserGameDataService extends AbstractUserGameDataService {
  constructor(
    private readonly userGameDataRepository: AbstractUserGameDataRepository,
    private readonly potentialMatchService: AbstractPotentialMatchService,
    private readonly matchmakingResultService: AbstractMatchmakingResultService,
  ) {
    super();
  }

  /**
   * Deletes user game data
   * @param userId - user id
   * @returns Void
   */
  async deleteUserGameData(userId: string): Promise<void> {
    const userGameData = await this.userGameDataRepository.findManyLean({
      user: userId,
    });
    if (userGameData) {
      const userGameDataIds = userGameData?.map((gameData) => {
        return gameData._id.toString();
      });
      await this.userGameDataRepository.deleteMany(userGameDataIds);
    }
  }

  /**
   * Sets Call of Duty preferences for a user
   * @param userId - user id
   * @param codPreferencesInput - call of duty preferences input
   * @returns user game data response
   */
  async setCallOfDutyPreferences(
    userId: string,
    codPreferencesInput: SetCallOfDutyPreferencesInput,
  ): Promise<UserGameData> {
    const {
      gameModes,
      gameplayStyle,
      teamSizes,
      teamWork,
      playingLevel,
      agression,
      rotations,
    } = codPreferencesInput;

    const userGameData = await this.userGameDataRepository.findOne({
      user: userId,
      game: Game.CallOfDuty,
    });
    if (!userGameData)
      throw new TGMDNotFoundException(
        'Call of Duty game data not found for this user',
      );

    const newPreferences: UserGamePreference[] = [
      {
        key: GamePreferenceKey.GameMode,
        title: 'Game Mode',
        values: gameModes.map((gameMode) => {
          return {
            key: gameMode,
            selectedValue: gameMode
              .split('-')
              .map((word) => {
                return word.charAt(0).toUpperCase() + word.slice(1);
              })
              .join(' '),
          };
        }),
      },
      {
        key: GamePreferenceKey.TeamSize,
        title: 'Team Size',
        values: teamSizes.map((teamSize) => {
          return {
            key: teamSize,
            selectedValue: teamSize
              .split('-')
              .map((word) => {
                return word.charAt(0).toUpperCase() + word.slice(1);
              })
              .join(' '),
          };
        }),
      },
      {
        key: GamePreferenceKey.PlayingLevel,
        title: 'Playing Level',
        values: [
          {
            key: playingLevel,
            selectedValue: playingLevel
              .split('-')
              .map((word) => {
                return word.charAt(0).toUpperCase() + word.slice(1);
              })
              .join(' '),
          },
        ],
      },
      {
        key: GamePreferenceKey.Rotate,
        title: 'Rotate',
        values: rotations.map((rotation) => {
          return {
            key: rotation,
            selectedValue: rotation
              .split('-')
              .map((word) => {
                return word.charAt(0).toUpperCase() + word.slice(1);
              })
              .join(' '),
          };
        }),
      },
      {
        key: GamePreferenceKey.PlayStyle,
        title: 'Play Style',
        values: [
          {
            key: GamePreferenceValue.Aggressive,
            numericDisplay: 'Aggressive',
            numericValue: agression,
          },
          {
            key: GamePreferenceValue.TeamPlayer,
            numericDisplay: 'Team Player',
            numericValue: teamWork,
          },
          {
            key: GamePreferenceValue.FindPeople,
            numericDisplay: 'Find People',
            numericValue: gameplayStyle,
          },
        ],
      },
      /**
       * NOTE: Will be used later, not needed for now
       */
      /* {
          key: GamePreferenceKey.Rank,
          title: 'Rank',
          values: [
            {
              key: rank,
              selectedValue: rank
                .split('-')
                .map((word) => {
                  this.convertToUppercase(word);
                })
                .join(' '),
            },
          ],
        }, */
    ];

    const playtimePreference = userGameData.preferences.filter(
      (pref) => pref.key === GamePreferenceKey.Playtime,
    );

    const newPreferencesWithPlaytime = [
      ...playtimePreference,
      ...newPreferences,
    ];

    const updateResult = await this.userGameDataRepository.updateOneById(
      userGameData.id,
      {
        preferences: newPreferencesWithPlaytime,
      },
    );

    await this.potentialMatchService.resetUserPotentialMatches(
      userId,
      Game.CallOfDuty,
    );

    await this.matchmakingResultService.resetMatchmakingResults(
      userId,
      Game.CallOfDuty,
    );

    return updateResult;
  }

  /**
   * Sets Apex Legends preferences for a user
   * @param userId - user id
   * @param apexPreferencesInput - apex legends preferences input
   * @returns user game data response
   */
  async setApexLegendsPreferences(
    userId: string,
    apexPreferencesInput: SetApexLegendsPreferencesInput,
  ): Promise<UserGameData> {
    const {
      types,
      gameplayStyle,
      teamSizes,
      teamWork,
      agression,
      classifications,
      playingLevel,
      mixtapeTypes,
      rotations,
    } = apexPreferencesInput;

    const userGameData = await this.userGameDataRepository.findOne({
      user: userId,
      game: Game.ApexLegends,
    });
    if (!userGameData)
      throw new TGMDNotFoundException(
        'Apex Legends game data not found for this user',
      );

    const newPreferences: UserGamePreference[] = [
      {
        key: GamePreferenceKey.Type,
        title: 'Type',
        values: types.map((type) => {
          return {
            key: type,
            selectedValue: type
              .split('-')
              .map((word) => {
                return word.charAt(0).toUpperCase() + word.slice(1);
              })
              .join(' '),
          };
        }),
      },
      {
        key: GamePreferenceKey.MixtapeType,
        title: 'Mixtape Type',
        values: mixtapeTypes.map((mixtapeType) => {
          return {
            key: mixtapeType,
            selectedValue: mixtapeType
              .split('-')
              .map((word) => {
                return word.charAt(0).toUpperCase() + word.slice(1);
              })
              .join(' '),
          };
        }),
      },
      {
        key: GamePreferenceKey.Rotate,
        title: 'Rotate',
        values: rotations.map((rotation) => {
          return {
            key: rotation,
            selectedValue: rotation
              .split('-')
              .map((word) => {
                return word.charAt(0).toUpperCase() + word.slice(1);
              })
              .join(' '),
          };
        }),
      },
      {
        key: GamePreferenceKey.Classifications,
        title: 'Classifications',
        values: classifications.map((classification) => {
          return {
            key: classification,
            selectedValue: classification
              .split('-')
              .map((word) => {
                return word.charAt(0).toUpperCase() + word.slice(1);
              })
              .join(' '),
          };
        }),
      },
      {
        key: GamePreferenceKey.TeamSize,
        title: 'Team Size',
        values: teamSizes.map((teamSize) => {
          return {
            key: teamSize,
            selectedValue: teamSize
              .split('-')
              .map((word) => {
                return word.charAt(0).toUpperCase() + word.slice(1);
              })
              .join(' '),
          };
        }),
      },
      {
        key: GamePreferenceKey.PlayingLevel,
        title: 'Playing Level',
        values: [
          {
            key: playingLevel,
            selectedValue: playingLevel
              .split('-')
              .map((word) => {
                return word.charAt(0).toUpperCase() + word.slice(1);
              })
              .join(' '),
          },
        ],
      },
      {
        key: GamePreferenceKey.PlayStyle,
        title: 'Play Style',
        values: [
          {
            key: GamePreferenceValue.Aggressive,
            numericDisplay: 'Agressive',
            numericValue: agression,
          },
          {
            key: GamePreferenceValue.TeamPlayer,
            numericDisplay: 'Team Player',
            numericValue: teamWork,
          },
          {
            key: GamePreferenceValue.FindPeople,
            numericDisplay: 'Find People',
            numericValue: gameplayStyle,
          },
        ],
      },
      /**
       * NOTE: Will be used later, not needed for now
       */
      /* {
          key: GamePreferenceKey.Rank,
          title: 'Rank',
          values: [
            {
              key: rank,
              selectedValue: rank
                .split('-')
                .map((word) => this.convertToUppercase(word))
                .join(' '),
            },
          ],
        }, */
    ];

    const playtimePreference = userGameData.preferences.filter(
      (pref) => pref.key === GamePreferenceKey.Playtime,
    );

    const newPreferencesWithPlaytime = [
      ...playtimePreference,
      ...newPreferences,
    ];

    const updateResult = await this.userGameDataRepository.updateOneById(
      userGameData.id,
      {
        preferences: newPreferencesWithPlaytime,
      },
    );

    await this.potentialMatchService.resetUserPotentialMatches(
      userId,
      Game.ApexLegends,
    );

    await this.matchmakingResultService.resetMatchmakingResults(
      userId,
      Game.ApexLegends,
    );

    return updateResult;
  }

  /**
   * Sets Rocket League preferences for a user
   * @param userId - user id
   * @param rocketLeaguePreferencesInput - rocket league preferences input
   * @returns user game data response
   */
  async setRocketLeaguePreferences(
    userId: string,
    rocketLeaguePreferencesInput: SetRocketLeaguePreferencesInput,
  ): Promise<UserGameData> {
    const { gameModes, teamSizes, playingLevel, playStyle, gameplays } =
      rocketLeaguePreferencesInput;

    const userGameData = await this.userGameDataRepository.findOne({
      user: userId,
      game: Game.RocketLeague,
    });
    if (!userGameData)
      throw new TGMDNotFoundException(
        'Rocket League game data not found for this user',
      );

    const newPreferences: UserGamePreference[] = [
      {
        key: GamePreferenceKey.GameMode,
        title: 'Game Mode',
        values: gameModes.map((gameMode) => {
          return {
            key: gameMode,
            selectedValue: gameMode
              .split('-')
              .map((word) => {
                return word.charAt(0).toUpperCase() + word.slice(1);
              })
              .join(' '),
          };
        }),
      },
      {
        key: GamePreferenceKey.Gameplay,
        title: 'Gameplay',
        values: gameplays.map((gameplays) => {
          return {
            key: gameplays,
            selectedValue: gameplays
              .split('-')
              .map((word) => {
                return word.charAt(0).toUpperCase() + word.slice(1);
              })
              .join(' '),
          };
        }),
      },
      {
        key: GamePreferenceKey.TeamSize,
        title: 'Team Size',
        values: teamSizes.map((teamSize) => {
          return {
            key: teamSize,
            selectedValue: teamSize
              .split('-')
              .map((word) => {
                return word.charAt(0).toUpperCase() + word.slice(1);
              })
              .join(' '),
          };
        }),
      },
      {
        key: GamePreferenceKey.PlayingLevel,
        title: 'Playing Level',
        values: [
          {
            key: playingLevel,
            selectedValue: playingLevel
              .split('-')
              .map((word) => {
                return word.charAt(0).toUpperCase() + word.slice(1);
              })
              .join(' '),
          },
        ],
      },
      {
        key: GamePreferenceKey.PlayStyle,
        title: 'Play Style',
        values: [
          {
            key: playStyle,
            selectedValue: playStyle
              .split('-')
              .map((word) => {
                return word.charAt(0).toUpperCase() + word.slice(1);
              })
              .join(' '),
          },
        ],
      },
      /**
       * NOTE: Will be used later, not needed for now
       */
      /*  {
          key: GamePreferenceKey.Rank,
          title: 'Rank',
          values: [
            {
              key: rank,
              selectedValue: rank
                .split('-')
                .map((word) => this.convertToUppercase(word))
                .join(' '),
            },
          ],
        }, */
    ];

    const playtimePreference = userGameData.preferences.filter(
      (pref) => pref.key === GamePreferenceKey.Playtime,
    );

    const newPreferencesWithPlaytime = [
      ...playtimePreference,
      ...newPreferences,
    ];

    const updateResult = await this.userGameDataRepository.updateOneById(
      userGameData.id,
      {
        preferences: newPreferencesWithPlaytime,
      },
    );

    await this.potentialMatchService.resetUserPotentialMatches(
      userId,
      Game.RocketLeague,
    );

    await this.matchmakingResultService.resetMatchmakingResults(
      userId,
      Game.RocketLeague,
    );

    return updateResult;
  }

  /**
   * Sets Fortnite preferences for a user
   * @param userId - user id
   * @param fortnitePreferencesInput - fortnite preferences input
   * @returns user game data response
   */
  async setFortnitePreferences(
    userId: string,
    fortnitePreferencesInput: SetFortnitePreferencesInput,
  ): Promise<UserGameData> {
    const {
      teamSizes,
      playingLevel,
      gameModes,
      agression,
      teamWork,
      gameplayStyle,
      rotations,
    } = fortnitePreferencesInput;

    const userGameData = await this.userGameDataRepository.findOne({
      user: userId,
      game: Game.Fortnite,
    });
    if (!userGameData)
      throw new TGMDNotFoundException(
        'Fortnite game data not found for this user',
      );

    const newPreferences: UserGamePreference[] = [
      {
        key: GamePreferenceKey.GameMode,
        title: 'Game Mode',
        values: gameModes.map((gameMode) => {
          return {
            key: gameMode,
            selectedValue: gameMode
              .split('-')
              .map((word) => {
                return word.charAt(0).toUpperCase() + word.slice(1);
              })
              .join(' '),
          };
        }),
      },

      {
        key: GamePreferenceKey.TeamSize,
        title: 'Team Size',
        values: teamSizes.map((teamSize) => {
          return {
            key: teamSize,
            selectedValue: teamSize
              .split('-')
              .map((word) => {
                return word.charAt(0).toUpperCase() + word.slice(1);
              })
              .join(' '),
          };
        }),
      },
      {
        key: GamePreferenceKey.PlayingLevel,
        title: 'Playing Level',
        values: [
          {
            key: playingLevel,
            selectedValue: playingLevel
              .split('-')
              .map((word) => {
                return word.charAt(0).toUpperCase() + word.slice(1);
              })
              .join(' '),
          },
        ],
      },
      {
        key: GamePreferenceKey.Rotate,
        title: 'Rotate',
        values: rotations.map((rotation) => {
          return {
            key: rotation,
            selectedValue: rotation
              .split('-')
              .map((word) => {
                return word.charAt(0).toUpperCase() + word.slice(1);
              })
              .join(' '),
          };
        }),
      },

      {
        key: GamePreferenceKey.PlayStyle,
        title: 'Play Style',
        values: [
          {
            key: GamePreferenceValue.Aggressive,
            numericDisplay: 'Aggressive',
            numericValue: agression,
          },
          {
            key: GamePreferenceValue.TeamPlayer,
            numericDisplay: 'Team Player',
            numericValue: teamWork,
          },
          {
            key: GamePreferenceValue.FindPeople,
            numericDisplay: 'Find People',
            numericValue: gameplayStyle,
          },
        ],
      },
      /**
       * NOTE: Will be used later, not needed for now
       */
      /* {
          key: GamePreferenceKey.Rank,
          title: 'Rank',
          values: [
            {
              key: rank,
              selectedValue: rank
                .split('-')
                .map((word) => this.convertToUppercase(word))
                .join(' '),
            },
          ],
        }, */
    ];

    const playtimePreference = userGameData.preferences.filter(
      (pref) => pref.key === GamePreferenceKey.Playtime,
    );

    const newPreferencesWithPlaytime = [
      ...playtimePreference,
      ...newPreferences,
    ];

    const updateResult = await this.userGameDataRepository.updateOneById(
      userGameData.id,
      {
        preferences: newPreferencesWithPlaytime,
      },
    );

    await this.potentialMatchService.resetUserPotentialMatches(
      userId,
      Game.Fortnite,
    );

    await this.matchmakingResultService.resetMatchmakingResults(
      userId,
      Game.Fortnite,
    );

    return updateResult;
  }

  /**
   * Sets user game play time
   * @param userId - user id
   * @param setGamePlaytimeInput - set game playtime input
   * @returns Void
   */
  async setGamePlaytime(
    userId: string,
    game: Game,
    setGamePlaytimeInput: SetGamePlaytimeInput,
  ): Promise<void> {
    const { playtime } = setGamePlaytimeInput;
    const userGameData = await this.userGameDataRepository.findOneLean({
      user: userId,
      game,
    });
    if (!userGameData)
      throw new TGMDNotFoundException(
        'Game data not found for this user and game',
      );

    const otherPreferences = userGameData.preferences.filter(
      (pref) => pref.key !== GamePreferenceKey.Playtime,
    );

    const playtimePreference = {
      key: GamePreferenceKey.Playtime,
      title: 'Playtime',
      values: [
        {
          key: playtime,
          selectedValue: StringUtils.kebabCaseToCapitalized(playtime),
        },
      ],
    };

    const preferencesWithPlaytime = [...otherPreferences, playtimePreference];

    await this.userGameDataRepository.updateOneById(userGameData._id, {
      preferences: preferencesWithPlaytime,
    });

    await this.potentialMatchService.resetUserPotentialMatches(userId, game);

    await this.matchmakingResultService.resetMatchmakingResults(userId, game);
  }

  /**
   * Sets user online schedule
   * @param userId - user id
   * @param game - game
   * @param setOnlineScheduleInput - set online schedule input
   * @returns Void
   */
  async setOnlineSchedule(
    userId: string,
    game: Game,
    setOnlineScheduleInput: SetOnlineScheduleInput,
  ): Promise<void> {
    const { startingTimestamp, endingTimestamp } = setOnlineScheduleInput;
    // Check if the user has game data
    const userGameData = await this.userGameDataRepository.findOneLean({
      user: userId,
      game,
    });
    if (!userGameData)
      throw new TGMDNotFoundException(
        'Game data not found for this user and game',
      );

    // Check if the starting timestamp is after the ending timestamp
    if (startingTimestamp > endingTimestamp) {
      throw new TGMDBadRequestException(
        'Starting timestamp must be before the ending timestamp',
      );
    }

    // Extract preferences other than online schedule
    const otherPreferences = userGameData.preferences.filter(
      (pref) => pref.key !== GamePreferenceKey.OnlineSchedule,
    );

    // Create online schedule preference
    const onlineSchedulePreference = {
      key: GamePreferenceKey.OnlineSchedule,
      title: StringUtils.kebabCaseToCapitalized(
        GamePreferenceKey.OnlineSchedule,
      ),
      values: [
        {
          key: GamePreferenceValue.StartingTimestamp,
          selectedValue: startingTimestamp.toISOString(),
        },
        {
          key: GamePreferenceValue.EndingTimestamp,
          selectedValue: endingTimestamp.toISOString(),
        },
      ],
    };

    // Construct the new preferences array and update the user game data
    const preferencesWithOnlineSchedule = [
      ...otherPreferences,
      onlineSchedulePreference,
    ];

    await this.userGameDataRepository.updateOneById(userGameData._id, {
      preferences: preferencesWithOnlineSchedule,
    });

    // Reset potential matches and matchmaking results
    await this.potentialMatchService.resetUserPotentialMatches(userId, game);

    await this.matchmakingResultService.resetMatchmakingResults(userId, game);
  }

  /**
   * Deletes user online schedule
   * @param userId - user id
   * @param game - game
   * @returns Void
   */
  async deleteOnlineSchedule(userId: string, game: Game): Promise<void> {
    // Check if the user has game data
    const userGameData = await this.userGameDataRepository.findOneLean({
      user: userId,
      game,
    });
    if (!userGameData)
      throw new TGMDNotFoundException(
        'Game data not found for this user and game',
      );

    // Extract preferences other than online schedule
    const otherPreferences = userGameData.preferences.filter(
      (pref) => pref.key !== GamePreferenceKey.OnlineSchedule,
    );

    // Update the user game data
    await this.userGameDataRepository.updateOneById(userGameData._id, {
      preferences: otherPreferences,
    });

    // Reset potential matches and matchmaking results
    await this.potentialMatchService.resetUserPotentialMatches(userId, game);

    await this.matchmakingResultService.resetMatchmakingResults(userId, game);
  }
}
