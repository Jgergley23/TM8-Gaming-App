import { ThrottlerGuard } from '@nestjs/throttler';

import { TGMDThrottlerException } from '../exceptions/custom.exception';

export class RateLimiterGuard extends ThrottlerGuard {
  protected async throwThrottlingException(): Promise<void> {
    throw new TGMDThrottlerException(
      'Too many requests in a short period of time. Try again in one minute',
    );
  }
}
