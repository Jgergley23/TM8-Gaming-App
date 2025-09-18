import { faker } from '@faker-js/faker';
import { UpdateWriteOpResult } from 'mongoose';

import { UserSuspendInput } from '../../dto/user-suspend-input';
import { User } from '../../schemas/user.schema';

export const suspendUsersInputMock: UserSuspendInput = {
  userIds: [faker.database.mongodbObjectId()],
  note: faker.lorem.sentence(3),
  until: faker.date.future(),
};

export const suspendUserUpdateFailedResponseMock: UpdateWriteOpResult = {
  modifiedCount: 0,
} as UpdateWriteOpResult;

export const suspendUserUpdateSuccessResponseMock: UpdateWriteOpResult = {
  modifiedCount: 1,
} as UpdateWriteOpResult;

export const suspendUsersResponseMock: User[] = [
  {
    _id: faker.database.mongodbObjectId(),
    username: faker.internet.userName(),
  } as User,
];
