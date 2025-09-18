/* eslint-disable @typescript-eslint/no-explicit-any */

import { faker } from '@faker-js/faker';
import { Document } from 'mongoose';
import { VerifyAppleIdTokenResponse } from 'verify-apple-id-token';

import { Role, SignupType, UserStatusType } from 'src/common/constants';
import { User } from 'src/modules/user/schemas/user.schema';

import { VerifyAppleIdInput } from '../../dto/verify-apple-id.input';
import { AuthResponse } from '../../response/auth.response';

export const verifyAppleIdNoEmailInputMock: VerifyAppleIdInput = {
  token: 'token',
};

export const verifyAppleIdInputMock: VerifyAppleIdInput = {
  token: 'token',
  email: faker.internet.email(),
};

export const verifyAppleTokenResponse = {
  sub: 'appleSub',
} as VerifyAppleIdTokenResponse;

export const existingAppleUserResponse = {
  _id: faker.database.mongodbObjectId(),
  email: faker.internet.email(),
  role: Role.User,
  signupType: SignupType.Social,
  username: 'username',
  name: 'name',
  status: { type: UserStatusType.Active },
  appleSub: 'appleSub',
} as User & Document<any, any, User>;

export const appleVerifyTokenResponseMock: AuthResponse = {
  success: true,
  accessToken: expect.any(String),
  refreshToken: expect.any(String),
  id: existingAppleUserResponse._id,
  role: existingAppleUserResponse.role,
  signupType: existingAppleUserResponse.signupType,
  username: existingAppleUserResponse.username,
  name: existingAppleUserResponse.name,
  chatToken: expect.any(String),
  dateOfBirth: null,
};
