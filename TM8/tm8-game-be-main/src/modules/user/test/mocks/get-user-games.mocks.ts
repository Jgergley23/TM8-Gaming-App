import { faker } from '@faker-js/faker';

import { Game } from 'src/common/constants';
import { GamePreferenceResponse } from 'src/modules/user-game-data/response/game-preference.response';
import { UserGameDataResponse } from 'src/modules/user-game-data/response/user-game-data.response';
import { GamePreferenceValue } from 'src/modules/user-game-data/schemas/game-preference-value.schema';

import { UserGamesResponse } from '../../response/user-games.response';
import { User } from '../../schemas/user.schema';

export const getUserGamesUserResponse = {
  _id: faker.database.mongodbObjectId(),
  username: faker.internet.domainWord(),
  email: faker.internet.email(),
} as User;

export const getUserGamesGameDataResponse: UserGameDataResponse[] = [
  {
    _id: faker.database.mongodbObjectId(),
    game: 'fake-game' as Game,
    user: getUserGamesUserResponse._id,
    preferences: [
      {
        key: 'fake-key',
        title: 'fake-title',
        values: [
          {
            key: 'fake-key',
            selectedValue: 'fake-value',
          } as GamePreferenceValue,
        ] as GamePreferenceResponse[],
      },
    ],
  },
];

export const userGamesResponseMock: UserGamesResponse = {
  userId: getUserGamesUserResponse._id,
  games: [
    { displayName: 'Fake Game', game: getUserGamesGameDataResponse[0].game },
  ],
};
