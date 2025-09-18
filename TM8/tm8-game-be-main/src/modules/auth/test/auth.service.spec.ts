/* eslint-disable @typescript-eslint/ban-ts-comment */
import 'reflect-metadata';

import { TestBed } from '@automock/jest';
import { faker } from '@faker-js/faker';
import { JwtService } from '@nestjs/jwt';
import * as argon2 from 'argon2';
import { OAuth2Client } from 'google-auth-library';
import * as verifyAppleToken from 'verify-apple-id-token';

import { RootConfig } from 'src/common/config/env.validation';
import { UserStatusType } from 'src/common/constants';
import {
  TGMDConflictException,
  TGMDExternalServiceException,
  TGMDForbiddenException,
  TGMDNotFoundException,
  TGMDUnauthorizedException,
} from 'src/common/exceptions/custom.exception';
import {
  EmailServiceResult,
  EmailServiceToken,
} from 'src/modules/email/interface/email-service.interface';
import { EmailService } from 'src/modules/email/providers/email.service';
import { AbstractEpicGamesService } from 'src/modules/epic-games/abstract/epic-games.abstract.service';
import {
  SmsServiceResult,
  SmsServiceToken,
} from 'src/modules/sms/interface/sms-service.interface';
import { SmsService } from 'src/modules/sms/providers/sms.service';
import { AbstractUserRepository } from 'src/modules/user/abstract/user.abstract.repository';
import { User } from 'src/modules/user/schemas/user.schema';

import { AuthService } from '../services/auth.service';
import {
  epicGamesTokenResponseMock,
  epicGamesUserResponseMock,
  epicGamesVerifyInputMock,
  storeEpicDataMock,
} from './mocks/epic-games-verify-input.mocks';
import {
  forgotPasswordEmailMock,
  forgotPasswordPhoneMock,
  forgotPasswordUserResponseMock,
} from './mocks/forgot-password.mocks';
import {
  loginDtoMock,
  tokenResponseMock,
  userResponseMock,
} from './mocks/login.mocks';
import {
  correctRefreshTokensInputMock,
  incorrectRefreshTokensInputMock,
  refreshTokenResponseMock,
  refreshUserResponseMock,
} from './mocks/refresh-token.mocks';
import { registerInput, userRegisteredResponse } from './mocks/register.mocks';
import {
  resendCodeInput,
  resendCodeUserRepositoryMock,
  updatedResendCodeUserRepositoryMock,
} from './mocks/resend-code.mocks';
import {
  resetPasswordMock,
  resetPasswordTokenResponseMock,
  resetPasswordUserResponseMock,
} from './mocks/reset-password.mocks';
import {
  setDateOfBirthInputMock,
  setDateOfBirthMockResponse,
} from './mocks/set-date-of-birth.mocks';
import {
  setUserPhoneInputMock,
  setUserPhoneUserResponseMock,
  userWithVerificationCodeResponseMock,
} from './mocks/set-user-phone.mocks';
import {
  appleVerifyTokenResponseMock,
  existingAppleUserResponse,
  verifyAppleIdInputMock,
  verifyAppleIdNoEmailInputMock,
  verifyAppleTokenResponse,
} from './mocks/verify-apple-id.mocks';
import {
  verifyForgotPasswordMock,
  verifyForgotPasswordUserResponseMock,
} from './mocks/verify-forgot-password.mocks';
import {
  existingGoogleUserResponse,
  googleVerifyTokenResponseMock,
  verifyGoogleIdInputMock,
  verifyGoogleTokenResponse,
} from './mocks/verify-google-id.mocks';
import {
  updatedVerifyPhoneUserRepositoryMock,
  verifyPhoneInput,
  verifyPhoneResponseMock,
  verifyPhoneTokenResponseMock,
  verifyPhoneUserRepositoryMock,
} from './mocks/verify-phone.mocks';

