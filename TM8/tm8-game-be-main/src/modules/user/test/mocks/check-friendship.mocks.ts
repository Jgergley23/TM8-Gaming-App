import { faker } from '@faker-js/faker';

import { Friends } from 'src/modules/friends/schemas/friends.schema';

import { CheckFriendshipResponse } from '../../response/check-friendship.response';
import { User } from '../../schemas/user.schema';

export const checkFriendshipUserRepositoryResponse = {
  _id: faker.database.mongodbObjectId(),
  username: faker.internet.domainWord(),
  email: faker.internet.email(),
} as User;

export const checkFriendshipFriendsRepositoryResponse = {
  _id: faker.database.mongodbObjectId(),
  user: faker.database.mongodbObjectId(),
  friends: [{ user: checkFriendshipUserRepositoryResponse._id }],
} as Friends;

export const checkFriendshipResult: CheckFriendshipResponse = {
  isFriend: expect.any(Boolean),
};
