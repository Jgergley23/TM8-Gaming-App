import { faker } from '@faker-js/faker';

import { UserNoteInput } from '../../dto/user-note.input';
import { User } from '../../schemas/user.schema';

export const userNoteInputMock: UserNoteInput = {
  note: faker.lorem.sentence(),
};

export const setUserNoteResponseMock: User = {
  _id: faker.database.mongodbObjectId(),
  note: faker.lorem.sentence(),
} as User;

export const setUserNoteUpdatedMock: User = {
  _id: faker.database.mongodbObjectId(),
  note: faker.lorem.sentence(),
} as User;
