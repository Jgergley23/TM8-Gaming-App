import { Inject, Injectable } from '@nestjs/common';
import { WINSTON_MODULE_NEST_PROVIDER, WinstonLogger } from 'nest-winston';

import {
  ISmsProviderService,
  SmsProviderServiceToken,
  TSmsProviderContent,
} from 'src/modules/twilio/interface/sms-provider.interface';

import {
  ISmsService,
  SmsServiceResult,
} from '../interface/sms-service.interface';

@Injectable()
export class SmsService implements ISmsService {
  constructor(
    @Inject(SmsProviderServiceToken)
    private readonly smsProvider: ISmsProviderService,
    @Inject(WINSTON_MODULE_NEST_PROVIDER)
    private readonly logger: WinstonLogger,
  ) {}

  /**
   * Send verification code SMS
   * @param options - message content
   * @returns - message result
   */
  async sendVerificationCodeSms(
    options: TSmsProviderContent,
  ): Promise<SmsServiceResult> {
    let result = SmsServiceResult.SUCCESS;
    try {
      await this.smsProvider.sendVerificationCodeSms(options);
    } catch (error) {
      this.logger.error(error);
      result = SmsServiceResult.FAIL;
    }
    return result;
  }
}
