import { faker } from '@faker-js/faker';

import { Role, SignupType, UserStatusType } from 'src/common/constants';
import { User } from 'src/modules/user/schemas/user.schema';

import { AuthLoginInput } from '../../dto/login.input';
import { AuthResponse } from '../../response/auth.response';

export const loginDtoMock: AuthLoginInput = {
  email: faker.internet.email(),
  password: faker.internet.password(),
};

export const userResponseMock = {
  _id: faker.database.mongodbObjectId(),
  email: faker.internet.email(),
  password: 'hashedPassword',
  role: Role.User,
  signupType: SignupType.Manual,
  username: 'username',
  name: 'name',
  status: { type: UserStatusType.Active },
  phoneNumber: faker.phone.number(),
  phoneVerified: true,
} as User;

export const tokenResponseMock: AuthResponse = {
  success: true,
  accessToken: expect.any(String),
  refreshToken: expect.any(String),
  id: userResponseMock._id,
  role: userResponseMock.role,
  signupType: userResponseMock.signupType,
  username: userResponseMock.username,
  name: userResponseMock.name,
};
