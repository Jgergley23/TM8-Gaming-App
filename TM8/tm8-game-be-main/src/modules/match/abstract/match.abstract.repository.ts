import { Injectable } from '@nestjs/common';

import { AbstractRepository } from 'src/common/abstract/abstract.repository';

import { Match } from '../schemas/match.schema';

@Injectable()
export abstract class AbstractMatchRepository extends AbstractRepository<Match> {}
