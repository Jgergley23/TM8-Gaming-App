/* eslint-disable @typescript-eslint/no-explicit-any */
import { faker } from '@faker-js/faker';
import { Document } from 'mongoose';

import { Game } from 'src/common/constants';
import { GamePreferenceValue } from 'src/common/constants/game-preference-value.enum';
import { UserGameData } from 'src/modules/user-game-data/schemas/user-game-data.schema';

import { SetCallOfDutyPreferencesInput } from '../../dto/set-call-of-duty-preferences.input';

export const setCallOfDutyPreferenceInput: SetCallOfDutyPreferencesInput = {
  gameModes: [GamePreferenceValue.BattleRoyale],
  teamSizes: [GamePreferenceValue.Squad],
  playingLevel: GamePreferenceValue.Intermediate,
  rotations: [GamePreferenceValue.CenterCircle],
  agression: 4,
  teamWork: 3,
  gameplayStyle: 3,
};

export const codUserGameDataResponse = {
  id: faker.database.mongodbObjectId(),
  user: faker.database.mongodbObjectId(),
  game: Game.CallOfDuty,
  preferences: [],
} as UserGameData & Document<any, any, UserGameData>;
