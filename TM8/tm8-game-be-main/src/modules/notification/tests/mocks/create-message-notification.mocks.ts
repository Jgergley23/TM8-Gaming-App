import { faker } from '@faker-js/faker';

import { CreateMessageNotificationDto } from '../../dto/create-message-notification.dto';

export const createMessageNotificationInput: CreateMessageNotificationDto = {
  senderUsername: faker.internet.userName(),
  message: faker.lorem.sentence(),
  recipientId: faker.database.mongodbObjectId(),
  redirectScreen: faker.internet.url(),
};
