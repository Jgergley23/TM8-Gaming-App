import { faker } from '@faker-js/faker';

import { ICreateMatchNotificationParams } from '../../interfaces/create-match-notification.interface';

export const createMatchNotificationInput: ICreateMatchNotificationParams = {
  currentUser: {
    _id: faker.database.mongodbObjectId(),
    username: faker.internet.userName(),
    photoKey: faker.lorem.word(),
  },
  targetUser: {
    _id: faker.database.mongodbObjectId(),
    username: faker.internet.userName(),
    photoKey: faker.lorem.word(),
  },
  redirectScreen: faker.internet.url(),
};
