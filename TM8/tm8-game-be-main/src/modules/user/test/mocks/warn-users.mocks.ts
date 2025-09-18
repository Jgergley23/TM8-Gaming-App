import { faker } from '@faker-js/faker';
import { UpdateWriteOpResult } from 'mongoose';

import { WarningReason } from 'src/common/constants';

import { UserWarningInput } from '../../dto/user-warning.input';
import { User } from '../../schemas/user.schema';

export const warnUsersInputMock: UserWarningInput = {
  userIds: [faker.database.mongodbObjectId()],
  note: faker.lorem.sentence(3),
  warning: WarningReason.ImpersonationOrFalseIdentity,
};

export const warnUserUpdateFailedResponseMock: UpdateWriteOpResult = {
  modifiedCount: 0,
} as UpdateWriteOpResult;

export const warnUserUpdateSuccessResponseMock: UpdateWriteOpResult = {
  modifiedCount: 1,
} as UpdateWriteOpResult;

export const warnUsersResponseMock: User[] = [
  {
    _id: faker.database.mongodbObjectId(),
    username: faker.internet.userName(),
  } as User,
];
