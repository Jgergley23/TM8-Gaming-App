import { faker } from '@faker-js/faker';
import { Document } from 'mongoose';

import { Game } from 'src/common/constants';
import { User } from 'src/modules/user/schemas/user.schema';

import { Match } from '../../schemas/match.schema';

export const giveMatchUserFeedbackConflictMock: Match = {
  _id: faker.database.mongodbObjectId(),
  players: [
    {
      _id: faker.database.mongodbObjectId(),
      user: faker.database.mongodbObjectId(),
      feedback: faker.number.int({ min: 1, max: 5 }),
    },
    {
      _id: faker.database.mongodbObjectId(),
      user: faker.database.mongodbObjectId(),
      feedback: faker.number.int({ min: 1, max: 5 }),
    },
  ],
  game: faker.lorem.word() as Game,
};

export const giveMatchUserFeedbackMock: Match = {
  _id: faker.database.mongodbObjectId(),
  players: [
    {
      _id: faker.database.mongodbObjectId(),
      user: faker.database.mongodbObjectId(),
      feedback: null,
    },
    {
      _id: faker.database.mongodbObjectId(),
      user: faker.database.mongodbObjectId(),
      feedback: null,
    },
  ],
  game: faker.lorem.word() as Game,
};

export const giveMatchFeedbackUserMock = {
  _id: faker.database.mongodbObjectId(),
  rating: { ratings: [], average: 0 },
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
} as User & Document<any, any, User>;
