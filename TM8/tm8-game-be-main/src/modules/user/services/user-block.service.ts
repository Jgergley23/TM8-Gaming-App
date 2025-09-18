import { Injectable } from '@nestjs/common';
import { FilterQuery } from 'mongoose';

import { ActionType } from 'src/common/constants';
import { TGMDNotFoundException } from 'src/common/exceptions/custom.exception';
import { PaginationParams } from 'src/common/pagination/pagination-params';
import { PaginationModel } from 'src/common/pagination/paginaton.model';
import { AbstractActionRepository } from 'src/modules/action/abstract/action.abstract.repository';
import { AbstractFriendsRepository } from 'src/modules/friends/abstract/friends.abstract.repository';

import { AbstractUserBlockService } from '../abstract/user-block.abstract.service';
import { AbstractUserRepository } from '../abstract/user.abstract.repository';
import { AbstractUserService } from '../abstract/user.abstract.service';
import { User } from '../schemas/user.schema';

@Injectable()
export class UserBlockService extends AbstractUserBlockService {
  constructor(
    private readonly userRepository: AbstractUserRepository,
    private readonly actionRepository: AbstractActionRepository,
    private readonly friendsRepository: AbstractFriendsRepository,
    private readonly userService: AbstractUserService,
  ) {
    super();
  }

  /**
   * Lists users that were blocked by the current user
   * @param userId - user id
   * @param params - pagination params
   * @returns paginated list of users
   */
  async listBlockedUsers(
    userId: string,
    params: PaginationParams,
  ): Promise<PaginationModel<User>> {
    const { limit, skip } = params;

    const userBlocks = await this.actionRepository.findOneLean({
      user: userId,
      actionType: ActionType.Block,
    });
    if (!userBlocks) return new PaginationModel([], params, 0);

    const blockedUserIds = userBlocks.actionsTo?.map((block) => block.user);
    if (!blockedUserIds) return new PaginationModel([], params, 0);

    const query: FilterQuery<User> = {
      _id: { $in: blockedUserIds },
    };

    const blockedUsers = await this.userRepository.findManyLean(
      query,
      '_id username photoKey',
      {
        skip,
        limit,
      },
    );

    const count = await this.userRepository.count(query);

    return new PaginationModel(blockedUsers, params, count);
  }

  /**
   * Removes blocks from the block requester and block target users
   * @param currentUserId - id of user requesting the unblock
   * @param targetUserIds - ids of users being unblocked
   * @returns unblock users response
   */
  async unblockUsers(
    currentUserId: string,
    targetUserIds: string[],
  ): Promise<void> {
    const targetUsers = await this.userRepository.findManyLean({
      _id: { $in: targetUserIds },
    });
    if (targetUsers.length !== targetUserIds.length) {
      throw new TGMDNotFoundException('One or more users not found');
    }

    await this.removeBlocksFromBlockRequester(currentUserId, targetUserIds);

    await this.removeBlockFromTargetUsers(currentUserId, targetUserIds);
  }

  /**
   * Removes block from the block requester
   * @param currentUserId - id of user to request the unblock
   * @param targetUserId - id of user to be unblocked
   * @returns Void
   */
  private async removeBlocksFromBlockRequester(
    currentUserId: string,
    targetUserIds: string[],
  ): Promise<void> {
    const currentUserActions = await this.actionRepository.findOneLean({
      user: currentUserId,
      actionType: ActionType.Block,
    });
    if (!currentUserActions)
      throw new TGMDNotFoundException('Existing block not found');

    for (const targetUserId of targetUserIds) {
      if (
        !currentUserActions.actionsTo.some(
          (action) => action.user.toString() === targetUserId,
        )
      )
        throw new TGMDNotFoundException('Existing block not found');

      currentUserActions.actionsTo = currentUserActions.actionsTo.filter(
        (action) => action.user.toString() !== targetUserId,
      );
    }

    await this.actionRepository.updateOneById(currentUserActions._id, {
      actionsTo: currentUserActions.actionsTo,
    });
  }

  /**
   * Removes block from the block target user
   * @param currentUserId - id of user to request the unblock
   * @param targetUserId - id of user to be unblocked
   * @returns Void
   */
  private async removeBlockFromTargetUsers(
    currentUserId: string,
    targetUserIds: string[],
  ): Promise<void> {
    await this.actionRepository.updateMany(
      {
        user: { $in: targetUserIds },
        actionType: ActionType.Block,
      },
      {
        $pull: {
          actionsFrom: { user: currentUserId },
        },
      },
    );
  }

  /**
   * Blocks a user
   * @param currentUserId - id of user requesting the block
   * @param targetUserId - id of user being blocked
   * @returns Void
   */
  async blockUser(currentUserId: string, targetUserId: string): Promise<void> {
    const targetUser = await this.userRepository.findOneLean({
      _id: targetUserId,
    });
    if (!targetUser) throw new TGMDNotFoundException('User not found');

    const blockerFriends = await this.friendsRepository.findOneLean({
      user: currentUserId,
    });
    if (blockerFriends && blockerFriends.friends) {
      const isBlockingFriend = blockerFriends.friends.some(
        (f) => f.user.toString() === targetUserId,
      );

      if (isBlockingFriend) {
        await this.userService.userRemoveFriend(currentUserId, targetUserId);
      }
    }

    await this.addBlockToBlockRequester(currentUserId, targetUserId);

    await this.addBlockToBlockTargetUser(currentUserId, targetUserId);
  }

  /**
   * Creates user block actions if not existing, and add blocked user to the list of blocker actions to
   * @param blockerId - id of user requesting the block
   * @param blockeeId - id od blocked user
   * @returns Void
   */
  private async addBlockToBlockRequester(
    blockerId: string,
    blockeeId: string,
  ): Promise<void> {
    const blockerActions = await this.actionRepository.findOneLean({
      user: blockerId,
      actionType: ActionType.Block,
    });
    if (!blockerActions) {
      await this.actionRepository.createOne({
        user: blockerId,
        actionType: ActionType.Block,
        actionsFrom: [],
        actionsTo: [{ user: blockeeId }],
      });
    } else {
      if (
        blockerActions.actionsTo.some((f) => f.user.toString() === blockeeId)
      ) {
        return;
      }
      blockerActions.actionsTo.push({
        user: blockeeId,
      });
      await this.actionRepository.updateOneById(blockerActions._id, {
        actionsTo: blockerActions.actionsTo,
      });
    }
  }

  /**
   * Creates user block actions if not existing, and add blocker user to the list of blocked user actions from
   * @param blockerId - id of user requesting the block
   * @param blockeeId - id od blocked user
   * @returns Void
   */
  private async addBlockToBlockTargetUser(
    blockerId: string,
    blockeeId: string,
  ): Promise<void> {
    const blockeeActions = await this.actionRepository.findOneLean({
      user: blockeeId,
      actionType: ActionType.Block,
    });
    if (!blockeeActions) {
      await this.actionRepository.createOne({
        user: blockeeId,
        actionType: ActionType.Block,
        actionsFrom: [{ user: blockerId }],
        actionsTo: [],
      });
    } else {
      if (
        blockeeActions.actionsFrom.some((f) => f.user.toString() === blockerId)
      ) {
        return;
      }
      blockeeActions.actionsFrom.push({
        user: blockerId,
      });
      await this.actionRepository.updateOneById(blockeeActions._id, {
        actionsFrom: blockeeActions.actionsFrom,
      });
    }
  }
}
