import { faker } from '@faker-js/faker';

import { Gender, Role, SignupType, UserStatusType } from 'src/common/constants';

import { IUserRecord } from '../../interface/user.interface';

export const deleteOneIncorrectResponseMock = [
  {
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
  },
] as IUserRecord[];

export const deleteOneCorrectResponseMock = [
  {
    ...deleteOneIncorrectResponseMock[0],
    role: Role.Admin,
  },
] as IUserRecord[];

export const deleteUserIds: string[] = [faker.database.mongodbObjectId()];
