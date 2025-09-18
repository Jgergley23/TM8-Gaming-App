import { Inject, Injectable, OnApplicationBootstrap } from '@nestjs/common';
import { WINSTON_MODULE_NEST_PROVIDER, WinstonLogger } from 'nest-winston';

import { Role, UserStatusType } from 'src/common/constants';
import { AbstractUserRepository } from 'src/modules/user/abstract/user.abstract.repository';

import { AbstractStatisticsRepository } from '../abstract/statistics.abstract.repository';

@Injectable()
export class StatisticsSeederService implements OnApplicationBootstrap {
  constructor(
    private readonly statisticsRepository: AbstractStatisticsRepository,
    private readonly userRespository: AbstractUserRepository,

    @Inject(WINSTON_MODULE_NEST_PROVIDER)
    private readonly logger: WinstonLogger,
  ) {}

  async onApplicationBootstrap(): Promise<void> {
    await this.seedStatistics();
  }

  /**
   * Seeds initial user statistics
   * @returns Void
   */
  async seedStatistics(): Promise<void> {
    try {
      const statisticsCount = await this.statisticsRepository.count();
      if (statisticsCount < 1) {
        const userCount = await this.userRespository.count({ role: Role.User });
        const onboardedCount = await this.userRespository.count({
          role: Role.User,
          'status.type': { $ne: UserStatusType.Pending },
        });

        await this.statisticsRepository.createOne({
          totalCount: userCount,
          onboardedCount: onboardedCount,
        });
      }
    } catch (error) {
      this.logger.error(error);
      throw new Error(error);
    }
  }
}
