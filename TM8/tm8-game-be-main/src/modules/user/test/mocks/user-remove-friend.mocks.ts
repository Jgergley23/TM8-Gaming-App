/* eslint-disable @typescript-eslint/no-explicit-any */
import { faker } from '@faker-js/faker';
import { Document } from 'mongoose';

import { Friends } from 'src/modules/friends/schemas/friends.schema';

import { User } from '../../schemas/user.schema';

export const removeFriendRequesterUserRepositoryResult = {
  _id: faker.database.mongodbObjectId(),
  username: faker.internet.domainWord(),
  email: faker.internet.email(),
} as User;

export const removeFriendRequesteeUserRepositoryResult = {
  _id: faker.database.mongodbObjectId(),
  username: faker.internet.domainWord(),
  email: faker.internet.email(),
} as User;

export const removeFriendRequesterNotFoundRepositoryMock = {
  _id: faker.database.mongodbObjectId(),
  user: removeFriendRequesterUserRepositoryResult._id,
  friends: [
    {
      user: faker.database.mongodbObjectId(),
    },
  ],
} as Friends & Document<any, any, Friends>;

export const removeFriendRequesteeNotFoundRepositoryMock = {
  _id: faker.database.mongodbObjectId(),
  user: removeFriendRequesteeUserRepositoryResult._id,
  friends: [
    {
      user: faker.database.mongodbObjectId(),
    },
  ],
} as Friends & Document<any, any, Friends>;

export const removeFriendRequesterRepositoryMock = {
  _id: faker.database.mongodbObjectId(),
  user: removeFriendRequesterUserRepositoryResult._id,
  friends: [
    {
      user: removeFriendRequesteeUserRepositoryResult._id,
    },
  ],
} as Friends & Document<any, any, Friends>;

export const removeFriendRequesteeRepositoryMock = {
  _id: faker.database.mongodbObjectId() as string & Friends,
  user: removeFriendRequesteeUserRepositoryResult._id,
  friends: [
    {
      _id: faker.database.mongodbObjectId(),
      user: removeFriendRequesterUserRepositoryResult._id,
    },
  ],
  requests: [],
} as Friends & Document<any, any, Friends>;
