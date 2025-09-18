import { faker } from '@faker-js/faker';
import { utc } from 'moment';
import { Document } from 'mongoose';

import { Game } from 'src/common/constants';

import { SetOnlineScheduleInput } from '../../dto/set-online-schedule.input';
import { UserGameData } from '../../schemas/user-game-data.schema';

const startingTimestamp = faker.date.recent();
const endingTimestamp = utc(startingTimestamp).add(1, 'day').toDate();

export const setOnlineSchedulePreferenceInput: SetOnlineScheduleInput = {
  startingTimestamp: startingTimestamp,
  endingTimestamp: endingTimestamp,
};

export const setOnlineScheduleResponse = {
  id: faker.database.mongodbObjectId(),
  user: faker.database.mongodbObjectId(),
  game: Game.RocketLeague,
  preferences: [],
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
} as UserGameData & Document<any, any, UserGameData>;
