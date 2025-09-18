/* eslint-disable @typescript-eslint/no-explicit-any */

import {
  TGMDConflictException,
  TGMDException,
  TGMDInternalException,
} from './custom.exception';

// Error map based on error code
export const MONGO_ERROR_MAP = new Map<string | number, () => TGMDException>([
  [
    11000,
    (): TGMDException =>
      new TGMDConflictException('This record already exists.'),
  ],
  [
    112,
    (): TGMDException =>
      new TGMDConflictException(
        'Could not process the request, please try again.',
      ),
  ],
  [
    211,
    (): TGMDException =>
      new TGMDInternalException(
        'Something went wrong, please try again later.',
      ),
  ],
  [
    11600,
    (): TGMDException =>
      new TGMDInternalException(
        'Something went wrong, please try again later.',
      ),
  ],
]);
