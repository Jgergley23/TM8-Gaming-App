import { Inject, Injectable } from '@nestjs/common';
import Firebase from 'firebase-admin';
import { TokenMessage } from 'firebase-admin/lib/messaging/messaging-api';
import { WINSTON_MODULE_NEST_PROVIDER, WinstonLogger } from 'nest-winston';

import { FirebaseConfig } from 'src/common/config/env.validation';
import { ChunkUtils } from 'src/common/utils/chunk.utils';
import {
  IParameterStoreService,
  ParameterStoreServiceToken,
} from 'src/parameter-store/interface/parameter-store.service.interface';

import {
  INotificationProvider,
  INotificationProviderServiceResult,
  NotificationSuccessResult,
} from '../interface/notification-provider.interface';
import { INotificationTokenPair } from '../interface/notification-token-pair.interface';

@Injectable()
export class FirebaseService implements INotificationProvider {
  constructor(
    @Inject(WINSTON_MODULE_NEST_PROVIDER)
    private readonly logger: WinstonLogger,
    private readonly config: FirebaseConfig,
    @Inject(ParameterStoreServiceToken)
    private readonly parameterStoreService: IParameterStoreService,
  ) {
    this.initializeFirebase();
  }

  /**
   * Initializes Firebase connection
   */
  private async initializeFirebase(): Promise<void> {
    const privateKey = await this.parameterStoreService.getParameter(
      'FIREBASE_PRIVATEKEY',
    );
    Firebase.initializeApp({
      credential: Firebase.credential.cert({
        projectId: this.config.PROJECTID,
        privateKey: privateKey.replace(/\\n/gm, '\n'),
        clientEmail: this.config.EMAIL,
      }),
    });
  }

  async sendOneNotification(
    pair: INotificationTokenPair,
  ): Promise<INotificationProviderServiceResult> {
    const result: INotificationProviderServiceResult = {
      status: NotificationSuccessResult.SUCCESS,
    };
    const payload = this.mapNotificationData(pair)[0];

    try {
      await Firebase.messaging().send(payload);
    } catch (err: unknown) {
      this.logger.error(err);
      result.status = NotificationSuccessResult.FAIL;
    }
    return result;
  }

  async sendMultipleNotifications(
    pairs: INotificationTokenPair[],
  ): Promise<INotificationProviderServiceResult> {
    const total = pairs.length;
    let failed = 0;
    const result: INotificationProviderServiceResult = {
      status: NotificationSuccessResult.SUCCESS,
      sentCount: 0,
    };

    const payloads = this.mapNotificationData(...pairs);
    const payloadChunks = ChunkUtils.splitIntoChunks(payloads);

    for (const chunk of payloadChunks) {
      try {
        const result = await Firebase.messaging().sendEach(chunk);
        failed += result.failureCount;
      } catch (err: unknown) {
        this.logger.error(err);
        throw err;
      }
    }

    result.sentCount = total - failed;

    if (total !== failed) {
      result.status = NotificationSuccessResult.PARTIAL_SUCCESS;
    } else if (total === failed) {
      result.status = NotificationSuccessResult.FAIL;
    }

    this.logger.log(
      `Sucessfully sent ${total - failed} out of ${total} notifications`,
    );

    return result;
  }

  mapNotificationData(...pairs: INotificationTokenPair[]): TokenMessage[] {
    return pairs.map((pair) => ({
      token: pair.token,
      notification: {
        title: pair.notification.title,
        body: pair.notification.description,
      },
      data: {
        title: pair.notification.title,
        body: pair.notification.description,
        redirectScreen: pair.notification.redirectScreen,
        meta: JSON.stringify(pair.notification.meta ?? ''),
      },
    }));
  }
}
