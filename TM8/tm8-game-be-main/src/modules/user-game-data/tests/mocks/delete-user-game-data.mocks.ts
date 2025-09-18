import { faker } from '@faker-js/faker';

import { Game } from 'src/common/constants';

import { UserGameData } from '../../schemas/user-game-data.schema';

export const deleteUserGameDataFindManyMock = [
  {
    _id: faker.database.mongodbObjectId(),
    game: 'game1' as Game,
    preferences: [],
    user: faker.database.mongodbObjectId(),
  } as UserGameData,
];
