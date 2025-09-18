/* eslint-disable @typescript-eslint/ban-ts-comment */

import { TestBed } from '@automock/jest';

import { AbstractUserGameDataRepository } from 'src/modules/user-game-data/abstract/user-game-data.abstract.repository';
import { AbstractUserRepository } from 'src/modules/user/abstract/user.abstract.repository';

import { AbstractStatisticsRepository } from '../abstract/statistics.abstract.repository';
import { StatisticsService } from '../services/statistics.service';
import {
  getNewUsersDailyInitialMock,
  getNewUsersDailyParamsMock,
  getNewUsersDailyResponseMock,
  getNewUsersMonthlyInitialMock,
  getNewUsersMonthlyParamsMock,
  getNewUsersMonthlyResponseMock,
  getNewUsersRegisteredEmptyResponseMock,
  getNewUsersWeeklyInitialMock,
  getNewUsersWeeklyParamsMock,
  getNewUsersWeeklyResponseMock,
  getNewUsersYearlyInitialMock,
  getNewUsersYearlyParamsMock,
  getNewUsersYearlyResponseMock,
  getUsersResponseMock,
} from './mocks/get-new-users-registered.mocks';
import {
  onboardingStatisticsResponseMock,
  statisticsOnboardingResponseMock,
} from './mocks/get-onboarding-completion.mocks';
import {
  statisticsResponseMock,
  statisticsTotalCountResponseMock,
} from './mocks/get-user-count.mocks';
import {
  aggregateUserGroupCountsMock,
  getUserGroupCountsParamsMock,
  userGroupCountsResponseMock,
} from './mocks/get-user-group-counts.mocks';

describe('StatisticsService', () => {
  let statisticsService: StatisticsService;
  let statisticsRepository: jest.Mocked<AbstractStatisticsRepository>;
  let userRepository: jest.Mocked<AbstractUserRepository>;
  let userGameDataRepository: jest.Mocked<AbstractUserGameDataRepository>;

  beforeAll(() => {
    const { unit, unitRef } = TestBed.create(StatisticsService).compile();

    statisticsService = unit;

    // @ts-ignore
    statisticsRepository = unitRef.get(AbstractStatisticsRepository);
    // @ts-ignore
    userRepository = unitRef.get(AbstractUserRepository);
    // @ts-ignore
    userGameDataRepository = unitRef.get(AbstractUserGameDataRepository);
  });

  describe('getUserCount', () => {
    it('should return total count response', async () => {
      //arrange
      userRepository.count.mockResolvedValue(
        statisticsResponseMock[0].totalCount,
      );
      statisticsRepository.findOneLean.mockResolvedValue(
        statisticsResponseMock[0],
      );

      //assert
      const result = await statisticsService.getUserCount();

      //act
      expect(result).toEqual(statisticsTotalCountResponseMock);
    });
  });

  describe('getOnboardingCompletion', () => {
    it('should return onboarding completion response', async () => {
      //arrange
      userRepository.count.mockResolvedValue(
        onboardingStatisticsResponseMock[0].onboardedCount,
      );
      statisticsRepository.findOneLean.mockResolvedValue(
        onboardingStatisticsResponseMock[0],
      );

      //assert
      const result = await statisticsService.getOnboardingCompletion();

      //act
      expect(result).toEqual(statisticsOnboardingResponseMock);
    });
  });

  describe('getNewUsersRegistered', () => {
    it('should return empty array if users not found', async () => {
      //arrange
      userRepository.findManyLean.mockResolvedValue([]);

      //assert
      const result = await statisticsService.getNewUsersRegistered(
        getNewUsersDailyParamsMock,
      );

      //act
      expect(result).toEqual(getNewUsersRegisteredEmptyResponseMock);
    });

    it('when grouping by day should return new users registered response', async () => {
      //arrange
      userRepository.findManyLean.mockResolvedValue(getUsersResponseMock);

      jest
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        .spyOn(StatisticsService.prototype as any, 'createInitialGroupedChart')
        .mockReturnValue(getNewUsersDailyInitialMock);

      //assert
      const result = await statisticsService.getNewUsersRegistered(
        getNewUsersDailyParamsMock,
      );

      //act
      expect(result).toEqual(getNewUsersDailyResponseMock);
    });

    it('when grouping by week should return new users registered response', async () => {
      //arrange
      userRepository.findManyLean.mockResolvedValue(getUsersResponseMock);

      jest
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        .spyOn(StatisticsService.prototype as any, 'createInitialGroupedChart')
        .mockReturnValue(getNewUsersWeeklyInitialMock);

      //assert
      const result = await statisticsService.getNewUsersRegistered(
        getNewUsersWeeklyParamsMock,
      );

      //act
      expect(result).toEqual(getNewUsersWeeklyResponseMock);
    });

    it('when grouping by month should return new users registered response', async () => {
      //arrange
      userRepository.findManyLean.mockResolvedValue(getUsersResponseMock);

      jest
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        .spyOn(StatisticsService.prototype as any, 'createInitialGroupedChart')
        .mockReturnValue(getNewUsersMonthlyInitialMock);

      //assert
      const result = await statisticsService.getNewUsersRegistered(
        getNewUsersMonthlyParamsMock,
      );

      //act
      expect(result).toEqual(getNewUsersMonthlyResponseMock);
    });

    it('when grouping by year should return new users registered response', async () => {
      //arrange
      userRepository.findManyLean.mockResolvedValue(getUsersResponseMock);

      jest
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        .spyOn(StatisticsService.prototype as any, 'createInitialGroupedChart')
        .mockReturnValue(getNewUsersYearlyInitialMock);

      //assert
      const result = await statisticsService.getNewUsersRegistered(
        getNewUsersYearlyParamsMock,
      );

      //act
      expect(result).toEqual(getNewUsersYearlyResponseMock);
    });
  });

  describe('getUserGroupCounts', () => {
    it('should return user group counts response when filters are passed', async () => {
      //arrange
      userRepository.count.mockResolvedValue(50);
      userGameDataRepository.countUsersPerGame.mockResolvedValue(
        aggregateUserGroupCountsMock,
      );

      //assert
      const result = await statisticsService.getUserGroupCounts(
        getUserGroupCountsParamsMock,
      );

      //act
      expect(result).toEqual(userGroupCountsResponseMock);
    });

    it('should return user group counts response when no filters are passed', async () => {
      //arrange
      userRepository.count.mockResolvedValue(50);
      userGameDataRepository.countUsersPerGame.mockResolvedValue(
        aggregateUserGroupCountsMock,
      );

      //assert
      const result = await statisticsService.getUserGroupCounts({});

      //act
      expect(result).toEqual(userGroupCountsResponseMock);
    });
  });

  describe('createWeeklyStatistics', () => {
    it('should return undefined', async () => {
      //arrange
      const numOfUsers = 50;
      userRepository.count.mockResolvedValue(numOfUsers);
      statisticsRepository.createOne.mockResolvedValue(undefined);

      //assert
      const result = await statisticsService.createWeeklyStatistics();

      //act
      expect(result).toBeUndefined();
    });
  });
});
