import { faker } from '@faker-js/faker';

import { User } from '../../schemas/user.schema';

export const unblockUserUserRepositoryResponse = [
  {
    _id: faker.database.mongodbObjectId(),
    username: faker.internet.domainWord(),
    email: faker.internet.email(),
  },
] as User[];
