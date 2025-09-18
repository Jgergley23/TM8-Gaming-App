import { faker } from '@faker-js/faker';

import {
  UserGroup,
  UserNotificationInterval,
  UserNotificationType,
} from 'src/common/constants';
import { PaginationMetaResponse } from 'src/common/pagination/pagination-meta.response';
import { PaginationParams } from 'src/common/pagination/pagination-params';
import { PaginationModel } from 'src/common/pagination/paginaton.model';

import { ListNotificationsInput } from '../../dto/list-notifications-input';
import { IScheduledNotificationRecord } from '../../interfaces/scheduled-notification.interface';
import { ScheduledNotification } from '../../schemas/scheduled-notification.schema';

export const listNotificationsInputMock: ListNotificationsInput = {
  sort: '-title',
  title: '',
};

export const notificationPaginationParamsMock: PaginationParams = {
  page: 1,
  limit: 10,
  skip: 0,
};

export const notificationResponseMock: IScheduledNotificationRecord[] = [
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
  },
];

export const listNotificationsResponseMock: PaginationModel<ScheduledNotification> =
  {
    items: notificationResponseMock,
    meta: {
      page: 1,
      limit: 10,
      itemCount: 1,
      pageCount: 1,
      hasPreviousPage: false,
      hasNextPage: false,
    } as PaginationMetaResponse,
  };

export const emptyListNotificationsResponseMock: PaginationModel<ScheduledNotification> =
  {
    items: null,
    meta: {
      page: 1,
      limit: 10,
      itemCount: 0,
      pageCount: 0,
      hasPreviousPage: false,
      hasNextPage: false,
    } as PaginationMetaResponse,
  };
