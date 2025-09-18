import { UserGroup, UserNotificationType } from 'src/common/constants';

export interface IScheduledNotificationData {
  targetGroup: UserGroup;
  notificationType: UserNotificationType;
  title: string;
  description: string;
  redirectScreen?: string;
}

export interface IScheduledNotificationDataRecord
  extends IScheduledNotificationData {
  createdAt?: Date;
  updatedAt?: Date;
}
