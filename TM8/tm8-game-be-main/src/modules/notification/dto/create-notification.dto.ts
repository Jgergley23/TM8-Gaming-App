import { UserNotificationType } from 'src/common/constants';

export class CreateNotificationDto {
  title: string;
  description: string;
  recipientId: string;
  redirectScreen: string;
  notificationType: UserNotificationType;
  meta?: object;
}
