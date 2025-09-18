/* eslint-disable @typescript-eslint/no-unused-vars */
/* eslint-disable @typescript-eslint/no-explicit-any */

import {
  IsDateString,
  ValidationArguments,
  ValidationOptions,
  registerDecorator,
} from 'class-validator';

export class DateValidator {
  @IsDateString()
  date: string;
}

export function IsOlderThanThirteen(validationOptions?: ValidationOptions) {
  return function (object: any, propertyName: string): void {
    registerDecorator({
      name: 'isDateGreaterThan13Years',
      target: object.constructor,
      propertyName: propertyName,
      options: validationOptions,
      validator: {
        validate(value: any, args: ValidationArguments) {
          if (!value) return true; // Let other decorators handle empty values
          const date = new Date(value);
          const today = new Date();
          const minDate = new Date(
            today.getFullYear() - 13,
            today.getMonth(),
            today.getDate(),
          ); // 13 years ago from today
          return date <= minDate;
        },
        defaultMessage(args: ValidationArguments) {
          return `${args.property} must be greater than or equal to 13 years ago from now`;
        },
      },
    });
  };
}
