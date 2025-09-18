import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';

import { AbstractStatisticsRepository } from '../abstract/statistics.abstract.repository';
import { Statistics } from '../schemas/statistics.schema';

@Injectable()
export class StatisticsRepository extends AbstractStatisticsRepository {
  constructor(
    @InjectModel('Statistics')
    repository: Model<Statistics>,
  ) {
    super(repository);
  }
}
