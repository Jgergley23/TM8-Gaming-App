import { UserNotificationType } from 'src/common/constants';

export interface INotificationData {
  title: string;
  description: string;
  redirectScreen?: string;
  type: UserNotificationType;

  /**
   * Flag which indicates whether the notification has been directly opened
   */
  isRead?: boolean;

  /**
   * Flag which indicates whether the notification has been fetched in the list
   */
  isOpened?: boolean;

  /**
   * Any additional data that the notification may contain
   */
  meta?: object;
}
