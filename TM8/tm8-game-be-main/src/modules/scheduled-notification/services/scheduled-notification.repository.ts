import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { FilterQuery, Model } from 'mongoose';

import { AbstractScheduledNotificationRepository } from '../abstract/scheduled-notification.abstract.repositrory';
import { ScheduledNotification } from '../schemas/scheduled-notification.schema';

@Injectable()
export class ScheduledNotificationRepository extends AbstractScheduledNotificationRepository {
  constructor(
    @InjectModel('ScheduledNotification')
    repository: Model<ScheduledNotification>,
  ) {
    super(repository);
  }

  async getScheduledNotificationsWithUsers(
    filter: FilterQuery<ScheduledNotification> = {},
  ): Promise<ScheduledNotification[]> {
    return await this.entity
      .find(filter)
      .populate({
        path: 'users',
        select: '_id notificationToken notificationSettings',
      })
      .lean();
  }
}
