import { faker } from '@faker-js/faker';

import { ActionType } from 'src/common/constants';
import { PaginationMetaResponse } from 'src/common/pagination/pagination-meta.response';
import { PaginationParams } from 'src/common/pagination/pagination-params';
import { PaginationModel } from 'src/common/pagination/paginaton.model';
import { IActionRecord } from 'src/modules/action/interfaces/action.interface';

import { User } from '../../schemas/user.schema';

export const listBlocksParamsMock: PaginationParams = {
  page: 1,
  limit: 10,
  skip: 0,
};

export const emptyListBlocksResponseMock: PaginationModel<Partial<User>> = {
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

export const blockedUsersResponseMock = [
  {
    _id: faker.database.mongodbObjectId(),
    username: faker.internet.domainWord(),
  },
] as User[];

export const blockedUsersListResponseMock: PaginationModel<Partial<User>> = {
  items: blockedUsersResponseMock,
  meta: {
    page: 1,
    limit: 10,
    itemCount: 1,
    pageCount: 1,
    hasPreviousPage: false,
    hasNextPage: false,
  } as PaginationMetaResponse,
};

export const blockedUsersRepositoryResponseMock: IActionRecord = {
  _id: faker.database.mongodbObjectId(),
  user: faker.database.mongodbObjectId(),
  actionType: ActionType.Block,
  actionsFrom: [],
  actionsTo: [
    {
      user: blockedUsersResponseMock[0]._id,
      createdAt: faker.date.recent(),
    },
  ],
};
