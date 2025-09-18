/* eslint-disable @typescript-eslint/no-explicit-any */
import { faker } from '@faker-js/faker';
import { Document } from 'mongoose';

import { Game } from 'src/common/constants';
import { GamePreferenceValue } from 'src/common/constants/game-preference-value.enum';
import { UserGameData } from 'src/modules/user-game-data/schemas/user-game-data.schema';

import { SetRocketLeaguePreferencesInput } from '../../dto/set-rocket-league-preferences.input';

export const setRocketLeaguePreferenceInput: SetRocketLeaguePreferencesInput = {
  gameModes: [GamePreferenceValue.BattleRoyale],
  teamSizes: [GamePreferenceValue.Squad],
  playingLevel: GamePreferenceValue.Intermediate,
  playStyle: GamePreferenceValue.DemoHeavy,
  gameplays: [GamePreferenceValue.MidScorer],
};

export const rocketLeagueUserGameDataResponse = {
  id: faker.database.mongodbObjectId(),
  user: faker.database.mongodbObjectId(),
  game: Game.RocketLeague,
  preferences: [],
} as UserGameData & Document<any, any, UserGameData>;
