/* eslint-disable complexity */
import { Inject, Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import * as argon2 from 'argon2';
import { Request } from 'express';
import { OAuth2Client } from 'google-auth-library';
import * as moment from 'moment';
import verifyAppleToken from 'verify-apple-id-token';

import { RootConfig } from 'src/common/config/env.validation';
import { Role, SignupType, UserStatusType } from 'src/common/constants';
import { USERNAME_MAX_LENGTH } from 'src/common/constants/user-info';
import {
  TGMDConflictException,
  TGMDExternalServiceException,
  TGMDForbiddenException,
  TGMDNotFoundException,
  TGMDRefreshTokenFailedException,
  TGMDUnauthorizedException,
} from 'src/common/exceptions/custom.exception';
import { CryptoUtils } from 'src/common/utils/crypto.utils';
import { StringUtils } from 'src/common/utils/string.utils';
import { SetUserPhoneInput } from 'src/modules/auth/dto/set-user-phone.input';
import {
  ChatUserServiceToken,
  IChatUserService,
} from 'src/modules/chat/interface/chat-service.interface';
import {
  EmailServiceResult,
  EmailServiceToken,
  IEmailService,
} from 'src/modules/email/interface/email-service.interface';
import { AbstractEpicGamesService } from 'src/modules/epic-games/abstract/epic-games.abstract.service';
import {
  ISmsService,
  SmsServiceResult,
  SmsServiceToken,
} from 'src/modules/sms/interface/sms-service.interface';
import { AbstractUserRepository } from 'src/modules/user/abstract/user.abstract.repository';
import { IUserRecord } from 'src/modules/user/interface/user.interface';
import { User, UserDocument } from 'src/modules/user/schemas/user.schema';

import { AbstractAuthService } from '../abstract/auth.abstract.service';
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
@Injectable()
export class AuthService extends AbstractAuthService {
  private readonly oauth2Client: OAuth2Client;

  // eslint-disable-next-line max-params
  constructor(
    private readonly userRepository: AbstractUserRepository,
    private readonly rootConfig: RootConfig,
    private jwtService: JwtService,
    @Inject(EmailServiceToken)
    private readonly emailService: IEmailService,
    @Inject(SmsServiceToken) private readonly smsService: ISmsService,
    private readonly epicGamesService: AbstractEpicGamesService,
    @Inject(ChatUserServiceToken)
    private readonly chatUserService: IChatUserService,
  ) {
    super();

    const clientId = rootConfig.GOOGLE.CLIENTID;
    const clientSecret = rootConfig.GOOGLE.CLIENTSECRET;

    this.oauth2Client = new OAuth2Client(clientId, clientSecret, '');
  }

  /**
   * Logs the user into the application
   * @param loginInput - Login credentials
   * @returns Authentication response with access tokens
   */
  async login(loginInput: AuthLoginInput): Promise<AuthResponse> {
    const { email, password, notificationToken } = loginInput;
    const user = await this.userRepository.findOne(
      { email },
      '_id email username name password phoneNumber role signupType status verifyPhoneRequested phoneVerified photoKey notificationSettings',
    );
    if (!user) throw new TGMDUnauthorizedException('Invalid email');

    await this.checkIfPasswordIsValid(password, user.password);

    if (user.role === Role.User && !user.phoneVerified)
      throw new TGMDConflictException(
        'Phone number not verified. Please verify your phone number to continue.',
      );

    if (user.status.type === UserStatusType.Banned)
      throw new TGMDForbiddenException(
        'This user has been banned from the platform',
      );

    if (user.status.type === UserStatusType.Suspended) {
      const formattedDate = moment(user.status.until).format('MM/DD/YYYY');
      throw new TGMDForbiddenException(
        `This user has been suspended until ${formattedDate}`,
      );
    }

    const validationResult = await this.validateUser(
      user._id,
      user.signupType,
      user.role,
    );

    const chatToken = await this.chatUserUpsertAndFetchToken(user);

    const updatedUser = await this.userRepository.updateOneById(user._id, {
      lastLogin: new Date(),
      chatToken: chatToken,
      notificationToken,
    });

    return {
      ...validationResult,
      username: user.username,
      name: user.name,
      role: user.role,
      id: user._id,
      chatToken: updatedUser.chatToken,
      signupType: user.signupType,
    };
  }

  /**
   * Registeres a user to the application
   * @param registerInput - registration input
   * @returns Void
   */
  async register(registerInput: RegisterInput): Promise<IUserRecord> {
    const {
      email,
      username,
      dateOfBirth,
      password,
      timezone,
      country,
      notificationToken,
    } = registerInput;

    const existingEmail = await this.userRepository.findOneLean({ email });
    if (existingEmail)
      throw new TGMDConflictException('User with that email already exists');

    const existingUsername = await this.userRepository.findOneLean({
      username,
    });
    if (existingUsername)
      throw new TGMDConflictException('User with that username already exists');

    return await this.userRepository.createOne({
      email,
      username,
      dateOfBirth,
      password,
      role: Role.User,
      signupType: SignupType.Manual,
      status: { type: UserStatusType.Pending },
      timezone,
      country,
      rating: { ratings: [], average: 0 },
      phoneVerified: false,
      notificationToken,
      notificationSettings: {
        enabled: true,
        match: true,
        message: true,
        friendAdded: true,
        news: true,
        reminders: true,
      },
      rejectedUsers: [],
    });
  }

  /**
   * Finds the user based on the input code and updates
   * the database entry to verify their phone
   * @param verifyPhoneInput - Verification code input
   * @returns Auth response
   */
  async verifyPhone(verifyPhoneInput: VerifyCodeInput): Promise<AuthResponse> {
    const { code } = verifyPhoneInput;
    const user = await this.userRepository.findOne({
      verificationCode: code,
      verifyPhoneRequested: true,
    });
    if (!user)
      throw new TGMDNotFoundException(
        'Could not find user with that verification code',
      );

    const chatToken = await this.chatUserUpsertAndFetchToken(user);

    await this.userRepository.updateOneById(user._id, {
      status: { type: UserStatusType.Active, note: '', until: null },
      verificationCode: null,
      verifyPhoneRequested: null,
      phoneVerified: true,
      chatToken: chatToken,
    });

    const response = await this.validateUser(
      user._id,
      user.signupType,
      user.role,
    );

    return {
      ...response,
      username: user.username,
      name: user.name,
      id: user._id,
      role: user.role,
      signupType: user.signupType,
      chatToken,
    };
  }

  /**
   * Resends phone verification code to user if verification is requested
   * @param phoneVerificationInput - phone number input
   * @returns Void
   */
  async resendPhoneVerificationCode(
    phoneVerificationInput: PhoneVerificationInput,
  ): Promise<void> {
    const { phoneNumber } = phoneVerificationInput;
    const user = await this.userRepository.findOne({
      phoneNumber,
      verifyPhoneRequested: true,
    });
    if (!user) throw new TGMDNotFoundException('User not found');

    const updatedUser = await this.userRepository.updateOneById(user._id, {
      verificationCode: +this.generateVerificationCode(),
    });

    const smsStatus = await this.smsService.sendVerificationCodeSms({
      body: updatedUser.verificationCode.toString(),
      to: updatedUser.phoneNumber,
    });
    if (smsStatus !== SmsServiceResult.SUCCESS) {
      throw new TGMDExternalServiceException('SMS sending failed');
    }
  }

  /**
   * Verifies Google ID token based on access token input
   * @param token - access token
   * @returns auth response
   */
  async verifyGoogleIdToken(input: VerifyGoogleIdInput): Promise<AuthResponse> {
    let user: User;
    const { fullName, token, notificationToken } = input;
    const tokenInfo = await this.oauth2Client.getTokenInfo(token);

    const { sub, email } = tokenInfo;

    user = await this.userRepository.findOneLean({
      googleSub: sub,
    });

    if (!user) {
      const userExists = !!(await this.userRepository.findOneLean({ email }));
      if (userExists)
        throw new TGMDConflictException('User already exists with that email');

      const createUser: Partial<User> = {
        email,
        name: fullName ? fullName : undefined,
        username: email.split('@')[0].substring(0, USERNAME_MAX_LENGTH),
        signupType: SignupType.Social,
        role: Role.User,
        status: { type: UserStatusType.Pending },
        googleSub: sub,
        notificationToken,
        rating: { ratings: [], average: 0 },
        rejectedUsers: [],
        notificationSettings: {
          enabled: true,
          match: true,
          message: true,
          friendAdded: true,
          news: true,
          reminders: true,
        },
      };
      user = await this.userRepository.createOne(createUser);
    }

    if (user.status.type === UserStatusType.Banned)
      throw new TGMDForbiddenException(
        'This user has been banned from the platform',
      );

    if (user.status.type === UserStatusType.Suspended) {
      const formattedDate = moment(user.status.until).format('MM/DD/YYYY');
      throw new TGMDForbiddenException(
        `This user has been suspended until ${formattedDate}`,
      );
    }

    const chatToken = await this.chatUserUpsertAndFetchToken(
      user as unknown as UserDocument,
    );

    await this.userRepository.updateOneById(user._id, {
      lastLogin: new Date(),
      chatToken: chatToken,
      notificationToken,
    });

    const validationResult = await this.validateUser(
      user._id,
      user.signupType,
      user.role,
    );

    return {
      ...validationResult,
      username: user.username,
      name: user.name,
      id: user._id,
      role: user.role,
      signupType: user.signupType,
      chatToken,
      dateOfBirth: user.dateOfBirth ?? null,
    };
  }

  /**
   * Creates user access tokens
   * @param userId - user ID
   * @param signupType - user signup type
   * @param role - user role
   * @returns Authentication response with access tokens
   */
  private async validateUser(
    userId: string,
    signupType: string,
    role: string,
  ): Promise<AuthResponse> {
    const tokens = await this.getTokens(userId, signupType, role);
    await this.updateRefreshToken(userId, tokens.refreshToken);
    return tokens;
  }

  /**
   * Creates a hash of given input
   * @param data - data to hash
   * @returns Hashed data
   */
  private async hashData(data: string): Promise<string> {
    return await argon2.hash(data);
  }

  /**
   * Updates refresh token and updates user record in database
   * @param userId - user ID
   * @param refreshToken - refresh token
   * @returns Void
   */
  private async updateRefreshToken(
    userId: string,
    refreshToken: string,
  ): Promise<void> {
    const hashedRefreshToken = await this.hashData(refreshToken);
    await this.userRepository.updateOneById(userId, {
      refreshToken: hashedRefreshToken,
    });
  }

  /**
   * Signs the token and appends necessary data inside it
   * @param userId - user ID
   * @param signupType - user signup type
   * @param role - user role
   * @returns Access tokens and success result
   */
  private async getTokens(
    userId: string,
    signupType: string,
    role: string,
  ): Promise<AuthResponse> {
    const [accessToken, refreshToken] = await Promise.all([
      this.jwtService.signAsync(
        {
          sub: userId,
          role,
          signupType,
        },
        {
          secret: this.rootConfig.JWT.SECRET,
          expiresIn: this.rootConfig.JWT.EXPIRY,
        },
      ),
      this.jwtService.signAsync(
        {
          sub: userId,
          role,
          signupType,
        },
        {
          secret: this.rootConfig.JWT.REFRESH.SECRET,
          expiresIn: this.rootConfig.JWT.REFRESH.EXPIRY,
        },
      ),
    ]);
    return {
      success: true,
      accessToken,
      refreshToken,
    };
  }

  /**
   * Refreshes the access and refresh token
   * @param req - Request
   * @returns Access tokens and success result
   */
  async refreshTokens(req: Request): Promise<AuthResponse> {
    const userId = req.user['sub'];
    const refreshTokenInput = req.user['refreshToken'];

    const user = await this.findOneUserOrThrow(userId);

    const refreshTokenMatches = await argon2.verify(
      user.refreshToken,
      refreshTokenInput,
    );
    if (!refreshTokenMatches)
      throw new TGMDRefreshTokenFailedException('User not found');
    const tokens = await this.validateUser(
      user._id,
      user.signupType,
      user.role,
    );
    const { accessToken, refreshToken } = tokens;
    return { accessToken, refreshToken, success: true };
  }

  /**
   * Generates a verification code for a user
   * @returns Verification code
   */
  private generateVerificationCode(): string {
    return StringUtils.generateSixDigitNumericCode();
  }

  /**
   * Checks if password is valied
   * @param inputPassword - Password used to log in
   * @param userPassword - Actual user password
   * @returns Void
   */
  private async checkIfPasswordIsValid(
    inputPassword: string,
    userPassword: string,
  ): Promise<void> {
    const isCorrectPassword = await CryptoUtils.validateHash(
      inputPassword,
      userPassword,
    );
    if (!isCorrectPassword)
      throw new TGMDUnauthorizedException('Invalid credentials');
  }

  /**
   * Finds a user or throws an error
   * @param userId - User ID
   * @returns User lean object
   */
  private async findOneUserOrThrow(userId: string): Promise<User> {
    const user = await this.userRepository.findOneLean(
      { _id: userId },
      '_id email username refreshToken',
    );
    if (!user?.refreshToken) throw new TGMDNotFoundException('User not found');
    return user;
  }

  /**
   * Initiates forgot password flow
   * @param forgotPasswordInput - Input for forgot password
   * @returns Void
   */
  async initiateForgotPassword(
    forgotPasswordInput: ForgotPasswordInput,
  ): Promise<void> {
    const { email, phoneNumber } = forgotPasswordInput;
    if (email && phoneNumber)
      throw new TGMDConflictException(
        'Cannot provide both email and phone number',
      );
    if (!email && !phoneNumber)
      throw new TGMDConflictException('Must provide phone number or email');
    if (email) {
      await this.initiateAdminForgotPassword(email);
    } else if (phoneNumber) {
      await this.initiateUserForgotPassword(phoneNumber);
    }
  }

  /**
   * Checks if user exists according to given input
   * and sends an email to admin account containing the verification code
   * @param email - Admin email
   * @returns Void
   */
  private async initiateAdminForgotPassword(email: string): Promise<void> {
    const user = await this.userRepository.findOne({
      email,
      role: { $ne: Role.User },
    });
    if (!user)
      throw new TGMDNotFoundException('User with that email not found');

    user.verificationCode = +this.generateVerificationCode();
    user.resetPasswordRequested = true;
    await user.save();

    const emailStatus = await this.emailService.sendEmailAdminForgotPassword(
      email,
      user.verificationCode.toString(),
    );
    if (emailStatus !== EmailServiceResult.SUCCESS)
      throw new TGMDExternalServiceException('Email sending failed');
  }

  /**
   * Checks if user exists according to given input
   * and sends an SMS verification code to user phone number
   * @param phoneNumber - User phone number
   * @returns Void
   */
  private async initiateUserForgotPassword(phoneNumber: string): Promise<void> {
    const user = await this.userRepository.findOne({
      phoneNumber,
      role: Role.User,
    });
    if (!user)
      throw new TGMDNotFoundException('User with that phone number not found');

    const updatedUser = await this.userRepository.updateOneById(user._id, {
      verificationCode: +this.generateVerificationCode(),
      resetPasswordRequested: true,
      verifyPhoneRequested: true,
    });

    const smsStatus = await this.smsService.sendVerificationCodeSms({
      to: updatedUser.phoneNumber,
      body: updatedUser.verificationCode.toString(),
    });
    if (smsStatus !== SmsServiceResult.SUCCESS)
      throw new TGMDExternalServiceException('SMS sending failed');
  }

  /**
   * Finds the user based on the input code and updates
   * the database entry to allow them to proceed
   * @param verifyForgotPasswordInput - Verification code input
   * @returns Auth response containing next step
   */
  async verifyForgotPassword(
    verifyForgotPasswordInput: VerifyCodeInput,
  ): Promise<void> {
    const { code } = verifyForgotPasswordInput;
    const user = await this.userRepository.findOne({
      verificationCode: code,
      resetPasswordRequested: true,
    });
    if (!user)
      throw new TGMDNotFoundException(
        'Could not find user with that verification code',
      );

    await this.userRepository.updateOneById(user._id, {
      verificationCode: null,
      resetPasswordConfirmed: true,
      verifyPhoneRequested: false,
    });
  }

  /**
   * Resets the user password to a new value
   * @param resetPasswordInput - Input for reset password (email, new password)
   * @returns Auth response containing access tokens
   */
  async resetPassword(
    resetPasswordInput: ResetPasswordInput,
  ): Promise<AuthResponse> {
    const { email, phoneNumber, password } = resetPasswordInput;
    if (email && phoneNumber)
      throw new TGMDConflictException(
        'Cannot provide both email and phone number',
      );
    if (!email && !phoneNumber)
      throw new TGMDConflictException(
        'Must provide either email or phone number',
      );

    const filter = {
      resetPasswordRequested: true,
      resetPasswordConfirmed: true,
    };

    email ? (filter['email'] = email) : (filter['phoneNumber'] = phoneNumber);

    const user = await this.userRepository.findOne(filter);
    if (!user) throw new TGMDNotFoundException('User not found');

    const chatToken = await this.chatUserUpsertAndFetchToken(user);
    user.password = password;
    user.resetPasswordConfirmed = undefined;
    user.resetPasswordRequested = undefined;
    user.chatToken = chatToken;
    await user.save();

    const tokens = await this.validateUser(
      user._id,
      user.signupType,
      user.role,
    );
    return {
      ...tokens,
      username: user.username,
      name: user.name,
      role: user.role,
      signupType: user.signupType,
      chatToken: chatToken,
    };
  }

  /**
   * Responds to the Epic Games OAuth 2.0 callback and fetches user data
   * @param epicGamesVerifyInput - epic games verify input
   * @returns Void
   */
  async epicGamesVerify(
    epicGamesVerifyInput: EpicGamesVerifyInput,
  ): Promise<void> {
    const { code, userId } = epicGamesVerifyInput;
    const response = await this.epicGamesService.sendEpicTokenRequest(code);
    if (!response)
      throw new TGMDExternalServiceException(
        'Failed to fetch tokens from Epic Games API',
      );

    const accessToken = response.access_token;
    const accountId = response.account_id;

    const epicUserResponse = await this.epicGamesService.getEpicGamesUser(
      accessToken,
      accountId,
    );
    if (!epicUserResponse)
      throw new TGMDExternalServiceException(
        'Failed to fetch user data from Epic Games API',
      );

    const user = await this.epicGamesService.storeEpicData(
      userId,
      epicUserResponse,
    );
    if (!user)
      throw new TGMDExternalServiceException('Failed to store epic data');
  }

  /*
   * Sets user phone number
   * @param setUserPhoneInput - Input for setting user phone number
   * @returns user response
   */
  async setUserPhone(setUserPhoneInput: SetUserPhoneInput): Promise<User> {
    const { email, phoneNumber } = setUserPhoneInput;
    const user = await this.userRepository.findOneLean({ email });
    if (!user) throw new TGMDNotFoundException('User not found');
    if (user.phoneVerified)
      throw new TGMDForbiddenException(
        'There is a verified phone number for this user',
      );

    const updatedUser = await this.userRepository.updateOneById(user._id, {
      phoneNumber,
      verificationCode: +this.generateVerificationCode(),
      verifyPhoneRequested: true,
    });

    const smsStatus = await this.smsService.sendVerificationCodeSms({
      body: updatedUser.verificationCode.toString(),
      to: updatedUser.phoneNumber,
    });
    if (smsStatus !== SmsServiceResult.SUCCESS)
      throw new TGMDExternalServiceException('SMS sending failed');

    return updatedUser;
  }

  /**
   * Verifies Apple ID token and logs in or registers the user
   * @param input - verify apple id input
   * @returns auth response
   */
  async verifyAppleIdToken(input: VerifyAppleIdInput): Promise<AuthResponse> {
    let user: User;
    const { token, fullName, email, notificationToken } = input;
    const jwtClaims = await verifyAppleToken({
      idToken: token,
      clientId: this.rootConfig.APPLE.CLIENTID,
    });

    user = await this.userRepository.findOne({
      appleSub: jwtClaims.sub,
    });

    if (!user) {
      if (!email)
        throw new TGMDConflictException(
          'Apple user not found. Please provide an email.',
        );
      const userExists = !!(await this.userRepository.findOne({ email }));
      if (userExists)
        throw new TGMDConflictException('User already exists with that email');

      const createUser: Partial<User> = {
        email,
        name: fullName ? fullName : undefined,
        username: email.split('@')[0].substring(0, USERNAME_MAX_LENGTH),
        signupType: SignupType.Social,
        role: Role.User,
        status: { type: UserStatusType.Pending },
        appleSub: jwtClaims.sub,
        notificationToken,
        rating: { ratings: [], average: 0 },
        rejectedUsers: [],
        notificationSettings: {
          enabled: true,
          match: true,
          message: true,
          friendAdded: true,
          news: true,
          reminders: true,
        },
      };
      user = await this.userRepository.createOne(createUser);
    }

    if (user.status.type === UserStatusType.Banned)
      throw new TGMDForbiddenException(
        'This user has been banned from the platform',
      );

    if (user.status.type === UserStatusType.Suspended) {
      const formattedDate = moment(user.status.until).format('MM/DD/YYYY');
      throw new TGMDForbiddenException(
        `This user has been suspended until ${formattedDate}`,
      );
    }

    const chatToken = await this.chatUserUpsertAndFetchToken(
      user as unknown as UserDocument,
    );

    await this.userRepository.updateOneById(user._id, {
      lastLogin: new Date(),
      chatToken: chatToken,
      notificationToken,
    });

    const validationResult = await this.validateUser(
      user._id,
      user.signupType,
      user.role,
    );

    return {
      ...validationResult,
      username: user.username,
      name: user.name,
      id: user._id,
      role: user.role,
      signupType: user.signupType,
      chatToken,
      dateOfBirth: user.dateOfBirth ?? null,
    };
  }

  /**
   * If regular user, upsert chat
   * @param user
   * @returns
   */
  private async chatUserUpsertAndFetchToken(
    user: UserDocument,
  ): Promise<string> {
    if (user.role !== Role.User) return;

    const chatToken = await this.chatUserService.createChatUserToken(
      user._id.toString(),
    );

    await this.chatUserService.upsertUser({
      id: user._id.toString(),
      role: 'user',
      image: user?.photoKey,
      username: user.username,
    });

    return chatToken.data;
  }

  /**
   * Sets user date of birth
   * @param setDateOfBirthInput - Input for setting user date of birth
   * @returns Void
   */
  async setDateOfBirth(
    userId: string,
    setDateOfBirthInput: SetDateOfBirthInput,
  ): Promise<void> {
    const { dateOfBirth } = setDateOfBirthInput;

    const user = await this.userRepository.findOneLean({
      _id: userId,
      signupType: SignupType.Social,
      dateOfBirth: { $exists: false },
    });
    if (!user) throw new TGMDNotFoundException('User not found');

    await this.userRepository.updateOneById(user._id, {
      dateOfBirth,
      'status.type': UserStatusType.Active,
    });
  }
}
