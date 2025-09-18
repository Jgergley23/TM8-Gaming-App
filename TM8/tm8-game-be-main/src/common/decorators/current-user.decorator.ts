// Custom decorator to extract the current user
import { ExecutionContext, createParamDecorator } from '@nestjs/common';

export interface IUserTokenData {
  sub: string;
  role: string;
}

export const CurrentUser = createParamDecorator(
  (data: unknown, ctx: ExecutionContext): IUserTokenData => {
    const request = ctx.switchToHttp().getRequest();
    return request.user;
  },
);
