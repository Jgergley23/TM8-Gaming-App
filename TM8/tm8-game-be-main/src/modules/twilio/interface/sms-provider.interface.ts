export interface SmsProviderContact {
  to: string;
}

export interface SmsProviderContent extends SmsProviderContact {
  body: string;
}

export type TSmsProviderContent = SmsProviderContent;

export interface ISmsProviderService {
  /**
   * Sends an SMS through the SMS provider.
   * @param msg - The message to be sent.
   * @returns  Void
   */
  sendVerificationCodeSms(options: TSmsProviderContent): Promise<void>;
}

export const SmsProviderServiceToken = Symbol('SmsProviderService');
