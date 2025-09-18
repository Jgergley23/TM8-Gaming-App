import { IGamePreferenceValue } from './game-preference-value.interface';

export interface IUserGamePreference {
  key: string;
  values: IGamePreferenceValue[];
  title: string;
}
