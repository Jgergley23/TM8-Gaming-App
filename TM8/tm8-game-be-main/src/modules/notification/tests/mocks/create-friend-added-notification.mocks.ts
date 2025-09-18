import { faker } from '@faker-js/faker';

import { CreateFriendAddedNotificationDto } from '../../dto/create-friend-added-notification.dto';

export const createFriendAddedNotificationInput: CreateFriendAddedNotificationDto =
  {
    friendUsername: faker.internet.userName(),
    recipientId: faker.database.mongodbObjectId(),
    redirectScreen: faker.internet.url(),
  };
