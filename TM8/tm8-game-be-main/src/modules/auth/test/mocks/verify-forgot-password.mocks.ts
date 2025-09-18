/* eslint-disable @typescript-eslint/no-explicit-any */
import { faker } from '@faker-js/faker';
import { Document } from 'mongoose';

import { Role, SignupType } from 'src/common/constants';
import { User } from 'src/modules/user/schemas/user.schema';

import { VerifyCodeInput } from '../../dto/verify-code.input';

export const verifyForgotPasswordMock: VerifyCodeInput = {
  code: faker.number.int({ min: 100000, max: 999999 }),
};

export const verifyForgotPasswordUserResponseMock = {
  _id: faker.database.mongodbObjectId() as string & User,
  email: faker.internet.email(),
  password: 'fake-hashed-password',
  role: Role.Superadmin,
  signupType: SignupType.Manual,
} as unknown as User & Document<User, any, any>;
