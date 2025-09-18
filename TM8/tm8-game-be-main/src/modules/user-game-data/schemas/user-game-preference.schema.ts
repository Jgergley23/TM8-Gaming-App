import { Prop } from '@nestjs/mongoose';

import { IUserGamePreference } from '../interface/user-game-preference.interface';
import { GamePreferenceValue } from './game-preference-value.schema';

export class UserGamePreference implements IUserGamePreference {
  @Prop({ type: String, required: true })
  key: string;
  @Prop({ type: String, required: true })
  title: string;
  @Prop({ type: [GamePreferenceValue], required: true })
  values: GamePreferenceValue[];
}
