import { Module } from '@nestjs/common';

import { FirebaseModule } from '../firebase/firebase.module';
import { NotificationProviderServiceToken } from './interface/notification-provider.service.interface';
import { NotificationProviderService } from './services/notification-provider.service';

@Module({
  imports: [FirebaseModule],
  providers: [
    NotificationProviderService,
    {
      provide: NotificationProviderServiceToken,
      useExisting: NotificationProviderService,
    },
  ],
  exports: [NotificationProviderServiceToken],
})
export class NotificationProviderModule {}
