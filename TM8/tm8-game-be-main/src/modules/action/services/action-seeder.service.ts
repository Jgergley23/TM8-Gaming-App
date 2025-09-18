import { Inject, Injectable, OnApplicationBootstrap } from '@nestjs/common';
import { WINSTON_MODULE_NEST_PROVIDER, WinstonLogger } from 'nest-winston';

import { NodeConfig } from 'src/common/config/env.validation';
import { ActionType, Environment, Role } from 'src/common/constants';
import { ReportReason } from 'src/common/constants/report-reason.enum';
import { TGMDNotFoundException } from 'src/common/exceptions/custom.exception';
import { AbstractUserRepository } from 'src/modules/user/abstract/user.abstract.repository';

import { AbstractActionRepository } from '../abstract/action.abstract.repository';
import { IAction } from '../interfaces/action.interface';

@Injectable()
export class ActionSeederService implements OnApplicationBootstrap {
  constructor(
    private readonly userRepository: AbstractUserRepository,
    private readonly actionRepository: AbstractActionRepository,
    private readonly nodeConfig: NodeConfig,
    @Inject(WINSTON_MODULE_NEST_PROVIDER)
    private readonly logger: WinstonLogger,
  ) {}

  async onApplicationBootstrap(): Promise<void> {
    /**
     * NOTE: Used only in development environment
     */
    if (this.nodeConfig.ENV !== Environment.Production) {
      const actionCount = await this.actionRepository.count({
        actionType: ActionType.Report,
      });
      if (actionCount < 1) {
        await this.seedEmptyUserReports();
        await this.seedUserReports();
      }
    }
  }

  /**
   * Seeds empty user actions (initial objects)
   * @returns Void
   */
  async seedEmptyUserReports(): Promise<void> {
    try {
      const users = await this.userRepository.findManyLean({ role: Role.User });
      if (users.length < 1) throw new TGMDNotFoundException('Users not found');

      const actions: IAction[] = [];

      for (const user of users) {
        actions.push({
          user: user._id,
          actionsFrom: [],
          actionsTo: [],
          actionType: ActionType.Report,
        });
      }

      await this.actionRepository.createMany(actions);
    } catch (error) {
      this.logger.error(error);
    }
  }

  /**
   * Seeds user reports
   * @returns Void
   */
  async seedUserReports(): Promise<void> {
    try {
      const users = await this.userRepository.findManyLean({ role: Role.User });
      if (users.length < 1) throw new TGMDNotFoundException('Users not found');

      const availableReporterIds = [...users.map((user) => user._id)]; // Array of available targetIds

      for (const user of users) {
        const action = await this.actionRepository.findOne({
          user: user._id,
          actionType: ActionType.Report,
        });
        if (!action) throw new TGMDNotFoundException('Action not found');

        // Randomly select a targetId and remove it from availableTargetIds
        const index = Math.floor(Math.random() * availableReporterIds.length);
        const reporterId = availableReporterIds.splice(index, 1)[0];

        const reporter = await this.userRepository.findOne({ _id: reporterId });
        if (!reporter) throw new TGMDNotFoundException('Reporter not found');

        action.actionsFrom.push({
          reportReason: ReportReason.ViolationOfPlatformPolicies,
          user: reporterId,
        });

        const reporterAction = await this.actionRepository.findOne({
          user: reporterId,
        });
        if (!reporterAction)
          throw new TGMDNotFoundException('Reporter actions not found');

        reporterAction.actionsTo.push({
          reportReason: ReportReason.ViolationOfPlatformPolicies,
          user: user._id,
        });

        action.save();
        reporterAction.save();
      }
    } catch (error) {
      this.logger.error(error);
    }
  }
}
