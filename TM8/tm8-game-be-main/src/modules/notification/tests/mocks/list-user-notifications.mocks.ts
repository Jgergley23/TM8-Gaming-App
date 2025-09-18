import { faker } from '@faker-js/faker';

import { UserNotificationType } from 'src/common/constants';
import { PaginationMetaResponse } from 'src/common/pagination/pagination-meta.response';
import { PaginationParams } from 'src/common/pagination/pagination-params';
import { PaginationModel } from 'src/common/pagination/paginaton.model';

import { Notification } from '../../schemas/notification.schema';

export const listUserNotificationsPaginationParams: PaginationParams = {
  limit: 10,
  page: 1,
  skip: 0,
};

export const emptyListUserNotificationsResponseMock: PaginationModel<
  Partial<Notification>
> = {
  items: [],
  meta: {
    page: 1,
    limit: 10,
    itemCount: 0,
    pageCount: 0,
    hasPreviousPage: false,
    hasNextPage: false,
  } as PaginationMetaResponse,
};

export const userNotificationsResponseMock = [
  {
    _id: faker.database.mongodbObjectId(),
    user: faker.database.mongodbObjectId(),
    since: faker.date.past(),
    until: faker.date.future(),
    data: {
      isRead: false,
      title: faker.lorem.sentence(),
      description: faker.lorem.sentence(),
      notificationType: 'fake-type' as UserNotificationType,
      redirectScreen: faker.lorem.sentence(),
    },
  },
] as Notification[];

export const listUserNotificationsResponseMock: PaginationModel<
  Partial<Notification>
> = {
  items: userNotificationsResponseMock,
  meta: {
    page: 1,
    limit: 10,
    itemCount: 1,
    pageCount: 1,
    hasPreviousPage: false,
    hasNextPage: false,
  } as PaginationMetaResponse,
};
