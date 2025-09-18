import { Module, forwardRef } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';

import { MatchModule } from '../match/match.module';
import { MatchmakingResultModule } from '../matchmaking-result/matchmaking-result.module';
import { MatchmakingModule } from '../matchmaking/matchmaking.module';
import { NotificationModule } from '../notification/notification.module';
import { UserModule } from '../user/user.module';
import { AbstractPotentialMatchRepository } from './abstract/potential-match.abstract.repository';
import { AbstractPotentialMatchService } from './abstract/potential-match.abstract.service';
import {
  PotentialMatch,
  PotentialMatchSchema,
} from './schemas/potential-match.schema';
import { PotentialMatchRepository } from './services/potential-match.repository';
import { PotentialMatchService } from './services/potential-match.service';

@Module({
  imports: [
    MongooseModule.forFeature([
      { name: PotentialMatch.name, schema: PotentialMatchSchema },
    ]),
    MatchModule,
    MatchmakingResultModule,
    MatchmakingModule,
    forwardRef(() => UserModule),
    forwardRef(() => NotificationModule),
  ],
  providers: [
    {
      provide: AbstractPotentialMatchService,
      useClass: PotentialMatchService,
    },
    {
      provide: AbstractPotentialMatchRepository,
      useClass: PotentialMatchRepository,
    },
  ],
  exports: [AbstractPotentialMatchRepository, AbstractPotentialMatchService],
})
export class PotentialMatchModule {}
