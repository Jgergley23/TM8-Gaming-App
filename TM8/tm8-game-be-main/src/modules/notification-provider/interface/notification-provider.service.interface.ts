import { INotificationProviderServiceResult } from 'src/modules/firebase/interface/notification-provider.interface';
import { INotificationTokenPair } from 'src/modules/firebase/interface/notification-token-pair.interface';

export interface INotificationProviderService {
  /**
   * Sends notification to a single device.
   * @param pair - Pair of notification and device token.
   * @returns  Void
   **/
  sendOneNotification(pair: INotificationTokenPair): Promise<void>;

  /**
   * Sends multiple notification, each notification to the corresponding device.
   * @param tokenPairs - Pairs of notification and device token.
   * @returns  Void
   */
  sendMultipleNotifications(
    tokenPairs: INotificationTokenPair[],
  ): Promise<INotificationProviderServiceResult>;
}

export const NotificationProviderServiceToken = Symbol(
  'NotificationProviderServiceToken',
);
