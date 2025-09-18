import { Controller, Get, Query, UseGuards } from '@nestjs/common';
import { ApiOkResponse, ApiResponse, ApiTags } from '@nestjs/swagger';

import { Role } from 'src/common/constants';
import { Roles } from 'src/common/decorators/roles.decorator';
import { TGMDExceptionResponse } from 'src/common/exceptions/custom-exception.response';
import { AccessTokenGuard } from 'src/common/guards/access-token.guard';
import { RolesGuard } from 'src/common/guards/roles.guard';
import { UserStatusGuard } from 'src/common/guards/user-status-guard';

import { AbstractStatisticsService } from './abstract/statistics.abstract.service';
import { GetNewUsersRegisteredParams } from './dto/get-new-users.registered.params';
import { GetUserGroupCountsParams } from './dto/get-user-group-counts.params';
import { StatisticsOnboardingCompletionResponse } from './response/statistic-onboarding-completion.response';
import { StatisticsNewUsersRegisteredResponse } from './response/statistics-new-users-registered.response';
import { StatisticsTotalCountResponse } from './response/statistics-total-count.response';
import { UserGroupCountsResponse } from './response/statistics-user-group-counts.response';

@ApiTags('Statistics')
@Controller('statistics')
@ApiResponse({
  description: 'Non-2XX response',
  type: TGMDExceptionResponse,
})
@UseGuards(AccessTokenGuard, UserStatusGuard, RolesGuard)
export class StatisticsController {
  constructor(private readonly statisticsService: AbstractStatisticsService) {}

  @Get('users/total-count')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: StatisticsTotalCountResponse,
  })
  @Roles(Role.Admin, Role.Superadmin)
  getUserCount(): Promise<StatisticsTotalCountResponse> {
    return this.statisticsService.getUserCount();
  }

  @Get('users/onboarding-completion')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: StatisticsOnboardingCompletionResponse,
  })
  @Roles(Role.Admin, Role.Superadmin)
  getOnboardingCompletion(): Promise<StatisticsOnboardingCompletionResponse> {
    return this.statisticsService.getOnboardingCompletion();
  }

  @Get('users/new-users-registered')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: StatisticsNewUsersRegisteredResponse,
  })
  @Roles(Role.Admin, Role.Superadmin)
  getNewUsersRegistered(
    @Query() getNewUsersRegisteredParams: GetNewUsersRegisteredParams,
  ): Promise<StatisticsNewUsersRegisteredResponse> {
    return this.statisticsService.getNewUsersRegistered(
      getNewUsersRegisteredParams,
    );
  }

  @Get('users/group-counts')
  @ApiOkResponse({
    status: 200,
    description: 'OK response',
    type: UserGroupCountsResponse,
  })
  @Roles(Role.Admin, Role.Superadmin)
  getUserGroupsCounts(
    @Query() getUserGroupCountsParams: GetUserGroupCountsParams,
  ): Promise<UserGroupCountsResponse> {
    return this.statisticsService.getUserGroupCounts(getUserGroupCountsParams);
  }
}
