import { Injectable } from '@nestjs/common';
import * as _ from 'lodash';
import * as moment from 'moment';

import { Game, Role, UserGroup, UserStatusType } from 'src/common/constants';
import { ChartGroup } from 'src/common/constants/chart-group.enum';
import { AbstractUserGameDataRepository } from 'src/modules/user-game-data/abstract/user-game-data.abstract.repository';
import { AbstractUserRepository } from 'src/modules/user/abstract/user.abstract.repository';
import { IUserRecord } from 'src/modules/user/interface/user.interface';
import { User } from 'src/modules/user/schemas/user.schema';

import { AbstractStatisticsRepository } from '../abstract/statistics.abstract.repository';
import { AbstractStatisticsService } from '../abstract/statistics.abstract.service';
import { GetNewUsersRegisteredParams } from '../dto/get-new-users.registered.params';
import { GetUserGroupCountsParams } from '../dto/get-user-group-counts.params';
import { IAggregatedGameUsersCount } from '../interfaces/aggregated-game-users-count.interface';
import { NewUsersRegisteredObjectResponse } from '../response/new-users-registered-object.response';
import { StatisticsOnboardingCompletionResponse } from '../response/statistic-onboarding-completion.response';
import { StatisticsNewUsersRegisteredResponse } from '../response/statistics-new-users-registered.response';
import { StatisticsTotalCountResponse } from '../response/statistics-total-count.response';
import { UserGroupCountsResponse } from '../response/statistics-user-group-counts.response';

@Injectable()
export class StatisticsService extends AbstractStatisticsService {
  constructor(
    private readonly userRepository: AbstractUserRepository,
    private readonly userGameDataRepository: AbstractUserGameDataRepository,
    private readonly statisticsRepository: AbstractStatisticsRepository,
  ) {
    super();
  }

  /**
   * Caculates total users count and change since last week
   * @returns - total user count response
   */
  async getUserCount(): Promise<StatisticsTotalCountResponse> {
    const result: StatisticsTotalCountResponse = { total: 0, currentWeek: 0 };

    // Get the current total number of users
    result.total = await this.userRepository.count({ role: Role.User });

    // Get the total number of users from the last week's statistics
    const lastWeekStatistics = await this.statisticsRepository.findOneLean(
      {},
      'totalCount',
      { sort: { createdAt: -1 } },
    );

    // Calculate the change in user count since last week
    if (lastWeekStatistics) {
      result.currentWeek = result.total - lastWeekStatistics.totalCount;
    }

    return result;
  }

  /**
   * Caculates onboarding completion percentage and change since last week
   * @returns - onboarding completion response
   */
  async getOnboardingCompletion(): Promise<StatisticsOnboardingCompletionResponse> {
    const result: StatisticsOnboardingCompletionResponse = {
      onboardingPct: 0,
      currentWeek: 0,
    };

    // Get the total number of users
    const totalUsers = await this.userRepository.count({ role: Role.User });

    // Get the total number of onboarded users
    const onboardedUsers = await this.userRepository.count({
      role: Role.User,
      'status.type': { $ne: UserStatusType.Pending },
    });

    // Get the last week's statistics
    const lastWeekStatistics = await this.statisticsRepository.findOneLean(
      {},
      'totalCount onboardedCount',
      { sort: { createdAt: -1 } },
    );

    // Calculate the onboarding completion percentage
    result.onboardingPct = (onboardedUsers / totalUsers) * 100.0;

    // Calculate the change in onboarding completion percantage since last week
    if (lastWeekStatistics) {
      const lastWeekOnboardingPct =
        (lastWeekStatistics.onboardedCount / lastWeekStatistics.totalCount) *
        100.0;
      result.currentWeek = result.onboardingPct - lastWeekOnboardingPct;
    }

    return result;
  }

  /**
   * Maps the object to an array
   * @param object - object to map
   * @param array - array to map to
   * @returns - mapped array
   */
  private mapObjectToArray(
    object: { [date: string]: number },
    array: NewUsersRegisteredObjectResponse[],
  ): NewUsersRegisteredObjectResponse[] {
    for (const entry of array) {
      if (Object.prototype.hasOwnProperty.call(object, entry.date)) {
        entry.quantity = object[entry.date];
      }
    }
    return array;
  }

  /**
   * Groups user by period using lodash and moment
   * @param users - array of users
   * @param period - period to group by
   * @returns new users registered response
   */
  private groupUsersByPeriod(
    users: User[],
    period: ChartGroup,
  ): { [date: string]: number } {
    if (period === ChartGroup.Day) {
      return _.mapValues(
        _.groupBy(users, (user: IUserRecord) =>
          moment(user.createdAt).format('YYYY-MM-DD'),
        ),
        _.size,
      );
    } else {
      const momentPeriod = period as moment.unitOfTime.StartOf;
      return _.mapValues(
        _.groupBy(users, (user: IUserRecord) =>
          moment(user.createdAt).startOf(momentPeriod).format('YYYY-MM-DD'),
        ),
        _.size,
      );
    }
  }

