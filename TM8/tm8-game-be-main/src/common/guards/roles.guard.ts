import { CanActivate, ExecutionContext, Injectable } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import * as jwt from 'jsonwebtoken';

import { AbstractUserRepository } from 'src/modules/user/abstract/user.abstract.repository';

import { JwtConfig } from '../config/env.validation';
import { Role } from '../constants';
import { ROLES_KEY } from '../decorators/roles.decorator';
import { TGMDForbiddenException } from '../exceptions/custom.exception';

type JwtPayload = {
  sub: string;
  username: string;
};

@Injectable()
export class RolesGuard implements CanActivate {
  constructor(
    private reflector: Reflector,
    private readonly userRepository: AbstractUserRepository,
    private readonly jwtConfig: JwtConfig,
  ) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const request = context.switchToHttp().getRequest();
    const token = this.validateToken(request.headers.authorization);

    const requiredRoles = this.reflector.getAllAndOverride<Role[]>(ROLES_KEY, [
      context.getHandler(),
      context.getClass(),
    ]);

    if (!requiredRoles) {
      return true;
    }

    if (token) {
      const user = await this.userRepository.findOne(
        { _id: token.sub },
        '_id role',
      );
      if (!user) throw new TGMDForbiddenException('User not found');

      return requiredRoles.some((role) => user.role === role);
    }
  }

  private validateToken(auth: string): JwtPayload {
    if (auth.split(' ')[0] !== 'Bearer') {
      throw new Error('Invalid token');
    }
    const token = auth.split(' ')[1];
    return jwt.verify(token, this.jwtConfig.SECRET) as JwtPayload;
  }
}
