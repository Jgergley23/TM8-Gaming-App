import { Injectable } from '@nestjs/common';

import { AbstractRepository } from 'src/common/abstract/abstract.repository';

import { Statistics } from '../schemas/statistics.schema';

@Injectable()
export abstract class AbstractStatisticsRepository extends AbstractRepository<Statistics> {}
