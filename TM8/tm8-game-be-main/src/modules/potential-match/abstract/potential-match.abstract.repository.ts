import { Injectable } from '@nestjs/common';

import { AbstractRepository } from 'src/common/abstract/abstract.repository';

import { PotentialMatch } from '../schemas/potential-match.schema';

@Injectable()
export abstract class AbstractPotentialMatchRepository extends AbstractRepository<PotentialMatch> {}
