import {
  ValidationArguments,
  ValidationOptions,
  ValidatorConstraint,
  ValidatorConstraintInterface,
  registerDecorator,
} from 'class-validator';

@ValidatorConstraint({ name: 'enumArray', async: false })
export class EnumArrayValidator implements ValidatorConstraintInterface {
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  validate(value: any, args: ValidationArguments): boolean {
    const [enumType] = args.constraints;
    if (!value) {
      return false;
    }

    const enumValues = Object.values(enumType);
    const values = value.split(',').map((item: string) => item.trim());

    return values.every((val: string) => enumValues.includes(val));
  }

  defaultMessage(args: ValidationArguments): string {
    return `${args.property} must contain valid values from the enum`;
  }
}

export function IsEnumArray(
  enumType: object,
  validationOptions?: ValidationOptions,
) {
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  return function (object: Record<string, any>, propertyName: string): void {
    registerDecorator({
      target: object.constructor,
      propertyName: propertyName,
      options: validationOptions,
      constraints: [enumType],
      validator: EnumArrayValidator,
    });
  };
}
