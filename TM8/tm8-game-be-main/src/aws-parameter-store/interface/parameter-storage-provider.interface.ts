/* eslint-disable @typescript-eslint/no-explicit-any */

import { MaybePromise } from 'src/common/types/maybe-promise.type';

export interface IParameterStorageProvider {
  /**
   * Gets a parameter from the storage
   * @param params - params for getting parameter
   * @returns Third-party service response
   */
  getParameter(params: any): MaybePromise<any>;
}

export const ParameterStorageProviderToken = Symbol(
  'ParameterStorageProviderToken',
);
