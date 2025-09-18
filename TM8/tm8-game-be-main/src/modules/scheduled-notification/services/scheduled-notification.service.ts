import { Inject, Injectable } from '@nestjs/common';
import * as moment from 'moment';
import mongoose, { FilterQuery } from 'mongoose';

import { NotificationConfig } from 'src/common/config/env.validation';
import {
  Game,
  Role,
  UserGroup,
  UserNotificationInterval,
  UserNotificationType,
  UserStatusType,
  userNotificationIntervalsResponse,
} from 'src/common/constants';
import { userNotificationTypesResponse } from 'src/common/constants/user-notification-types';
import {
  TGMDConflictException,
  TGMDExternalServiceException,
  TGMDNotFoundException,
} from 'src/common/exceptions/custom.exception';
import { PaginationParams } from 'src/common/pagination/pagination-params';
import { PaginationModel } from 'src/common/pagination/paginaton.model';
import { DateUtils } from 'src/common/utils/date.utils';
import { StringUtils } from 'src/common/utils/string.utils';
import { INotificationTokenPair } from 'src/modules/firebase/interface/notification-token-pair.interface';
import {
  INotificationProviderService,
  NotificationProviderServiceToken,
} from 'src/modules/notification-provider/interface/notification-provider.service.interface';
import { AbstractNotificationRepository } from 'src/modules/notification/abstract/notification.abstract.repository';
import { AbstractNotificationService } from 'src/modules/notification/abstract/notification.abstract.service';
import { Notification } from 'src/modules/notification/schemas/notification.schema';
import { AbstractUserGameDataRepository } from 'src/modules/user-game-data/abstract/user-game-data.abstract.repository';
import { AbstractUserRepository } from 'src/modules/user/abstract/user.abstract.repository';
import { User } from 'src/modules/user/schemas/user.schema';

import { AbstractScheduledNotificationRepository } from '../abstract/scheduled-notification.abstract.repositrory';
import { AbstractScheduledNotificationService } from '../abstract/scheduled-notification.abstract.service';
import { CreateScheduledNotificationInput } from '../dto/create-scheduled-notification.input';
import { ListNotificationsInput } from '../dto/list-notifications-input';
import { UpdateScheduledNotificationInput } from '../dto/update-scheduled-notification.input';
import { IScheduledNotification } from '../interfaces/scheduled-notification.interface';
import { NotificationIntervalResponse } from '../response/notification-interval.response';
import { NotificationTypeResponse } from '../response/notification-type.response';
import { ScheduledNotification } from '../schemas/scheduled-notification.schema';

@Injectable()
export class ScheduledNotificationService extends AbstractScheduledNotificationService {
  // eslint-disable-next-line max-params
  constructor(
    private readonly scheduledNotificationRepository: AbstractScheduledNotificationRepository,
    private readonly userRepository: AbstractUserRepository,
    private readonly gameUserGameDataRepository: AbstractUserGameDataRepository,
    private readonly notificationRepository: AbstractNotificationRepository,
    @Inject(NotificationProviderServiceToken)
    private readonly notificationProvider: INotificationProviderService,
    private readonly notificationConfig: NotificationConfig,
    private readonly notificationService: AbstractNotificationService,
  ) {
    super();
  }

  /**
   * Lists notification based on the input and pagination parameters
   * @param listUserInput - input for listing notifications
   * @param params - pagination parameters
   * @returns paginated list of scheduled notifications
   */
  async listNotifications(
    listNotificationsInput: ListNotificationsInput,
    params: PaginationParams,
  ): Promise<PaginationModel<ScheduledNotification>> {
    const { limit, skip } = params;
    const { title, types, userGroups } = listNotificationsInput;
    let { sort } = listNotificationsInput;

    const sortObj: Record<string, 1 | -1> = {};

    if (sort.includes('title')) {
      sort = sort.replace('title', 'data.title');
    }

    const sortArray = sort.split(',');

    sortArray.forEach((sortItem) => {
      const match = sortItem.match(/^([+-])(\w+(\.\w+)?)$/);
      if (match) {
        const [, sign, field] = match;
        sortObj[field] = sign === '-' ? -1 : 1;
      }
    });

    const query: FilterQuery<ScheduledNotification> = {
      ['data.title']: { $regex: title, $options: 'i' },
    };

    if (types) {
      query['data.notificationType'] = { $in: types };
    }

    if (userGroups) {
      query['data.targetGroup'] = { $in: userGroups };
    }

    const data = await this.scheduledNotificationRepository.findManyLean(
      query,
      '',
      {
        skip: skip,
        limit: limit,
        sort: sortObj,
      },
    );

    const count = await this.scheduledNotificationRepository.count(query);

    return new PaginationModel(data, params, count);
  }

