import { faker } from '@faker-js/faker';

import { Gender, Role, SignupType, UserStatusType } from 'src/common/constants';

import { User } from '../../schemas/user.schema';

export const findOneMock: string = faker.database.mongodbObjectId();

export const findOneResponseMock = {
  _id: faker.database.mongodbObjectId(),
  name: faker.person.fullName(),
  email: faker.internet.email(),
  role: Role.User,
  gender: Gender.Male,
  signupType: SignupType.Manual,
  status: {
    type: UserStatusType.Active,
    note: '',
    until: null,
  },
  createdAt: faker.date.anytime(),
  updatedAt: faker.date.anytime(),
} as unknown as User;
