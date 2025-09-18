import { faker } from '@faker-js/faker';

import { Role } from 'src/common/constants';
import { User } from 'src/modules/user/schemas/user.schema';

export const inactiveUsersMock: User[] = [
  {
    _id: faker.database.mongodbObjectId(),
    username: faker.internet.domainWord(),
    email: faker.internet.email(),
    notificationToken: faker.string.alphanumeric(10),
    role: Role.User,
    lastLogin: faker.date.past(),
  } as User,
];
