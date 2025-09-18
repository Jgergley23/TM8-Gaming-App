import {
  Body,
  Controller,
  Delete,
  Get,
  HttpCode,
  Patch,
  Post,
  Req,
  Res,
  UseGuards,
} from '@nestjs/common';
import { ApiOkResponse, ApiResponse, ApiTags } from '@nestjs/swagger';
import { Request, Response } from 'express';

import { EpicGamesConfig } from 'src/common/config/env.validation';
import { Role } from 'src/common/constants';
import {
  CurrentUser,
  IUserTokenData,
} from 'src/common/decorators/current-user.decorator';
import { Roles } from 'src/common/decorators/roles.decorator';
import { TGMDExceptionResponse } from 'src/common/exceptions/custom-exception.response';
import { AccessTokenGuard } from 'src/common/guards/access-token.guard';
import { RateLimiterGuard } from 'src/common/guards/rate-limiter.guard';
import { RefreshTokenGuard } from 'src/common/guards/refresh-token.guard';
import { RolesGuard } from 'src/common/guards/roles.guard';
import { UserStatusGuard } from 'src/common/guards/user-status-guard';

import { AbstractEpicGamesService } from '../epic-games/abstract/epic-games.abstract.service';
import { UserResponse } from '../user/response/user.response';
import { User } from '../user/schemas/user.schema';
import { AbstractAuthService } from './abstract/auth.abstract.service';
import { EpicGamesVerifyInput } from './dto/epic-games-verify.input';
import { ForgotPasswordInput } from './dto/forgot-password.input';
import { AuthLoginInput } from './dto/login.input';
import { PhoneVerificationInput } from './dto/phone-verification.input';
import { RegisterInput } from './dto/register-input';
import { ResetPasswordInput } from './dto/reset-password.input';
import { SetDateOfBirthInput } from './dto/set-date-of-birth.input';
import { SetUserPhoneInput } from './dto/set-user-phone.input';
import { VerifyAppleIdInput } from './dto/verify-apple-id.input';
import { VerifyCodeInput } from './dto/verify-code.input';
import { VerifyGoogleIdInput } from './dto/verify-google-id.input';
import { AuthResponse } from './response/auth.response';
@ApiTags('Auth')
@Controller('auth')
@ApiResponse({
  description: 'Non-2XX response',
  type: TGMDExceptionResponse,
})
export class AuthController {
  constructor(
    private readonly authService: AbstractAuthService,
    private readonly epicGamesConfig: EpicGamesConfig,
    private readonly epicGamesService: AbstractEpicGamesService,
  ) {}

  @UseGuards(RefreshTokenGuard)
  @Post('token/refresh')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: AuthResponse,
  })
  refreshTokens(@Req() req: Request): Promise<AuthResponse> {
    return this.authService.refreshTokens(req);
  }

  @Post('sign-in')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: AuthResponse,
  })
  login(@Body() loginInput: AuthLoginInput): Promise<AuthResponse> {
    return this.authService.login(loginInput);
  }

  @Post('register')
  @ApiResponse({
    status: 201,
    description: 'OK response',
    type: UserResponse,
  })
  @HttpCode(201)
  register(@Body() registerInput: RegisterInput): Promise<User> {
    return this.authService.register(registerInput);
  }

  @Post('verify-phone')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: AuthResponse,
  })
  veirifyPhone(
    @Body() verifyPhoneInput: VerifyCodeInput,
  ): Promise<AuthResponse> {
    return this.authService.verifyPhone(verifyPhoneInput);
  }

  @Post('resend-code')
  @UseGuards(RateLimiterGuard)
  @ApiOkResponse({
    status: 204,
    description: 'OK response',
  })
  @HttpCode(204)
  resendCode(
    @Body() phoneVerificationInput: PhoneVerificationInput,
  ): Promise<void> {
    return this.authService.resendPhoneVerificationCode(phoneVerificationInput);
  }

  @Post('google/verify')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: AuthResponse,
  })
  googleAuth(@Body() input: VerifyGoogleIdInput): Promise<AuthResponse> {
    return this.authService.verifyGoogleIdToken(input);
  }

  @Get('epic-games/sign-in')
  @UseGuards(AccessTokenGuard, UserStatusGuard, RolesGuard)
  @Roles(Role.User)
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
  })
  epicGamesAuth(@Res() res: Response) {
    return res.redirect(this.epicGamesConfig.CLIENTURL);
  }

  @UseGuards(AccessTokenGuard, UserStatusGuard, RolesGuard)
  @Roles(Role.User)
  @Post('epic-games/verify')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
  })
  epicGamesVerify(
    @Body() epicGamesVerifyInput: EpicGamesVerifyInput,
  ): Promise<void> {
    return this.authService.epicGamesVerify(epicGamesVerifyInput);
  }

  @UseGuards(AccessTokenGuard, UserStatusGuard, RolesGuard)
  @Roles(Role.User)
  @Delete('epic-games')
  @ApiOkResponse({
    status: 204,
    description: 'OK response',
  })
  @HttpCode(204)
  removeEpicAccoun(@CurrentUser() currentUser: IUserTokenData): Promise<void> {
    return this.epicGamesService.removeEpicAccount(currentUser.sub);
  }

  @Post('forgot-password')
  @ApiResponse({
    status: 200,
    description: 'OK response',
  })
  @HttpCode(200)
  forgotPassword(
    @Body() forgotPasswordInput: ForgotPasswordInput,
  ): Promise<void> {
    return this.authService.initiateForgotPassword(forgotPasswordInput);
  }

  @Post('forgot-password/verify')
  @ApiOkResponse({
    status: 201,
    description: 'OK response',
  })
  verifyForgotPassword(
    @Body() verifyForgotPasswordInput: VerifyCodeInput,
  ): Promise<void> {
    return this.authService.verifyForgotPassword(verifyForgotPasswordInput);
  }

  @Post('forgot-password/reset')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: AuthResponse,
  })
  resetPassword(
    @Body() resetPasswordInput: ResetPasswordInput,
  ): Promise<AuthResponse> {
    return this.authService.resetPassword(resetPasswordInput);
  }

  @Patch('date-of-birth')
  @ApiOkResponse({
    status: 204,
    description: 'OK response',
  })
  @HttpCode(204)
  @UseGuards(AccessTokenGuard, UserStatusGuard, RolesGuard)
  @Roles(Role.User)
  setDateOfBirth(
    @CurrentUser() currentUser: IUserTokenData,
    @Body() setDateOfBirthInput: SetDateOfBirthInput,
  ): Promise<void> {
    return this.authService.setDateOfBirth(
      currentUser.sub,
      setDateOfBirthInput,
    );
  }

  @Patch('set-phone-number')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: UserResponse,
  })
  setUserPhone(@Body() setUserPhoneInput: SetUserPhoneInput): Promise<User> {
    return this.authService.setUserPhone(setUserPhoneInput);
  }

  @Post('apple/verify')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: AuthResponse,
  })
  verifyAppleIdToken(
    @Body() verifyInput: VerifyAppleIdInput,
  ): Promise<AuthResponse> {
    return this.authService.verifyAppleIdToken(verifyInput);
  }
}
