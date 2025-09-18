import { faker } from '@faker-js/faker';

import { User } from '../../schemas/user.schema';

export const setUserPhotoUserResponse = {
  _id: faker.database.mongodbObjectId(),
  username: faker.internet.domainWord(),
  email: faker.internet.email(),
  photoKey: 'fake-photo-key',
} as User;

export const setUserPhotoMockPhoto = {
  fieldname: 'file',
  originalname: 'mockfile.txt',
  encoding: '7bit',
  mimetype: 'text/plain',
  size: 512,
  buffer: Buffer.from('mock file content'),
  stream: null,
  destination: '',
  filename: '',
  path: '',
};
