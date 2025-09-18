import {
  MiddlewareConsumer,
  Module,
  NestModule,
  RequestMethod,
} from '@nestjs/common';
import { APP_FILTER } from '@nestjs/core';
import { MongooseModule } from '@nestjs/mongoose';
import { ThrottlerModule } from '@nestjs/throttler';
import { TypedConfigModule, dotenvLoader } from 'nest-typed-config';
import { WinstonModule } from 'nest-winston';

import { MongoConfig, RootConfig } from 'src/common/config/env.validation';
import { GlobalExceptionFilter } from 'src/common/exceptions/exception.filter';
import { LoggerMiddleware } from 'src/common/middlewares/logger.middleware';
import { MongooseOptions } from 'src/common/providers/mongo.provider';
import { WinstonOptions } from 'src/common/providers/winston.provider';
import { StatisticsModule } from 'src/modules/statistics/statistics.module';

import { ActionModule } from '../action/action.module';
import { AuthModule } from '../auth/auth.module';
import { ChatModule } from '../chat/chat.module';
import { EmailModule } from '../email/email.module';
import { EpicGamesModule } from '../epic-games/epic-games.module';
import { FriendsModule } from '../friends/friends.module';
import { GameModule } from '../game/game.module';
import { LandingPageModule } from '../landing-page/landing-page.module';
import { MatchModule } from '../match/match.module';
import { MatchmakingResultModule } from '../matchmaking-result/matchmaking-result.module';
import { MatchmakingModule } from '../matchmaking/matchmaking.module';
import { NotificationModule } from '../notification/notification.module';
import { OnlinePresenceModule } from '../online-presence/online-presence.module';
import { PotentialMatchModule } from '../potential-match/potential-match.module';
import { ScheduledNotificationModule } from '../scheduled-notification/scheduled-notification.module';
import { SchedulerModule } from '../scheduler/scheduler.module';
import { SendgridModule } from '../sendgrid/sendgrid.module';
import { SmsModule } from '../sms/sms.module';
import { StreamChatModule } from '../stream-chat/stream-chat.module';
import { TwilioModule } from '../twilio/twilio.module';
import { UserGameDataModule } from '../user-game-data/user-game-data.module';
import { UserModule } from '../user/user.module';
import { AppController } from './app.controller';
import { AppService } from './app.service';

@Module({
  imports: [
    // Environment variables
    TypedConfigModule.forRoot({
      schema: RootConfig,
      load: dotenvLoader({ separator: '_' }),
    }),

    // Logging
    WinstonModule.forRootAsync({
      useClass: WinstonOptions,
    }),

    //Rate limiting
    ThrottlerModule.forRoot([
      {
        ttl: +process.env.THROTTLER_TTL,
        limit: +process.env.THROTTLER_LIMIT,
      },
    ]),

    // MongoDB
    MongooseModule.forRootAsync({
      imports: [TypedConfigModule],
      inject: [MongoConfig],
      useClass: MongooseOptions,
    }),
    SchedulerModule,
    // Provider Modules
    UserModule,
    UserGameDataModule,
    AuthModule,
    EmailModule,
    SendgridModule,
    StatisticsModule,
    ActionModule,
    ScheduledNotificationModule,
    LandingPageModule,
    SmsModule,
    TwilioModule,
    EpicGamesModule,
    GameModule,
    StreamChatModule,
    ChatModule,
    FriendsModule,
    NotificationModule,
    MatchmakingResultModule,
    PotentialMatchModule,
    MatchModule,
    MatchmakingModule,
    OnlinePresenceModule,
  ],

  controllers: [AppController],
  providers: [
    AppService,

    {
      provide: APP_FILTER,
      useClass: GlobalExceptionFilter,
    },
  ],
})
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer): void {
    consumer
      .apply(LoggerMiddleware)
      .exclude('/')
      .forRoutes({ path: '*', method: RequestMethod.ALL });
  }
}
