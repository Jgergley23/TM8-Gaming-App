import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';

import { AbstractMatchmakingResultRepository } from '../abstract/matchmaking-result.abstract.repository';
import { MatchmakingResult } from '../schemas/matchmaking-result.schema';

@Injectable()
export class MatchmakingResultRepository extends AbstractMatchmakingResultRepository {
  constructor(
    @InjectModel('MatchmakingResult')
    repository: Model<MatchmakingResult>,
  ) {
    super(repository);
  }
}
