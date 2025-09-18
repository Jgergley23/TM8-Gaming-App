import { Module } from '@nestjs/common';
import { JwtModule } from '@nestjs/jwt';

import { AccessTokenStrategy } from 'src/common/strategies/access-token.strategy';
import { RefreshTokenStrategy } from 'src/common/strategies/refresh-token.strategy';

import { ChatModule } from '../chat/chat.module';
import { EmailModule } from '../email/email.module';
import { EpicGamesModule } from '../epic-games/epic-games.module';
import { SmsModule } from '../sms/sms.module';
import { UserModule } from '../user/user.module';
import { AbstractAuthService } from './abstract/auth.abstract.service';
import { AuthController } from './auth.controller';
import { AuthService } from './services/auth.service';

@Module({
  imports: [
    JwtModule.register({}),
    UserModule,
    EmailModule,
    SmsModule,
    EpicGamesModule,
    ChatModule,
  ],
  providers: [
    AccessTokenStrategy,
    RefreshTokenStrategy,
    AuthService,
    { provide: AbstractAuthService, useExisting: AuthService },
  ],
  controllers: [AuthController],
})
export class AuthModule {}
