/* eslint-disable @typescript-eslint/ban-ts-comment */
import { TestBed } from '@automock/jest';
import { faker } from '@faker-js/faker';

import { Game } from 'src/common/constants';
import { TGMDNotFoundException } from 'src/common/exceptions/custom.exception';
import { AbstractMatchmakingResultService } from 'src/modules/matchmaking-result/abstract/matchmaking-result.service.abstract';
import { AbstractPotentialMatchService } from 'src/modules/potential-match/abstract/potential-match.abstract.service';

import { AbstractUserGameDataRepository } from '../abstract/user-game-data.abstract.repository';
import { UserGameDataService } from '../services/user-game-data.service';
import { deleteUserGameDataFindManyMock } from './mocks/delete-user-game-data.mocks';
import {
  apexUserGameDataResponse,
  setApexLegendsPreferenceInput,
} from './mocks/set-apex-preferences.mocks';
import {
  codUserGameDataResponse,
  setCallOfDutyPreferenceInput,
} from './mocks/set-cod-preferences.mocks';
import {
  fortniteUserGameDataResponse,
  setFortnitePreferenceInput,
} from './mocks/set-fortnite-preferences.mocks';
import {
  setGamePlaytimePreferenceInput,
  setPlaytimeUserGameDataResponse,
} from './mocks/set-game-playtime.mocks';
import {
  setOnlineSchedulePreferenceInput,
  setOnlineScheduleResponse,
} from './mocks/set-online-schedule.mocks';
import {
  rocketLeagueUserGameDataResponse,
  setRocketLeaguePreferenceInput,
} from './mocks/set-rocket-league-preferences.mocks';

