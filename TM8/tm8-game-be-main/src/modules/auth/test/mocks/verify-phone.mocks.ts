/* eslint-disable @typescript-eslint/no-explicit-any */
import { faker } from '@faker-js/faker';
import { Document } from 'mongoose';

import { Role, SignupType, UserStatusType } from 'src/common/constants';
import { User } from 'src/modules/user/schemas/user.schema';

import { VerifyCodeInput } from '../../dto/verify-code.input';
import { AuthResponse } from '../../response/auth.response';

export const verifyPhoneInput: VerifyCodeInput = {
  code: faker.number.int(5),
};

export const verifyPhoneUserRepositoryMock = {
  _id: faker.database.mongodbObjectId() as string & User,
  email: faker.internet.email(),
  phoneNumber: faker.phone.number(),
  username: faker.internet.userName(),
  verificationCode: faker.number.int(5),
  verifyPhoneRequested: true,
  role: Role.User,
  signupType: SignupType.Manual,
} as unknown as User & Document<User, any, any>;

export const updatedVerifyPhoneUserRepositoryMock = {
  ...verifyPhoneUserRepositoryMock,
  verifyPhoneRequested: undefined,
  verificationCode: undefined,
  status: { type: UserStatusType.Active, note: '', until: null },
};

export const verifyPhoneTokenResponseMock = {
  success: true,
  accessToken: expect.any(String),
  refreshToken: expect.any(String),
} as AuthResponse;

export const verifyPhoneResponseMock = {
  success: true,
  accessToken: expect.any(String),
  refreshToken: expect.any(String),
  chatToken: expect.any(String),
  username: updatedVerifyPhoneUserRepositoryMock.username,
  name: updatedVerifyPhoneUserRepositoryMock.name,
  id: updatedVerifyPhoneUserRepositoryMock._id,
  role: updatedVerifyPhoneUserRepositoryMock.role,
  signupType: updatedVerifyPhoneUserRepositoryMock.signupType,
} as AuthResponse;
