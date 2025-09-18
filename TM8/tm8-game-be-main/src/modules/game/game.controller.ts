import { Controller, Get, Param, UseGuards } from '@nestjs/common';
import { ApiOkResponse, ApiResponse, ApiTags } from '@nestjs/swagger';

import { Role } from 'src/common/constants';
import { Roles } from 'src/common/decorators/roles.decorator';
import { TGMDExceptionResponse } from 'src/common/exceptions/custom-exception.response';
import { AccessTokenGuard } from 'src/common/guards/access-token.guard';
import { RolesGuard } from 'src/common/guards/roles.guard';
import { UserStatusGuard } from 'src/common/guards/user-status-guard';

import { AbstractGameService } from './abstract/abstract.game.service';
import { GetGameByNameParams } from './dto/get-game-by-name.params';
import { GamePreferenceInputResponse } from './response/game-preference-input.response';
import { GameResponse } from './response/game-response';

@ApiTags('Game')
@Controller('games')
@ApiResponse({
  description: 'Non-2XX response',
  type: TGMDExceptionResponse,
})
@UseGuards(AccessTokenGuard, UserStatusGuard, RolesGuard)
export class GameController {
  constructor(private readonly gameService: AbstractGameService) {}

  @Get('')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: [GameResponse],
  })
  @Roles(Role.User, Role.Admin, Role.Superadmin)
  getUserReportTypes(): GameResponse[] {
    return this.gameService.getAllGames();
  }

  @Get(':game/preference-form')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: [GamePreferenceInputResponse],
  })
  @Roles(Role.User, Role.Admin, Role.Superadmin)
  getPreferenceForm(
    @Param() { game }: GetGameByNameParams,
  ): GamePreferenceInputResponse[] {
    return this.gameService.getPreferenceForm(game);
  }
}
