/* eslint-disable @typescript-eslint/no-explicit-any */
import { faker } from '@faker-js/faker';
import { Document } from 'mongoose';

import { Role, SignupType } from 'src/common/constants';
import { User } from 'src/modules/user/schemas/user.schema';

import { PhoneVerificationInput } from '../../dto/phone-verification.input';

export const resendCodeInput: PhoneVerificationInput = {
  phoneNumber: faker.phone.number(),
};

export const resendCodeUserRepositoryMock = {
  _id: faker.database.mongodbObjectId() as string & User,
  email: faker.internet.email(),
  phoneNumber: resendCodeInput.phoneNumber,
  username: faker.internet.userName(),
  verifyPhoneRequested: true,
  role: Role.User,
  signupType: SignupType.Manual,
} as unknown as User & Document<User, any, any>;

export const updatedResendCodeUserRepositoryMock = {
  ...resendCodeUserRepositoryMock,
  verificationCode: faker.number.int(6),
};
