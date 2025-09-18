import { SSM } from '@aws-sdk/client-ssm';
import { Injectable } from '@nestjs/common';

import { S3Config } from 'src/common/config/env.validation';

import { IParameterStorageProvider } from '../interface/parameter-storage-provider.interface';

@Injectable()
export class AwsParameterStoreService implements IParameterStorageProvider {
  private ssm: SSM;

  constructor(private readonly config: S3Config) {
    this.ssm = new SSM({
      region: this.config.REGION,
      credentials: {
        secretAccessKey: this.config.SECRET,
        accessKeyId: this.config.ACCESSKEY,
      },
    });
  }

  /**
   * Gets parameter from parameter store
   * @param params - params for getting a parameter
   * @returns Third-party service response
   */
  async getParameter(name: string): Promise<string> {
    const response = await this.ssm.getParameter({
      Name: name,
      WithDecryption: true,
    });

    return response.Parameter.Value;
  }
}
