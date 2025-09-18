import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';

import { AbstractMatchmakingResultRepository } from './abstract/matchmaking-result.abstract.repository';
import { AbstractMatchmakingResultService } from './abstract/matchmaking-result.service.abstract';
import {
  MatchmakingResult,
  MatchmakingResultSchema,
} from './schemas/matchmaking-result.schema';
import { MatchmakingResultRepository } from './services/matchmaking-result.repository';
import { MatchmakingResultService } from './services/matchmaking-result.service';

@Module({
  imports: [
    MongooseModule.forFeature([
      { name: MatchmakingResult.name, schema: MatchmakingResultSchema },
    ]),
  ],
  providers: [
    {
      provide: AbstractMatchmakingResultRepository,
      useClass: MatchmakingResultRepository,
    },
    {
      provide: AbstractMatchmakingResultService,
      useClass: MatchmakingResultService,
    },
  ],
  exports: [
    AbstractMatchmakingResultRepository,
    AbstractMatchmakingResultService,
  ],
})
export class MatchmakingResultModule {}
