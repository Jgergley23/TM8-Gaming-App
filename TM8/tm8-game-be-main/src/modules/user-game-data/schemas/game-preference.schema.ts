import { Prop } from '@nestjs/mongoose';

import { IGamePreference } from '../interface/game-preference.interface';
import { GamePreferenceValue } from './game-preference-value.schema';

export class GamePreference implements IGamePreference {
  @Prop({ type: String, required: true })
  key: string;
  @Prop({ type: String, required: true })
  title: string;
  @Prop({ type: GamePreferenceValue, required: true })
  values: GamePreferenceValue[];
}
