import { User } from 'src/modules/user/schemas/user.schema';

export interface ICreateMatchNotificationParams {
  currentUser: Pick<User, '_id' | 'username' | 'photoKey'>;
  targetUser: Pick<User, '_id' | 'username' | 'photoKey'>;
  redirectScreen: string;
}
