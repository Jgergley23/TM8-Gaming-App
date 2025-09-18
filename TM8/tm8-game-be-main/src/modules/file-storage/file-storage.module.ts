import { Module } from '@nestjs/common';

import { S3Module } from '../s3/s3.module';
import { FileStorageServiceToken } from './interface/file-storage.service.interface';
import { FileStorageService } from './services/file-storage.service';

@Module({
  imports: [S3Module],
  providers: [
    FileStorageService,
    { provide: FileStorageServiceToken, useExisting: FileStorageService },
  ],
  exports: [FileStorageServiceToken],
})
export class FileStorageModule {}
