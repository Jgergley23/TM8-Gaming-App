import { faker } from '@faker-js/faker';

import { Role, UserStatusType } from 'src/common/constants';
import { User } from 'src/modules/user/schemas/user.schema';

import { EpicGamesTokenResponse } from '../../../epic-games/response/epic-games-token.response';
import { EpicGamesUserResponse } from '../../../epic-games/response/epic-games-user.response';
import { EpicGamesVerifyInput } from '../../dto/epic-games-verify.input';

export const epicGamesVerifyInputMock: EpicGamesVerifyInput = {
  code: faker.string.alphanumeric(16),
  userId: faker.database.mongodbObjectId(),
};

export const epicGamesTokenResponseMock: EpicGamesTokenResponse = {
  scope: faker.string.alpha(10),
  token_type: faker.string.alpha(10),
  access_token: faker.string.alpha(10),
  refresh_token: faker.string.alpha(10),
  expires_in: faker.number.int(4),
  expires_at: faker.date.recent().toISOString(),
  refresh_expires_in: faker.number.int(5),
  refresh_expires_at: faker.date.recent().toISOString(),
  account_id: faker.string.alpha(10),
  client_id: faker.string.alpha(10),
  application_id: faker.string.alpha(10),
};

export const epicGamesUserResponseMock: EpicGamesUserResponse = {
  accountId: faker.string.alpha(10),
  displayName: faker.internet.userName(),
  prefferedLanguage: faker.location.countryCode(),
  linkedAccouns: [],
  country: faker.location.countryCode(),
};

export const storeEpicDataMock = {
  email: faker.internet.email(),
  username: faker.internet.userName(),
  _id: faker.database.mongodbObjectId(),
  epicGamesUsername: faker.internet.userName(),
  role: Role.User,
  status: { type: UserStatusType.Active },
} as User;
