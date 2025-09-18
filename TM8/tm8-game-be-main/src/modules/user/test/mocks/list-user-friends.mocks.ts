/* eslint-disable @typescript-eslint/no-explicit-any */
import { faker } from '@faker-js/faker';
import { Document } from 'mongoose';

import { PaginationParams } from 'src/common/pagination/pagination-params';
import { PaginationModel } from 'src/common/pagination/paginaton.model';
import { Friends } from 'src/modules/friends/schemas/friends.schema';

import { ListUserFriendsParams } from '../../dto/list-user-friends.params';
import { User } from '../../schemas/user.schema';

export const listUserFriendsParamsMock = {
  username: '',
} as ListUserFriendsParams;

export const listUserFriendsPaginationParamsMock: PaginationParams = {
  page: 1,
  limit: 10,
  skip: 0,
};

export const userFriendsPaginationResult: PaginationModel<User> = {
  items: [expect.any(Object)],
  meta: {
    page: expect.any(Number),
    limit: expect.any(Number),
    itemCount: expect.any(Number),
    pageCount: expect.any(Number),
    hasNextPage: expect.any(Boolean),
    hasPreviousPage: expect.any(Boolean),
  },
};

export const listUserGamesUserRepositoryResult: User[] = [
  {
    _id: faker.database.mongodbObjectId(),
    username: faker.internet.domainWord(),
    email: faker.internet.email(),
    description: faker.lorem.sentence(),
    photoKey: faker.system.commonFileName(),
    audioKey: faker.system.commonFileName(),
  } as User,
];

export const listUserGamesFriendsRepositoryMock = {
  _id: faker.database.mongodbObjectId(),
  user: faker.database.mongodbObjectId(),
  friends: [
    {
      user: faker.database.mongodbObjectId(),
    },
  ],
} as Friends & Document<any, any, Friends>;
