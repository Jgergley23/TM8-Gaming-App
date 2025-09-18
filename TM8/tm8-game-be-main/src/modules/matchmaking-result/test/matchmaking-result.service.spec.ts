/* eslint-disable @typescript-eslint/ban-ts-comment */
import { TestBed } from '@automock/jest';
import { faker } from '@faker-js/faker';

import { Game } from 'src/common/constants';

import { AbstractMatchmakingResultRepository } from '../abstract/matchmaking-result.abstract.repository';
import { MatchmakingResult } from '../schemas/matchmaking-result.schema';
import { MatchmakingResultService } from '../services/matchmaking-result.service';

describe('MatchmakingResultService', () => {
  let matchmakingResultService: MatchmakingResultService;
  let matchmakingResultRepository: jest.Mocked<AbstractMatchmakingResultRepository>;

  beforeEach(() => {
    const { unit, unitRef } = TestBed.create(
      MatchmakingResultService,
    ).compile();

    matchmakingResultService = unit;

    matchmakingResultRepository = unitRef.get(
      // @ts-ignore
      AbstractMatchmakingResultRepository,
    );
  });

  beforeEach(() => {
    jest.clearAllMocks();
  });

  describe('resetMatchmakingResults', () => {
    it('should return undefined on success', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();

      matchmakingResultRepository.findOneLean.mockResolvedValue({
        _id: faker.database.mongodbObjectId(),
        game: 'game' as Game,
        matches: [],
      } as MatchmakingResult);

      //act
      const result = await matchmakingResultService.resetMatchmakingResults(
        userId,
        'game' as Game,
      );

      //assert
      expect(result).toEqual(undefined);
    });
  });

  describe('deleteUserMatchmakingResults', () => {
    it('should return undefined on success', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();

      matchmakingResultRepository.findManyLean.mockResolvedValue([
        {
          _id: faker.database.mongodbObjectId(),
          game: 'game' as Game,
          matches: [],
        } as MatchmakingResult,
      ]);

      matchmakingResultRepository.deleteMany.mockResolvedValue(undefined);

      //act
      const result =
        await matchmakingResultService.deleteUserMatchmakingResults(userId);

      //assert
      expect(result).toEqual(undefined);
    });
  });
});
