import { Inject, Injectable } from '@nestjs/common';
import * as moment from 'moment';

import {
  NotificationRedirectScreen,
  UserNotificationType,
} from 'src/common/constants';
import { TGMDNotFoundException } from 'src/common/exceptions/custom.exception';
import { PaginationParams } from 'src/common/pagination/pagination-params';
import { PaginationModel } from 'src/common/pagination/paginaton.model';
import { StringUtils } from 'src/common/utils/string.utils';
import {
  INotificationProviderService,
  NotificationProviderServiceToken,
} from 'src/modules/notification-provider/interface/notification-provider.service.interface';
import { UpdateNotificationSettingsDto } from 'src/modules/notification/dto/update-notification-settings.dto';
import { AbstractScheduledNotificationRepository } from 'src/modules/scheduled-notification/abstract/scheduled-notification.abstract.repositrory';
import { AbstractUserRepository } from 'src/modules/user/abstract/user.abstract.repository';
import { User } from 'src/modules/user/schemas/user.schema';

import { AbstractNotificationRepository } from '../abstract/notification.abstract.repository';
import { AbstractNotificationService } from '../abstract/notification.abstract.service';
import { notificationSettingsOptions } from '../constants/notification-settings-options';
import { CreateCallNotificationDto } from '../dto/create-call-notification.dto';
import { CreateFriendAddedNotificationDto } from '../dto/create-friend-added-notification.dto';
import { CreateMessageNotificationDto } from '../dto/create-message-notification.dto';
import { CreateNotificationDto } from '../dto/create-notification.dto';
import { ICreateMatchNotificationParams } from '../interfaces/create-match-notification.interface';
import { NotificationSettingsOptionResponse } from '../response/notification-settings-option.response';
import { UnreadNotificationsResponse } from '../response/unread-notifications.response';
import { Notification } from '../schemas/notification.schema';

@Injectable()
export class NotificationService extends AbstractNotificationService {
  constructor(
    private readonly userRepository: AbstractUserRepository,
    @Inject(NotificationProviderServiceToken)
    private readonly notificationProvider: INotificationProviderService,
    private readonly notificationRepository: AbstractNotificationRepository,
    private readonly scheduledNotificationRepository: AbstractScheduledNotificationRepository,
  ) {
    super();
  }
  /**
   * Refreshes the notification token of a user
   * @param userId - user id
   * @param notificationToken - notification token
   * @returns Void
   */
  async refreshToken(userId: string, notificationToken: string): Promise<void> {
    await this.userRepository.updateOneById(userId, {
      notificationToken,
    });
  }

  /**
   * Creates a message notification and sends it to the user
   * @param createMessageNotificationDto - create notification dto
   * @returns Void
   */
  async createMessageNotification(
    createMessageNotificationDto: CreateMessageNotificationDto,
  ): Promise<void> {
    const { senderUsername, recipientId, message, redirectScreen } =
      createMessageNotificationDto;

    const title = `${senderUsername} has sent you a new message`;

    await this.createNotification({
      title,
      description: message,
      recipientId,
      redirectScreen,
      notificationType: UserNotificationType.Message,
    });
  }

  /**
   * Creates a friend added notification and sends it to the user
   * @param createFriendAddedNotificationDto - create notification dto
   * @returns Void
   */
  async createFriendAddedNotification(
    createFriendAddedNotificationDto: CreateFriendAddedNotificationDto,
  ): Promise<void> {
    const { friendUsername, recipientId, redirectScreen } =
      createFriendAddedNotificationDto;

    const title = `${friendUsername} added you as a friend`;
    const description = 'Go ahead and check out their profile';

    await this.createNotification({
      title,
      description,
      recipientId,
      redirectScreen,
      notificationType: UserNotificationType.FriendAdded,
    });
  }

  /**
   * Creates a call notification and sends it to the user
   * @param createCallNotificationDto - create notification dto
   * @returns Void
   */
  async createCallNotification(
    createCallNotificationDto: CreateCallNotificationDto,
  ): Promise<void> {
    const { callerUsername, recipientId, redirectScreen } =
      createCallNotificationDto;

    const title = callerUsername;
    const description = `Incoming call from ${callerUsername}`;

    await this.createNotification({
      title,
      description,
      recipientId,
      redirectScreen,
      notificationType: UserNotificationType.Call,
    });
  }

  /**
   * Creates a match notification and sends it to the user
   * @param createMatchNotificationDto - create notification dto
   * @returns Void
   */
  async createMatchNotification(
    createMatchNotificationDto: ICreateMatchNotificationParams,
  ): Promise<void> {
    const { currentUser, targetUser, redirectScreen } =
      createMatchNotificationDto;

    const title = 'New Match!';
    const description = `${currentUser.username} has just matched with you. Message them now and start playing together!`;

    await this.createNotification({
      title,
      description,
      recipientId: targetUser._id.toString(),
      redirectScreen,
      notificationType: UserNotificationType.Match,
      meta: {
        senderUser: currentUser,
        targetUser,
      },
    });
  }

