import { faker } from '@faker-js/faker';

import { Game } from 'src/common/constants';

import { Match } from '../../schemas/match.schema';

export const checkForExistingMatchMock: Match = {
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
