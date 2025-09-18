/* eslint-disable @typescript-eslint/no-explicit-any */
import { faker } from '@faker-js/faker';
import { Document } from 'mongoose';

import { Friends } from 'src/modules/friends/schemas/friends.schema';

import { User } from '../../schemas/user.schema';

export const addFriendRequesterUserRepositoryResult = {
  _id: faker.database.mongodbObjectId(),
  username: faker.internet.domainWord(),
  email: faker.internet.email(),
} as User;

export const addFriendRequesteeUserRepositoryResult = {
  _id: faker.database.mongodbObjectId(),
  username: faker.internet.domainWord(),
  email: faker.internet.email(),
} as User;

export const addFriendRequesterRepositoryMock = {
  _id: faker.database.mongodbObjectId(),
  user: addFriendRequesterUserRepositoryResult._id,
  friends: [
    {
      user: faker.database.mongodbObjectId(),
    },
  ],
} as Friends & Document<any, any, Friends>;

export const addFriendRequesteeRepositoryMock = {
  _id: faker.database.mongodbObjectId() as string & Friends,
  user: addFriendRequesteeUserRepositoryResult._id,
  friends: [
    {
      _id: faker.database.mongodbObjectId(),
      user: faker.database.mongodbObjectId(),
    },
  ],
  requests: [],
} as Friends & Document<any, any, Friends>;

export const addFriendRequesterConflictRepositoryMock = {
  _id: faker.database.mongodbObjectId(),
  user: addFriendRequesterUserRepositoryResult._id,
  friends: [
    {
      user: addFriendRequesteeUserRepositoryResult._id,
    },
  ],
} as Friends & Document<any, any, Friends>;

export const addFriendRequesteeConflictRepositoryMock = {
  _id: faker.database.mongodbObjectId(),
  user: addFriendRequesteeUserRepositoryResult._id,
  friends: [
    {
      user: addFriendRequesterUserRepositoryResult._id,
    },
  ],
} as Friends & Document<any, any, Friends>;
