import { faker } from '@faker-js/faker';

import { User } from '../../schemas/user.schema';

export const setUserAudioIntroUserResponse = {
  _id: faker.database.mongodbObjectId(),
  username: faker.internet.domainWord(),
  email: faker.internet.email(),
  photoKey: 'fake-photo-key',
} as User;

export const setUserAudioIntroMockAudio = {
  fieldname: 'file',
  originalname: 'mockfile.mp3',
  encoding: '7bit',
  mimetype: 'text/plain',
  size: 512,
  buffer: Buffer.from('mock file content'),
  stream: null,
  destination: '',
  filename: '',
  path: '',
};
