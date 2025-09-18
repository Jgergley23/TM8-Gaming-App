import { faker } from '@faker-js/faker';
import { Document } from 'mongoose';

import { Game, Playtime } from 'src/common/constants';

import { SetGamePlaytimeInput } from '../../dto/set-game-playtime.input';
import { UserGameData } from '../../schemas/user-game-data.schema';

export const setGamePlaytimePreferenceInput: SetGamePlaytimeInput = {
  playtime: 'fake-playtime' as Playtime,
};

export const setPlaytimeUserGameDataResponse = {
  id: faker.database.mongodbObjectId(),
  user: faker.database.mongodbObjectId(),
  game: Game.RocketLeague,
  preferences: [],
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
} as UserGameData & Document<any, any, UserGameData>;