  /**
   * Checks if the user has enabled notifications for the notification type
   * @param user - User object
   * @param notificationType - The notification type
   * @returns Whether the user has enabled notifications for the notification type
   */
  userHasEnabledNotification(
    user: User,
    notificationType: UserNotificationType,
  ): boolean {
    // By default, notifications are enabled
    if (!user.notificationSettings) return true;

    // If all notifications are disabled, return false
    if (!user.notificationSettings.enabled) return false;

    // Check the notification settings for the specified notification type
    const notificationSettings =
      user.notificationSettings[
        StringUtils.kebabCaseToCamelCase(notificationType)
      ];
    return notificationSettings ?? true; // Default to true if the notification type is not found
  }

  /**
   * Creates a notification and sends it to the user
   * @param createNotificationDto - create notification dto
   * @returns Void
   */
  private async createNotification(
    createNotificationDto: CreateNotificationDto,
  ): Promise<void> {
    const {
      title,
      recipientId,
      description,
      redirectScreen,
      notificationType,
      meta,
    } = createNotificationDto;
    const user = await this.userRepository.findOneLean(
      { _id: recipientId },
      '_id notificationToken notificationSettings',
    );
    if (!user) throw new TGMDNotFoundException('User not found');

    // Validate that the user has enabled notifications for the notification type (if not, do not create or send the notification)
    if (!this.userHasEnabledNotification(user, notificationType)) return;

    const since = moment().startOf('month').toDate();
    const until = moment().endOf('month').toDate();

    if (notificationType !== UserNotificationType.Message) {
      await this.notificationRepository.createOne({
        user: recipientId,
        since,
        until,
        data: {
          isRead: false,
          redirectScreen,
          notificationType,
          title,
          description,
        },
      });
    }
    await this.notificationProvider.sendOneNotification({
      token: user.notificationToken,
      notification: {
        title,
        description,
        type: notificationType,
        redirectScreen,
        meta: meta ?? {},
      },
    });
  }

  /**
   * List user notifications based on the user id and paginaton parameters
   * @param userId - user id
   * @param paginationParams - pagination params
   * @returns paginated list of notifications
   */
  async listUserNotifications(
    userId: string,
    paginationParams: PaginationParams,
  ): Promise<PaginationModel<Notification>> {
    const { limit, skip } = paginationParams;

    const notifications = await this.notificationRepository.findManyLean(
      { user: userId },
      '',
      { limit: limit, skip: skip, sort: { createdAt: -1 } },
    );

    const count = await this.notificationRepository.count({ user: userId });

    return new PaginationModel(notifications, paginationParams, count);
  }

  /**
   * Deletes a notification based on the user id and notification id
   * @param userId - user id
   * @param notificationId - notification id
   * @returns Void
   */
  async deleteNotification(
    userId: string,
    notificationId: string,
  ): Promise<void> {
    const notification = await this.notificationRepository.findOneLean({
      user: userId,
      _id: notificationId,
    });
    if (!notification)
      throw new TGMDNotFoundException('Notification not found');

    await this.notificationRepository.deleteOne({
      user: userId,
      _id: notificationId,
    });
  }

  /**
   * Fetches notification detail by notification and user id
   * @param userId - user id
   * @param notificationId - notification id
   * @returns notification response
   */
  async getNotificationDetail(
    userId: string,
    notificationId: string,
  ): Promise<Notification> {
    const notification = await this.notificationRepository.findOneLean({
      user: userId,
      _id: notificationId,
    });
    if (!notification)
      throw new TGMDNotFoundException('Notification not found');

    return notification;
  }

  /**
   * Marks a notification as read based on the user id and notification id
   * @param userId - user id
   * @param notificationId - notification id
   * @returns Void
   */
  async markNotificationAsRead(
    userId: string,
    notificationId: string,
  ): Promise<void> {
    const notification = await this.notificationRepository.findOneLean({
      user: userId,
      _id: notificationId,
    });
    if (!notification)
      throw new TGMDNotFoundException('Notification not found');

    await this.notificationRepository.updateOneById(notificationId, {
      'data.isRead': true,
    });

    if (notification.scheduledNotification) {
      await this.scheduledNotificationRepository.updateOneById(
        notification.scheduledNotification as string,
        {
          $inc: { openedBy: 1 },
        },
      );
    }
  }

  /**
   * Checks if there are any unread notifications for a user
   * @param userId - user id
   * @returns unread notifications response
   */
  async checkUnreadNotifications(
    userId: string,
  ): Promise<UnreadNotificationsResponse> {
    const unreadNotifications = await this.notificationRepository.count({
      user: userId,
      'data.isRead': false,
    });

    return {
      unread: unreadNotifications > 0,
      count: unreadNotifications > 0 ? unreadNotifications : undefined,
    };
  }

