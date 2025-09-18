import {
  Body,
  Controller,
  Get,
  HttpCode,
  Param,
  Post,
  Query,
  UseGuards,
} from '@nestjs/common';
import { ApiOkResponse, ApiTags } from '@nestjs/swagger';

import { Role } from 'src/common/constants';
import {
  CurrentUser,
  IUserTokenData,
} from 'src/common/decorators/current-user.decorator';
import { Roles } from 'src/common/decorators/roles.decorator';
import { AccessTokenGuard } from 'src/common/guards/access-token.guard';
import { PaginationParams } from 'src/common/pagination/pagination-params';
import { PaginationModel } from 'src/common/pagination/paginaton.model';

import { AbstractPotentialMatchService } from '../potential-match/abstract/potential-match.abstract.service';
import { AcceptPotentialMatchResponse } from '../potential-match/response/accept-potential-match.response';
import { GetGameByNameParams } from '../user/dto/game-by-name.params';
import { GetUserByIdParams } from '../user/dto/user-by-id.params';
import { AbstractMatchmakingService } from './abstract/matchmaking.abstract.service';
import { MatchmakingResultUserResponse } from './response/matchmaking-result-user.response';
import { MatchmakingResultPaginatedResponse } from './response/matchmaking-result.paginated.response';

@Controller('matchmaking')
@ApiTags('Matchmaking')
@UseGuards(AccessTokenGuard)
export class MatchmakingController {
  constructor(
    private readonly matchmakingService: AbstractMatchmakingService,
    private readonly potentialMatchService: AbstractPotentialMatchService,
  ) {}

  @Post(':game')
  @ApiOkResponse({
    status: 204,
    description: 'OK response',
  })
  @HttpCode(204)
  @Roles(Role.User)
  matchmake(
    @CurrentUser() user: IUserTokenData,
    @Param() { game }: GetGameByNameParams,
  ): Promise<void> {
    return this.matchmakingService.matchmake(user.sub, game);
  }

  @Get(':game/results')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: MatchmakingResultPaginatedResponse,
  })
  @Roles(Role.User)
  listMatchmakingResults(
    @Query() paginationParams: PaginationParams,
    @Param() { game }: GetGameByNameParams,
    @CurrentUser() user: IUserTokenData,
  ): Promise<PaginationModel<MatchmakingResultUserResponse>> {
    return this.matchmakingService.listMatchmakingResults(
      user.sub,
      game,
      paginationParams,
    );
  }

  @Post(':game/accept')
  @ApiOkResponse({
    status: 201,
    description: 'OK response',
    type: AcceptPotentialMatchResponse,
  })
  @Roles(Role.User)
  acceptPotentialMatch(
    @Body() { userId }: GetUserByIdParams,
    @Param() { game }: GetGameByNameParams,
    @CurrentUser() user: IUserTokenData,
  ): Promise<AcceptPotentialMatchResponse> {
    return this.potentialMatchService.acceptPotentialMatch(
      user.sub,
      userId,
      game,
    );
  }

  @Post(':game/reject')
  @ApiOkResponse({
    status: 204,
    description: 'OK response',
  })
  @HttpCode(204)
  @Roles(Role.User)
  rejectPotentialMatch(
    @Body() { userId }: GetUserByIdParams,
    @Param() { game }: GetGameByNameParams,
    @CurrentUser() user: IUserTokenData,
  ): Promise<void> {
    return this.potentialMatchService.rejectPotentialMatch(
      user.sub,
      userId,
      game,
    );
  }
}
