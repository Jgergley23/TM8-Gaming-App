import { GetNewUsersRegisteredParams } from '../dto/get-new-users.registered.params';
import { GetUserGroupCountsParams } from '../dto/get-user-group-counts.params';
import { StatisticsOnboardingCompletionResponse } from '../response/statistic-onboarding-completion.response';
import { StatisticsNewUsersRegisteredResponse } from '../response/statistics-new-users-registered.response';
import { StatisticsTotalCountResponse } from '../response/statistics-total-count.response';
import { UserGroupCountsResponse } from '../response/statistics-user-group-counts.response';

export abstract class AbstractStatisticsService {
  abstract getUserCount(): Promise<StatisticsTotalCountResponse>;
  abstract getOnboardingCompletion(): Promise<StatisticsOnboardingCompletionResponse>;
  abstract getNewUsersRegistered(
    getNewUsersRegisteredParams: GetNewUsersRegisteredParams,
  ): Promise<StatisticsNewUsersRegisteredResponse>;
  abstract getUserGroupCounts(
    userGroupCountsParams: GetUserGroupCountsParams,
  ): Promise<UserGroupCountsResponse>;
}
