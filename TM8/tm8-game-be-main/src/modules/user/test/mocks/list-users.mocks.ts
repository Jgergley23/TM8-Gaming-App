import { faker } from '@faker-js/faker';

import { Role, UserStatusType } from 'src/common/constants';
import { PaginationMetaResponse } from 'src/common/pagination/pagination-meta.response';
import { PaginationParams } from 'src/common/pagination/pagination-params';
import { PaginationModel } from 'src/common/pagination/paginaton.model';

import { ListUsersInput } from '../../dto/list-users.input';
import { User } from '../../schemas/user.schema';

export const listUsersInputMock = {
  sort: '-createdAt',
  username: '',
  roles: [Role.User],
} as ListUsersInput;

export const paginationParamsMock: PaginationParams = {
  page: 1,
  limit: 10,
  skip: 0,
};

export const usersResponseMock = [
  {
    _id: faker.database.mongodbObjectId(),
    username: faker.internet.domainWord(),
    email: faker.internet.email(),
    status: { type: UserStatusType.Active, note: '', until: null },
  },
] as User[];

export const listUsersResponseMock: PaginationModel<Partial<User>> = {
  items: usersResponseMock,
  meta: {
    page: 1,
    limit: 10,
    itemCount: 1,
    pageCount: 1,
    hasPreviousPage: false,
    hasNextPage: false,
  } as PaginationMetaResponse,
};

export const emptyListUsersResponseMock: PaginationModel<Partial<User>> = {
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
