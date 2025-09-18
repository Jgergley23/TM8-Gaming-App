/* eslint-disable @typescript-eslint/no-explicit-any */
import { faker } from '@faker-js/faker';
import { Document } from 'mongoose';

import { Game, Role, SignupType, UserStatusType } from 'src/common/constants';
import { UserGameDataDocument } from 'src/modules/user-game-data/schemas/user-game-data.schema';

import { User } from '../../schemas/user.schema';

export const addUserGameUserResponse = {
  _id: faker.database.mongodbObjectId(),
  email: faker.internet.email(),
  role: Role.User,
  signupType: SignupType.Manual,
  username: 'username',
  name: 'name',
  status: { type: UserStatusType.Active },
} as User & Document<any, any, User>;

export const addUserGameResponse = {
  user: addUserGameUserResponse._id,
  game: 'game' as Game,
  preferences: [],
} as UserGameDataDocument;
