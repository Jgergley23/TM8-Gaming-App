/* eslint-disable @typescript-eslint/no-explicit-any */

import { INotificationTokenPair } from 'src/modules/firebase/interface/notification-token-pair.interface';

export enum NotificationSuccessResult {
  SUCCESS,
  PARTIAL_SUCCESS,
  FAIL,
}

export interface INotificationProviderServiceResult {
  status: NotificationSuccessResult;
  sentCount?: number;
}

export interface INotificationProvider {
  /**
   * Sends notification to a single device.
   * @param pair - Pair of notification and device token.
   * @returns  Void
   **/
  sendOneNotification(
    pair: INotificationTokenPair,
  ): Promise<INotificationProviderServiceResult>;

  /**
   * Sends multiple notification, each notification to the corresponding device.
   * @param tokenPairs - Pairs of notification and device token.
   * @returns  Void
   */
  sendMultipleNotifications(
    tokenPairs: INotificationTokenPair[],
  ): Promise<INotificationProviderServiceResult>;

  /**
   * Maps notification data to the format that the third-party service expects.
   * @param pairs - Pairs of notification and device token.
   * @returns  Data in the format that the third-party service expects.
   */
  mapNotificationData(...pairs: INotificationTokenPair[]): any;
}

export const NotificationProviderToken = Symbol('NotificationProviderToken');
