export const rocketLeaguePlaystyle: Record<string, string[]> = {
  aggressive: ['passer', 'anchor', 'demo-heavy'],
  passer: ['1v1', 'aggressive'],
  anchor: ['aggressive', '1v1'],
  '1v1': ['passer', 'demo-heavy', 'anchor'],
  'demo-heavy': ['1v1', 'aggressive'],
};

export const rocketLeagueGameplay: Record<string, string[]> = {
  'offensive-scorer': ['defensive-passer'],
  'offensive-passer': ['defensive-scorer'],
  'mid-scorer': ['mid-defender'],
  'defensive-passer': ['offensive-scorer'],
  'defensive-scorer': ['offensive-passer'],
  'mid-defender': ['mid-scorer'],
};

export const playingLevel: Record<string, string[]> = {
  beginner: ['beginner', 'first-time'],
  'first-time': ['beginner', 'first-time'],
  intermediate: ['intermediate'],
  advanced: ['advanced'],
  pro: ['pro'],
  legend: ['legend'],
};
