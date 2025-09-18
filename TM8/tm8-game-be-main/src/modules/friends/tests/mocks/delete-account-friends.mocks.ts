import { faker } from '@faker-js/faker';

import { Friends } from '../../schemas/friends.schema';

export const findFriendsRepositoryMock = {
  _id: faker.database.mongodbObjectId(),
  user: faker.database.mongodbObjectId(),
  friends: [
    {
      _id: faker.database.mongodbObjectId(),
      user: faker.database.mongodbObjectId(),
    },
  ],
  requests: [],
} as Friends;

export const findFriendFriendsRepositoryMock = [
  {
    _id: faker.database.mongodbObjectId(),
    user: faker.database.mongodbObjectId(),
    friends: [
      {
        _id: faker.database.mongodbObjectId(),
        user: faker.database.mongodbObjectId(),
      },
    ],
    requests: [],
  },
] as Friends[];
