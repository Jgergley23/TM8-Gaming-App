import { Module, forwardRef } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';

import { ActionModule } from '../action/action.module';
import { ChatModule } from '../chat/chat.module';
import { EmailModule } from '../email/email.module';
import { FileStorageModule } from '../file-storage/file-storage.module';
import { FriendsModule } from '../friends/friends.module';
import { MatchModule } from '../match/match.module';
import { MatchmakingResultModule } from '../matchmaking-result/matchmaking-result.module';
import { NotificationModule } from '../notification/notification.module';
import { PotentialMatchModule } from '../potential-match/potential-match.module';
import { UserGameDataModule } from '../user-game-data/user-game-data.module';
import { AbstractRejectedUserService } from './abstract/rejected-user.abstract.service';
import { AbstractUserBlockService } from './abstract/user-block.abstract.service';
import { AbstractUserRepository } from './abstract/user.abstract.repository';
import { AbstractUserService } from './abstract/user.abstract.service';
import { User, UserSchema } from './schemas/user.schema';
import { RejectedUserService } from './services/rejected-user.service';
import { UserBlockService } from './services/user-block.service';
import { UserSeederService } from './services/user-seeder.service';
import { UserRepository } from './services/user.respository';
import { UserService } from './services/user.service';
import { UserController } from './user.controller';

@Module({
  imports: [
    MongooseModule.forFeature([{ name: User.name, schema: UserSchema }]),
    UserGameDataModule,
    forwardRef(() => ActionModule),
    EmailModule,
    FriendsModule,
    FileStorageModule,
    ActionModule,
    NotificationModule,
    MatchModule,
    PotentialMatchModule,
    MatchmakingResultModule,
    ChatModule,
  ],
  providers: [
    UserRepository,
    UserSeederService,
    UserService,
    UserBlockService,
    { provide: AbstractUserService, useClass: UserService },
    { provide: AbstractUserRepository, useClass: UserRepository },
    { provide: AbstractUserBlockService, useClass: UserBlockService },
    { provide: AbstractRejectedUserService, useClass: RejectedUserService },
  ],
  controllers: [UserController],
  exports: [AbstractUserRepository, AbstractRejectedUserService],
})
export class UserModule {}
