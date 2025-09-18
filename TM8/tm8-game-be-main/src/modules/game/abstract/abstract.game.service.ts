import { GamePreferenceInputResponse } from '../response/game-preference-input.response';
import { GameResponse } from '../response/game-response';

export abstract class AbstractGameService {
  abstract getAllGames(): GameResponse[];
  abstract getPreferenceForm(game: string): GamePreferenceInputResponse[];
}
