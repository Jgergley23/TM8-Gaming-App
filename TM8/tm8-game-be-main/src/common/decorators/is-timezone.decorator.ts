/* eslint-disable @typescript-eslint/no-unused-vars */
import {
  ValidationArguments,
  ValidationOptions,
  registerDecorator,
} from 'class-validator';

export function IsTimezone(validationOptions?: ValidationOptions) {
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  return function (object: any, propertyName: string): void {
    registerDecorator({
      name: 'isTimezone',
      target: object.constructor,
      propertyName: propertyName,
      options: validationOptions,
      validator: {
        // eslint-disable-next-line @typescript-eslint/no-explicit-any
        validate(value: any, args: ValidationArguments) {
          // Regex to match three or four characters followed by an optional '+' or '-' and 1 or 2 digits
          const timeZoneRegex = /^[A-Z]{3,4}[+-]\d{1,2}$/;
          return typeof value === 'string' && timeZoneRegex.test(value);
        },
        defaultMessage(args: ValidationArguments) {
          return `${args.property} must be a valid time zone string in the format "ABC±XX"`;
        },
      },
    });
  };
}
