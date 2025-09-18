import { Injectable } from '@nestjs/common';

import { AbstractRejectedUserService } from '../abstract/rejected-user.abstract.service';
import { AbstractUserRepository } from '../abstract/user.abstract.repository';

@Injectable()
export class RejectedUserService extends AbstractRejectedUserService {
  constructor(private readonly userRepository: AbstractUserRepository) {
    super();
  }

  /**
   * Cleans up rejected users from each user in the database.
   */
  async cleanupRejectedUsers(): Promise<void> {
    const currentDate = new Date();
    await this.userRepository.updateMany(
      {
        'rejectedUsers.until': { $lte: currentDate },
      },
      {
        $pull: { rejectedUsers: { until: { $lte: currentDate } } },
      },
    );
  }
}
