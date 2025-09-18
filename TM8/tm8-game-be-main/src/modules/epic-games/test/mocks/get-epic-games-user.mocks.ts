import { faker } from '@faker-js/faker';

import { EpicGamesUserResponse } from 'src/modules/epic-games/response/epic-games-user.response';

export const epicGamesUserResponseMock: EpicGamesUserResponse = {
  accountId: faker.string.alpha(10),
  displayName: faker.internet.userName(),
  prefferedLanguage: faker.location.countryCode(),
  linkedAccouns: [],
  country: faker.location.countryCode(),
};

export const getEpicGamesUserInputMock: {
  accessToken: string;
  accountId: string;
} = { accessToken: faker.string.alpha(10), accountId: faker.string.alpha(10) };
