import { Module, forwardRef } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';

import { NotificationProviderModule } from '../notification-provider/notification-provider.module';
import { NotificationModule } from '../notification/notification.module';
import { UserGameDataModule } from '../user-game-data/user-game-data.module';
import { UserModule } from '../user/user.module';
import { AbstractScheduledNotificationRepository } from './abstract/scheduled-notification.abstract.repositrory';
import { AbstractScheduledNotificationService } from './abstract/scheduled-notification.abstract.service';
import { ScheduledNotificationController } from './scheduled-notification.controller';
import {
  ScheduledNotification,
  ScheduledNotificationSchema,
} from './schemas/scheduled-notification.schema';
import { ScheduledNotificationSeederService } from './services/scheduled-notification-seeder.service';
import { ScheduledNotificationRepository } from './services/scheduled-notification.repository';
import { ScheduledNotificationService } from './services/scheduled-notification.service';

@Module({
  imports: [
    MongooseModule.forFeature([
      { name: ScheduledNotification.name, schema: ScheduledNotificationSchema },
    ]),
    NotificationProviderModule,
    forwardRef(() => UserModule),
    UserGameDataModule,
    forwardRef(() => NotificationModule),
  ],
  providers: [
    ScheduledNotificationService,
    ScheduledNotificationRepository,
    ScheduledNotificationSeederService,
    {
      provide: AbstractScheduledNotificationRepository,
      useExisting: ScheduledNotificationRepository,
    },
    {
      provide: AbstractScheduledNotificationService,
      useExisting: ScheduledNotificationService,
    },
  ],
  controllers: [ScheduledNotificationController],
  exports: [
    AbstractScheduledNotificationRepository,
    AbstractScheduledNotificationService,
  ],
})
export class ScheduledNotificationModule {}
