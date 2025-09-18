import { faker } from '@faker-js/faker';

import { ActionData } from '../../schemas/action-data.schema';
import { Action } from '../../schemas/action.schema';

export const findManyInboundActionsResponse = [
  {
    _id: faker.database.mongodbObjectId(),
    user: faker.database.mongodbObjectId(),
    actionType: expect.any(String),
    actionsFrom: [
      {
        user: faker.database.mongodbObjectId(),
      },
    ] as ActionData[],
  } as Action,
];
