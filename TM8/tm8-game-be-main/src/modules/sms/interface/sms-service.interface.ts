import { TSmsProviderContent } from 'src/modules/twilio/interface/sms-provider.interface';

export enum SmsServiceResult {
  SUCCESS,
  FAIL,
}

export interface ISmsService {
  sendVerificationCodeSms(
    options: TSmsProviderContent,
  ): Promise<SmsServiceResult>;
}

export const SmsServiceToken = Symbol('SmsServiceToken');
