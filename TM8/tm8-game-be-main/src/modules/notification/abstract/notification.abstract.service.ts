import { UserNotificationType } from 'src/common/constants';
import { PaginationParams } from 'src/common/pagination/pagination-params';
import { PaginationModel } from 'src/common/pagination/paginaton.model';
import { User } from 'src/modules/user/schemas/user.schema';

import { CreateCallNotificationDto } from '../dto/create-call-notification.dto';
import { CreateFriendAddedNotificationDto } from '../dto/create-friend-added-notification.dto';
import { CreateMessageNotificationDto } from '../dto/create-message-notification.dto';
import { UpdateNotificationSettingsDto } from '../dto/update-notification-settings.dto';
import { ICreateMatchNotificationParams } from '../interfaces/create-match-notification.interface';
import { NotificationSettingsOptionResponse } from '../response/notification-settings-option.response';
import { UnreadNotificationsResponse } from '../response/unread-notifications.response';
import { Notification } from '../schemas/notification.schema';

export abstract class AbstractNotificationService {
  abstract refreshToken(
    userId: string,
    notificationToken: string,
  ): Promise<void>;
  abstract createMessageNotification(
    createMessageNotificationDto: CreateMessageNotificationDto,
  ): Promise<void>;
  abstract createFriendAddedNotification(
    createFriendAddedNotificationDto: CreateFriendAddedNotificationDto,
  ): Promise<void>;
  abstract createCallNotification(
    createCallNotificationDto: CreateCallNotificationDto,
  ): Promise<void>;
  abstract createMatchNotification(
    createMatchNotificationDto: ICreateMatchNotificationParams,
  ): Promise<void>;
  abstract listUserNotifications(
    userId: string,
    paginationParams: PaginationParams,
  ): Promise<PaginationModel<Notification>>;
  abstract deleteNotification(
    userId: string,
    notificationId: string,
  ): Promise<void>;
  abstract getNotificationDetail(
    userId: string,
    notificationId: string,
  ): Promise<Notification>;
  abstract markNotificationAsRead(
    userId: string,
    notificationId: string,
  ): Promise<void>;
  abstract checkUnreadNotifications(
    userId: string,
  ): Promise<UnreadNotificationsResponse>;
  abstract updateNotificationSettings(
    userId: string,
    notificationSettingsInput: UpdateNotificationSettingsDto,
  ): Promise<void>;
  abstract cleanUpOldNotifications(): Promise<void>;
  abstract deleteUserNotifications(userId: string): Promise<void>;
  abstract getNotificationSettingsOptions(): NotificationSettingsOptionResponse[];
  abstract userHasEnabledNotification(
    user: User,
    notificationType: UserNotificationType,
  ): boolean;
  abstract createAndSendBanNotifications(
    userIds: string[],
    note: string,
  ): Promise<void>;
  abstract createAndSendSuspendNotifications(
    userIds: string[],
    note: string,
    suspensionEndDate: Date,
  ): Promise<void>;
  abstract removeUserNotificationsOfSpecifiedType(
    userIds: string[],
    notificationTypes: UserNotificationType[],
  ): Promise<void>;
}
