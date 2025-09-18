import { faker } from '@faker-js/faker';

import { User } from '../../schemas/user.schema';

export const updateUsernameCurrentUserResponse = {
  _id: faker.database.mongodbObjectId(),
  username: 'fake-old-username',
  email: faker.internet.email(),
} as User;

export const updateUsernameExistingUserResponse = {
  _id: faker.database.mongodbObjectId(),
  username: 'fake-existing-username',
  email: faker.internet.email(),
} as User;
