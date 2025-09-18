import { faker } from '@faker-js/faker';

import { CreateAdminInput } from '../../dto/create-admin.input';
import { IUserRecord } from '../../interface/user.interface';
import { UserDocument } from '../../schemas/user.schema';

export const createAdminInputMock: CreateAdminInput = {
  email: faker.internet.email(),
  fullName: faker.person.fullName(),
};

export const existingUserMock = {
  email: faker.internet.email(),
} as IUserRecord;

export const createdUserMock = {
  email: faker.internet.email(),
} as UserDocument;
