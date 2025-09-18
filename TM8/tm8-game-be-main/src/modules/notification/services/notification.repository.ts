import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';

import { AbstractNotificationRepository } from '../abstract/notification.abstract.repository';
import { Notification } from '../schemas/notification.schema';

@Injectable()
export class NotificationRepository extends AbstractNotificationRepository {
  constructor(
    @InjectModel('Notification')
    repository: Model<Notification>,
  ) {
    super(repository);
  }
}
