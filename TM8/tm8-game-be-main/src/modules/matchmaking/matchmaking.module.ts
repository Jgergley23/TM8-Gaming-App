import { Module, forwardRef } from '@nestjs/common';

import { ActionModule } from '../action/action.module';
import { FriendsModule } from '../friends/friends.module';
import { MatchModule } from '../match/match.module';
import { MatchmakingResultModule } from '../matchmaking-result/matchmaking-result.module';
import { OnlinePresenceModule } from '../online-presence/online-presence.module';
import { PotentialMatchModule } from '../potential-match/potential-match.module';
import { UserGameDataModule } from '../user-game-data/user-game-data.module';
import { UserModule } from '../user/user.module';
import { AbstractGameMatchmakingService } from './abstract/game-matchmaking.abstract.service';
import { AbstractMatchmakingPreferenceFilteringService } from './abstract/matchmaking-preference-filtering.abstract.service';
import { AbstractMatchmakingUserFilteringService } from './abstract/matchmaking-user-filtering.abstract.service';
import { AbstractMatchmakingUserSortingService } from './abstract/matchmaking-user-sorting.abstract.service';
import { AbstractMatchmakingService } from './abstract/matchmaking.abstract.service';
import { MatchmakingController } from './matchmaking.controller';
import { GameMatchmakingService } from './services/game-matchmaking.service';
import { MatchmakingPreferenceFilteringService } from './services/matchmaking-preference-filtering.service';
import { MatchmakingUserFilteringService } from './services/matchmaking-user-filtering.service';
import { MatchmakingUserSortingService } from './services/matchmaking-user-sorting.service';
import { MatchmakingService } from './services/matchmaking.service';

@Module({
  imports: [
    forwardRef(() => UserModule),
    forwardRef(() => UserGameDataModule),
    ActionModule,
    FriendsModule,
    MatchmakingResultModule,
    forwardRef(() => PotentialMatchModule),
    MatchModule,
    OnlinePresenceModule,
  ],
  controllers: [MatchmakingController],
  providers: [
    MatchmakingUserSortingService,
    { provide: AbstractMatchmakingService, useClass: MatchmakingService },
    {
      provide: AbstractMatchmakingPreferenceFilteringService,
      useClass: MatchmakingPreferenceFilteringService,
    },
    {
      provide: AbstractMatchmakingUserFilteringService,
      useClass: MatchmakingUserFilteringService,
    },
    {
      provide: AbstractGameMatchmakingService,
      useClass: GameMatchmakingService,
    },
    {
      provide: AbstractMatchmakingUserSortingService,
      useExisting: MatchmakingUserSortingService,
    },
  ],
})
export class MatchmakingModule {}
