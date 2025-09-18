/* eslint-disable @typescript-eslint/no-explicit-any */
import { MaybePromise } from 'src/common/types/maybe-promise.type';

import { IFileStorageParams } from './file-storage-params.interface';

export interface IFileStorageService {
  /**
   * Uploads a file to the storage.
   * @param params - Params for uploading a file
   * @returns Third-party service response
   */
  upload(params: IFileStorageParams): MaybePromise<any>;

  /**
   * Deletes a photo by key.
   * @param key - Key of the file to be deleted
   * @returns Void
   */
  delete(key: string): MaybePromise<void>;
}

export const FileStorageServiceToken = Symbol('FileStorageServiceToken');
