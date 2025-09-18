import { faker } from '@faker-js/faker';

import { UserNotificationType } from 'src/common/constants';

import { Notification } from '../../schemas/notification.schema';

export const deleteUserNotificationsMock: Notification[] = [
  {
    _id: faker.database.mongodbObjectId(),
    user: faker.database.mongodbObjectId(),
    since: faker.date.past(),
    until: faker.date.future(),
    data: {
      _id: faker.database.mongodbObjectId(),
      isRead: false,
      title: faker.lorem.sentence(),
      description: faker.lorem.sentence(),
      notificationType: 'fake-type' as UserNotificationType,
      redirectScreen: faker.lorem.sentence(),
    },
  } as Notification,
];
