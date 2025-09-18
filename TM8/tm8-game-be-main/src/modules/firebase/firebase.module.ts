import { Module } from '@nestjs/common';

import { ParameterStoreModule } from 'src/parameter-store/parameter-store.module';

import { NotificationProviderToken } from './interface/notification-provider.interface';
import { FirebaseService } from './providers/firebase.service';

@Module({
  imports: [ParameterStoreModule],
  providers: [
    FirebaseService,
    {
      provide: NotificationProviderToken,
      useExisting: FirebaseService,
    },
  ],
  exports: [NotificationProviderToken],
})
export class FirebaseModule {}
