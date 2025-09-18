import { faker } from '@faker-js/faker';

import { Friends } from 'src/modules/friends/schemas/friends.schema';

import { User } from '../../schemas/user.schema';

export const blockUserUserRepositoryResponse = {
  _id: faker.database.mongodbObjectId(),
  username: faker.internet.domainWord(),
  email: faker.internet.email(),
} as User;

export const blockUserFriendsRepositoryResponse = {
  _id: faker.database.mongodbObjectId(),
  user: blockUserUserRepositoryResponse._id,
  friends: [],
} as Friends;
