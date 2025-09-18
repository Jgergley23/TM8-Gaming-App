import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';

import { AbstractFriendsRepository } from '../abstract/friends.abstract.repository';
import { Friends } from '../schemas/friends.schema';

@Injectable()
export class FriendsRepository extends AbstractFriendsRepository {
  constructor(
    @InjectModel('Friends')
    repository: Model<Friends>,
  ) {
    super(repository);
  }
}
