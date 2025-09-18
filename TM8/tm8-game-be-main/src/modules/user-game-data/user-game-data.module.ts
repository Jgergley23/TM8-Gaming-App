import { Module, forwardRef } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';

import { MatchmakingResultModule } from '../matchmaking-result/matchmaking-result.module';
import { PotentialMatchModule } from '../potential-match/potential-match.module';
import { UserModule } from '../user/user.module';
import { AbstractUserGameDataRepository } from './abstract/user-game-data.abstract.repository';
import { AbstractUserGameDataService } from './abstract/user-game-data.abstract.service';
import {
  UserGameData,
  UserGameDataSchema,
} from './schemas/user-game-data.schema';
import { UserGameDataSeederService } from './services/user-game-data-seeder.service';
import { UserGameDataRepository } from './services/user-game-data.repository';
import { UserGameDataService } from './services/user-game-data.service';

@Module({
  imports: [
    MongooseModule.forFeature([
      { name: UserGameData.name, schema: UserGameDataSchema },
    ]),
    forwardRef(() => UserModule),
    PotentialMatchModule,
    MatchmakingResultModule,
  ],
  providers: [
    UserGameDataRepository,
    UserGameDataSeederService,
    UserGameDataService,
    {
      provide: AbstractUserGameDataService,
      useClass: UserGameDataService,
    },
    {
      provide: AbstractUserGameDataRepository,
      useClass: UserGameDataRepository,
    },
  ],
  exports: [AbstractUserGameDataRepository, AbstractUserGameDataService],
})
export class UserGameDataModule {}
