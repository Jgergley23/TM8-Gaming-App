import { Inject, Injectable } from '@nestjs/common';

import {
  INotificationProvider,
  INotificationProviderServiceResult,
  NotificationProviderToken,
} from 'src/modules/firebase/interface/notification-provider.interface';
import { INotificationTokenPair } from 'src/modules/firebase/interface/notification-token-pair.interface';

import { INotificationProviderService } from '../interface/notification-provider.service.interface';

@Injectable()
export class NotificationProviderService
  implements INotificationProviderService
{
  constructor(
    @Inject(NotificationProviderToken)
    private readonly notificationProvider: INotificationProvider,
  ) {}

  async sendOneNotification(pair: INotificationTokenPair): Promise<void> {
    await this.notificationProvider.sendOneNotification(pair);
  }

  async sendMultipleNotifications(
    tokenPairs: INotificationTokenPair[],
  ): Promise<INotificationProviderServiceResult> {
    return await this.notificationProvider.sendMultipleNotifications(
      tokenPairs,
    );
  }
}
