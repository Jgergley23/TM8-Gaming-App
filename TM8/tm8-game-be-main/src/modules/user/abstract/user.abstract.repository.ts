import { Injectable } from '@nestjs/common';

import { AbstractRepository } from 'src/common/abstract/abstract.repository';

import { IUserRecord } from '../interface/user.interface';
import { User } from '../schemas/user.schema';

@Injectable()
export abstract class AbstractUserRepository extends AbstractRepository<User> {
  abstract getUserById(id: string): Promise<IUserRecord>;
  abstract getUserByEmailOrUsername(
    email?: string,
    username?: string,
  ): Promise<IUserRecord>;
}
