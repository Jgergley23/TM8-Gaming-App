/* eslint-disable @typescript-eslint/no-explicit-any */
import { faker } from '@faker-js/faker';
import { Document } from 'mongoose';

import { Game } from 'src/common/constants';
import { GamePreferenceValue } from 'src/common/constants/game-preference-value.enum';
import { UserGameData } from 'src/modules/user-game-data/schemas/user-game-data.schema';

import { SetFortnitePreferencesInput } from '../../dto/set-fortnite-preferences.input';

export const setFortnitePreferenceInput: SetFortnitePreferencesInput = {
  gameModes: [GamePreferenceValue.BattleRoyale],
  teamSizes: [GamePreferenceValue.Duo],
  playingLevel: GamePreferenceValue.Intermediate,
  agression: 3,
  teamWork: 3,
  gameplayStyle: 3,
  rotations: [GamePreferenceValue.CenterCircle],
};

export const fortniteUserGameDataResponse = {
  id: faker.database.mongodbObjectId(),
  user: faker.database.mongodbObjectId(),
  game: Game.Fortnite,
  preferences: [],
} as UserGameData & Document<any, any, UserGameData>;