  /**
   * Updated user notification settings
   * @param userId - user id
   * @param notificationSettingsInput - notification settings input
   * @returns Void
   */
  async updateNotificationSettings(
    userId: string,
    notificationSettingsInput: UpdateNotificationSettingsDto,
  ): Promise<void> {
    const { enabled, friendAdded, match, message, news, reminders } =
      notificationSettingsInput;
    await this.userRepository.updateOneById(userId, {
      'notificationSettings.enabled': enabled ?? undefined,
      'notificationSettings.friendAdded': friendAdded ?? undefined,
      'notificationSettings.match': match ?? undefined,
      'notificationSettings.message': message ?? undefined,
      'notificationSettings.news': news ?? undefined,
      'notificationSettings.reminders': reminders ?? undefined,
    });
  }

  /**
   * Cleans up old notifications that are older than 30 days
   * @returns Void
   */
  async cleanUpOldNotifications(): Promise<void> {
    const aMonthAgoDate = moment().subtract(30, 'days').toDate();

    const oldNotifications = await this.notificationRepository.findManyLean({
      since: { $lt: aMonthAgoDate },
    });
    if (oldNotifications.length > 0) {
      const oldNotificationIds = oldNotifications.map((notification) =>
        notification._id.toString(),
      );

      await this.notificationRepository.deleteMany(oldNotificationIds);
    }
  }

  /**
   * Deletes all user notifications
   * @param userId - user id
   * @returns Void
   */
  async deleteUserNotifications(userId: string): Promise<void> {
    const userNotifications = await this.notificationRepository.findManyLean({
      user: userId,
    });
    if (userNotifications.length > 0) {
      const userNotificationIds = userNotifications.map((notification) =>
        notification._id.toString(),
      );
      await this.notificationRepository.deleteMany(userNotificationIds);
    }
  }

  /**
   * Gets notification settings options
   */
  getNotificationSettingsOptions(): NotificationSettingsOptionResponse[] {
    return notificationSettingsOptions;
  }

  /**
   * Sends ban notifications to the specified users
   * @param userIds - user ids
   * @param note - ban note
   */
  async createAndSendBanNotifications(
    userIds: string[],
    note: string,
  ): Promise<void> {
    const title = 'You have been banned';
    const description = `You have been banned from the platform. More info about the ban: ${note}.`;

    // Get all user notification tokens
    let users = await this.userRepository.findManyLean(
      { _id: { $in: userIds } },
      '_id notificationToken',
    );

    // Filter users without notification tokens
    users = users.filter((user) => !!user.notificationToken);

    // Send ban notifications to all specified users
    await this.notificationProvider.sendMultipleNotifications(
      users.map((user) => ({
        token: user.notificationToken,
        notification: {
          title,
          description,
          type: UserNotificationType.Ban,
          redirectScreen: NotificationRedirectScreen.Banned,
          meta: {},
        },
      })),
    );

    // Save notifications to the database
    await this.notificationRepository.createMany(
      users.map((user) => ({
        user: user._id,
        since: moment().toDate(),
        until: moment().add(10, 'year').toDate(),
        data: {
          notificationType: UserNotificationType.Ban,
          title,
          description,
          redirectScreen: NotificationRedirectScreen.Banned,
          isRead: false,
        },
      })),
    );
  }

  /**
   * Sends suspension notifications to the specified users
   * @param userIds - user ids
   * @param note - suspension note
   * @param suspensionEndDate - suspension end date
   */
  async createAndSendSuspendNotifications(
    userIds: string[],
    note: string,
    suspensionEndDate: Date,
  ): Promise<void> {
    const title = 'You have been suspended';
    const description = `You have been suspended from the platform until ${suspensionEndDate.toDateString()}. More info about suspension: ${note}.`;

    // Get all user notification tokens
    let users = await this.userRepository.findManyLean(
      { _id: { $in: userIds } },
      '_id notificationToken',
    );

    // Filter users without notification tokens
    users = users.filter((user) => !!user.notificationToken);

    // Send suspension notifications to all specified users
    await this.notificationProvider.sendMultipleNotifications(
      users.map((user) => ({
        token: user.notificationToken,
        notification: {
          title,
          description,
          type: UserNotificationType.Suspend,
          redirectScreen: NotificationRedirectScreen.Suspended,
          meta: {},
        },
      })),
    );

    // Save notifications to the database
    await this.notificationRepository.createMany(
      users.map((user) => ({
        user: user._id,
        since: moment().toDate(),
        until: suspensionEndDate,
        data: {
          notificationType: UserNotificationType.Suspend,
          title,
          description,
          redirectScreen: NotificationRedirectScreen.Suspended,
          isRead: false,
        },
      })),
    );
  }

  /**
   * Removes notifications for the specified users of specified types
   * @param userIds - user ids
   * @param notificationTypes - notification types
   */
  async removeUserNotificationsOfSpecifiedType(
    userIds: string[],
    notificationTypes: UserNotificationType[],
  ): Promise<void> {
    // Find notifications for the specified users and types
    const notifications = await this.notificationRepository.findManyLean({
      user: { $in: userIds },
      'data.notificationType': { $in: notificationTypes },
    });

    // Delete the found notifications
    if (notifications.length > 0) {
      const notificationIds = notifications.map((notification) =>
        notification._id.toString(),
      );
      await this.notificationRepository.deleteMany(notificationIds);
    }
  }
}
