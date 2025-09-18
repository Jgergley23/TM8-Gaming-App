import { Injectable } from '@nestjs/common';

import { AbstractActionRepository } from '../abstract/action.abstract.repository';
import { AbstractActionService } from '../abstract/action.abstract.service';

@Injectable()
export class ActionService extends AbstractActionService {
  constructor(private readonly actionRepository: AbstractActionRepository) {
    super();
  }

  /**
   * Deletes user related inbound actions
   * @param userId - user id
   * @returns Void
   */
  async deleteUserRelatedInboundActions(userId: string): Promise<void> {
    const userRelatedInboundActions = await this.actionRepository.findManyLean({
      actionsTo: { $elemMatch: { user: userId } },
    });
    if (userRelatedInboundActions) {
      const userRelatedInboundActionsIds = userRelatedInboundActions?.map(
        (action) => action._id,
      );

      await this.actionRepository.updateMany(
        {
          user: { $in: userRelatedInboundActionsIds },
        },
        {
          $pull: { actionsTo: { user: userId } },
        },
      );
    }
  }

  /**
   * Deletes user related outbound actions
   * @param userId - user id
   * @returns Void
   */
  async deleteUserRelatedOutboundActions(userId: string): Promise<void> {
    const userRelatedOutboundActions = await this.actionRepository.findManyLean(
      {
        actionsFrom: { $elemMatch: { user: userId } },
      },
    );
    if (userRelatedOutboundActions) {
      const userRelatedOutboundActionsIds = userRelatedOutboundActions?.map(
        (action) => action._id,
      );

      await this.actionRepository.updateMany(
        {
          user: { $in: userRelatedOutboundActionsIds },
        },
        {
          $pull: { actionsFrom: { user: userId } },
        },
      );
    }
  }

  /**
   * Deletes user related outbound actions
   * @param userId - user id
   * @returns Void
   */
  async deleteUserActions(userId: string): Promise<void> {
    const userActions = await this.actionRepository.findManyLean({
      user: userId,
    });
    if (userActions) {
      const userActionsIds = userActions?.map((action) => {
        return action._id.toString();
      });
      await this.actionRepository.deleteMany(userActionsIds);
    }
  }
}
