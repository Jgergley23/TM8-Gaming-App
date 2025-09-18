import { faker } from '@faker-js/faker';

import { Game } from 'src/common/constants';
import { GamePreferenceResponse } from 'src/modules/user-game-data/response/game-preference.response';
import { UserGameDataResponse } from 'src/modules/user-game-data/response/user-game-data.response';
import { GamePreferenceValue } from 'src/modules/user-game-data/schemas/game-preference-value.schema';

import { GetGamePreferencesParams } from '../../dto/get-game-preferences.params';
import { GetUserByIdParams } from '../../dto/user-by-id.params';

export const getUserGamePreferencesParamMock: GetUserByIdParams = {
  userId: faker.database.mongodbObjectId(),
};

export const getUserGamePreferencesParams: GetGamePreferencesParams = {
  games: 'fake-game',
};

export const getUserGamePreferencesResultMock: UserGameDataResponse[] = [
  {
    _id: faker.database.mongodbObjectId(),
    game: 'fake-game' as Game,
    user: faker.database.mongodbObjectId(),
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
