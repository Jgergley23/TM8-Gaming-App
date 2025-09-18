import { Injectable } from '@nestjs/common';

import { AbstractFriendsRepository } from '../abstract/friends.abstract.repository';
import { AbstractFriendsService } from '../abstract/friends.abstract.service';

@Injectable()
export class FriendsService extends AbstractFriendsService {
  constructor(private readonly friendsRepository: AbstractFriendsRepository) {
    super();
  }

  /**
   * Deletes user friend records
   * @param userId - user id
   * @returns Void
   */
  async deleteAccountFriends(userId: string): Promise<void> {
    const userFriends = await this.friendsRepository.findOneLean({
      user: userId,
    });
    if (userFriends) {
      await this.friendsRepository.deleteOne(userFriends);
    }

    const userFriendFriends = await this.friendsRepository.findManyLean({
      friends: { $elemMatch: { user: userId } },
    });
    if (userFriendFriends) {
      const userFriendsIds = userFriendFriends?.map((friend) => friend._id);

      await this.friendsRepository.updateMany(
        {
          user: { $in: userFriendsIds },
        },
        {
          $pull: { friends: { user: userId } },
        },
      );
    }
  }
}
