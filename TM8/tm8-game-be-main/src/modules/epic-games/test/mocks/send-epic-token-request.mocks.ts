import { faker } from '@faker-js/faker';

import { EpicGamesTokenResponse } from 'src/modules/epic-games/response/epic-games-token.response';

export const sendEpicTokenRequestInputMock = faker.string.alphanumeric(10);

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
