import { faker } from '@faker-js/faker';

import { Game } from 'src/common/constants';
import { UserGameData } from 'src/modules/user-game-data/schemas/user-game-data.schema';

export const sendGamePreferenceReminderNotificationMock: UserGameData[] = [
  {
    _id: faker.database.mongodbObjectId(),
    user: faker.database.mongodbObjectId(),
    game: 'game' as Game,
    preferences: [],
  },
];
