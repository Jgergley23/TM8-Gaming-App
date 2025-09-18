import {
  Controller,
  Get,
  HttpCode,
  Param,
  Post,
  UseGuards,
} from '@nestjs/common';
import { ApiParam, ApiResponse, ApiTags } from '@nestjs/swagger';

import { Role } from 'src/common/constants';
import {
  CurrentUser,
  IUserTokenData,
} from 'src/common/decorators/current-user.decorator';
import { Roles } from 'src/common/decorators/roles.decorator';
import { TGMDExceptionResponse } from 'src/common/exceptions/custom-exception.response';
import { AccessTokenGuard } from 'src/common/guards/access-token.guard';
import { RolesGuard } from 'src/common/guards/roles.guard';
import { UserStatusGuard } from 'src/common/guards/user-status-guard';

import { AbstractMatchService } from './abstract/match.abstract.service';
import { CheckFeedbackGivenDto } from './dto/check-feedback-given.dto';
import { GiveMatchFeedbackDto } from './dto/give-match-feedback.dto';
import { CheckFeedbackGivenResponse } from './response/check-feedback-given.response';
import { CheckMatchExistsResponse } from './response/check-match-exists.response';

@Controller('matches')
@ApiTags('Matches')
@ApiResponse({
  description: 'Non-2XX response',
  type: TGMDExceptionResponse,
})
@UseGuards(AccessTokenGuard, UserStatusGuard, RolesGuard)
export class MatchController {
  constructor(private readonly matchService: AbstractMatchService) {}

  @Post(':matchId/feedback/:rating')
  @ApiResponse({
    status: 200,
    description: 'OK response',
  })
  @HttpCode(200)
  @Roles(Role.User)
  @ApiParam({ name: 'matchId', type: 'string', description: 'Match ID' })
  @ApiParam({ name: 'rating', type: 'number', description: 'Rating' })
  giveMatchUserFeedback(
    @CurrentUser() user: IUserTokenData,
    @Param() { matchId }: GiveMatchFeedbackDto,
    @Param() { rating }: GiveMatchFeedbackDto,
  ): Promise<void> {
    return this.matchService.giveMatchUserFeedback(user.sub, matchId, rating);
  }

  @Get('feedback/users/:userId/check')
  @ApiResponse({
    status: 200,
    description: 'OK response',
    type: CheckFeedbackGivenResponse,
  })
  @Roles(Role.User)
  @ApiParam({ name: 'userId', type: 'string', description: 'User ID' })
  checkIfMatchFeedbackGiven(
    @CurrentUser() user: IUserTokenData,
    @Param() { userId }: CheckFeedbackGivenDto,
  ): Promise<CheckFeedbackGivenResponse> {
    return this.matchService.checkIfMatchFeedbackGiven(user.sub, userId);
  }

  @Get('check/:userId')
  @ApiResponse({
    status: 200,
    description: 'OK response',
    type: CheckMatchExistsResponse,
  })
  @Roles(Role.User)
  @ApiParam({ name: 'userId', type: 'string', description: 'User ID' })
  checkForExistingMatch(
    @CurrentUser() user: IUserTokenData,
    @Param() { userId }: CheckFeedbackGivenDto,
  ): Promise<CheckMatchExistsResponse> {
    return this.matchService.checkForExistingMatch(user.sub, userId);
  }
}
