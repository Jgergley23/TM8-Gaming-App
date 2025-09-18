/**
 * Metadata for TGMD exceptions.
 * Includes status code, error code, and default error message.
 */

import { ExceptionName } from './custom.exception.enum';
import { ICustomExceptionInfo } from './exception-info.interface';

const EXCEPTION_PREFIX = 'TGMD';

export const exceptionMetadata: Record<ExceptionName, ICustomExceptionInfo> = {
  INTERNAL_EXCEPTION: {
    status: 500,
    code: '0001',
    detail: 'Internal server exception',
  },
  BAD_REQUEST: {
    status: 400,
    code: '0011',
    detail: 'Bad request',
  },
  INCORRECT_SIGNIN: {
    status: 401,
    code: '0002',
    detail: 'Incorrect credentials',
  },
  VALIDATION_FAILED: {
    status: 422,
    code: '0003',
    detail: 'Input validation failed',
  },
  FORBIDDEN: {
    status: 403,
    code: '0004',
    detail: 'You are not authorized for this action',
  },
  NOT_FOUND: {
    status: 404,
    code: '0005',
    detail: 'Entity could not be found',
  },
  ALREADY_EXISTS: {
    status: 409,
    code: '0006',
    detail: 'Entity already exists',
  },
  CONFLICT: {
    status: 409,
    code: '0007',
    detail: 'A request could not be processed due to a conflict',
  },
  EXTERNAL_SERVICE_EXCEPTION: {
    status: 504,
    code: '0008',
    detail: 'External service failed',
  },
  REFRESH_TOKEN: {
    status: 500,
    code: '0009',
    detail: 'Token refresh failed; User should be logged out',
  },
  UNAUTHORIZED: {
    status: 401,
    code: '0010',
    detail: 'Unauthorized access',
  },
  THROTTLER: {
    status: 429,
    code: '0012',
    detail: 'Too Many Requests',
  },
  INVALID_USER_STATUS: {
    status: 403,
    code: '0013',
    detail: 'User status is invalid for this action',
  },
};

export const getAllCustomExceptionCodes = (): string[] => {
  return Object.values(exceptionMetadata).map(
    (meta) => `${EXCEPTION_PREFIX}-${meta.code}`,
  );
};

export const getAllCustomExceptionStatuses = (): number[] => {
  return Object.values(exceptionMetadata).map((meta) => meta.status);
};

export const getException = (
  name: ExceptionName,
  detail?: string,
): ICustomExceptionInfo => {
  const exception: ICustomExceptionInfo = Object.assign(
    {},
    exceptionMetadata[name] ?? exceptionMetadata.INTERNAL_EXCEPTION,
  );

  exception.code = `${EXCEPTION_PREFIX}-${exception.code}`;

  return Object.assign(exception, detail ? { detail: detail } : undefined);
};
