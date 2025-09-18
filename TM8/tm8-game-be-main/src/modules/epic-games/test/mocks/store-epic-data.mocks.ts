/* eslint-disable @typescript-eslint/no-explicit-any */
import { faker } from '@faker-js/faker';
import { Document } from 'mongoose';

import { Role, UserStatusType } from 'src/common/constants';
import { EpicGamesUserResponse } from 'src/modules/epic-games/response/epic-games-user.response';
import { User } from 'src/modules/user/schemas/user.schema';

export const userId = faker.database.mongodbObjectId();
export const storeEpicGameDataInputMock: EpicGamesUserResponse = {
  accountId: faker.string.alpha(10),
  displayName: faker.internet.userName(),
  prefferedLanguage: faker.location.countryCode(),
  linkedAccouns: [],
  country: faker.location.countryCode(),
};

export const storeEpicDataUserResponseMock = {
  email: faker.internet.email(),
  username: faker.internet.userName(),
  _id: faker.database.mongodbObjectId() as string & User,
  epicGamesUsername: faker.internet.userName(),
  role: Role.User,
  status: { type: UserStatusType.Active },
} as unknown as User & Document<User, any, any>;