  /**
   * Create initial grouped chart with default values
   * @param startDate - start date
   * @param endDate - end date
   * @param todayDate - today's date
   * @param result - input array
   * @param group - period to group by
   */
  private createInitialGroupedChart(
    startDate: moment.Moment,
    endDate: moment.Moment,
    todayDate: moment.Moment,
    result: NewUsersRegisteredObjectResponse[],
    group: ChartGroup,
  ): { date: string; quantity: number }[] {
    const momentGroup = group as moment.unitOfTime.StartOf;
    const momentGroupDuration = group as moment.unitOfTime.DurationConstructor;
    let currentDate: moment.Moment;

    if (group === ChartGroup.Day) {
      currentDate = startDate.clone();
    } else {
      currentDate = startDate.clone().startOf(momentGroup);
    }

    // Loop through the dates until the end date and set appropriate default values
    while (currentDate.isSameOrBefore(endDate, momentGroup)) {
      const formattedDate = currentDate.format('YYYY-MM-DD');
      if (currentDate.isBefore(todayDate))
        result.push({ date: formattedDate, quantity: 0 });
      currentDate.add(1, momentGroupDuration); // Move to the next day
    }

    return result;
  }

  /**
   * Gets chart data for new registered users
   * @param getNewUsersRegisteredParams - start date, end date and group by parameters
   * @returns new users registered response
   */
  async getNewUsersRegistered(
    getNewUsersRegisteredParams: GetNewUsersRegisteredParams,
  ): Promise<StatisticsNewUsersRegisteredResponse> {
    const {
      groupBy,
      startDate: startDateInput,
      endDate: endDateInput,
    } = getNewUsersRegisteredParams;

    let startDate = moment(startDateInput);
    const endDate = moment(endDateInput);

    const users = await this.userRepository.findManyLean({
      createdAt: { $gte: startDate, $lte: endDate },
      role: Role.User,
    });

    if (users.length < 1) return { chart: [] };

    let result: NewUsersRegisteredObjectResponse[] = [];

    const currentDate = moment();

    if (groupBy === ChartGroup.Month || groupBy === ChartGroup.Year) {
      startDate = startDate.clone().startOf(groupBy);
    }

    // Loop through the dates until the end date and set appropriate default values
    result = this.createInitialGroupedChart(
      startDate,
      endDate,
      currentDate,
      result,
      groupBy,
    );

    // Grouping by type of group
    const groupedData = this.groupUsersByPeriod(users, groupBy);

    // Assigning the grouped data to the result
    result = this.mapObjectToArray(groupedData, result);

    return { chart: result };
  }

  /**
   * Fetches user group counts
   * @param userGroupCountsParams - user group counts params
   * @returns array of user group counts response
   */
  async getUserGroupCounts(
    userGroupCountsParams: GetUserGroupCountsParams,
  ): Promise<UserGroupCountsResponse> {
    const result: UserGroupCountsResponse = {};

    let requiredGroups: string[] = [];

    if (!userGroupCountsParams.userGroups) {
      requiredGroups = Object.values(Game);
      const allUsers = await this.userRepository.count({ role: Role.User });
      result.allUsers = allUsers;
    } else {
      requiredGroups.push(...userGroupCountsParams.userGroups);
      for (const group of userGroupCountsParams.userGroups) {
        this.assignGameBasedOnUserGroup(group, requiredGroups);
      }
      if (userGroupCountsParams.userGroups.includes(UserGroup.AllUsers)) {
        const allUsers = await this.userRepository.count({ role: Role.User });
        result.allUsers = allUsers;
      }
    }

    const aggregatedData = await this.userGameDataRepository.countUsersPerGame(
      requiredGroups,
    );

    for (const data of aggregatedData) {
      this.assignUsersToResult(data, result);
    }

    return result;
  }

  /**
   * Assigns game player group to result
   * @param data - aggregated game users count
   * @param result - user group count response object
   */
  private assignUsersToResult(
    data: IAggregatedGameUsersCount,
    result: UserGroupCountsResponse,
  ): void {
    switch (data._id) {
      case Game.CallOfDuty: {
        result.callOfDutyPlayers = data.count;
        break;
      }
      case Game.ApexLegends: {
        result.apexLegendsPlayers = data.count;
        break;
      }
      case Game.Fortnite: {
        result.fortnitePlayers = data.count;
        break;
      }
      case Game.RocketLeague: {
        result.rocketLeaguePlayers = data.count;
        break;
      }
      default:
        break;
    }
  }

  /**
   * Assign game based on user group
   * @param group group name
   * @param requiredGroups required groups array
   */
  private assignGameBasedOnUserGroup(
    group: string,
    requiredGroups: string[],
  ): void {
    switch (group) {
      case UserGroup.CallOfDutyPlayers: {
        requiredGroups.push(Game.CallOfDuty);
        break;
      }
      case UserGroup.ApexLegendsPlayers: {
        requiredGroups.push(Game.ApexLegends);
        break;
      }
      case UserGroup.FortnitePlayers: {
        requiredGroups.push(Game.Fortnite);
        break;
      }
      case UserGroup.RocketLeaguePlayers: {
        requiredGroups.push(Game.RocketLeague);
        break;
      }
      default:
        break;
    }
  }

  /**
   * Creates weekly statistics for total users and onboarded users
   */
  async createWeeklyStatistics(): Promise<void> {
    // Count total users and onboarded users
    const userCount = await this.userRepository.count({ role: Role.User });
    const onboardedCount = await this.userRepository.count({
      role: Role.User,
      'status.type': { $ne: UserStatusType.Pending },
    });

    // Create weekly statistics
    await this.statisticsRepository.createOne({
      totalCount: userCount,
      onboardedCount: onboardedCount,
    });
  }
}
