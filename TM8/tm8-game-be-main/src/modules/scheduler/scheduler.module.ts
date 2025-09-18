import { Module } from '@nestjs/common';
import { ScheduleModule } from '@nestjs/schedule';

import { NotificationModule } from '../notification/notification.module';
import { ScheduledNotificationModule } from '../scheduled-notification/scheduled-notification.module';
import { UserModule } from '../user/user.module';
import { SchedulerService } from './services/scheduler.service';

@Module({
  imports: [
    ScheduleModule.forRoot(),
    ScheduledNotificationModule,
    NotificationModule,
    UserModule,
  ],
  providers: [SchedulerService],
})
export class SchedulerModule {}
