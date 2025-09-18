/* eslint-disable @typescript-eslint/no-explicit-any */
import { faker } from '@faker-js/faker';
import { Document } from 'mongoose';

import { Role, SignupType } from 'src/common/constants';
import { User } from 'src/modules/user/schemas/user.schema';

import { ResetPasswordInput } from '../../dto/reset-password.input';
import { AuthResponse } from '../../response/auth.response';

export const resetPasswordMock: ResetPasswordInput = {
  email: faker.internet.email(),
  password: faker.internet.password(),
};

export const resetPasswordUserResponseMock = {
  _id: 'id' as string & User,
  email: faker.internet.email(),
  password: 'fake-hashed-password',
  role: Role.Superadmin,
  signupType: SignupType.Manual,
  username: faker.internet.userName(),
  name: faker.person.fullName(),
} as unknown as User & Document<User, any, any>;

export const resetPasswordTokenResponseMock = {
  success: true,
  accessToken: expect.any(String),
  refreshToken: expect.any(String),
  username: resetPasswordUserResponseMock.username,
  name: resetPasswordUserResponseMock.name,
  id: resetPasswordUserResponseMock._id,
  role: resetPasswordUserResponseMock.role,
  signupType: resetPasswordUserResponseMock.signupType,
  chatToken: expect.any(String),
} as AuthResponse;
