import { Injectable } from '@nestjs/common';

import { AbstractRepository } from 'src/common/abstract/abstract.repository';

import { Notification } from '../schemas/notification.schema';

@Injectable()
export abstract class AbstractNotificationRepository extends AbstractRepository<Notification> {}
