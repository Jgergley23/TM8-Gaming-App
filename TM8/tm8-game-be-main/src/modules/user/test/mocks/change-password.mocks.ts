/* eslint-disable @typescript-eslint/no-explicit-any */
import { Document } from 'mongoose';

import { User } from '../../schemas/user.schema';

export const changePasswordUserResponseMock = {
  _id: 'id' as string & User,
  password: 'fake-hashed-password',
} as unknown as User & Document<User, any, any>;
