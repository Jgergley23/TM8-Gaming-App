import { UserNotificationType } from 'src/common/constants';
import { IScheduledNotification } from 'src/modules/scheduled-notification/interfaces/scheduled-notification.interface';
import { User } from 'src/modules/user/schemas/user.schema';

export interface INotificationData {
  isRead: boolean;
  title: string;
  description: string;
  notificationType: UserNotificationType;
  redirectScreen?: string;
}

export interface INotificationDataRecord extends INotificationData {
  _id: string;
}

export interface INotification {
  user: string | User;
  since: Date;
  until: Date;
  data: INotificationData;
  scheduledNotification?: string | IScheduledNotification;
}

export interface INotificationRecord extends INotification {
  _id: string;
  createdAt?: Date;
  updatedAt?: Date;
}
