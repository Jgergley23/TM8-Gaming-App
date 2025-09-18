import { faker } from '@faker-js/faker';

import { UserDocument } from 'src/modules/user/schemas/user.schema';

import { RegisterInput } from '../../dto/register-input';

export const registerInput: RegisterInput = {
  email: faker.internet.email(),
  password: faker.internet.password(),
  username: faker.internet.userName(),
  dateOfBirth: faker.date.past().toString(),
  timezone: 'EST+01',
  country: 'USA',
};

export const userRegisteredResponse = {
  email: registerInput.email,
  username: registerInput.username,
  dateOfBirth: new Date(registerInput.dateOfBirth),
  verificationCode: +faker.string.alphanumeric(),
} as UserDocument;
