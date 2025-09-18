import { ApiProperty } from '@nestjs/swagger';

import { IDropdownOption } from '../interface/dropdown-option.interface';

export class DropdownOptionResponse implements IDropdownOption {
  @ApiProperty()
  display: string;

  @ApiProperty()
  attribute: string;
}