  /**
   * Creates a new scheduled notification
   * @param createNotificationInput - create scheduled notification input
   * @returns scheduled notification object
   */
  async createScheduledNotification(
    createScheduledNotificationInput: CreateScheduledNotificationInput,
  ): Promise<ScheduledNotification> {
    const {
      title,
      description,
      redirectScreen,
      notificationType,
      date,
      interval,
      targetGroup,
      individualUserId,
    } = createScheduledNotificationInput;

    if (targetGroup === UserGroup.IndividualUser && !individualUserId) {
      throw new TGMDConflictException(
        'Individual user ID is required if group is set to individual user',
      );
    } else if (targetGroup !== UserGroup.IndividualUser && individualUserId) {
      throw new TGMDConflictException(
        'Cannot provide individual user ID if group is not set to individual user',
      );
    }

    const uniqueId = await this.createUniqueIdAndCheckIfExists();

    const notificationObject: IScheduledNotification = {
      date: moment(date).utc().toDate(),
      interval,
      users: [],
      data: {
        title,
        description,
        redirectScreen,
        notificationType,
        targetGroup,
      },
      openedBy: 0,
      receivedBy: 0,
      uniqueId,
    };

    if (targetGroup !== UserGroup.IndividualUser) {
      notificationObject.users = await this.getNotificationUsers(targetGroup);
    } else {
      notificationObject.users = [individualUserId];
    }

    return await this.scheduledNotificationRepository.createOne(
      notificationObject,
    );
  }

  /**
   * Finds one scheduled notification by id
   * @param notificationId - notification id
   * @returns returns a scheduled notification object
   */
  async findScheduledNotification(
    notificationId: string,
  ): Promise<ScheduledNotification> {
    const notification = await this.scheduledNotificationRepository.findOneLean(
      {
        _id: notificationId,
      },
    );
    if (!notification)
      throw new TGMDNotFoundException('Notification not found');

    return notification;
  }

  /**
   * Updates a scheduled notification
   * @param id - scheduled notification id
   * @param updateNotificationInput - update scheduled notification input
   * @returns shceduled notification object
   */
  async updateScheduledNotification(
    id: string,
    updateNotificationInput: UpdateScheduledNotificationInput,
  ): Promise<ScheduledNotification> {
    const {
      title,
      description,
      redirectScreen,
      notificationType,
      date,
      interval,
      targetGroup,
      individualUserId,
    } = updateNotificationInput;

    const notification = await this.scheduledNotificationRepository.findOneLean(
      { _id: id },
    );
    if (!notification)
      throw new TGMDNotFoundException('Scheduled notification not found');

    if (targetGroup === UserGroup.IndividualUser && !individualUserId) {
      throw new TGMDConflictException(
        'Individual user ID is required if group is set to individual user',
      );
    } else if (targetGroup !== UserGroup.IndividualUser && individualUserId) {
      throw new TGMDConflictException(
        'Cannot provide individual user ID if group is not set to individual user',
      );
    }

    const notificationObject: Partial<IScheduledNotification> = {
      date,
      interval,
      users: [],
      data: {
        title,
        description,
        redirectScreen,
        notificationType,
        targetGroup,
      },
    };

    if (targetGroup !== UserGroup.IndividualUser) {
      notificationObject.users = await this.getNotificationUsers(targetGroup);
    } else {
      notificationObject.users = [individualUserId];
    }

    return await this.scheduledNotificationRepository.updateOneById(
      id,
      notificationObject,
    );
  }