describe('AuthService', () => {
  let authService: AuthService;
  let userRepository: jest.Mocked<AbstractUserRepository>;
  let rootConfig: jest.Mocked<RootConfig>;
  let jwtService: jest.Mocked<JwtService>;
  let emailService: jest.Mocked<EmailService>;
  let smsService: jest.Mocked<SmsService>;
  let epicGamesService: jest.Mocked<AbstractEpicGamesService>;

  beforeAll(() => {
    const { unit, unitRef } = TestBed.create(AuthService).compile();

    authService = unit;

    // @ts-ignore
    userRepository = unitRef.get(AbstractUserRepository);
    rootConfig = unitRef.get(RootConfig);
    jwtService = unitRef.get(JwtService);
    emailService = unitRef.get(EmailServiceToken);
    smsService = unitRef.get(SmsServiceToken);
    // @ts-ignore
    epicGamesService = unitRef.get(AbstractEpicGamesService);

    rootConfig.JWT.SECRET = 'test secret';
    rootConfig.JWT.EXPIRY = '2h';
    rootConfig.JWT.REFRESH = {
      SECRET: 'test secret',
      EXPIRY: '7d',
    };
  });

  describe('login', () => {
    it('should throw TGMDUnauthorizedException if user is not found when logging in', async () => {
      //arrange
      userRepository.findOne.mockResolvedValue(null);

      expect(async () => {
        //act
        await authService.login(loginDtoMock);

        //assert
      }).rejects.toThrow(TGMDUnauthorizedException);
    });

    it('should throw TGMDConflictException if user has not verified their phone number', async () => {
      //arrange
      // @ts-ignore
      userRepository.findOne.mockResolvedValue({
        ...userResponseMock,
        phoneVerified: false,
      });

      jest
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        .spyOn(AuthService.prototype as any, 'checkIfPasswordIsValid')
        .mockResolvedValue(true);

      expect(async () => {
        //act
        await authService.login(loginDtoMock);

        //assert
      }).rejects.toThrow(TGMDConflictException);
    });

    it('should throw TGMDForbiddenException if user is banned from the platform', async () => {
      //arrange
      // @ts-ignore
      userRepository.findOne.mockResolvedValue({
        ...userResponseMock,
        status: { type: UserStatusType.Banned },
      });

      jest
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        .spyOn(AuthService.prototype as any, 'checkIfPasswordIsValid')
        .mockResolvedValue(true);

      expect(async () => {
        //act
        await authService.login(loginDtoMock);

        //assert
      }).rejects.toThrow(TGMDForbiddenException);
    });

    it('should throw TGMDForbiddenException if user is suspended from the platform', async () => {
      //arrange
      // @ts-ignore
      userRepository.findOne.mockResolvedValue({
        ...userResponseMock,
        status: { type: UserStatusType.Suspended },
      });

      jest
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        .spyOn(AuthService.prototype as any, 'checkIfPasswordIsValid')
        .mockResolvedValue(true);

      expect(async () => {
        //act
        await authService.login(loginDtoMock);

        //assert
      }).rejects.toThrow(TGMDForbiddenException);
    });

    it('should throw TGMDUnauthorizedException if password does not match when logging in', async () => {
      //arrange
      // @ts-ignore
      userRepository.findOne.mockResolvedValue(userResponseMock);

      jest
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        .spyOn(AuthService.prototype as any, 'checkIfPasswordIsValid')
        .mockRejectedValue(
          new TGMDUnauthorizedException('Invalid credentials'),
        );

      expect(async () => {
        //act
        await authService.login(loginDtoMock);

        //assert
      }).rejects.toThrow(TGMDUnauthorizedException);
    });

    it('should throw TGMDExternalServiceException if chat token or user upsert fail', async () => {
      //arrange
      // @ts-ignore
      userRepository.findOne.mockResolvedValue(userResponseMock);

      jest
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        .spyOn(AuthService.prototype as any, 'checkIfPasswordIsValid')
        .mockResolvedValue(true);

      jest
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        .spyOn(AuthService.prototype as any, 'validateUser')
        .mockImplementation(async () => {
          jwtService.signAsync.mockResolvedValue('token');
          jest.spyOn(argon2, 'hash').mockResolvedValue('token');
          return tokenResponseMock;
        });

      jest
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        .spyOn(AuthService.prototype as any, 'chatUserUpsertAndFetchToken')
        .mockRejectedValue(new TGMDExternalServiceException(''));

      expect(
        //act
        async () => await authService.login(loginDtoMock),

        //assert
      ).rejects.toThrow(TGMDExternalServiceException);
    });

    it('should return tokens on successfull login', async () => {
      //arrange
      // @ts-ignore
      userRepository.findOne.mockResolvedValue(userResponseMock);

      jest
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        .spyOn(AuthService.prototype as any, 'checkIfPasswordIsValid')
        .mockResolvedValue(true);

      jest
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        .spyOn(AuthService.prototype as any, 'validateUser')
        .mockImplementation(async () => {
          jwtService.signAsync.mockResolvedValue('token');
          jest.spyOn(argon2, 'hash').mockResolvedValue('token');
          return tokenResponseMock;
        });

      jest
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        .spyOn(AuthService.prototype as any, 'chatUserUpsertAndFetchToken')
        .mockResolvedValue(expect.any(String));

      userRepository.updateOneById.mockResolvedValue({
        ...userResponseMock,
        refreshToken: 'token',
        phoneNumber: faker.phone.number(),
        status: { type: UserStatusType.Active },
      } as User);

      //act
      const tokenResponse = await authService.login(loginDtoMock);

      //assert
      expect(tokenResponse).toEqual(tokenResponseMock);
    });
  });

  describe('refreshTokens', () => {
    it('should throw TGMDNotFoundException if user is not found when refreshing token', async () => {
      //arrange
      userRepository.findOne.mockResolvedValue(null);

      expect(async () => {
        //act
        await authService.refreshTokens(incorrectRefreshTokensInputMock);

        //assert
      }).rejects.toThrow(TGMDNotFoundException);
    });

    it('should throw TGMDNotFoundException if refresh token is not valid when refreshing token', async () => {
      //arrange
      userRepository.findOne.mockResolvedValue(null);

      expect(async () => {
        //act
        await authService.refreshTokens(incorrectRefreshTokensInputMock);

        //assert
      }).rejects.toThrow(TGMDNotFoundException);
    });

    it('should return tokens on successful token refresh', async () => {
      //arrange
      // @ts-ignore
      userRepository.findOneLean.mockResolvedValue(refreshUserResponseMock);

      jest.spyOn(argon2, 'verify').mockResolvedValue(true);

      jest
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        .spyOn(AuthService.prototype as any, 'validateUser')
        .mockImplementation(async () => {
          jwtService.signAsync.mockResolvedValue('token');
          jest.spyOn(argon2, 'hash').mockResolvedValue('token');
          return tokenResponseMock;
        });

      userRepository.updateOneById.mockResolvedValue({
        ...userResponseMock,
        refreshToken: 'token',
        phoneNumber: faker.phone.number(),
        status: { type: UserStatusType.Active },
      } as User);

      //act
      const tokenResponse = await authService.refreshTokens(
        correctRefreshTokensInputMock,
      );

      //assert
      expect(tokenResponse).toEqual(refreshTokenResponseMock);
    });
  });

  describe('initiateForgotPassword', () => {
    it('should throw TGMDNotFoundException if email for forgot password is not valid', async () => {
      //arrange
      userRepository.findOne.mockResolvedValue(null);

      expect(async () => {
        //act
        await authService.initiateForgotPassword(forgotPasswordEmailMock);

        //assert
      }).rejects.toThrow(TGMDNotFoundException);
    });

    it('should throw TGMDExternalServiceException if email sending fails', async () => {
      //arrange
      userRepository.findOne.mockResolvedValue(forgotPasswordUserResponseMock);
      forgotPasswordUserResponseMock.save = jest
        .fn()
        .mockReturnValue(forgotPasswordUserResponseMock);
      emailService.sendEmailAdminForgotPassword.mockResolvedValue(
        EmailServiceResult.FAIL,
      );

      expect(async () => {
        //act
        await authService.initiateForgotPassword(forgotPasswordEmailMock);

        //assert
      }).rejects.toThrow(TGMDExternalServiceException);
    });

    it('should throw TGMDExternalServiceException if SMS sending fails', async () => {
      //arrange
      userRepository.findOne.mockResolvedValue(forgotPasswordUserResponseMock);
      userRepository.updateOneById.mockResolvedValue(
        forgotPasswordUserResponseMock,
      );

      smsService.sendVerificationCodeSms.mockResolvedValue(
        SmsServiceResult.FAIL,
      );

      expect(async () => {
        //act
        await authService.initiateForgotPassword(forgotPasswordPhoneMock);

        //assert
      }).rejects.toThrow(TGMDExternalServiceException);
    });

    it('should return void on succesfull forgot password request with sms', async () => {
      //arrange
      userRepository.findOne.mockResolvedValue(forgotPasswordUserResponseMock);

      userRepository.updateOneById.mockResolvedValue(
        forgotPasswordUserResponseMock,
      );

      smsService.sendVerificationCodeSms.mockResolvedValue(
        SmsServiceResult.SUCCESS,
      );

      //act
      const result = await authService.initiateForgotPassword(
        forgotPasswordPhoneMock,
      );

      //assert
      expect(result).toEqual(undefined);
    });

    it('should return void on successfull forgot password request with email', async () => {
      //arrange
      userRepository.findOne.mockResolvedValue(forgotPasswordUserResponseMock);
      forgotPasswordUserResponseMock.save = jest
        .fn()
        .mockReturnValue(forgotPasswordUserResponseMock);
      emailService.sendEmailAdminForgotPassword.mockResolvedValue(
        EmailServiceResult.SUCCESS,
      );

      //act
      const result = await authService.initiateForgotPassword(
        forgotPasswordEmailMock,
      );

      //assert
      expect(result).toEqual(undefined);
    });
  });

  describe('verifyForgotPassword', () => {
    it('should throw TGMDNotFoundException if user with given code for forgot password is not found', async () => {
      //arrange
      userRepository.findOne.mockResolvedValue(null);

      expect(async () => {
        //act
        await authService.verifyForgotPassword(verifyForgotPasswordMock);

        //assert
      }).rejects.toThrow(TGMDNotFoundException);
    });

    it('should return void on successfull forgot password verification', async () => {
      //arrange
      userRepository.findOne.mockResolvedValue(
        verifyForgotPasswordUserResponseMock,
      );

      userRepository.updateOneById.mockResolvedValue(
        verifyForgotPasswordUserResponseMock,
      );

      //act
      const result = await authService.verifyForgotPassword(
        verifyForgotPasswordMock,
      );

      //assert
      expect(result).toEqual(undefined);
    });
  });

  describe('resetPassword', () => {
    it('should throw TGMDNotFoundException if user that resets the password cannot be found in the database', async () => {
      //arrange
      userRepository.findOne.mockResolvedValue(null);

      expect(async () => {
        //act
        await authService.resetPassword(resetPasswordMock);

        //assert
      }).rejects.toThrow(TGMDNotFoundException);
    });

    it('should throw TGMDExternalServiceException if chat token or user upsert fail', async () => {
      //arrange
      userRepository.findOne.mockResolvedValue(resetPasswordUserResponseMock);

      jest
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        .spyOn(AuthService.prototype as any, 'chatUserUpsertAndFetchToken')
        .mockRejectedValue(new TGMDExternalServiceException(''));

      expect(
        //act
        async () => await authService.resetPassword(resetPasswordMock),

        //assert
      ).rejects.toThrow(TGMDExternalServiceException);
    });

    it('should return authentication response on successfull password reset', async () => {
      //arrange
      userRepository.findOne.mockResolvedValue(resetPasswordUserResponseMock);

      jest
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        .spyOn(AuthService.prototype as any, 'chatUserUpsertAndFetchToken')
        .mockResolvedValue(expect.any(String));

      resetPasswordUserResponseMock.save = jest
        .fn()
        .mockReturnValue(resetPasswordUserResponseMock);

      jest
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        .spyOn(AuthService.prototype as any, 'validateUser')
        .mockImplementation(async () => {
          jwtService.signAsync.mockResolvedValue('token');
          jest.spyOn(argon2, 'hash').mockResolvedValue('token');
          return resetPasswordTokenResponseMock;
        });

      //act
      const result = await authService.resetPassword(resetPasswordMock);

      //assert
      expect(result).toEqual(resetPasswordTokenResponseMock);
    });
  });

  describe('register', () => {
    it('should throw TGMDConflictException if user with that email already exists', async () => {
      //arrange
      userRepository.findOneLean.mockResolvedValue(userRegisteredResponse);

      expect(async () => {
        //act
        await authService.register(registerInput);

        //assert
      }).rejects.toThrow(TGMDConflictException);
    });

    it('should return undefined on successfull registration', async () => {
      //arrange
      userRepository.findOneLean.mockResolvedValue(null);
      userRepository.createOne.mockResolvedValue(userRegisteredResponse);

      //act
      const result = await authService.register(registerInput);

      //assert
      expect(result).toEqual(userRegisteredResponse);
    });
  });

  describe('verifyPhone', () => {
    it('should throw TGMDNotFoundException if user not found', async () => {
      //arrange
      userRepository.findOne.mockResolvedValue(null);

      expect(async () => {
        //act
        await authService.verifyPhone(verifyPhoneInput);

        //assert
      }).rejects.toThrow(TGMDNotFoundException);
    });

    it('should throw TGMDExternalServiceException if chat token or user upsert fail', async () => {
      //arrange
      userRepository.findOne.mockResolvedValue(verifyPhoneUserRepositoryMock);

      jest
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        .spyOn(AuthService.prototype as any, 'chatUserUpsertAndFetchToken')
        .mockRejectedValue(new TGMDExternalServiceException(''));

      expect(
        //act
        async () => await authService.verifyPhone(verifyPhoneInput),

        //assert
      ).rejects.toThrow(TGMDExternalServiceException);
    });

    it('should return auth response on successfull phone verification', async () => {
      //arrange
      userRepository.findOne.mockResolvedValue(verifyPhoneUserRepositoryMock);

      jest
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        .spyOn(AuthService.prototype as any, 'chatUserUpsertAndFetchToken')
        .mockResolvedValue(expect.any(String));

      userRepository.updateOneById.mockResolvedValue(
        updatedVerifyPhoneUserRepositoryMock,
      );

      jest
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        .spyOn(AuthService.prototype as any, 'validateUser')
        .mockImplementation(async () => {
          jwtService.signAsync.mockResolvedValue('token');
          jest.spyOn(argon2, 'hash').mockResolvedValue('token');
          return verifyPhoneTokenResponseMock;
        });
      //act
      const result = await authService.verifyPhone(verifyPhoneInput);

      //assert
      expect(result).toEqual(verifyPhoneResponseMock);
    });
  });

  describe('resendPhoneCode', () => {
    it('should throw TGMDNotFoundException if user is not found', async () => {
      //arrange
      userRepository.findOne.mockResolvedValue(null);

      expect(async () => {
        //act
        await authService.resendPhoneVerificationCode(resendCodeInput);

        //assert
      }).rejects.toThrow(TGMDNotFoundException);
    });

    it('should throw TGMDExternalServiceException if SMS sending fails', async () => {
      //arrange
      userRepository.findOne.mockResolvedValue(resendCodeUserRepositoryMock);

      userRepository.updateOneById.mockResolvedValue(
        updatedResendCodeUserRepositoryMock,
      );

      smsService.sendVerificationCodeSms.mockResolvedValue(
        SmsServiceResult.FAIL,
      );
      expect(async () => {
        //act
        await authService.resendPhoneVerificationCode(resendCodeInput);

        //assert
      }).rejects.toThrow(TGMDExternalServiceException);
    });

    it('should return undefined on successfull code resend', async () => {
      //arrange
      userRepository.findOne.mockResolvedValue(resendCodeUserRepositoryMock);

      resendCodeUserRepositoryMock.save = jest
        .fn()
        .mockResolvedValue(updatedResendCodeUserRepositoryMock);

      smsService.sendVerificationCodeSms.mockResolvedValue(
        SmsServiceResult.SUCCESS,
      );
      //act
      const result = await authService.resendPhoneVerificationCode(
        resendCodeInput,
      );

      //assert
      expect(result).toEqual(undefined);
    });
  });

  describe('epicGamesVerify', () => {
    it('should throw TGMDExternalServiceException if token fetching from Epic fails', async () => {
      //arrange

      epicGamesService.sendEpicTokenRequest.mockResolvedValue(null);

      expect(async () => {
        //act
        await authService.epicGamesVerify(epicGamesVerifyInputMock);
      });
    });
    it('should throw TGMDExternalServiceException user fetching from Epic fails', async () => {
      //arrange
      epicGamesService.sendEpicTokenRequest.mockResolvedValue(
        epicGamesTokenResponseMock,
      );

      epicGamesService.getEpicGamesUser.mockResolvedValue(null);

      expect(async () => {
        //act
        await authService.epicGamesVerify(epicGamesVerifyInputMock);

        //assert
      }).rejects.toThrow(TGMDExternalServiceException);
    });

    it('should throw TGMDExternalServiceException if application user not found', async () => {
      //arrange
      epicGamesService.sendEpicTokenRequest.mockResolvedValue(
        epicGamesTokenResponseMock,
      );

      epicGamesService.getEpicGamesUser.mockResolvedValue(
        epicGamesUserResponseMock,
      );

      epicGamesService.storeEpicData.mockResolvedValue(null);

      expect(async () => {
        //act
        await authService.epicGamesVerify(epicGamesVerifyInputMock);

        //assert
      }).rejects.toThrow(TGMDExternalServiceException);
    });

    it('should return undefined if Epic user is synced with application user', async () => {
      //arrange

      epicGamesService.sendEpicTokenRequest.mockResolvedValue(
        epicGamesTokenResponseMock,
      );

      epicGamesService.getEpicGamesUser.mockResolvedValue(
        epicGamesUserResponseMock,
      );

      epicGamesService.storeEpicData.mockResolvedValue(storeEpicDataMock);

      //act
      const result = await authService.epicGamesVerify(
        epicGamesVerifyInputMock,
      );

      expect(result).toEqual(undefined);
    });
  });

  describe('setUserPhone', () => {
    it('should throw TGMDNotFoundException if user is not found', async () => {
      //arrange
      userRepository.findOne.mockResolvedValue(null);

      expect(async () => {
        //act
        await authService.setUserPhone(setUserPhoneInputMock);

        //assert
      }).rejects.toThrow(TGMDNotFoundException);
    });

    it('should throw TGMDForbiddenException if user has already verified their phone number', async () => {
      //arrange
      userRepository.findOneLean.mockResolvedValue({
        ...setUserPhoneUserResponseMock,
        phoneVerified: true,
      });

      expect(async () => {
        //act
        await authService.setUserPhone(setUserPhoneInputMock);

        //assert
      }).rejects.toThrow(TGMDForbiddenException);
    });

    it('should throw TGMDExternalServiceException if SMS sending fails', async () => {
      //arrange
      userRepository.findOneLean.mockResolvedValue(
        setUserPhoneUserResponseMock,
      );

      userRepository.updateOneById.mockResolvedValue({
        ...setUserPhoneUserResponseMock,
        verificationCode: faker.number.int(),
        phoneNumber: setUserPhoneInputMock.phoneNumber,
      });

      smsService.sendVerificationCodeSms.mockResolvedValue(
        SmsServiceResult.FAIL,
      );

      expect(async () => {
        //act
        await authService.setUserPhone(setUserPhoneInputMock);

        //assert
      }).rejects.toThrow(TGMDExternalServiceException);
    });

    it('should return user response on success', async () => {
      //arrange
      userRepository.findOneLean.mockResolvedValue(
        setUserPhoneUserResponseMock,
      );

      userRepository.updateOneById.mockResolvedValue(
        userWithVerificationCodeResponseMock,
      );

      smsService.sendVerificationCodeSms.mockResolvedValue(
        SmsServiceResult.SUCCESS,
      );
      //act
      const result = await authService.setUserPhone(setUserPhoneInputMock);

      //assert
      expect(result).toEqual(userWithVerificationCodeResponseMock);
    });
  });

  describe('verifyAppleIdToken', () => {
    it('should throw TGMDConflictException if there is no registered user and no email provided', async () => {
      //arrange

      jest
        .spyOn(verifyAppleToken, 'default')
        .mockResolvedValue(verifyAppleTokenResponse);

      userRepository.findOne.mockResolvedValue(null);

      expect(async () => {
        //act
        await authService.verifyAppleIdToken(verifyAppleIdNoEmailInputMock);

        //assert
      }).rejects.toThrow(TGMDConflictException);
    });

    it('should throw TGMDConflictException if there is an existing user with given email', async () => {
      //arrange

      jest
        .spyOn(verifyAppleToken, 'default')
        .mockResolvedValue(verifyAppleTokenResponse);

      userRepository.findOne.mockResolvedValueOnce(null);

      userRepository.findOne.mockResolvedValue(existingAppleUserResponse);

      expect(async () => {
        //act
        await authService.verifyAppleIdToken(verifyAppleIdInputMock);

        //assert
      }).rejects.toThrow(TGMDConflictException);
    });

    it('should throw TGMDExternalServiceException if chat token or user upsert fail', async () => {
      //arrange
      jest
        .spyOn(verifyAppleToken, 'default')
        .mockResolvedValue(verifyAppleTokenResponse);

      userRepository.findOne.mockResolvedValue(null);

      userRepository.createOne.mockResolvedValue(existingAppleUserResponse);

      jest
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        .spyOn(AuthService.prototype as any, 'chatUserUpsertAndFetchToken')
        .mockRejectedValue(new TGMDExternalServiceException(''));

      expect(
        //act
        async () =>
          await authService.verifyAppleIdToken(verifyAppleIdInputMock),

        //assert
      ).rejects.toThrow(TGMDExternalServiceException);
    });

    it('should return auth response on success', async () => {
      //arrange
      jest
        .spyOn(verifyAppleToken, 'default')
        .mockResolvedValue(verifyAppleTokenResponse);

      userRepository.findOne.mockResolvedValue(null);

      userRepository.createOne.mockResolvedValue(existingAppleUserResponse);

      jest
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        .spyOn(AuthService.prototype as any, 'chatUserUpsertAndFetchToken')
        .mockResolvedValue(expect.any(String));

      userRepository.updateOneById.mockResolvedValue(existingAppleUserResponse);

      //act
      const result = await authService.verifyAppleIdToken(
        verifyAppleIdInputMock,
      );

      //assert
      expect(result).toEqual(appleVerifyTokenResponseMock);
    });
  });

  describe('verifyGoogleIdToken', () => {
    it('should throw TGMDConflictException if there is an existing user with given email', async () => {
      //arrange

      jest
        .spyOn(OAuth2Client.prototype, 'getTokenInfo')
        .mockResolvedValue(verifyGoogleTokenResponse);

      userRepository.findOneLean.mockResolvedValueOnce(null);

      userRepository.findOneLean.mockResolvedValue(existingGoogleUserResponse);

      expect(async () => {
        //act
        await authService.verifyGoogleIdToken(verifyGoogleIdInputMock);

        //assert
      }).rejects.toThrow(TGMDConflictException);
    });

    it('should throw TGMDExternalServiceException if chat token or user upsert fail', async () => {
      //arrange
      jest
        .spyOn(OAuth2Client.prototype, 'getTokenInfo')
        .mockResolvedValue(verifyGoogleTokenResponse);

      userRepository.findOne.mockResolvedValue(null);

      userRepository.createOne.mockResolvedValue(existingGoogleUserResponse);

      jest
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        .spyOn(AuthService.prototype as any, 'chatUserUpsertAndFetchToken')
        .mockRejectedValue(new TGMDExternalServiceException(''));

      expect(
        //act
        async () =>
          await authService.verifyGoogleIdToken(verifyGoogleIdInputMock),

        //assert
      ).rejects.toThrow(TGMDExternalServiceException);
    });

    it('should return auth response on new user registered success', async () => {
      //arrange
      jest
        .spyOn(OAuth2Client.prototype, 'getTokenInfo')
        .mockResolvedValue(verifyGoogleTokenResponse);

      userRepository.findOne.mockResolvedValue(null);

      userRepository.createOne.mockResolvedValue(existingGoogleUserResponse);

      jest
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        .spyOn(AuthService.prototype as any, 'chatUserUpsertAndFetchToken')
        .mockResolvedValue(expect.any(String));

      userRepository.updateOneById.mockResolvedValue(
        existingGoogleUserResponse,
      );

      //act
      const result = await authService.verifyGoogleIdToken(
        verifyGoogleIdInputMock,
      );

      //assert
      expect(result).toEqual(googleVerifyTokenResponseMock);
    });

    it('should return auth response on new user registered success', async () => {
      //arrange
      jest
        .spyOn(OAuth2Client.prototype, 'getTokenInfo')
        .mockResolvedValue(verifyGoogleTokenResponse);

      userRepository.findOne.mockResolvedValue(existingGoogleUserResponse);

      userRepository.updateOneById.mockResolvedValue(
        existingGoogleUserResponse,
      );

      //act
      const result = await authService.verifyGoogleIdToken(
        verifyGoogleIdInputMock,
      );

      //assert
      expect(result).toEqual(googleVerifyTokenResponseMock);
    });
  });

  describe('setDateOfBirth', () => {
    it('should throw TGMDNotFoundException if user with given criteria not found', async () => {
      //arrange
      const userId = faker.database.mongodbObjectId();
      userRepository.findOneLean.mockResolvedValue(null);

      expect(async () => {
        //act
        await authService.setDateOfBirth(userId, setDateOfBirthInputMock);

        //assert
      }).rejects.toThrow(TGMDNotFoundException);
    });

    it('should return undefined on success', async () => {
      //arrange
      userRepository.findOneLean.mockResolvedValue(setDateOfBirthMockResponse);
      userRepository.updateOneById.mockResolvedValue(undefined);

      //act
      const result = await authService.setDateOfBirth(
        setDateOfBirthMockResponse._id,
        setDateOfBirthInputMock,
      );

      //assert
      expect(result).toEqual(undefined);
    });
  });
});
