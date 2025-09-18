import { faker } from '@faker-js/faker';

import { CreateCallNotificationDto } from '../../dto/create-call-notification.dto';

export const createCallNotificationInput: CreateCallNotificationDto = {
  callerUsername: faker.internet.userName(),
  recipientId: faker.database.mongodbObjectId(),
  redirectScreen: faker.internet.url(),
};