  /**
   * Deletes scheduled notifications
   * @param notificationIds - array of notification ids
   * @returns Void
   */
  async deleteScheduledNotifications(notificationIds: string[]): Promise<void> {
    const notifications =
      await this.scheduledNotificationRepository.findManyLean({
        _id: { $in: notificationIds },
      });
    if (notifications.length < 1)
      throw new TGMDNotFoundException('Notifications not found');

    const deletedCount = await this.scheduledNotificationRepository.deleteMany(
      notificationIds,
    );
    if (deletedCount !== notifications.length)
      throw new TGMDExternalServiceException(
        'Some notifications were not deleted',
      );
  }

  /**
   * Creates a unique ID and checks if it exists in the database
   * @returns unique id
   */
  private async createUniqueIdAndCheckIfExists(): Promise<string> {
    const uniqueId = StringUtils.generateSevenDigitAlphaNumericCode();
    const uniqueIdExists =
      await this.scheduledNotificationRepository.findOneLean({ uniqueId });
    if (uniqueIdExists) await this.createUniqueIdAndCheckIfExists();
    return uniqueId;
  }

  /**
   * Get notification users based on the user group
   * @param userGroup - user group
   * @returns array of user IDs
   */
  private async getNotificationUsers(userGroup: UserGroup): Promise<string[]> {
    switch (userGroup) {
      case UserGroup.AllUsers: {
        const allUsers = await this.userRepository.findManyLean(
          { role: Role.User },
          '_id',
        );
        return allUsers.map((player) => player._id);
      }
      case UserGroup.ApexLegendsPlayers: {
        const apexPlayers = await this.gameUserGameDataRepository.findManyLean(
          { game: Game.ApexLegends },
          'user',
        );
        return apexPlayers.map((player) => player.user as string);
      }
      case UserGroup.CallOfDutyPlayers: {
        const codPlayers = await this.gameUserGameDataRepository.findManyLean(
          { game: Game.CallOfDuty },
          'user',
        );
        return codPlayers.map((player) => player.user as string);
      }
      case UserGroup.FortnitePlayers: {
        const fortnitePlayers =
          await this.gameUserGameDataRepository.findManyLean(
            { game: Game.Fortnite },
            'user',
          );
        return fortnitePlayers.map((player) => player.user as string);
      }
      case UserGroup.RocketLeaguePlayers: {
        const rocketLeaguePlayers =
          await this.gameUserGameDataRepository.findManyLean(
            { game: Game.RocketLeague },
            'user',
          );
        return rocketLeaguePlayers.map((player) => player.user as string);
      }
      default: {
        break;
      }
    }
  }

  /**
   * Fetches notification types
   * @returns array of notification type response
   */
  getNotificationTypes(): NotificationTypeResponse[] {
    return userNotificationTypesResponse;
  }

  /**
   * Fetches notification intervals
   * @returns array of notification interval response
   */
  getNotificationIntervals(): NotificationIntervalResponse[] {
    return userNotificationIntervalsResponse;
  }

  async prepareScheduledNotifications(): Promise<void> {
    const startOfCurrentMinute = moment().startOf('minute').toDate();
    const endOfCurrentMinute = moment().endOf('minute').toDate();

    const scheduledNotifications =
      await this.scheduledNotificationRepository.getScheduledNotificationsWithUsers(
        { date: { $gte: startOfCurrentMinute, $lt: endOfCurrentMinute } },
      );
    if (scheduledNotifications.length > 0) {
      await this.sendScheduledNotifications(scheduledNotifications);
    }
  }

