import { CanActivate, ExecutionContext, Injectable } from '@nestjs/common';

import { AbstractUserRepository } from 'src/modules/user/abstract/user.abstract.repository';

import { UserStatusType } from '../constants';
import {
    TGMDForbiddenException,
    TGMDInvalidUserStatusException,
} from '../exceptions/custom.exception';

@Injectable()
export class UserStatusGuard implements CanActivate {
  constructor(private readonly userRepository: AbstractUserRepository) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const request = context.switchToHttp().getRequest();

    // Find the user that is making the request
    const user = await this.userRepository.findOne(
      { _id: request.user?.sub },
      '_id status',
    );
    if (!user) throw new TGMDForbiddenException('User not found');

    // Check if the user is Banned or Suspended
    if (user.status?.type === UserStatusType.Banned) {
      throw new TGMDInvalidUserStatusException('Your account has been banned');
    } else if (user.status?.type === UserStatusType.Suspended) {
      throw new TGMDInvalidUserStatusException(
        `Your account has been suspended until ${user.status?.until}`,
      );
    }

    // For now, we will allow all other user statuses
    return true;
  }
}
