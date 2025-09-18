/* eslint-disable @typescript-eslint/ban-ts-comment */
import { TestBed } from '@automock/jest';
import { faker } from '@faker-js/faker';

import { Game } from 'src/common/constants';
import { AbstractMatchmakingResultRepository } from 'src/modules/matchmaking-result/abstract/matchmaking-result.abstract.repository';
import { AbstractUserGameDataRepository } from 'src/modules/user-game-data/abstract/user-game-data.abstract.repository';

import { MatchmakingService } from '../services/matchmaking.service';
import {
  emptyMatchmakingResultPaginationMock,
  listMatchmakingResultsEmptyResponseMock,
  listMatchmakingResultsResponseMock,
  matchmakingResultPaginationMock,
  userGameDataRepositoryMock,
} from './mocks/list-matchmaking-results.mock';

describe('MatchmakingService', () => {
  let matchmakingService: MatchmakingService;
  let matchmakingResultRepository: jest.Mocked<AbstractMatchmakingResultRepository>;
  let userGameDataRepository: jest.Mocked<AbstractUserGameDataRepository>;

  beforeEach(() => {
    const { unit, unitRef } = TestBed.create(MatchmakingService).compile();

    matchmakingService = unit;

    matchmakingResultRepository = unitRef.get(
      //@ts-ignore
      AbstractMatchmakingResultRepository,
    );
    //@ts-ignore
    userGameDataRepository = unitRef.get(AbstractUserGameDataRepository);
  });

  describe('matchmake', () => {
    it('should return undefined on success', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();
      const game = 'fake-game' as Game;

      //act
      const result = await matchmakingService.matchmake(userId, game);

      //assert
      expect(result).toEqual(undefined);
    });
  });

  describe('listMatchmakingResults', () => {
    it('should return empty list if no data is found', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();
      const game = 'fake-game' as Game;

      matchmakingResultRepository.findOneLean.mockResolvedValue(
        listMatchmakingResultsEmptyResponseMock,
      );

      //act
      const result = await matchmakingService.listMatchmakingResults(
        userId,
        game,
        { page: 1, limit: 10, skip: 0 },
      );

      //assert
      expect(result).toEqual(emptyMatchmakingResultPaginationMock);
    });
  });

  it('should return paginated list of matchmaking results', async () => {
    //arrange
    const userId = faker.database.mongodbObjectId();
    const game = 'fake-game' as Game;

    matchmakingResultRepository.findOneLean.mockResolvedValue(
      listMatchmakingResultsResponseMock,
    );

    userGameDataRepository.getUserGameDataWithMatchmakingResultUserDetails.mockResolvedValue(
      userGameDataRepositoryMock,
    );

    //act
    const result = await matchmakingService.listMatchmakingResults(
      userId,
      game,
      { page: 1, limit: 10, skip: 0 },
    );

    //assert
    expect(result).toEqual(matchmakingResultPaginationMock);
  });
});
