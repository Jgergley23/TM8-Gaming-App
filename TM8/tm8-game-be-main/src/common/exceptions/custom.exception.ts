/**
 * Custom exception class for TGMD exceptions.
 */

import { ExceptionName } from './custom.exception.enum';
import { ICustomExceptionInfo } from './exception-info.interface';
import { getException } from './metadata.exception';

export abstract class TGMDException extends Error {
  public exceptionName: ExceptionName;
  public exceptionInfo: ICustomExceptionInfo;

  constructor(exceptionName: ExceptionName, message: string) {
    super();
    this.exceptionName = exceptionName;
    this.exceptionInfo = getException(exceptionName);
    this.exceptionInfo.detail = message;
  }

  public toString = (): string => {
    return `${this.exceptionName} exception:\n${this.exceptionInfo}`;
  };
}

export class TGMDNotFoundException extends TGMDException {
  constructor(message: string) {
    super(ExceptionName.NOT_FOUND, message);
  }
}

export class TGMDBadRequestException extends TGMDException {
  constructor(message: string) {
    super(ExceptionName.BAD_REQUEST, message);
  }
}

export class TGMDConflictException extends TGMDException {
  constructor(message: string) {
    super(ExceptionName.CONFLICT, message);
  }
}

export class TGMDForbiddenException extends TGMDException {
  constructor(message: string) {
    super(ExceptionName.FORBIDDEN, message);
  }
}

export class TGMDValidationException extends TGMDException {
  constructor(message: string) {
    super(ExceptionName.VALIDATION_FAILED, message);
  }
}

export class TGMDInternalException extends TGMDException {
  constructor(message: string) {
    super(ExceptionName.INTERNAL_EXCEPTION, message);
  }
}

export class TGMDExternalServiceException extends TGMDException {
  constructor(message: string) {
    super(ExceptionName.EXTERNAL_SERVICE_EXCEPTION, message);
  }
}

export class TGMDRefreshTokenFailedException extends TGMDException {
  constructor(message: string) {
    super(ExceptionName.REFRESH_TOKEN, message);
  }
}

export class TGMDUnauthorizedException extends TGMDException {
  constructor(message: string) {
    super(ExceptionName.UNAUTHORIZED, message);
  }
}
export class TGMDThrottlerException extends TGMDException {
  constructor(message: string) {
    super(ExceptionName.THROTTLER, message);
  }
}

export class TGMDInvalidUserStatusException extends TGMDException {
  constructor(message: string) {
    super(ExceptionName.INVALID_USER_STATUS, message);
  }
}

// TODO Add exception classes when needed.
