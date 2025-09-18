import { faker } from '@faker-js/faker';

import { ActionType, ReportReason } from 'src/common/constants';
import { IActionRecord } from 'src/modules/action/interfaces/action.interface';

import { UserReportResponse } from '../../response/user-report.response';
import { User } from '../../schemas/user.schema';

export const userReportsMock: UserReportResponse[] = [
  {
    reporter: 'fake-username',
    reportReason: ReportReason.HarrasmentAndBullying,
    createdAt: new Date('2023-11-10T02:00:49.190Z'),
  },
];

export const reportUserRepositoryResponseMock = {
  username: 'fake-username',
} as User;

export const reportActionRepositoryResponseMock: IActionRecord = {
  _id: faker.database.mongodbObjectId(),
  user: reportUserRepositoryResponseMock,
  actionType: ActionType.Report,
  actionsFrom: [
    {
      user: reportUserRepositoryResponseMock,
      reportReason: ReportReason.HarrasmentAndBullying,
      createdAt: new Date('2023-11-10T02:00:49.190Z'),
    },
  ],
  actionsTo: [],
};
