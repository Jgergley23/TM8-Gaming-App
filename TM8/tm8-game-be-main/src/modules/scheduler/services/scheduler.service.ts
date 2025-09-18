import { Injectable } from '@nestjs/common';
import { Cron } from '@nestjs/schedule';

import { IS_SCHEDULER_ENABLED } from 'src/common/constants';
import { AbstractNotificationService } from 'src/modules/notification/abstract/notification.abstract.service';
import { AbstractScheduledNotificationService } from 'src/modules/scheduled-notification/abstract/scheduled-notification.abstract.service';
import { AbstractRejectedUserService } from 'src/modules/user/abstract/rejected-user.abstract.service';

import { AbstractSchedulerService } from '../abstract/scheduler.abstract.service';

@Injectable()
export class SchedulerService extends AbstractSchedulerService {
  constructor(
    private readonly scheduledNotificationService: AbstractScheduledNotificationService,
    private readonly notificationService: AbstractNotificationService,
    private readonly rejectedUserService: AbstractRejectedUserService,
  ) {
    super();
  }

  @Cron('0 * * * * *', {
    name: 'PREPARE_SCHEDULED_NOTIFICATIONS',
    disabled: !IS_SCHEDULER_ENABLED,
  })
  /**
   * Checks for and prepares scheduled notifications every minute
   * @returns Void
   */
  private async prepareScheduledNotifications(): Promise<void> {
    await this.scheduledNotificationService.prepareScheduledNotifications();
  }

  @Cron('0 0 1 * *', {
    name: 'SEND_INCATIVE_USER_REMINDER_NOTIFICATIONS',
    disabled: !IS_SCHEDULER_ENABLED,
  })
  /**
   * Sends inactive user reminder notifications on the start of each month
   * @returns Void
   */
  private async sendInactiveUserReminderNotifications(): Promise<void> {
    await this.scheduledNotificationService.sendInactiveUserReminderNotifications();
  }

  @Cron('0 12 * * 5', {
    name: 'SEND_ONBOARDING_REMINDER_NOTIFICATIONS',
    disabled: !IS_SCHEDULER_ENABLED,
  })
  /**
   * Sends onboarding reminder notifications to users every friday at noon
   * @returns Void
   */
  private async sendOnboardingReminderNotifications(): Promise<void> {
    await this.scheduledNotificationService.sendOnboardingReminderNotifications();
  }

  @Cron('0 12 * * 5', {
    name: 'SEND_GAME_PREFERENCE_REMINEDER_NOTIFICATIONS',
    disabled: !IS_SCHEDULER_ENABLED,
  })
  /**
   * Sends game preference reminder notifications to users every friday at noon
   * @returns Void
   */
  private async sendGamePreferenceReminderNotifications(): Promise<void> {
    await this.scheduledNotificationService.sendGamePreferenceReminderNotifications();
  }

  @Cron('0 0 1 * *', {
    name: 'CLEANUP_OLD_NOTIFICATIONS',
    disabled: !IS_SCHEDULER_ENABLED,
  })
  /**
   * Cleans up old notifications at the start of every month
   * @returns Void
   */
  private async cleanUpOldNotifications(): Promise<void> {
    await this.notificationService.cleanUpOldNotifications();
  }

  @Cron('0 0 * * *', {
    name: 'CLEANUP_REJECTED_USERS',
    disabled: !IS_SCHEDULER_ENABLED,
  })
  /**
   * Cleans up old rejected users every day at midnight
   * @returns Void
   */
  private async cleanupRejectedUsers(): Promise<void> {
    await this.rejectedUserService.cleanupRejectedUsers();
  }
}
