import { Injectable } from '@nestjs/common';
import { Cron } from '@nestjs/schedule';

import { IS_SCHEDULER_ENABLED } from 'src/common/constants';

import { StatisticsService } from './statistics.service';

@Injectable()
export class StatisticsSchedulerService {
  constructor(private readonly statisticsService: StatisticsService) {}

  @Cron('0 0 0 * * 0', {
    name: 'CREATE_WEEKLY_USER_STATISTICS',
    disabled: !IS_SCHEDULER_ENABLED,
  })
  /**
   * Creates weekly user statistics every sunday at midnight
   * @returns Void
   */
  private async createWeeklyUserStatistics(): Promise<void> {
    await this.statisticsService.createWeeklyStatistics();
  }
}
