import { Inject, Injectable } from '@nestjs/common';

import {
  FileStorageProviderToken,
  IFileStorageProvider,
} from 'src/modules/s3/interface/file-storage-provider.interface';

import { IFileStorageParams } from '../interface/file-storage-params.interface';
import { IFileStorageService } from '../interface/file-storage.service.interface';

@Injectable()
export class FileStorageService implements IFileStorageService {
  constructor(
    @Inject(FileStorageProviderToken)
    private readonly fileStorageProvider: IFileStorageProvider,
  ) {}

  /**
   * Uploads a file to the file storage
   * @param params - file upload params
   * @returns Void
   */
  async upload(params: IFileStorageParams): Promise<void> {
    await this.fileStorageProvider.upload(params);
    //   return { id: data.data.channel.id };
  }

  /**
   * Deletes a file from the file storage
   * @param key - file key
   * @returns Void
   */
  async delete(key: string): Promise<void> {
    return await this.fileStorageProvider.delete(key);
  }
}
