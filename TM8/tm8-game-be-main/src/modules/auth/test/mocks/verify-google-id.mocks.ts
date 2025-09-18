/* eslint-disable @typescript-eslint/no-explicit-any */
import { faker } from '@faker-js/faker';
import { TokenInfo } from 'google-auth-library';
import { Document } from 'mongoose';

import { Role, SignupType, UserStatusType } from 'src/common/constants';
import { User } from 'src/modules/user/schemas/user.schema';

import { VerifyGoogleIdInput } from '../../dto/verify-google-id.input';
import { AuthResponse } from '../../response/auth.response';

export const verifyGoogleIdInputMock: VerifyGoogleIdInput = {
  token: 'token',
  fullName: faker.person.fullName(),
};

export const verifyGoogleTokenResponse = {
  sub: 'appleSub',
  email: faker.internet.email(),
} as TokenInfo;

export const existingGoogleUserResponse = {
  _id: faker.database.mongodbObjectId(),
  email: faker.internet.email(),
  role: Role.User,
  signupType: SignupType.Social,
  username: 'username',
  name: 'name',
  status: { type: UserStatusType.Active },
  googleSub: 'googleSub',
  chatToken: 'token',
} as User & Document<any, any, User>;

export const googleVerifyTokenResponseMock: AuthResponse = {
  success: true,
  accessToken: expect.any(String),
  refreshToken: expect.any(String),
  id: existingGoogleUserResponse._id,
  role: existingGoogleUserResponse.role,
  signupType: existingGoogleUserResponse.signupType,
  username: existingGoogleUserResponse.username,
  name: existingGoogleUserResponse.name,
  dateOfBirth: null,
  chatToken: existingGoogleUserResponse.chatToken,
};
