import { Module } from '@nestjs/common';

import { UserModule } from '../user/user.module';
import { AbstractEpicGamesService } from './abstract/epic-games.abstract.service';
import { EpicGamesService } from './services/epic-games.service';

@Module({
  imports: [UserModule],
  providers: [
    EpicGamesService,
    {
      provide: AbstractEpicGamesService,
      useClass: EpicGamesService,
    },
  ],
  exports: [AbstractEpicGamesService],
})
export class EpicGamesModule {}
