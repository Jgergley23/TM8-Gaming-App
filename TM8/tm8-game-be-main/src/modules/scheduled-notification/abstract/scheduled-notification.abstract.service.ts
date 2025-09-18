import { PaginationParams } from 'src/common/pagination/pagination-params';
import { PaginationModel } from 'src/common/pagination/paginaton.model';

import { CreateScheduledNotificationInput } from '../dto/create-scheduled-notification.input';
import { ListNotificationsInput } from '../dto/list-notifications-input';
import { UpdateScheduledNotificationInput } from '../dto/update-scheduled-notification.input';
import { NotificationIntervalResponse } from '../response/notification-interval.response';
import { NotificationTypeResponse } from '../response/notification-type.response';
import { ScheduledNotification } from '../schemas/scheduled-notification.schema';

export abstract class AbstractScheduledNotificationService {
  abstract listNotifications(
    listNotificationsInput: ListNotificationsInput,
    params: PaginationParams,
  ): Promise<PaginationModel<ScheduledNotification>>;
  abstract createScheduledNotification(
    createScheduledNotificationInput: CreateScheduledNotificationInput,
  ): Promise<ScheduledNotification>;
  abstract deleteScheduledNotifications(
    notificationIds: string[],
  ): Promise<void>;
  abstract updateScheduledNotification(
    id: string,
    updateNotificationInput: UpdateScheduledNotificationInput,
  ): Promise<ScheduledNotification>;
  abstract findScheduledNotification(
    notificationId: string,
  ): Promise<ScheduledNotification>;
  abstract getNotificationTypes(): NotificationTypeResponse[];
  abstract getNotificationIntervals(): NotificationIntervalResponse[];
  abstract prepareScheduledNotifications(): Promise<void>;
  abstract prepareScheduledNotifications(
    notifications: ScheduledNotification[],
  ): Promise<void>;
  abstract sendInactiveUserReminderNotifications(): Promise<void>;
  abstract sendOnboardingReminderNotifications(): Promise<void>;
  abstract sendGamePreferenceReminderNotifications(): Promise<void>;
}
