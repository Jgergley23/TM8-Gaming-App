import { faker } from '@faker-js/faker';
import { Request } from 'express';

import { User } from 'src/modules/user/schemas/user.schema';

import { AuthResponse } from '../../response/auth.response';

export const refreshUserResponseMock = {
  _id: faker.database.mongodbObjectId() as string & User,
  email: faker.internet.email(),
  refreshToken: 'refresh-token',
};

export const refreshTokenResponseMock: AuthResponse = {
  success: true,
  accessToken: expect.any(String),
  refreshToken: expect.any(String),
};

export const correctRefreshTokensInputMock = {
  user: {
    sub: faker.database.mongodbObjectId(),
    refreshToken: 'refresh-token',
  },
} as unknown as Request;

export const incorrectRefreshTokensInputMock = {
  user: {
    sub: faker.database.mongodbObjectId(),
    refreshToken: 'fake-token',
  },
} as unknown as Request;
