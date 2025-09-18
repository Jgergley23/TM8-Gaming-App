import { PaginationParams } from 'src/common/pagination/pagination-params';
import { PaginationModel } from 'src/common/pagination/paginaton.model';

import { User } from '../schemas/user.schema';

export abstract class AbstractUserBlockService {
  abstract listBlockedUsers(
    userId: string,
    params: PaginationParams,
  ): Promise<PaginationModel<User>>;
  abstract blockUser(
    currentUserId: string,
    targetUserId: string,
  ): Promise<void>;
  abstract unblockUsers(
    currentUserId: string,
    targetUserIds: string[],
  ): Promise<void>;
}
