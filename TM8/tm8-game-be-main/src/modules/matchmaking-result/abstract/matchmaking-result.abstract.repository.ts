import { Injectable } from '@nestjs/common';

import { AbstractRepository } from 'src/common/abstract/abstract.repository';

import { MatchmakingResult } from '../schemas/matchmaking-result.schema';

@Injectable()
export abstract class AbstractMatchmakingResultRepository extends AbstractRepository<MatchmakingResult> {}
