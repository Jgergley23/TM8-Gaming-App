import { Module } from '@nestjs/common';

import { ParameterStorageProviderToken } from './interface/parameter-storage-provider.interface';
import { AwsParameterStoreService } from './services/aws-parameter-store.service';

@Module({
  providers: [
    AwsParameterStoreService,
    {
      provide: ParameterStorageProviderToken,
      useExisting: AwsParameterStoreService,
    },
  ],
  exports: [ParameterStorageProviderToken],
})
export class AwsParameterStoreModule {}
