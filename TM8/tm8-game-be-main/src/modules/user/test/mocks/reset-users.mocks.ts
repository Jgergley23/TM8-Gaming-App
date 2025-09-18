import { faker } from '@faker-js/faker';
import { UpdateWriteOpResult } from 'mongoose';

import { UserResetInput } from '../../dto/user-reset-input';
import { User } from '../../schemas/user.schema';

export const resetUsersInputMock: UserResetInput = {
  userIds: [faker.database.mongodbObjectId()],
};

export const resetUserUpdateFailedResponseMock: UpdateWriteOpResult = {
  modifiedCount: 0,
} as UpdateWriteOpResult;

export const resetUserUpdateSuccessResponseMock: UpdateWriteOpResult = {
  modifiedCount: 1,
} as UpdateWriteOpResult;

export const resetUsersResponseMock: User[] = [
  {
    _id: faker.database.mongodbObjectId(),
    username: faker.internet.userName(),
  } as User,
];
