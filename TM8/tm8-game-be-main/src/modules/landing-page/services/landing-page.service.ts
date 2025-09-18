import { Inject, Injectable } from '@nestjs/common';

import { TGMDExternalServiceException } from 'src/common/exceptions/custom.exception';
import {
  EmailServiceResult,
  EmailServiceToken,
  IEmailService,
} from 'src/modules/email/interface/email-service.interface';

import { AbstractLandingPageService } from '../abstract/landing-page.abstract.service';
import { ContactFormInput } from '../dto/contact-form.input';

@Injectable()
export class LandingPageService extends AbstractLandingPageService {
  constructor(
    @Inject(EmailServiceToken) private readonly emailService: IEmailService,
  ) {
    super();
  }

  /**
   * Send contact form email
   * @param contactFormInput - contactFormInput
   * @returns void
   */
  async sendContactForm(contactFormInput: ContactFormInput): Promise<void> {
    const { firstName, lastName, email, message } = contactFormInput;
    const name = `${firstName} ${lastName}`;
    const emailResult = await this.emailService.sendEmailContactForm(
      name,
      email,
      message,
    );
    if (emailResult !== EmailServiceResult.SUCCESS) {
      throw new TGMDExternalServiceException('Email sending failed');
    }
  }
}
