import { Module, forwardRef } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';

import { NotificationProviderModule } from '../notification-provider/notification-provider.module';
import { ScheduledNotificationModule } from '../scheduled-notification/scheduled-notification.module';
import { UserModule } from '../user/user.module';
import { AbstractNotificationRepository } from './abstract/notification.abstract.repository';
import { AbstractNotificationService } from './abstract/notification.abstract.service';
import { NotificationController } from './notification.controller';
import {
  Notification,
  NotificationSchema,
} from './schemas/notification.schema';
import { NotificationRepository } from './services/notification.repository';
import { NotificationService } from './services/notification.service';

@Module({
  imports: [
    MongooseModule.forFeature([
      { name: Notification.name, schema: NotificationSchema },
    ]),
    forwardRef(() => UserModule),
    ScheduledNotificationModule,
    NotificationProviderModule,
  ],
  controllers: [NotificationController],
  providers: [
    NotificationService,
    NotificationRepository,
    {
      provide: AbstractNotificationRepository,
      useClass: NotificationRepository,
    },
    {
      provide: AbstractNotificationService,
      useClass: NotificationService,
    },
  ],
  exports: [AbstractNotificationRepository, AbstractNotificationService],
})
export class NotificationModule {}
