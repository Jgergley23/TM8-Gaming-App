/* eslint-disable @typescript-eslint/ban-ts-comment */
import { TestBed } from '@automock/jest';

import { MatchmakingPreferenceFilteringService } from '../services/matchmaking-preference-filtering.service';
import {
  currentUserGameDataMock,
  gameDataUserIdsMock,
  usersGameDataMock,
} from './mocks/matchmaking.mocks';

describe('MatchmakingPreferenceFilteringService', () => {
  let matchmakingPreferenceFilteringService: MatchmakingPreferenceFilteringService;

  beforeEach(() => {
    const { unit } = TestBed.create(
      MatchmakingPreferenceFilteringService,
    ).compile();

    matchmakingPreferenceFilteringService = unit;
  });

  describe('getAtLeastOneMatchingPreference', () => {
    it('should return user game data array on success', async () => {
      //arrange

      //act
      const result =
        matchmakingPreferenceFilteringService.getAtLeastOneMatchingPreference(
          currentUserGameDataMock,
          usersGameDataMock,
          'fake-key',
        );

      //assert
      expect(result).toEqual(gameDataUserIdsMock);
    });
  });

  describe('getPlayStyleMatchingPreference', () => {
    it('should return user game data array on success', async () => {
      //arrange
      jest
        .spyOn(
          // eslint-disable-next-line @typescript-eslint/no-explicit-any
          MatchmakingPreferenceFilteringService.prototype as any,
          'allPlaystylesMatch',
        )
        .mockReturnValue(true);

      //act
      const result =
        matchmakingPreferenceFilteringService.getPlayStyleMatchingPreference(
          currentUserGameDataMock,
          usersGameDataMock,
        );

      //assert
      expect(result).toEqual(gameDataUserIdsMock);
    });
  });

  describe('getMatchingPreferencesBasedOnMapping', () => {
    it('should return user game data array on success', async () => {
      //arrange

      //act
      const result =
        matchmakingPreferenceFilteringService.getMatchingPreferencesBasedOnMapping(
          currentUserGameDataMock,
          usersGameDataMock,
          { 'fake-key': ['fake-key'] },
          'fake-key',
        );

      //assert
      expect(result).toEqual(gameDataUserIdsMock);
    });
  });

  describe('getAllMatchingUsers', () => {
    it('should return array containing elements which are present in all input arrays', async () => {
      //arrange

      //act
      const result = matchmakingPreferenceFilteringService.getAllMatchingUsers([
        ['1', '2'],
        ['2', '3'],
        ['2', '4'],
      ]);

      //assert
      expect(result).toEqual(['2']);
    });
  });

  describe('getMatchingOnlineSchedulePreferences', () => {
    it('should return array containing all IDs from the provided users since the user does not have a defined online schedule', async () => {
      //arrange
      const expectedResult = [];
      usersGameDataMock.forEach((gameData) => {
        if (typeof gameData.user !== 'string') {
          expectedResult.push(gameData.user._id);
        }
      });

      //act
      const result =
        matchmakingPreferenceFilteringService.getMatchingOnlineSchedulePreferences(
          currentUserGameDataMock,
          usersGameDataMock,
        );

      //assert
      expect(result).toEqual(expectedResult);
    });
  });
});
