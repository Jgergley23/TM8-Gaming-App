/* eslint-disable @typescript-eslint/ban-ts-comment */
import { TestBed } from '@automock/jest';

import { Game } from 'src/common/constants';
import { AbstractPotentialMatchRepository } from 'src/modules/potential-match/abstract/potential-match.abstract.repository';

import { MatchmakingUserFilteringService } from '../services/matchmaking-user-filtering.service';
import {
  currentUserRepositoryMock,
  gameDataUserIdsMock,
  potentialMatchRepositoryMock,
  usersGameDataMock,
} from './mocks/matchmaking.mocks';

describe('MatchmakingUserFilteringService', () => {
  let matchmakingUserFilteringService: MatchmakingUserFilteringService;
  let potentialMatchRepository: jest.Mocked<AbstractPotentialMatchRepository>;

  beforeEach(() => {
    const { unit, unitRef } = TestBed.create(
      MatchmakingUserFilteringService,
    ).compile();

    matchmakingUserFilteringService = unit;

    potentialMatchRepository = unitRef.get(
      // @ts-ignore
      AbstractPotentialMatchRepository,
    );
  });

  describe('filterPlayableUserGameData', () => {
    it('should return user game data array on success', async () => {
      //arrange
      jest
        .spyOn(
          // eslint-disable-next-line @typescript-eslint/no-explicit-any
          MatchmakingUserFilteringService.prototype as any,
          'excludeCurrentUserFromMatching',
        )
        .mockReturnValue(usersGameDataMock);

      jest
        .spyOn(
          // eslint-disable-next-line @typescript-eslint/no-explicit-any
          MatchmakingUserFilteringService.prototype as any,
          'filterActiveUsers',
        )
        .mockReturnValue(usersGameDataMock);

      jest
        .spyOn(
          // eslint-disable-next-line @typescript-eslint/no-explicit-any
          MatchmakingUserFilteringService.prototype as any,
          'filterUsersByAge',
        )
        .mockReturnValue(usersGameDataMock);

      jest
        .spyOn(
          // eslint-disable-next-line @typescript-eslint/no-explicit-any
          MatchmakingUserFilteringService.prototype as any,
          'filterPlayersByRegions',
        )
        .mockReturnValue(usersGameDataMock);

      //act
      const result = matchmakingUserFilteringService.filterPlayableUserGameData(
        currentUserRepositoryMock,
        usersGameDataMock,
      );

      //assert
      expect(result).toEqual(usersGameDataMock);
    });
  });

  describe('filterUnmatchableUsers', () => {
    it('should return an array of user ids on success', async () => {
      //arrange
      jest
        .spyOn(
          // eslint-disable-next-line @typescript-eslint/no-explicit-any
          MatchmakingUserFilteringService.prototype as any,
          'filterRejectedUsers',
        )
        .mockResolvedValue(gameDataUserIdsMock);

      jest
        .spyOn(
          // eslint-disable-next-line @typescript-eslint/no-explicit-any
          MatchmakingUserFilteringService.prototype as any,
          'filterUserFriends',
        )
        .mockResolvedValue(gameDataUserIdsMock);

      jest
        .spyOn(
          // eslint-disable-next-line @typescript-eslint/no-explicit-any
          MatchmakingUserFilteringService.prototype as any,
          'filterAlreadyMatchedUsers',
        )
        .mockResolvedValue(gameDataUserIdsMock);

      jest
        .spyOn(
          // eslint-disable-next-line @typescript-eslint/no-explicit-any
          MatchmakingUserFilteringService.prototype as any,
          'filterBlockedOrReportedUsers',
        )
        .mockResolvedValue(gameDataUserIdsMock);

      //act
      const result =
        await matchmakingUserFilteringService.filterUnmatchableUsers(
          currentUserRepositoryMock,
          gameDataUserIdsMock,
          'fake-game' as Game,
        );

      //assert
      expect(result).toEqual(gameDataUserIdsMock);
    });
  });

  describe('checkMatchmakingResultsForExistingPotentialMatch', () => {
    it('should return user game data array on success', async () => {
      //arrange
      potentialMatchRepository.findManyLean.mockResolvedValue(
        potentialMatchRepositoryMock,
      );

      //act
      const result =
        await matchmakingUserFilteringService.checkMatchmakingResultsForExistingPotentialMatch(
          potentialMatchRepositoryMock[0].users[0].user as string,
          'fake-game',
          gameDataUserIdsMock,
        );

      //assert
      expect(result).toEqual(gameDataUserIdsMock);
    });
  });
});
