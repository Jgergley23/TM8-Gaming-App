import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';

import { AbstractMatchRepository } from '../abstract/match.abstract.repository';
import { Match } from '../schemas/match.schema';

@Injectable()
export class MatchRepository extends AbstractMatchRepository {
  constructor(
    @InjectModel('Match')
    repository: Model<Match>,
  ) {
    super(repository);
  }
}
