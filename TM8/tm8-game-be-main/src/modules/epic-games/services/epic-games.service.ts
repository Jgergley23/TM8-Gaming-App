import { Injectable } from '@nestjs/common';
import axios from 'axios';

import { EpicGamesConfig } from 'src/common/config/env.validation';
import {
  TGMDConflictException,
  TGMDExternalServiceException,
  TGMDNotFoundException,
} from 'src/common/exceptions/custom.exception';
import { User } from 'src/modules/user/schemas/user.schema';

import { AbstractUserRepository } from '../../user/abstract/user.abstract.repository';
import { AbstractEpicGamesService } from '../abstract/epic-games.abstract.service';
import { EpicGamesTokenResponse } from '../response/epic-games-token.response';
import { EpicGamesUserResponse } from '../response/epic-games-user.response';

@Injectable()
export class EpicGamesService extends AbstractEpicGamesService {
  constructor(
    private readonly epicGamesConfig: EpicGamesConfig,
    private readonly userRepository: AbstractUserRepository,
  ) {
    super();
  }

  /**
   * Sends a request to Epic Games API to fetch user data
   * @param code - Epic Games OAuth 2.0 code
   * @returns epic games token response
   */
  async sendEpicTokenRequest(code: string): Promise<EpicGamesTokenResponse> {
    const response = await axios.post(
      this.epicGamesConfig.ENDPOINT.TOKENURL,
      {
        grant_type: 'authorization_code',
        code: code,
      },
      {
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        auth: {
          username: this.epicGamesConfig.CLIENTID,
          password: this.epicGamesConfig.CLIENTSECRET,
        },
      },
    );
    if (!response.data || Object.keys(response.data).length === 0)
      throw new TGMDExternalServiceException(
        'Failed to fetch tokens from Epic Games API',
      );

    return response.data;
  }

  /**
   * Pings Epic Game Account to fetch user data
   * @param accessToken - Epic Games user access token
   * @param accountId - Epic Games user account ID
   * @param userId - User ID
   * @returns Void
   */
  async getEpicGamesUser(
    accessToken: string,
    accountId: string,
  ): Promise<EpicGamesUserResponse> {
    const userResponse = await axios.get(
      `${this.epicGamesConfig.ENDPOINT.ACCOUNTURL}?accountId=${accountId}`,

      {
        headers: { Authorization: `Bearer ${accessToken}` },
      },
    );
    if (!userResponse.data || userResponse.data.length < 1)
      throw new TGMDExternalServiceException(
        'Failed to fetch user data from Epic Games API',
      );
    return userResponse.data[0];
  }

  /**
   * Sets epic data for user
   * @param userId - userId
   * @param epicUser - epic user object
   * @returns Void
   */
  async storeEpicData(
    userId: string,
    epicUser: EpicGamesUserResponse,
  ): Promise<User> {
    const user = await this.userRepository.findOne({ _id: userId });
    if (!user) throw new TGMDNotFoundException('User not found');

    return await this.userRepository.updateOneById(user._id, {
      epicGamesUsername: epicUser.displayName,
    });
  }

  /**
   * Removes the Epic Games account from the user
   * @param userId - user id
   * @returns Void
   */
  async removeEpicAccount(userId: string): Promise<void> {
    const user = await this.userRepository.findOneLean({ _id: userId });
    if (!user.epicGamesUsername)
      throw new TGMDConflictException(
        'User does not have a connected Epic Games account',
      );

    await this.userRepository.updateOneById(userId, {
      epicGamesUsername: null,
    });
  }
}
