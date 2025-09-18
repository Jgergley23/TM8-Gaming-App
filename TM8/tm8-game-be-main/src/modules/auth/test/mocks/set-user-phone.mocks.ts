import { faker } from '@faker-js/faker';

import { Role, SignupType, UserStatusType } from 'src/common/constants';
import { User } from 'src/modules/user/schemas/user.schema';

import { SetUserPhoneInput } from '../../dto/set-user-phone.input';

export const setUserPhoneInputMock: SetUserPhoneInput = {
  phoneNumber: faker.phone.number(),
  email: faker.internet.email(),
};

export const setUserPhoneUserResponseMock = {
  _id: faker.database.mongodbObjectId(),
  email: faker.internet.email(),
  password: 'hashedPassword',
  role: Role.User,
  signupType: SignupType.Manual,
  username: 'username',
  name: 'name',
  status: { type: UserStatusType.Active },
  phoneNumber: faker.phone.number(),
  phoneVerified: false,
} as User;

export const userWithVerificationCodeResponseMock = {
  ...setUserPhoneUserResponseMock,
  verificationCode: +faker.number.int(),
} as User;
