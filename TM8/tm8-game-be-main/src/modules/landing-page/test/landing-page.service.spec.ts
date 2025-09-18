/* eslint-disable @typescript-eslint/ban-ts-comment */

import { TestBed } from '@automock/jest';

import { TGMDExternalServiceException } from 'src/common/exceptions/custom.exception';
import {
  EmailServiceResult,
  EmailServiceToken,
  IEmailService,
} from 'src/modules/email/interface/email-service.interface';

import { LandingPageService } from '../services/landing-page.service';
import { contactFormInput } from './mocks/send-contact-form.mock';

describe('LandingPageService', () => {
  let landingPageService: LandingPageService;

  let emailService: jest.Mocked<IEmailService>;

  beforeAll(() => {
    const { unit, unitRef } = TestBed.create(LandingPageService).compile();

    landingPageService = unit;

    emailService = unitRef.get(EmailServiceToken);
  });

  describe('sendContactEmail', () => {
    it('should throw TGMDExternalServiceException if email sending fails', async () => {
      //arrange

      emailService.sendEmailContactForm.mockResolvedValue(
        EmailServiceResult.FAIL,
      );

      expect(async () => {
        //act
        await landingPageService.sendContactForm(contactFormInput);

        //assert
      }).rejects.toThrow(TGMDExternalServiceException);
    });

    it('should return empty response if email sending succeeds', async () => {
      //arrange
      emailService.sendEmailContactForm.mockResolvedValue(
        EmailServiceResult.SUCCESS,
      );

      //act
      const result = await landingPageService.sendContactForm(contactFormInput);

      //assert
      expect(result).toEqual(undefined);
    });
  });
});
