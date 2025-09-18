import { Inject, Injectable } from '@nestjs/common';

import {
  IParameterStorageProvider,
  ParameterStorageProviderToken,
} from 'src/aws-parameter-store/interface/parameter-storage-provider.interface';

import { IParameterStoreService } from '../interface/parameter-store.service.interface';

@Injectable()
export class ParameterStoreService implements IParameterStoreService {
  constructor(
    @Inject(ParameterStorageProviderToken)
    private readonly parameterStorageProvider: IParameterStorageProvider,
  ) {}

  async getParameter(name: string): Promise<string> {
    return await this.parameterStorageProvider.getParameter(name);
  }
}
