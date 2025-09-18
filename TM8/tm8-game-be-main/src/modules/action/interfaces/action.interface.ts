import { ActionType } from 'src/common/constants';
import { User } from 'src/modules/user/schemas/user.schema';

import { IActionDataRecord } from './action-data.interface';

export interface IAction {
  actionsFrom: IActionDataRecord[];
  actionsTo: IActionDataRecord[];
  user: string | User;
  actionType: ActionType;
}

export interface IActionRecord extends IAction {
  _id: string;
  createdAt?: Date;
  updatedAt?: Date;
}
