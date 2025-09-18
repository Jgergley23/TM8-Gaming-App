import { Request } from 'express';

import { SetUserPhoneInput } from 'src/modules/auth/dto/set-user-phone.input';
import { IUserRecord } from 'src/modules/user/interface/user.interface';
import { User } from 'src/modules/user/schemas/user.schema';

import { EpicGamesVerifyInput } from '../dto/epic-games-verify.input';
import { ForgotPasswordInput } from '../dto/forgot-password.input';
import { AuthLoginInput } from '../dto/login.input';
import { PhoneVerificationInput } from '../dto/phone-verification.input';
import { RegisterInput } from '../dto/register-input';
import { ResetPasswordInput } from '../dto/reset-password.input';
import { SetDateOfBirthInput } from '../dto/set-date-of-birth.input';
import { VerifyAppleIdInput } from '../dto/verify-apple-id.input';
import { VerifyCodeInput } from '../dto/verify-code.input';
import { VerifyGoogleIdInput } from '../dto/verify-google-id.input';
import { AuthResponse } from '../response/auth.response';

export abstract class AbstractAuthService {
  abstract login(loginInput: AuthLoginInput): Promise<AuthResponse>;
  abstract refreshTokens(req: Request): Promise<AuthResponse>;
  abstract initiateForgotPassword(
    forgotPasswordInput: ForgotPasswordInput,
  ): Promise<void>;
  abstract verifyForgotPassword(
    verifyForgotPasswordInput: VerifyCodeInput,
  ): Promise<void>;
  abstract resetPassword(
    resetPasswordInput: ResetPasswordInput,
  ): Promise<AuthResponse>;
  abstract register(registerInput: RegisterInput): Promise<IUserRecord>;
  abstract verifyPhone(
    verifyPhoneInput: VerifyCodeInput,
  ): Promise<AuthResponse>;
  abstract resendPhoneVerificationCode(
    phoneVerificationInput: PhoneVerificationInput,
  ): Promise<void>;
  abstract epicGamesVerify(
    epicGamesVerifyInput: EpicGamesVerifyInput,
  ): Promise<void>;
  abstract setUserPhone(setUserPhoneInput: SetUserPhoneInput): Promise<User>;
  abstract verifyAppleIdToken(
    verifyInput: VerifyAppleIdInput,
  ): Promise<AuthResponse>;
  abstract verifyGoogleIdToken(
    input: VerifyGoogleIdInput,
  ): Promise<AuthResponse>;
  abstract setDateOfBirth(
    userId: string,
    setDateOfBirthInput: SetDateOfBirthInput,
  ): Promise<void>;
}
