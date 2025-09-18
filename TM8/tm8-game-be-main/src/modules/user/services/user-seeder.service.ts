import { faker } from '@faker-js/faker';
import { Inject, Injectable, OnApplicationBootstrap } from '@nestjs/common';
import { WINSTON_MODULE_NEST_PROVIDER, WinstonLogger } from 'nest-winston';

import { NodeConfig, SeederConfig } from 'src/common/config/env.validation';
import {
  Environment,
  Gender,
  Region,
  Role,
  SignupType,
} from 'src/common/constants';
import { Timezone } from 'src/common/constants/timezone.enum';
import { UserStatusType } from 'src/common/constants/user-status-type.enum';
import { CryptoUtils } from 'src/common/utils/crypto.utils';

import { AbstractUserRepository } from '../abstract/user.abstract.repository';
import { User } from '../schemas/user.schema';

@Injectable()
export class UserSeederService implements OnApplicationBootstrap {
  constructor(
    private readonly userRepository: AbstractUserRepository,
    private readonly seederConfig: SeederConfig,
    @Inject(WINSTON_MODULE_NEST_PROVIDER)
    private readonly logger: WinstonLogger,
    private readonly nodeConfig: NodeConfig,
  ) {}

  async onApplicationBootstrap(): Promise<void> {
    await this.seedSuperadmin();
    /**
     * NOTE: Used only in development environment
     */
    if (this.nodeConfig.ENV !== Environment.Production) {
      await this.seedUsers();
    }
  }

  /**
   * Seeds superadmin
   * @returns Void
   */
  async seedSuperadmin(): Promise<void> {
    try {
      const superadminCount = await this.userRepository.count({
        role: 'superadmin',
      });
      if (superadminCount === 0) {
        await this.userRepository.createOne({
          email: this.seederConfig.SUPERADMIN.EMAIL,
          name: this.seederConfig.SUPERADMIN.NAME,
          password: this.seederConfig.SUPERADMIN.PASSWORD,
          role: Role.Superadmin,
          status: { type: UserStatusType.Active },
          notificationSettings: [],
        });
      }
    } catch (error) {
      this.logger.error(error);
      throw new Error(error);
    }
  }

  /**
   * Seeds users using faker
   * @returns Void
   */
  async seedUsers(): Promise<void> {
    try {
      const userCount = await this.userRepository.count({
        role: Role.User,
      });

      const hashedPassword = await CryptoUtils.generateHash(
        this.seederConfig.SUPERADMIN.PASSWORD,
      );
      const users: User[] = [];
      if (userCount === 0) {
        const seededUserCount = this.seederConfig.USER.COUNT;
        for (let i = 0; i < seededUserCount; i++) {
          users.push({
            role: Role.User,
            name: faker.person.fullName(),
            email: faker.internet.email(),
            password: hashedPassword,
            status: { type: UserStatusType.Active, note: '', until: null },
            gender: Gender.Male,
            signupType: SignupType.Manual,
            country: 'USA',
            username: faker.internet.userName(),
            phoneNumber: faker.phone.number(),
            dateOfBirth: faker.date.past({
              years: 20,
              refDate: '2015-01-01T00:00:00.000Z',
            }),
            timezone: Timezone.EST,
            photoKey: null,
            phoneVerified: true,
            rating: { ratings: [], average: 0 },
            notificationToken: `fake-${faker.string.alphanumeric(10)}`,
            notificationSettings: {
              enabled: true,
              match: true,
              friendAdded: true,
              message: true,
              reminders: true,
              news: true,
            },
            rejectedUsers: [],
            regions: [Region.NorthAmerica, Region.Europe],
            epicGamesUsername: `fake-${faker.internet.userName()}`,
          } as User);
        }
        await this.userRepository.createMany(users);
      }
    } catch (error) {
      this.logger.error(error);
    }
  }
}