  /**
   * Schedules notifications for sending
   * @param notifications - array of scheduled notifications
   * @returns Void
   */
  private async sendScheduledNotifications(
    notifications: ScheduledNotification[],
  ): Promise<void> {
    for (const notification of notifications) {
      const notificationPayloads =
        this.createNotificationUsersPayload(notification);

      const newDate = this.calculateNewNotificationDate(notification);
      const notificationResult =
        await this.notificationProvider.sendMultipleNotifications(
          notificationPayloads,
        );

      await this.scheduledNotificationRepository.updateOneById(
        notification._id,
        {
          date: newDate ? newDate : undefined,
          receivedBy: (notification.receivedBy += notificationResult.sentCount),
        },
      );
      await this.createUserNotifications(
        notification.users as User[],
        notification.data.title,
        notification.data.description,
        notification.data.redirectScreen,
        notification.data.notificationType,
        notification._id.toString(),
      );
    }
  }

  /**
   * Creates payload for sending notification to each user
   * @param notification - scheduled notification
   * @returns list of notification token pairs
   */
  private createNotificationUsersPayload(
    notification: ScheduledNotification,
  ): INotificationTokenPair[] {
    const notificationPayloads: INotificationTokenPair[] = [];
    for (const user of notification.users) {
      if (
        typeof user !== 'string' &&
        user.notificationToken &&
        this.notificationService.userHasEnabledNotification(
          user,
          notification.data.notificationType,
        )
      ) {
        notificationPayloads.push({
          token: user.notificationToken,
          notification: {
            title: notification.data.title,
            description: notification.data.description,
            type: notification.data.notificationType,
            redirectScreen: notification.data.redirectScreen
              ? notification.data.redirectScreen
              : '',
          },
        });
      }
    }

    return notificationPayloads;
  }

  /**
   * Checks for and sends reminder notifications to inactive users
   * @returns Void
   */
  async sendInactiveUserReminderNotifications(): Promise<void> {
    const aMonthAgoDate = moment().subtract(30, 'days').toDate();
    const inactiveUsers = await this.userRepository.findManyLean({
      lastLogin: { $lte: aMonthAgoDate },
      role: Role.User,
      'notificationSettings.reminders': true,
      'notificationSettings.enabled': true,
    });

    const notificationTitle = 'Time To Jump Back Into Matchmaking!';
    const notificationDescription =
      "It's been a while and we've missed you. Let's get back into action!";

    if (inactiveUsers.length > 0) {
      await this.setNotificationsPayloadAndSend(
        inactiveUsers,
        notificationTitle,
        notificationDescription,
        this.notificationConfig.REDIRECT.INACTIVE,
        UserNotificationType.Reminder,
      );

      await this.createUserNotifications(
        inactiveUsers,
        notificationTitle,
        notificationDescription,
        this.notificationConfig.REDIRECT.INACTIVE,
        UserNotificationType.Reminder,
      );
    }
  }

  /**
   * Checks for and sends reminder notifications to users which have not completed onboarding
   * @returns Void
   */
  async sendOnboardingReminderNotifications(): Promise<void> {
    const inactiveUsers = await this.userRepository.findManyLean({
      role: Role.User,
      $or: [
        { phoneVerified: false },
        { dateOfBirth: false },
        { 'status.type': UserStatusType.Pending },
      ],
    });

    const notificationTitle = 'Complete Your Onboarding To Start Matchmaking!';
    const notificationDescription =
      'Complete your profile and start matchmaking';

    if (inactiveUsers.length > 0) {
      await this.setNotificationsPayloadAndSend(
        inactiveUsers,
        notificationTitle,
        notificationDescription,
        this.notificationConfig.REDIRECT.ONBOARDING,
        UserNotificationType.Reminder,
      );

      await this.createUserNotifications(
        inactiveUsers,
        notificationTitle,
        notificationDescription,
        this.notificationConfig.REDIRECT.ONBOARDING,
        UserNotificationType.Reminder,
      );
    }
  }

