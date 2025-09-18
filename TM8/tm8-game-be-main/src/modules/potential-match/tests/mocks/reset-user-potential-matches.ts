import { faker } from '@faker-js/faker';

import { Game, UserMatchChoice } from 'src/common/constants';

import { PotentialMatch } from '../../schemas/potential-match.schema';

export const userPotentialMatchesResponseMock: PotentialMatch[] = [
  {
    _id: faker.database.mongodbObjectId(),
    game: 'fake-game' as Game,
    users: [
      {
        _id: faker.database.mongodbObjectId(),
        user: faker.database.mongodbObjectId(),
        choice: 'fake-choice' as UserMatchChoice,
      },
      {
        _id: faker.database.mongodbObjectId(),
        user: faker.database.mongodbObjectId(),
        choice: 'fake-choice' as UserMatchChoice,
      },
    ],
  },
];
