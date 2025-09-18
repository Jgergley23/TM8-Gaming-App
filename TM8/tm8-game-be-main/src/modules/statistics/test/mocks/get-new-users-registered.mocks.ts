import { faker } from '@faker-js/faker';

import { ChartGroup } from 'src/common/constants';
import { IUserRecord } from 'src/modules/user/interface/user.interface';

import { GetNewUsersRegisteredParams } from '../../dto/get-new-users.registered.params';
import { StatisticsNewUsersRegisteredResponse } from '../../response/statistics-new-users-registered.response';

export const getNewUsersDailyParamsMock: GetNewUsersRegisteredParams = {
  groupBy: ChartGroup.Day,
  startDate: '2024-02-12',
  endDate: '2024-02-18',
};

export const getNewUsersWeeklyParamsMock: GetNewUsersRegisteredParams = {
  groupBy: ChartGroup.Week,
  startDate: '2024-02-12',
  endDate: '2024-02-18',
};

export const getNewUsersMonthlyParamsMock: GetNewUsersRegisteredParams = {
  groupBy: ChartGroup.Month,
  startDate: '2024-02-12',
  endDate: '2024-02-18',
};

export const getNewUsersYearlyParamsMock: GetNewUsersRegisteredParams = {
  groupBy: ChartGroup.Year,
  startDate: '2024-02-12',
  endDate: '2024-02-18',
};

export const getNewUsersDailyResponseMock: StatisticsNewUsersRegisteredResponse =
  {
    chart: [
      {
        date: '2024-02-12',
        quantity: 1,
      },
    ],
  };

export const getNewUsersWeeklyResponseMock: StatisticsNewUsersRegisteredResponse =
  {
    chart: [
      {
        date: '2024-02-11',
        quantity: 1,
      },
    ],
  };

export const getNewUsersMonthlyResponseMock: StatisticsNewUsersRegisteredResponse =
  {
    chart: [
      {
        date: '2024-02-01',
        quantity: 1,
      },
    ],
  };

export const getNewUsersYearlyResponseMock: StatisticsNewUsersRegisteredResponse =
  {
    chart: [
      {
        date: '2024-01-01',
        quantity: 1,
      },
    ],
  };

type ChartPointArray = { date: string; quantity: number }[];

export const getNewUsersDailyInitialMock: ChartPointArray = [
  {
    date: '2024-02-12',
    quantity: 0,
  },
];

export const getNewUsersDailyGroupedMock: ChartPointArray = [
  {
    date: '2024-02-12',
    quantity: 1,
  },
];

export const getNewUsersWeeklyInitialMock: ChartPointArray = [
  {
    date: '2024-02-11',
    quantity: 0,
  },
];

export const getNewUsersWeeklyGroupedMock: ChartPointArray = [
  {
    date: '2024-02-11',
    quantity: 1,
  },
];

export const getNewUsersMonthlyInitialMock: ChartPointArray = [
  {
    date: '2024-02-01',
    quantity: 0,
  },
];

export const getNewUsersMonthlyGroupedMock: ChartPointArray = [
  {
    date: '2024-02-01',
    quantity: 1,
  },
];

export const getNewUsersYearlyInitialMock: ChartPointArray = [
  {
    date: '2024-01-01',
    quantity: 0,
  },
];

export const getNewUsersYearlyGroupedMock: ChartPointArray = [
  {
    date: '2024-01-01',
    quantity: 1,
  },
];

export const getNewUsersRegisteredEmptyResponseMock: StatisticsNewUsersRegisteredResponse =
  {
    chart: [],
  };

export const getUsersResponseMock: IUserRecord[] = [
  {
    _id: faker.database.mongodbObjectId(),
    username: faker.internet.userName(),
    createdAt: new Date('2024-02-12T00:00:00.000'),
  } as IUserRecord,
];
