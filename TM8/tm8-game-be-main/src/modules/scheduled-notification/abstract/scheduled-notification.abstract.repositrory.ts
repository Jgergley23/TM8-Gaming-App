import { FilterQuery } from 'mongoose';

import { AbstractRepository } from 'src/common/abstract/abstract.repository';

import { ScheduledNotification } from '../schemas/scheduled-notification.schema';

export abstract class AbstractScheduledNotificationRepository extends AbstractRepository<ScheduledNotification> {
  abstract getScheduledNotificationsWithUsers(
    filter: FilterQuery<ScheduledNotification>,
  ): Promise<ScheduledNotification[]>;
}
