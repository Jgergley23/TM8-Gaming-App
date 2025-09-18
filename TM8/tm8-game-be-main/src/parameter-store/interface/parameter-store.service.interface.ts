/* eslint-disable @typescript-eslint/no-explicit-any */
import { MaybePromise } from 'src/common/types/maybe-promise.type';

export interface IParameterStoreService {
  /**
   * Gets parameter from parameter store
   * @param params - name of parameter
   * @returns Third-party service response
   */
  getParameter(name: string): MaybePromise<any>;
}

export const ParameterStoreServiceToken = Symbol('ParameterStoreServiceToken');
