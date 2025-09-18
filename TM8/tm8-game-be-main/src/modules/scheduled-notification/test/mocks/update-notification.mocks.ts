import { faker } from '@faker-js/faker';

import {
  UserGroup,
  UserNotificationInterval,
  UserNotificationType,
} from 'src/common/constants';

import { UpdateScheduledNotificationInput } from '../../dto/update-scheduled-notification.input';
import { IScheduledNotificationRecord } from '../../interfaces/scheduled-notification.interface';

export const updateNotificationInputMock: UpdateScheduledNotificationInput = {
  title: 'title',
};

export const notificationRepositoryUpdateResponseMock: IScheduledNotificationRecord =
  {
    _id: faker.database.mongodbObjectId(),
    date: faker.date.past(),
    interval: UserNotificationInterval.DoesntRepeat,
    users: [faker.database.mongodbObjectId()],
    data: {
      targetGroup: UserGroup.AllUsers,
      notificationType: UserNotificationType.ExclusiveOffers,
      title: faker.lorem.sentence(),
      description: faker.lorem.sentence(),
      createdAt: faker.date.past(),
      updatedAt: faker.date.past(),
    },
    receivedBy: faker.number.int(),
    openedBy: faker.number.int(),
    uniqueId: faker.string.alphanumeric(7),
  };

export const notificationUpdateResponseMock = {
  ...notificationRepositoryUpdateResponseMock,
  title: 'title',
};

export const updateIndividualNoUserIdNotificationInputMock: UpdateScheduledNotificationInput =
  {
    targetGroup: UserGroup.IndividualUser,
  };

export const updateGroupWithUserIdNotificationInputMock: UpdateScheduledNotificationInput =
  {
    individualUserId: faker.database.mongodbObjectId(),
    targetGroup: UserGroup.AllUsers,
  };
