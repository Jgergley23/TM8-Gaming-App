import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';

import { AbstractPotentialMatchRepository } from '../abstract/potential-match.abstract.repository';
import { PotentialMatch } from '../schemas/potential-match.schema';

@Injectable()
export class PotentialMatchRepository extends AbstractPotentialMatchRepository {
  constructor(
    @InjectModel('PotentialMatch')
    repository: Model<PotentialMatch>,
  ) {
    super(repository);
  }
}
