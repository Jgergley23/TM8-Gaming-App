import { Injectable } from '@nestjs/common';

import { AbstractRepository } from 'src/common/abstract/abstract.repository';

import { Friends } from '../schemas/friends.schema';

@Injectable()
export abstract class AbstractFriendsRepository extends AbstractRepository<Friends> {}
