/* eslint-disable @typescript-eslint/ban-ts-comment */
import { TestBed } from '@automock/jest';

import { AbstractMatchmakingPreferenceFilteringService } from '../abstract/matchmaking-preference-filtering.abstract.service';
import { RocketLeagueMatchmakingStrategy } from '../services/rocket-league-matchmaking.strategy';
import {
  currentUserGameDataMock,
  gameDataUserIdsMock,
  usersGameDataMock,
} from './mocks/matchmaking.mocks';

describe('RocketLeagueMatchmakingStrategy', () => {
  let rocketLeagueMatchmakingStrategy: RocketLeagueMatchmakingStrategy;

  let matchmakingPreferenceFilteringService: jest.Mocked<AbstractMatchmakingPreferenceFilteringService>;

  beforeEach(() => {
    const { unit, unitRef } = TestBed.create(
      RocketLeagueMatchmakingStrategy,
    ).compile();

    rocketLeagueMatchmakingStrategy = unit;

    matchmakingPreferenceFilteringService = unitRef.get(
      // @ts-ignore
      AbstractMatchmakingPreferenceFilteringService,
    );
  });

  describe('filterPreferences', () => {
    it('should return array of ids on success', async () => {
      //arrange
      matchmakingPreferenceFilteringService.getMatchingOnlineSchedulePreferences.mockReturnValue(
        gameDataUserIdsMock,
      );

      matchmakingPreferenceFilteringService.getAtLeastOneMatchingPreference.mockReturnValue(
        gameDataUserIdsMock,
      );

      matchmakingPreferenceFilteringService.getAtLeastOneMatchingPreference.mockReturnValue(
        gameDataUserIdsMock,
      );
      matchmakingPreferenceFilteringService.getAtLeastOneMatchingPreference.mockReturnValue(
        gameDataUserIdsMock,
      );
      matchmakingPreferenceFilteringService.getMatchingPreferencesBasedOnMapping.mockReturnValue(
        gameDataUserIdsMock,
      );
      matchmakingPreferenceFilteringService.getMatchingPreferencesBasedOnMapping.mockReturnValue(
        gameDataUserIdsMock,
      );
      matchmakingPreferenceFilteringService.getPlayStyleMatchingPreference.mockReturnValue(
        gameDataUserIdsMock,
      );

      //act
      const result = rocketLeagueMatchmakingStrategy.filterPreferences(
        currentUserGameDataMock,
        usersGameDataMock,
      );

      //assert
      expect(result).toEqual([
        gameDataUserIdsMock,
        gameDataUserIdsMock,
        gameDataUserIdsMock,
        gameDataUserIdsMock,
        gameDataUserIdsMock,
        gameDataUserIdsMock,
        gameDataUserIdsMock,
      ]);
    });
  });
});