  /**
   * Checks for and sends reminder notifications to users which have not set their game preferences
   * @returns Void
   */
  async sendGamePreferenceReminderNotifications(): Promise<void> {
    const gamePreferences =
      await this.gameUserGameDataRepository.getUserGameDataWithUsers({
        preferences: [],
      });

    const notificationTitle = 'Set Your Game Preferences To Start Matchmaking!';
    const notificationDescription =
      'We have noticed that you have not set up your game preferences. Set them up now and start matchmaking';

    const gamePreferencesUsers = gamePreferences
      .filter(
        (gamePreference) =>
          typeof gamePreference.user !== 'string' &&
          gamePreference.user.notificationSettings.enabled === true &&
          gamePreference.user.notificationSettings.reminders === true,
      )
      .map((gamePreference) => gamePreference.user);

    if (gamePreferences.length > 0) {
      await this.setNotificationsPayloadAndSend(
        gamePreferencesUsers as User[],
        notificationTitle,
        notificationDescription,
        this.notificationConfig.REDIRECT.PREFERENCES,
        UserNotificationType.Reminder,
      );

      await this.createUserNotifications(
        gamePreferencesUsers as User[],
        notificationTitle,
        notificationDescription,
        this.notificationConfig.REDIRECT.PREFERENCES,
        UserNotificationType.Reminder,
      );
    }
  }

  /**
   * Updates the notification date based on the interval
   * @param notification notification object
   * @returns Void
   */
  private calculateNewNotificationDate(
    notification: ScheduledNotification,
  ): Date {
    let newDate = new Date();

    switch (notification.interval) {
      case UserNotificationInterval.DoesntRepeat: {
        newDate = undefined;
        break;
      }
      case UserNotificationInterval.RepeatDaily: {
        newDate.setDate(notification.date.getDate() + 1);
        break;
      }
      case UserNotificationInterval.RepeatWeekly: {
        newDate.setDate(notification.date.getDate() + 7);
        break;
      }
      case UserNotificationInterval.RepeatBiWeekly: {
        newDate.setDate(notification.date.getDate() + 14);
        break;
      }
      case UserNotificationInterval.RepeatMonthly: {
        const currentMonth = new Date().getMonth();
        const currentYear = new Date().getFullYear();
        const daysToNextMonth = DateUtils.daysInMonth(
          currentMonth,
          currentYear,
        );
        newDate.setDate(notification.date.getDate() + daysToNextMonth);
        break;
      }
      case UserNotificationInterval.RepeatAnnually: {
        newDate.setDate(
          notification.date.getDate() +
            DateUtils.calculateAnniversaryInterval(notification.date),
        );
        break;
      }
    }

    return newDate;
  }

  /**
   * Creates regular notifications for each user
   * @param users - array of users
   * @param title - notification title
   * @param description - notification description
   * @param redirectScreen - notification redirect screen
   */
  private async createUserNotifications(
    users: User[],
    title: string,
    description: string,
    redirectScreen: string,
    type: UserNotificationType,
    scheduledNotificationId?: string,
  ): Promise<void> {
    const userNotifications: Notification[] = [];
    for (const user of users) {
      userNotifications.push({
        _id: String(new mongoose.Types.ObjectId()),
        user: user._id,
        since: moment().startOf('month').toDate(),
        until: moment().endOf('month').toDate(),
        scheduledNotification: scheduledNotificationId,
        data: {
          _id: String(new mongoose.Types.ObjectId()),
          notificationType: type,
          title: title,
          description: description,
          redirectScreen: redirectScreen,
          isRead: false,
        },
      });
    }
    if (userNotifications.length > 0) {
      await this.notificationRepository.createMany(userNotifications);
    }
  }

  /**
   * Creates notification payloads and sends multiple notifications
   * @param users - array of users
   * @param title - notification title
   * @param description - notification description
   * @param redirectScreen - notification redirect screen
   * @param type - notification type
   */
  private async setNotificationsPayloadAndSend(
    users: User[],
    title: string,
    description: string,
    redirectScreen: string,
    type: UserNotificationType,
  ): Promise<void> {
    const notificationPayloads: INotificationTokenPair[] = [];
    for (const user of users) {
      if (user.notificationToken) {
        notificationPayloads.push({
          token: user.notificationToken,
          notification: {
            title,
            description,
            type,
            redirectScreen,
          },
        });
      }
    }
    if (notificationPayloads.length > 0) {
      await this.notificationProvider.sendMultipleNotifications(
        notificationPayloads,
      );
    }
  }
}
