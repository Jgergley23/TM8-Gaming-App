import { Module } from '@nestjs/common';

import { AwsParameterStoreModule } from 'src/aws-parameter-store/aws-parameter-store.module';

import { ParameterStoreServiceToken } from './interface/parameter-store.service.interface';
import { ParameterStoreService } from './services/parameter-store.service';

@Module({
  imports: [AwsParameterStoreModule],
  providers: [
    ParameterStoreService,
    { provide: ParameterStoreServiceToken, useExisting: ParameterStoreService },
  ],
  exports: [ParameterStoreServiceToken],
})
export class ParameterStoreModule {}
