import { faker } from '@faker-js/faker';

import { ReportReason } from 'src/common/constants';

import { ReportUserInput } from '../../dto/report-user.input';
import { User } from '../../schemas/user.schema';

export const reportUserUserRepositoryResponse = {
  _id: faker.database.mongodbObjectId(),
  username: faker.internet.domainWord(),
  email: faker.internet.email(),
} as User;

export const reportUserInput: ReportUserInput = {
  reporterId: faker.database.mongodbObjectId(),
  targetId: faker.database.mongodbObjectId(),
  reportReason: 'reason' as ReportReason,
};
