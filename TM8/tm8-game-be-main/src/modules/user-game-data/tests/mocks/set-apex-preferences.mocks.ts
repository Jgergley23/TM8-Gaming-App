/* eslint-disable @typescript-eslint/no-explicit-any */
import { faker } from '@faker-js/faker';
import { Document } from 'mongoose';

import { Game } from 'src/common/constants';
import { GamePreferenceValue } from 'src/common/constants/game-preference-value.enum';
import { UserGameData } from 'src/modules/user-game-data/schemas/user-game-data.schema';

import { SetApexLegendsPreferencesInput } from '../../dto/set-apex-legends-preferences.input';

export const setApexLegendsPreferenceInput: SetApexLegendsPreferencesInput = {
  types: [GamePreferenceValue.BattleRoyale],
  classifications: [GamePreferenceValue.BattleRoyale],
  mixtapeTypes: [GamePreferenceValue.BattleRoyale],
  teamSizes: [GamePreferenceValue.Squad],
  playingLevel: GamePreferenceValue.Intermediate,
  rotations: [GamePreferenceValue.CenterCircle],
  agression: 4,
  teamWork: 3,
  gameplayStyle: 3,
};

export const apexUserGameDataResponse = {
  id: faker.database.mongodbObjectId(),
  user: faker.database.mongodbObjectId(),
  game: Game.ApexLegends,
  preferences: [],
} as UserGameData & Document<any, any, UserGameData>;
