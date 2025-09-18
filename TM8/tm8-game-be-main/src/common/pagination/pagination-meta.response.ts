import { ApiProperty } from '@nestjs/swagger';

import { IPageMeta } from './pagination-meta.interface';

export class PaginationMetaResponse {
  @ApiProperty({ description: 'Page number' })
  readonly page: number;

  @ApiProperty({ description: 'Page size' })
  readonly limit: number;

  @ApiProperty({ description: 'Total items without pagination' })
  readonly itemCount: number;

  @ApiProperty({
    description: 'Total pages with current page size',
  })
  readonly pageCount: number;

  @ApiProperty({
    description: 'Flag indicating if there is a previous page',
  })
  readonly hasPreviousPage: boolean;

  @ApiProperty({
    description: 'Flag indicating if there is a next page',
  })
  readonly hasNextPage: boolean;

  constructor({ params, count }: IPageMeta) {
    this.page = params.page;
    this.limit = params.limit;
    this.itemCount = count;
    this.pageCount = Math.ceil(this.itemCount / this.limit);
    this.hasPreviousPage = this.page > 1;
    this.hasNextPage = this.page < this.pageCount;
  }
}