describe('UserGameDataService', () => {
  let userGameDataService: UserGameDataService;
  let userGameDataRepository: jest.Mocked<AbstractUserGameDataRepository>;
  let potentialMatchService: jest.Mocked<AbstractPotentialMatchService>;
  let matchmakingResultService: jest.Mocked<AbstractMatchmakingResultService>;

  beforeEach(() => {
    const { unit, unitRef } = TestBed.create(UserGameDataService).compile();

    userGameDataService = unit;

    // @ts-ignore
    userGameDataRepository = unitRef.get(AbstractUserGameDataRepository);

    // @ts-ignore
    potentialMatchService = unitRef.get(AbstractPotentialMatchService);
    // @ts-ignore
    matchmakingResultService = unitRef.get(AbstractMatchmakingResultService);
  });

  beforeEach(() => {
    jest.clearAllMocks();
  });

  describe('deleteUserGameData', () => {
    it('should return undefined on success', async () => {
      //arrange
      const userId = deleteUserGameDataFindManyMock[0].user.toString();
      userGameDataRepository.findManyLean.mockResolvedValue(
        deleteUserGameDataFindManyMock,
      );
      userGameDataRepository.deleteMany.mockResolvedValue(undefined);

      //act
      const result = await userGameDataService.deleteUserGameData(userId);

      //assert
      expect(result).toEqual(undefined);
    });
  });

  describe('setCallOfDutyPreferences', () => {
    it('should throw TGMDNotFoundException if user game data is not found', async () => {
      //arrange

      const userId = faker.database.mongodbObjectId();
      userGameDataRepository.findOne.mockResolvedValue(null);

      //act
      expect(
        async () =>
          await userGameDataService.setCallOfDutyPreferences(
            userId,
            setCallOfDutyPreferenceInput,
          ),

        //assert
      ).rejects.toThrow(TGMDNotFoundException);
    });

    it('should return undefined if game preferences are successfully set', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();

      userGameDataRepository.findOne.mockResolvedValue(codUserGameDataResponse);
      userGameDataRepository.updateOneById.mockResolvedValue(
        codUserGameDataResponse,
      );

      potentialMatchService.resetUserPotentialMatches.mockResolvedValue(
        undefined,
      );

      matchmakingResultService.resetMatchmakingResults.mockResolvedValue(
        undefined,
      );

      //act
      const result = await userGameDataService.setCallOfDutyPreferences(
        userId,
        setCallOfDutyPreferenceInput,
      );

      expect(result).toEqual(codUserGameDataResponse);
    });
  });

  describe('setApexLegendsPreferences', () => {
    it('should throw TGMDNotFoundException if user game data is not found', async () => {
      //arrange

      const userId = faker.database.mongodbObjectId();
      userGameDataRepository.findOne.mockResolvedValue(null);

      //act
      expect(
        async () =>
          await userGameDataService.setApexLegendsPreferences(
            userId,
            setApexLegendsPreferenceInput,
          ),

        //assert
      ).rejects.toThrow(TGMDNotFoundException);
    });

    it('should return undefined if game preferences are successfully set', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();

      userGameDataRepository.findOne.mockResolvedValue(
        apexUserGameDataResponse,
      );
      userGameDataRepository.updateOneById.mockResolvedValue(
        apexUserGameDataResponse,
      );

      potentialMatchService.resetUserPotentialMatches.mockResolvedValue(
        undefined,
      );

      matchmakingResultService.resetMatchmakingResults.mockResolvedValue(
        undefined,
      );

      //act
      const result = await userGameDataService.setApexLegendsPreferences(
        userId,
        setApexLegendsPreferenceInput,
      );

      expect(result).toEqual(apexUserGameDataResponse);
    });
  });

  describe('setRocketLeaguePreferences', () => {
    it('should throw TGMDNotFoundException if user game data is not found', async () => {
      //arrange

      const userId = faker.database.mongodbObjectId();
      userGameDataRepository.findOne.mockResolvedValue(null);

      //act
      expect(
        async () =>
          await userGameDataService.setRocketLeaguePreferences(
            userId,
            setRocketLeaguePreferenceInput,
          ),

        //assert
      ).rejects.toThrow(TGMDNotFoundException);
    });

    it('should return undefined if game preferences are successfully set', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();

      userGameDataRepository.findOne.mockResolvedValue(
        rocketLeagueUserGameDataResponse,
      );
      userGameDataRepository.updateOneById.mockResolvedValue(
        rocketLeagueUserGameDataResponse,
      );

      potentialMatchService.resetUserPotentialMatches.mockResolvedValue(
        undefined,
      );

      matchmakingResultService.resetMatchmakingResults.mockResolvedValue(
        undefined,
      );

      //act
      const result = await userGameDataService.setRocketLeaguePreferences(
        userId,
        setRocketLeaguePreferenceInput,
      );

      expect(result).toEqual(rocketLeagueUserGameDataResponse);
    });
  });

  describe('setFortnitePreferences', () => {
    it('should throw TGMDNotFoundException if user game data is not found', async () => {
      //arrange

      const userId = faker.database.mongodbObjectId();
      userGameDataRepository.findOne.mockResolvedValue(null);

      //act
      expect(
        async () =>
          await userGameDataService.setFortnitePreferences(
            userId,
            setFortnitePreferenceInput,
          ),

        //assert
      ).rejects.toThrow(TGMDNotFoundException);
    });

    it('should return undefined if game preferences are successfully set', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();

      userGameDataRepository.findOne.mockResolvedValue(
        fortniteUserGameDataResponse,
      );
      userGameDataRepository.updateOneById.mockResolvedValue(
        fortniteUserGameDataResponse,
      );

      potentialMatchService.resetUserPotentialMatches.mockResolvedValue(
        undefined,
      );

      matchmakingResultService.resetMatchmakingResults.mockResolvedValue(
        undefined,
      );

      //act
      const result = await userGameDataService.setFortnitePreferences(
        userId,
        setFortnitePreferenceInput,
      );

      expect(result).toEqual(fortniteUserGameDataResponse);
    });
  });

  describe('setGamePlaytime', () => {
    it('should throw TGMDNotFoundException if user game data is not found', async () => {
      //arrange

      const userId = faker.database.mongodbObjectId();
      const game = 'fake-game' as Game;
      userGameDataRepository.findOneLean.mockResolvedValue(null);

      //act
      expect(
        async () =>
          await userGameDataService.setGamePlaytime(
            userId,
            game,
            setGamePlaytimePreferenceInput,
          ),

        //assert
      ).rejects.toThrow(TGMDNotFoundException);
    });

    it('should return undefined if playtime is successfully set', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();
      const game = 'fake-game' as Game;

      userGameDataRepository.findOneLean.mockResolvedValue(
        setPlaytimeUserGameDataResponse,
      );
      userGameDataRepository.updateOneById.mockResolvedValue(undefined);

      potentialMatchService.resetUserPotentialMatches.mockResolvedValue(
        undefined,
      );

      matchmakingResultService.resetMatchmakingResults.mockResolvedValue(
        undefined,
      );

      //act
      const result = await userGameDataService.setGamePlaytime(
        userId,
        game,
        setGamePlaytimePreferenceInput,
      );

      expect(result).toEqual(undefined);
    });
  });

  describe('setOnlineSchedule', () => {
    it('should throw TGMDNotFoundException if user game data is not found', async () => {
      //arrange

      const userId = faker.database.mongodbObjectId();
      const game = 'fake-game' as Game;
      userGameDataRepository.findOneLean.mockResolvedValue(null);

      //act
      expect(
        async () =>
          await userGameDataService.setGamePlaytime(
            userId,
            game,
            setGamePlaytimePreferenceInput,
          ),

        //assert
      ).rejects.toThrow(TGMDNotFoundException);
    });

    it('should return undefined if online schedule preference is successfully set', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();
      const game = 'fake-game' as Game;

      userGameDataRepository.findOneLean.mockResolvedValue(
        setOnlineScheduleResponse,
      );
      userGameDataRepository.updateOneById.mockResolvedValue(undefined);

      potentialMatchService.resetUserPotentialMatches.mockResolvedValue(
        undefined,
      );

      matchmakingResultService.resetMatchmakingResults.mockResolvedValue(
        undefined,
      );

      //act
      const result = await userGameDataService.setOnlineSchedule(
        userId,
        game,
        setOnlineSchedulePreferenceInput,
      );

      expect(result).toEqual(undefined);
    });
  });
});
