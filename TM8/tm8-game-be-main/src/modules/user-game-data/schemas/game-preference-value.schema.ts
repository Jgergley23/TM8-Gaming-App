import { Prop } from '@nestjs/mongoose';

import { GamePreferenceValue as GamePreferenceValueEnum } from 'src/common/constants/game-preference-value.enum';

import { IGamePreferenceValue } from '../interface/game-preference-value.interface';

export class GamePreferenceValue implements IGamePreferenceValue {
  @Prop({ type: GamePreferenceValueEnum, required: true })
  key: string;
  @Prop({ type: String, required: false })
  selectedValue?: string;
  @Prop({ type: Number, required: false, min: 1 })
  numericValue?: number;
  @Prop({ type: String, required: false })
  numericDisplay?: string;
}
