import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';

import { AbstractUserRepository } from '../abstract/user.abstract.repository';
import { IUserRecord } from '../interface/user.interface';
import { User } from '../schemas/user.schema';

@Injectable()
export class UserRepository extends AbstractUserRepository {
  constructor(
    @InjectModel('User')
    repository: Model<User>,
  ) {
    super(repository);
  }

  async getUserById(id: string): Promise<IUserRecord> {
    return await this.entity.findById(id).lean();
  }

  async getUserByEmailOrUsername(
    email?: string,
    username?: string,
  ): Promise<IUserRecord> {
    if (!email && !username) throw new Error('Email or username is required');
    return await this.entity.findOne({
      $or: [{ email }, { username }],
    });
  }
}
