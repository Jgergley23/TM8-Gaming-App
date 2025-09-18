import { Gender, Region, Role, SignupType } from 'src/common/constants';

import { UserNotificationSettings } from '../schemas/user-notification-settings.schema';
import { UserRating } from '../schemas/user-rating.schema';
import { RejectedUser } from '../schemas/user-rejected-user.schema';
import { UserStatus } from '../schemas/user-status.schema';

export interface IUser {
  name?: string;
  username?: string;
  email: string;
  phoneNumber?: string;
  role: Role;
  country?: string;
  dateOfBirth?: Date;
  verificationCode?: number;
  password?: string;
  gender?: Gender;
  refreshToken?: string;
  resetPasswordRequested?: boolean;
  resetPasswordConfirmed?: boolean;
  signupType?: SignupType;
  newEmail?: string;
  resetEmailRequested?: boolean;
  verifyPhoneRequested?: boolean;
  status: UserStatus;
  timezone?: string;
  note?: string;
  photoKey?: string;
  audioKey?: string;
  lastLogin?: Date;
  epicGamesUsername?: string;
  phoneVerified?: boolean;
  appleSub?: string;
  googleSub?: string;
  chatToken?: string;
  description?: string;
  emailChangeCode?: string;
  changeEmailRequested?: boolean;
  language?: string;
  regions?: Region[];
  notificationToken?: string;
  notificationSettings: UserNotificationSettings;
  rejectedUsers?: RejectedUser[];
  rating?: UserRating;
}

export interface IUserRecord extends IUser {
  _id: string;
  createdAt?: Date;
  updatedAt?: Date;
}
