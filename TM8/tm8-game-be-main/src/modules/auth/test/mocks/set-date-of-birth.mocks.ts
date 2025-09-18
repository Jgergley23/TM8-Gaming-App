/* eslint-disable @typescript-eslint/no-explicit-any */
import { faker } from '@faker-js/faker';
import { Document } from 'mongoose';

import { Role, SignupType } from 'src/common/constants';
import { User } from 'src/modules/user/schemas/user.schema';

import { SetDateOfBirthInput } from '../../dto/set-date-of-birth.input';

export const setDateOfBirthMockResponse = {
  _id: faker.database.mongodbObjectId(),
  email: faker.internet.email(),
  role: Role.User,
  signupType: SignupType.Social,
  googleSub: 'googleSub',
} as User & Document<any, any, User>;

export const setDateOfBirthInputMock: SetDateOfBirthInput = {
  dateOfBirth: '2000-01-01',
};
