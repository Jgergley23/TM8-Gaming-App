import { ApiProperty } from '@nestjs/swagger';

export class HealthCheckResponse {
  @ApiProperty({
    description: 'Name of the API',
  })
  name: string;

  @ApiProperty({
    description: 'Description of the API',
  })
  description: string;

  @ApiProperty({
    description: 'Version of the API',
  })
  version: string;

  constructor(name: string, description: string, version: string) {
    this.name = name;
    this.description = description;
    this.version = version;
  }
}
