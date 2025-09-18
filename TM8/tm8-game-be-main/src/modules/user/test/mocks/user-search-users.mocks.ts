import { faker } from '@faker-js/faker';

import { UserStatusType } from 'src/common/constants';

import { UserSearchResponse } from '../../response/user-search.response';
import { User } from '../../schemas/user.schema';

export const usersSearchResponseMock = [
  {
    _id: faker.database.mongodbObjectId(),
    username: faker.internet.domainWord(),
    email: faker.internet.email(),
    status: { type: UserStatusType.Active, note: '', until: null },
  },
] as User[];

export const userSearchUsersMockResult: UserSearchResponse[] = [
  {
    id: usersSearchResponseMock[0]._id,
    username: usersSearchResponseMock[0].username,
    friend: expect.any(Boolean),
  },
];
