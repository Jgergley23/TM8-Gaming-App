import { Inject, Injectable } from '@nestjs/common';
import { WINSTON_MODULE_NEST_PROVIDER, WinstonLogger } from 'nest-winston';

import { SendgridConfig } from 'src/common/config/env.validation';
import {
  EmailProviderServiceToken,
  IEmailProviderService,
} from 'src/modules/sendgrid/interface/email-provider.interface';

import {
  EmailServiceResult,
  IEmailService,
} from '../interface/email-service.interface';

@Injectable()
export class EmailService implements IEmailService {
  constructor(
    @Inject(EmailProviderServiceToken)
    private readonly emailProvider: IEmailProviderService,
    @Inject(WINSTON_MODULE_NEST_PROVIDER)
    private readonly logger: WinstonLogger,
    private readonly sendgridConfig: SendgridConfig,
  ) {}

  /**
   * Send email for admin forgot password
   * @param email - user email
   * @param code - verification code
   * @returns email service result response
   */
  async sendEmailAdminForgotPassword(
    email: string,
    code: string,
  ): Promise<EmailServiceResult> {
    let result = EmailServiceResult.SUCCESS;
    try {
      await this.emailProvider.sendEmail({
        from: this.sendgridConfig.FROM,
        to: email,
        templateId: this.sendgridConfig.TEMPLATE.ADMINFORGOTPASSWORD,
        dynamicTemplateData: {
          verificationCode: code,
        },
      });
    } catch (err) {
      this.logger.error(err);
      result = EmailServiceResult.FAIL;
    }
    return result;
  }

  /**
   * Send email for admin account created
   * @param email - user email
   * @param name - user name
   * @param password - user password
   * @returns email service result response
   */
  async sendEmailAdminAccountCreated(
    email: string,
    name: string,
    password: string,
  ): Promise<EmailServiceResult> {
    let result = EmailServiceResult.SUCCESS;
    try {
      await this.emailProvider.sendEmail({
        from: this.sendgridConfig.FROM,
        to: email,
        templateId: this.sendgridConfig.TEMPLATE.ADMINACCOUNTCREATED,
        dynamicTemplateData: {
          password: password,
          name: name,
        },
      });
    } catch (err) {
      this.logger.error(err);
      result = EmailServiceResult.FAIL;
    }
    return result;
  }

  /**
   * Send email from contact fom
   * @param name - contact name
   * @param email - contact email
   * @param message - contact message
   * @returns email service result response
   */
  async sendEmailContactForm(
    name: string,
    email: string,
    message: string,
  ): Promise<EmailServiceResult> {
    let result = EmailServiceResult.SUCCESS;
    try {
      await this.emailProvider.sendEmail({
        from: this.sendgridConfig.FROM,
        to: this.sendgridConfig.FROM,
        templateId: this.sendgridConfig.TEMPLATE.CONTACTFORM,
        dynamicTemplateData: {
          message: message,
          name: name,
          email: email,
        },
      });
    } catch (err) {
      this.logger.error(err);
      result = EmailServiceResult.FAIL;
    }
    return result;
  }

  /**
   * Send email for user email change
   * @param email - user email
   * @param code - verification code
   * @returns email service result response
   */
  async sendEmailUserEmailChange(
    email: string,
    code: string,
    username: string,
  ): Promise<EmailServiceResult> {
    let result = EmailServiceResult.SUCCESS;
    try {
      await this.emailProvider.sendEmail({
        from: this.sendgridConfig.FROM,
        to: email,
        templateId: this.sendgridConfig.TEMPLATE.USERCHANGEEMAIL,
        dynamicTemplateData: {
          verificationCode: code,
          name: username,
        },
      });
    } catch (err) {
      this.logger.error(err);
      result = EmailServiceResult.FAIL;
    }
    return result;
  }
}
