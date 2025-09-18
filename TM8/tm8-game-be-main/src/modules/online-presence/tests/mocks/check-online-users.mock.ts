import { faker } from '@faker-js/faker';

export const onlineUserId = faker.database.mongodbObjectId();
export const offlineUserId = faker.database.mongodbObjectId();

export const onlineUsersSetMock = [onlineUserId];
