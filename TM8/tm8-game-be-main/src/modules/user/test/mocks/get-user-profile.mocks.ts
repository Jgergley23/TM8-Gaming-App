/* eslint-disable @typescript-eslint/no-explicit-any */

import { faker } from '@faker-js/faker';
import { Document } from 'mongoose';

import { Friends } from 'src/modules/friends/schemas/friends.schema';

import { UserProfileResponse } from '../../response/user-profile.response';
import { User } from '../../schemas/user.schema';

export const userProfileUserRepositoryResult = {
  _id: faker.database.mongodbObjectId(),
  username: faker.internet.domainWord(),
  email: faker.internet.email(),
  description: faker.lorem.sentence(),
  photoKey: faker.system.commonFileName(),
  audioKey: faker.system.commonFileName(),
} as User;

export const userProfileFriendsRepositoryMock = {
  _id: faker.database.mongodbObjectId(),
  user: userProfileUserRepositoryResult._id,
  friends: [
    {
      user: faker.database.mongodbObjectId(),
    },
  ],
  requests: [],
} as Friends & Document<any, any, Friends>;

export const userProfileResponseMock: UserProfileResponse = {
  username: userProfileUserRepositoryResult.username,
  description: userProfileUserRepositoryResult.description,
  photo: userProfileUserRepositoryResult.photoKey,
  audio: userProfileUserRepositoryResult.audioKey,
  isFriend: expect.any(Boolean),
  sentFriendRequest: expect.any(Boolean),
  receivedFriendRequest: expect.any(Boolean),
  friendsCount: expect.any(Number),
};
