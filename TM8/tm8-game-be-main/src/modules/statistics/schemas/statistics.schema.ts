import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { HydratedDocument } from 'mongoose';

import { IStatisticsRecord } from '../interfaces/statistics.interface';

@Schema({ timestamps: true })
export class Statistics implements IStatisticsRecord {
  _id: string;

  @Prop({ type: Number, required: true })
  totalCount: number;

  @Prop({ type: Number, required: true })
  onboardedCount: number;
}

export type StatisticsDocument = HydratedDocument<Statistics>;
export const StatisticsSchema = SchemaFactory.createForClass(Statistics).set(
  'toJSON',
  {
    virtuals: true,
  },
);
