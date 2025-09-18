import { Inject, Injectable } from '@nestjs/common';
import { WINSTON_MODULE_NEST_PROVIDER, WinstonLogger } from 'nest-winston';
import * as twilio from 'twilio';
import TwilioClient from 'twilio/lib/rest/Twilio';
import {
  MessageInstance,
  MessageListInstanceCreateOptions,
} from 'twilio/lib/rest/api/v2010/account/message';

import { TwilioConfig } from 'src/common/config/env.validation';

import { AbstractUserRepository } from '../../user/abstract/user.abstract.repository';
import {
  ISmsProviderService,
  TSmsProviderContent,
} from '../interface/sms-provider.interface';

@Injectable()
export class TwilioSmsService implements ISmsProviderService {
  client: TwilioClient;

  constructor(
    private readonly twilioConfig: TwilioConfig,
    private readonly userRepository: AbstractUserRepository,
    @Inject(WINSTON_MODULE_NEST_PROVIDER)
    private readonly logger: WinstonLogger,
  ) {
    const twilioAccountSid = this.twilioConfig.ACCOUNTSID;
    const twilioAuthToken = this.twilioConfig.TOKEN;
    this.client = twilio(twilioAccountSid, twilioAuthToken);
  }

  /**
   * Sends sms to the user
   * @param options - message options
   * @param retryCount - send retry count
   * @returns - message result
   */
  private async send(
    options: MessageListInstanceCreateOptions,
    retryCount = 0,
  ): Promise<MessageInstance> {
    try {
      const from = this.twilioConfig.FROM;

      return await this.client.messages.create({ ...options, from });
    } catch (error) {
      if (retryCount < this.twilioConfig.RETRIES) {
        this.logger.debug(
          `SMS to ${options.to} failed, retrying (${
            this.twilioConfig.RETRIES - retryCount
          } attempts left)`,
          String(error),
        );
        // Recursive call for retry
        await this.send(options, retryCount + 1);
      } else {
        // Max retries reached, log the error or handle it as needed
        this.logger.error(
          `SMS to ${options.to} failed after ${this.twilioConfig.RETRIES} attempts`,
          String(error),
        );
        throw error;
      }
    }
  }

  async sendVerificationCodeSms(options: TSmsProviderContent): Promise<void> {
    await this.send({
      ...options,
      body: `This is your TM8 code. Dont share it with anyone: ${options.body}`,
    });
  }
}
