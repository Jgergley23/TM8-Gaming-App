import { faker } from '@faker-js/faker';

import { Statistics } from 'src/modules/statistics/schemas/statistics.schema';

import { StatisticsOnboardingCompletionResponse } from '../../response/statistic-onboarding-completion.response';

export const onboardingStatisticsResponseMock: Statistics[] = [
  {
    _id: faker.database.mongodbObjectId(),
    totalCount: 50,
    onboardedCount: 50,
  } as Statistics,
];

export const statisticsOnboardingResponseMock: StatisticsOnboardingCompletionResponse =
  {
    onboardingPct: 100,
    currentWeek: 0,
  };
