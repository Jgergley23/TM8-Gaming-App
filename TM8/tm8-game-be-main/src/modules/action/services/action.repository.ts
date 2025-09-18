import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';

import { ActionType } from 'src/common/constants';

import { AbstractActionRepository } from '../abstract/action.abstract.repository';
import { Action } from '../schemas/action.schema';

@Injectable()
export class ActionRepository extends AbstractActionRepository {
  constructor(
    @InjectModel('Action')
    repository: Model<Action>,
  ) {
    super(repository);
  }

  /**
   * Finds one action with reporter
   * @param id - action id
   * @returns action object
   */
  async findOneLeanWithReporter(id: string): Promise<Action> {
    return await this.entity
      .findOne({ user: id, actionType: ActionType.Report })
      .populate({ path: 'actionsFrom', populate: { path: 'user' } })
      .lean();
  }
}
