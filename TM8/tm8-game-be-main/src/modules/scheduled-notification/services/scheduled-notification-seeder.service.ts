import { Inject, Injectable, OnApplicationBootstrap } from '@nestjs/common';
import { WINSTON_MODULE_NEST_PROVIDER, WinstonLogger } from 'nest-winston';

import { NodeConfig } from 'src/common/config/env.validation';
import {
  Environment,
  Game,
  Role,
  UserGroup,
  UserNotificationInterval,
  UserNotificationType,
} from 'src/common/constants';
import { TGMDNotFoundException } from 'src/common/exceptions/custom.exception';
import { StringUtils } from 'src/common/utils/string.utils';
import { AbstractUserGameDataRepository } from 'src/modules/user-game-data/abstract/user-game-data.abstract.repository';
import { AbstractUserRepository } from 'src/modules/user/abstract/user.abstract.repository';

import { AbstractScheduledNotificationRepository } from '../abstract/scheduled-notification.abstract.repositrory';
import { IScheduledNotification } from '../interfaces/scheduled-notification.interface';

@Injectable()
export class ScheduledNotificationSeederService
  implements OnApplicationBootstrap
{
  constructor(
    private readonly scheduledNotificationRepository: AbstractScheduledNotificationRepository,
    private readonly userRepository: AbstractUserRepository,
    private readonly gameUserGameDataRepository: AbstractUserGameDataRepository,
    private readonly nodeConfig: NodeConfig,
    @Inject(WINSTON_MODULE_NEST_PROVIDER)
    private readonly logger: WinstonLogger,
  ) {}

  async onApplicationBootstrap(): Promise<void> {
    /**
     * NOTE: Used only in development environment
     */
    if (this.nodeConfig.ENV !== Environment.Production) {
      const scheduledNotifications =
        await this.scheduledNotificationRepository.count();
      if (scheduledNotifications < 1) {
        await this.seedGameNotifications();
        await this.seedGeneralNotifications();
      }
    }
  }

  /**
   * Seeds scheduled game-specific notifications
   * @returns Void
   */
  async seedGameNotifications(): Promise<void> {
    try {
      const callOfDutyPlayers =
        await this.gameUserGameDataRepository.findManyLean(
          {
            game: Game.CallOfDuty,
          },
          'user',
        );
      if (!callOfDutyPlayers)
        throw new TGMDNotFoundException('Call of Duty players not found');

      const createCodNotificationInput: IScheduledNotification = {
        date: new Date(new Date().setDate(new Date().getDate() + 30)),
        data: {
          title: 'Call of Duty: New Season',
          description: 'New season is out, get ready to play!',
          targetGroup: UserGroup.CallOfDutyPlayers,
          notificationType: UserNotificationType.GameUpdate,
        },
        users: callOfDutyPlayers.map((player) => player.user as string),
        interval: UserNotificationInterval.DoesntRepeat,
        openedBy: 0,
        receivedBy: 0,
        uniqueId: StringUtils.generateSevenDigitAlphaNumericCode(),
      };

      const fortnitePlayers =
        await this.gameUserGameDataRepository.findManyLean(
          {
            game: Game.Fortnite,
          },
          'user',
        );
      if (!fortnitePlayers)
        throw new TGMDNotFoundException('Fortnite players not found');

      const createFortniteNotificationInput: IScheduledNotification = {
        date: new Date(new Date().setDate(new Date().getDate() + 30)),
        data: {
          title: 'Fortnite: New Season',
          description: 'New season is out, get ready to play!',
          notificationType: UserNotificationType.GameUpdate,
          targetGroup: UserGroup.FortnitePlayers,
        },
        users: fortnitePlayers.map((player) => player.user as string),
        interval: UserNotificationInterval.DoesntRepeat,
        openedBy: 0,
        receivedBy: 0,
        uniqueId: StringUtils.generateSevenDigitAlphaNumericCode(),
      };

      const rocketLeaguePlayers =
        await this.gameUserGameDataRepository.findManyLean(
          {
            game: Game.RocketLeague,
          },
          'user',
        );
      if (!rocketLeaguePlayers)
        throw new TGMDNotFoundException('Rocket League players not found');

      const createRlNotificationInput: IScheduledNotification = {
        date: new Date(new Date().setDate(new Date().getDate() + 30)),
        users: rocketLeaguePlayers.map((player) => player.user as string),
        interval: UserNotificationInterval.DoesntRepeat,
        data: {
          notificationType: UserNotificationType.GameUpdate,
          title: 'Rocket League: New Season',
          description: 'New season is out, get ready to play!',
          targetGroup: UserGroup.RocketLeaguePlayers,
        },
        openedBy: 0,
        receivedBy: 0,
        uniqueId: StringUtils.generateSevenDigitAlphaNumericCode(),
      };

      const apexPlayers = await this.gameUserGameDataRepository.findManyLean(
        {
          game: Game.ApexLegends,
        },
        'user',
      );
      if (!apexPlayers)
        throw new TGMDNotFoundException('Apex Legends players not found');

      const creatApexNotificationInput: IScheduledNotification = {
        date: new Date(new Date().setDate(new Date().getDate() + 30)),
        users: apexPlayers.map((player) => player.user as string),
        interval: UserNotificationInterval.DoesntRepeat,
        data: {
          title: 'Apex Legends: New Season',
          description: 'New season is out, get ready to play!',
          notificationType: UserNotificationType.GameUpdate,
          targetGroup: UserGroup.ApexLegendsPlayers,
        },
        openedBy: 0,
        receivedBy: 0,
        uniqueId: StringUtils.generateSevenDigitAlphaNumericCode(),
      };

      await this.scheduledNotificationRepository.createMany([
        createCodNotificationInput,
        creatApexNotificationInput,
        createFortniteNotificationInput,
        createRlNotificationInput,
      ]);
    } catch (error) {
      this.logger.error(error);
      throw new Error(error);
    }
  }

  /**
   * Seeds general notifications
   * @returns Void
   */
  async seedGeneralNotifications(): Promise<void> {
    try {
      const users = await this.userRepository.findManyLean(
        { role: Role.User },
        '_id',
      );
      if (!users) throw new TGMDNotFoundException('Users not found');

      const maintenanceNotificationInput: IScheduledNotification = {
        date: new Date(new Date().setDate(new Date().getDate() + 30)),
        users: users.map((user) => user._id),
        interval: UserNotificationInterval.DoesntRepeat,
        data: {
          title: 'System Maintenance Planned',
          description:
            'System maintenance planned for 10th March 2024, 02:00 AM UTC. Some services may be unavailable',
          notificationType: UserNotificationType.SystemMaintenance,
          targetGroup: UserGroup.AllUsers,
        },
        openedBy: 0,
        receivedBy: 0,
        uniqueId: StringUtils.generateSevenDigitAlphaNumericCode(),
      };

      const discountNotificationInput: IScheduledNotification = {
        date: new Date(new Date().setDate(new Date().getDate() + 30)),
        users: users.map((user) => user._id),
        interval: UserNotificationInterval.RepeatWeekly,
        data: {
          title: 'Subscription Discount Offer',
          description:
            'We are offering a subscription discount for a limited time. Subscribe now and get 20% off!',
          notificationType: UserNotificationType.ExclusiveOffers,
          targetGroup: UserGroup.AllUsers,
        },
        openedBy: 0,
        receivedBy: 0,
        uniqueId: StringUtils.generateSevenDigitAlphaNumericCode(),
      };

      const improvementNotificationInput: IScheduledNotification = {
        date: new Date(new Date().setDate(new Date().getDate() + 30)),
        users: users.map((user) => user._id),
        interval: UserNotificationInterval.DoesntRepeat,
        data: {
          title: 'Matchmaking Improvements',
          description:
            'We have improved our matchmaking system. You will now find better matches faster!',
          notificationType: UserNotificationType.NewFeatures,
          targetGroup: UserGroup.AllUsers,
        },
        openedBy: 0,
        receivedBy: 0,
        uniqueId: StringUtils.generateSevenDigitAlphaNumericCode(),
      };

      const newGamesNotificationInput: IScheduledNotification = {
        date: new Date(new Date().setDate(new Date().getDate() + 30)),
        users: users.map((user) => user._id),
        interval: UserNotificationInterval.DoesntRepeat,
        data: {
          title: 'New Games Coming Soon',
          description:
            "We're excited to announce that we are adding new games to our platform. Stay tuned for more updates!",
          notificationType: UserNotificationType.NewFeatures,
          targetGroup: UserGroup.AllUsers,
        },
        openedBy: 0,
        receivedBy: 0,
        uniqueId: StringUtils.generateSevenDigitAlphaNumericCode(),
      };

      const communityNotificationInput: IScheduledNotification = {
        date: new Date(new Date().setDate(new Date().getDate() + 30)),
        users: users.map((user) => user._id),
        interval: UserNotificationInterval.DoesntRepeat,
        data: {
          title: 'Start Matchmaking Now',
          description:
            'Jump into the action now and start matchmaking with other players!',
          targetGroup: UserGroup.AllUsers,
          notificationType: UserNotificationType.CommunityNews,
        },
        openedBy: 0,
        receivedBy: 0,
        uniqueId: StringUtils.generateSevenDigitAlphaNumericCode(),
      };

      const freeTrialNotificationInput: IScheduledNotification = {
        date: new Date(new Date().setDate(new Date().getDate() + 30)),
        users: users.map((user) => user._id),
        interval: UserNotificationInterval.DoesntRepeat,
        data: {
          title: 'Introducing Free Trial Period',
          description:
            'We are introducing a 14 day free trial period for new users. Try out our platform now!',
          notificationType: UserNotificationType.ExclusiveOffers,
          targetGroup: UserGroup.AllUsers,
        },
        openedBy: 0,
        receivedBy: 0,
        uniqueId: StringUtils.generateSevenDigitAlphaNumericCode(),
      };
      await this.scheduledNotificationRepository.createMany([
        maintenanceNotificationInput,
        discountNotificationInput,
        improvementNotificationInput,
        newGamesNotificationInput,
        communityNotificationInput,
        freeTrialNotificationInput,
      ]);
    } catch (error) {
      this.logger.error(error);
      throw new Error(error);
    }
  }
}
