import { faker } from '@faker-js/faker';

import { Game } from 'src/common/constants';
import { UserGameDataDocument } from 'src/modules/user-game-data/schemas/user-game-data.schema';

export const deleteUserGameResponse = {
  user: faker.database.mongodbObjectId(),
  game: 'game' as Game,
  preferences: [],
} as UserGameDataDocument;
