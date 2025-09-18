/* eslint-disable @typescript-eslint/no-explicit-any */
import { faker } from '@faker-js/faker';
import { Document } from 'mongoose';

import { Game } from 'src/common/constants';
import { Friends } from 'src/modules/friends/schemas/friends.schema';
import { UserGameDataResponse } from 'src/modules/user-game-data/response/user-game-data.response';

import { GetMeUserResponse } from '../../response/get-me-user.response';
import { User } from '../../schemas/user.schema';

export const getMeUserResponse = {
  _id: faker.database.mongodbObjectId(),
  username: faker.internet.domainWord(),
  email: faker.internet.email(),
  photoKey: 'fake-photo-key',
  audioKey: 'fake-audio-key',
  description: faker.lorem.sentence(),
  notificationSettings: {
    enabled: true,
    match: true,
    message: true,
    friendAdded: true,
    news: true,
    reminders: true,
  },
} as User;

export const getMeUserFriendsRepositoryMock = {
  _id: faker.database.mongodbObjectId(),
  user: getMeUserResponse._id,
  friends: [
    {
      user: faker.database.mongodbObjectId(),
    },
  ],
} as Friends & Document<any, any, Friends>;

export const getMeUserGamesGameDataResponse: UserGameDataResponse[] = [
  {
    _id: faker.database.mongodbObjectId(),
    game: Game.CallOfDuty,
    user: getMeUserResponse._id,
    preferences: [],
  },
];

export const getMeResponse: GetMeUserResponse = {
  id: getMeUserResponse._id,
  email: getMeUserResponse.email,
  username: getMeUserResponse.username,
  photoKey: getMeUserResponse.photoKey,
  audioKey: getMeUserResponse.audioKey,
  games: ['Call Of Duty'],
  friends: 1,
  description: getMeUserResponse.description,
  notificationSettings: {
    enabled: true,
    match: true,
    message: true,
    friendAdded: true,
    news: true,
    reminders: true,
  },
};
