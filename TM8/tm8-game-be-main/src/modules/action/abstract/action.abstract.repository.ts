import { Injectable } from '@nestjs/common';

import { AbstractRepository } from 'src/common/abstract/abstract.repository';

import { Action } from '../schemas/action.schema';

@Injectable()
export abstract class AbstractActionRepository extends AbstractRepository<Action> {
  abstract findOneLeanWithReporter(id: string): Promise<Action>;
}
