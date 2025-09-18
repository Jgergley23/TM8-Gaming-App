import { faker } from '@faker-js/faker';
import { UpdateWriteOpResult } from 'mongoose';

import { UserBanInput } from '../../dto/user-ban.input';
import { User } from '../../schemas/user.schema';

export const banUsersInputMock: UserBanInput = {
  userIds: [faker.database.mongodbObjectId()],
  note: faker.lorem.sentence(3),
};

export const banUserUpdateFailedResponseMock: UpdateWriteOpResult = {
  modifiedCount: 0,
} as UpdateWriteOpResult;

export const banUserUpdateSuccessResponseMock: UpdateWriteOpResult = {
  modifiedCount: 1,
} as UpdateWriteOpResult;

export const banUsersResponseMock: User[] = [
  {
    _id: faker.database.mongodbObjectId(),
    username: faker.internet.userName(),
  } as User,
];
