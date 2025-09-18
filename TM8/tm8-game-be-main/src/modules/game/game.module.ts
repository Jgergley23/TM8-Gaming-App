import { Module } from '@nestjs/common';

import { UserModule } from '../user/user.module';
import { AbstractGameService } from './abstract/abstract.game.service';
import { GameController } from './game.controller';
import { GameService } from './services/game.service';

@Module({
  imports: [UserModule],
  controllers: [GameController],
  providers: [
    GameService,
    { provide: AbstractGameService, useClass: GameService },
  ],
})
export class GameModule {}
