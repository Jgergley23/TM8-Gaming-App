import { faker } from '@faker-js/faker';

import {
  UserGroup,
  UserNotificationInterval,
  UserNotificationType,
} from 'src/common/constants';

import { CreateScheduledNotificationInput } from '../../dto/create-scheduled-notification.input';
import { IScheduledNotificationRecord } from '../../interfaces/scheduled-notification.interface';
import { ScheduledNotification } from '../../schemas/scheduled-notification.schema';

export const createIndividualNoUserIdNotificationInputMock: CreateScheduledNotificationInput =
  {
    title: 'Test Title',
    description: 'Test Description',
    redirectScreen: 'Test Redirect Screen',
    notificationType: UserNotificationType.Other,
    date: new Date().toISOString(),
    interval: UserNotificationInterval.DoesntRepeat,
    targetGroup: UserGroup.IndividualUser,
  };

export const createGroupWithUserIdNotificationInputMock: CreateScheduledNotificationInput =
  {
    title: 'Test Title',
    description: 'Test Description',
    redirectScreen: 'Test Redirect Screen',
    notificationType: UserNotificationType.Other,
    individualUserId: faker.database.mongodbObjectId(),
    date: new Date().toISOString(),
    interval: UserNotificationInterval.DoesntRepeat,
    targetGroup: UserGroup.AllUsers,
  };

export const createIndividualNotificationInputMock: CreateScheduledNotificationInput =
  {
    title: faker.lorem.sentence(),
    description: faker.lorem.sentence(),
    notificationType: UserNotificationType.Other,
    individualUserId: faker.database.mongodbObjectId(),
    date: new Date().toISOString(),
    interval: UserNotificationInterval.DoesntRepeat,
    targetGroup: UserGroup.IndividualUser,
  };

export const createGroupNotificationInputMock: CreateScheduledNotificationInput =
  {
    title: faker.lorem.sentence(),
    description: faker.lorem.sentence(),
    notificationType: UserNotificationType.Other,
    date: new Date().toISOString(),
    interval: UserNotificationInterval.DoesntRepeat,
    targetGroup: UserGroup.AllUsers,
  };

export const createdIndividualNotificationObject: IScheduledNotificationRecord =
  {
    _id: faker.database.mongodbObjectId(),
    uniqueId: faker.string.alphanumeric(7),
    openedBy: faker.number.int(),
    receivedBy: faker.number.int(),
    date: new Date(),
    interval: UserNotificationInterval.DoesntRepeat,
    users: [createIndividualNotificationInputMock.individualUserId],
    data: {
      targetGroup: UserGroup.IndividualUser,
      notificationType: UserNotificationType.Other,
      title: createIndividualNotificationInputMock.title,
      description: createIndividualNotificationInputMock.description,
    },
  } as ScheduledNotification;

export const userIdArrayMock = [
  faker.database.mongodbObjectId(),
  faker.database.mongodbObjectId(),
];

export const createdGroupNotificationObject: IScheduledNotificationRecord = {
  _id: faker.database.mongodbObjectId(),
  uniqueId: faker.string.alphanumeric(7),
  openedBy: faker.number.int(),
  receivedBy: faker.number.int(),
  date: new Date(),
  interval: UserNotificationInterval.DoesntRepeat,
  users: userIdArrayMock,
  data: {
    targetGroup: UserGroup.AllUsers,
    notificationType: UserNotificationType.Other,
    title: createIndividualNotificationInputMock.title,
    description: createIndividualNotificationInputMock.description,
  },
} as ScheduledNotification;
