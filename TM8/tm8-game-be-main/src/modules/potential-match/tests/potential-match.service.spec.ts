/* eslint-disable @typescript-eslint/ban-ts-comment */
import { TestBed } from '@automock/jest';
import { faker } from '@faker-js/faker';

import { Game } from 'src/common/constants';
import {
  TGMDConflictException,
  TGMDNotFoundException,
} from 'src/common/exceptions/custom.exception';
import { AbstractMatchRepository } from 'src/modules/match/abstract/match.abstract.repository';
import { AbstractMatchmakingResultRepository } from 'src/modules/matchmaking-result/abstract/matchmaking-result.abstract.repository';

import { AbstractPotentialMatchRepository } from '../abstract/potential-match.abstract.repository';
import { PotentialMatch } from '../schemas/potential-match.schema';
import { PotentialMatchService } from '../services/potential-match.service';
import {
  matchRepositoryResponseMock,
  matchmakingResultErrorResponseMock,
  matchmakingResultResponseMock,
  potentialMatchResponseMock,
} from './mocks/accept-potential-match.mock';
import { userPotentialMatchesResponseMock } from './mocks/reset-user-potential-matches';

describe('PotentialMatchService', () => {
  let potentialMatchService: PotentialMatchService;
  let potentialMatchRepository: jest.Mocked<AbstractPotentialMatchRepository>;
  let matchRepository: jest.Mocked<AbstractMatchRepository>;
  let matchmakingResultRepository: jest.Mocked<AbstractMatchmakingResultRepository>;

  beforeEach(() => {
    const { unit, unitRef } = TestBed.create(PotentialMatchService).compile();

    potentialMatchService = unit;

    // @ts-ignore
    potentialMatchRepository = unitRef.get(AbstractPotentialMatchRepository);
    //@ts-ignore
    matchRepository = unitRef.get(AbstractMatchRepository);
    matchmakingResultRepository = unitRef.get(
      //@ts-ignore
      AbstractMatchmakingResultRepository,
    );
  });

  beforeEach(() => {
    jest.clearAllMocks();
  });

  describe('resetUserPotentialMatches', () => {
    it('should return undefined on success', async () => {
      //arrange
      const userId = userPotentialMatchesResponseMock[0].users[0].user;
      const game = userPotentialMatchesResponseMock[0].game;

      potentialMatchRepository.findManyLean.mockResolvedValue(
        userPotentialMatchesResponseMock,
      );
      potentialMatchRepository.deleteMany.mockResolvedValue(undefined);

      //act
      const result = await potentialMatchService.resetUserPotentialMatches(
        userId as string,
        game,
      );

      //assert
      expect(result).toEqual(undefined);
    });
  });

  describe('acceptPotentialMatch', () => {
    it('should throw TGMDConflictException if there is an existing match', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();
      const targetUserId = faker.database.mongodbObjectId();
      const game = 'fake-game' as Game;

      matchRepository.findOneLean.mockResolvedValue(
        matchRepositoryResponseMock,
      );

      //act
      expect(async () => {
        await potentialMatchService.acceptPotentialMatch(
          userId,
          targetUserId,
          game,
        );
        //assert
      }).rejects.toThrow(TGMDConflictException);
    });

    it('should throw TGMDNotFoundException if there are not matchmaking results', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();
      const targetUserId = faker.database.mongodbObjectId();
      const game = 'fake-game' as Game;

      matchRepository.findOneLean.mockResolvedValue(null);

      matchmakingResultRepository.findOneLean.mockResolvedValue(null);

      //act
      expect(async () => {
        await potentialMatchService.acceptPotentialMatch(
          userId,
          targetUserId,
          game,
        );
        //assert
      }).rejects.toThrow(TGMDNotFoundException);
    });

    it('should throw TGMDNotFoundException if matchmaking results dont contain the current user', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();
      const targetUserId = faker.database.mongodbObjectId();
      const game = 'fake-game' as Game;

      matchRepository.findOneLean.mockResolvedValue(null);

      matchmakingResultRepository.findOneLean.mockResolvedValue(
        matchmakingResultErrorResponseMock,
      );

      //act
      expect(async () => {
        await potentialMatchService.acceptPotentialMatch(
          userId,
          targetUserId,
          game,
        );
        //assert
      }).rejects.toThrow(TGMDNotFoundException);
    });

    it('should create a potential match between two users', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();
      const targetUserId = matchmakingResultResponseMock.matches[0] as string;
      const game = 'fake-game' as Game;

      matchRepository.findOneLean.mockResolvedValue(null);

      matchmakingResultRepository.findOneLean.mockResolvedValue(
        matchmakingResultResponseMock,
      );

      potentialMatchRepository.findOneLean.mockResolvedValue(null);

      potentialMatchRepository.createOne.mockResolvedValue(null);

      jest
        .spyOn(
          // eslint-disable-next-line @typescript-eslint/no-explicit-any
          PotentialMatchService.prototype as any,
          'sendMatchNotification',
        )
        .mockResolvedValue(undefined);

      //act
      const result = await potentialMatchService.acceptPotentialMatch(
        userId,
        targetUserId,
        game,
      );

      //assert
      expect(result).toEqual({ isMatch: false });
    });

    it('should create a match between two users', async () => {
      //arrange
      const userId = potentialMatchResponseMock.users[0].user as string;
      const targetUserId = potentialMatchResponseMock.users[1].user as string;
      const game = 'fake-game' as Game;

      matchRepository.findOneLean.mockResolvedValue(null);

      matchmakingResultRepository.findOneLean.mockResolvedValue(
        matchmakingResultResponseMock,
      );

      potentialMatchRepository.findOneLean.mockResolvedValue(
        potentialMatchResponseMock,
      );

      matchRepository.createOne.mockResolvedValue(undefined);

      potentialMatchRepository.deleteOne.mockResolvedValue(undefined);

      //act
      const result = await potentialMatchService.acceptPotentialMatch(
        userId,
        targetUserId,
        game,
      );

      //assert
      expect(result).toEqual({ isMatch: true });
    });
  });

  describe('rejectPotentialMatch', () => {
    it('should throw TGMDConflictException if there is an existing match', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();
      const targetUserId = faker.database.mongodbObjectId();
      const game = 'fake-game' as Game;

      matchRepository.findOneLean.mockResolvedValue(
        matchRepositoryResponseMock,
      );

      //act
      expect(async () => {
        await potentialMatchService.rejectPotentialMatch(
          userId,
          targetUserId,
          game,
        );
        //assert
      }).rejects.toThrow(TGMDConflictException);
    });

    it('should throw TGMDNotFoundException if there are not matchmaking results', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();
      const targetUserId = faker.database.mongodbObjectId();
      const game = 'fake-game' as Game;

      matchRepository.findOneLean.mockResolvedValue(null);

      matchmakingResultRepository.findOneLean.mockResolvedValue(null);

      //act
      expect(async () => {
        await potentialMatchService.rejectPotentialMatch(
          userId,
          targetUserId,
          game,
        );
        //assert
      }).rejects.toThrow(TGMDNotFoundException);
    });

    it('should throw TGMDNotFoundException if matchmaking results dont contain the current user', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();
      const targetUserId = faker.database.mongodbObjectId();
      const game = 'fake-game' as Game;

      matchRepository.findOneLean.mockResolvedValue(null);

      matchmakingResultRepository.findOneLean.mockResolvedValue(
        matchmakingResultErrorResponseMock,
      );

      //act
      expect(async () => {
        await potentialMatchService.rejectPotentialMatch(
          userId,
          targetUserId,
          game,
        );
        //assert
      }).rejects.toThrow(TGMDNotFoundException);
    });

    it('should create a potential match between two users', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();
      const targetUserId = matchmakingResultResponseMock.matches[0] as string;
      const game = 'fake-game' as Game;

      matchRepository.findOneLean.mockResolvedValue(null);

      matchmakingResultRepository.findOneLean.mockResolvedValue(
        matchmakingResultResponseMock,
      );

      potentialMatchRepository.findOneLean.mockResolvedValue(
        potentialMatchResponseMock,
      );

      potentialMatchRepository.deleteOne.mockResolvedValue(undefined);

      jest
        .spyOn(
          // eslint-disable-next-line @typescript-eslint/no-explicit-any
          PotentialMatchService.prototype as any,
          'removePotentialMatchFromMatchmakingResult',
        )
        .mockResolvedValue(undefined);

      jest
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        .spyOn(PotentialMatchService.prototype as any, 'addUserToRejectedUsers')
        .mockResolvedValue(undefined);

      //act
      const result = await potentialMatchService.rejectPotentialMatch(
        userId,
        targetUserId,
        game,
      );

      //assert
      expect(result).toEqual(undefined);
    });
  });

  describe('deleteUserPotentialMatches', () => {
    it('should return undefined on success', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();

      potentialMatchRepository.findManyLean.mockResolvedValue([
        {
          _id: faker.database.mongodbObjectId(),
          game: 'game' as Game,
          users: [],
        } as PotentialMatch,
      ]);

      potentialMatchRepository.deleteMany.mockResolvedValue(undefined);

      //act
      const result = await potentialMatchService.deleteUserPotentialMatches(
        userId,
      );

      //assert
      expect(result).toEqual(undefined);
    });
  });
});
