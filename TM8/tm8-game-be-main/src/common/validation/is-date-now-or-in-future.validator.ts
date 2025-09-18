import {
  ValidationArguments,
  ValidationOptions,
  ValidatorConstraint,
  ValidatorConstraintInterface,
  registerDecorator,
} from 'class-validator';

@ValidatorConstraint({ name: 'isDateNowOrInFuture', async: false })
export class IsDateNowOrInFutureConstraint
  implements ValidatorConstraintInterface
{
  validate(value: string): boolean {
    const currentDate = new Date();
    const date = new Date(value);

    return date >= currentDate;
  }

  defaultMessage(args: ValidationArguments): string {
    return `${args.property} must be now or in the future`;
  }
}

export function IsDateNowOrInFuture(validationOptions?: ValidationOptions) {
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  return function (object: Record<string, any>, propertyName: string): void {
    registerDecorator({
      target: object.constructor,
      propertyName: propertyName,
      options: validationOptions,
      constraints: [],
      validator: IsDateNowOrInFutureConstraint,
    });
  };
}
