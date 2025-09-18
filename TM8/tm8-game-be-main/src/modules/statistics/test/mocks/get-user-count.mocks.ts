import { faker } from '@faker-js/faker';

import { StatisticsTotalCountResponse } from 'src/modules/statistics/response/statistics-total-count.response';
import { Statistics } from 'src/modules/statistics/schemas/statistics.schema';

export const statisticsResponseMock: Statistics[] = [
  {
    _id: faker.database.mongodbObjectId(),
    totalCount: 50,
    onboardedCount: 40,
  } as Statistics,
];

export const statisticsTotalCountResponseMock: StatisticsTotalCountResponse = {
  total: 50,
  currentWeek: 0,
};
