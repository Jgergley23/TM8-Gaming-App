/* eslint-disable @typescript-eslint/no-explicit-any */
import { faker } from '@faker-js/faker';
import { Document } from 'mongoose';

import { Role, SignupType } from 'src/common/constants';
import { User } from 'src/modules/user/schemas/user.schema';

import { ForgotPasswordInput } from '../../dto/forgot-password.input';

export const forgotPasswordEmailMock: ForgotPasswordInput = {
  email: faker.internet.email(),
};

export const forgotPasswordPhoneMock: ForgotPasswordInput = {
  phoneNumber: faker.phone.number(),
};

export const forgotPasswordUserResponseMock = {
  _id: faker.database.mongodbObjectId() as string & User,
  email: faker.internet.email(),
  password: 'fake-hashed-password',
  role: Role.Superadmin,
  signupType: SignupType.Manual,
} as unknown as User & Document<User, any, any>;
