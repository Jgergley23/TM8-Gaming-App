import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';

enum ScheduledNotificationDataResponseTargetGroup {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('all-users')
  allUsers('all-users'),
  @JsonValue('fortnite-players')
  fortnitePlayers('fortnite-players'),
  @JsonValue('apex-legends-players')
  apexLegendsPlayers('apex-legends-players'),
  @JsonValue('call-of-duty-players')
  callOfDutyPlayers('call-of-duty-players'),
  @JsonValue('rocket-league-players')
  rocketLeaguePlayers('rocket-league-players'),
  @JsonValue('individual-user')
  individualUser('individual-user');

  final String? value;

  const ScheduledNotificationDataResponseTargetGroup(this.value);
}

enum ScheduledNotificationDataResponseNotificationType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('game-update')
  gameUpdate('game-update'),
  @JsonValue('new-features')
  newFeatures('new-features'),
  @JsonValue('system-maintenance')
  systemMaintenance('system-maintenance'),
  @JsonValue('exclusive-offers')
  exclusiveOffers('exclusive-offers'),
  @JsonValue('community-news')
  communityNews('community-news'),
  @JsonValue('other')
  other('other'),
  @JsonValue('call')
  call('call'),
  @JsonValue('message')
  message('message'),
  @JsonValue('friend-request')
  friendRequest('friend-request'),
  @JsonValue('friend-added')
  friendAdded('friend-added'),
  @JsonValue('match')
  match('match'),
  @JsonValue('reminder')
  reminder('reminder'),
  @JsonValue('ban')
  ban('ban'),
  @JsonValue('suspend')
  suspend('suspend');

  final String? value;

  const ScheduledNotificationDataResponseNotificationType(this.value);
}

enum NotificationTypeResponseKey {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('game-update')
  gameUpdate('game-update'),
  @JsonValue('new-features')
  newFeatures('new-features'),
  @JsonValue('system-maintenance')
  systemMaintenance('system-maintenance'),
  @JsonValue('exclusive-offers')
  exclusiveOffers('exclusive-offers'),
  @JsonValue('community-news')
  communityNews('community-news'),
  @JsonValue('other')
  other('other'),
  @JsonValue('call')
  call('call'),
  @JsonValue('message')
  message('message'),
  @JsonValue('friend-request')
  friendRequest('friend-request'),
  @JsonValue('friend-added')
  friendAdded('friend-added'),
  @JsonValue('match')
  match('match'),
  @JsonValue('reminder')
  reminder('reminder'),
  @JsonValue('ban')
  ban('ban'),
  @JsonValue('suspend')
  suspend('suspend');

  final String? value;

  const NotificationTypeResponseKey(this.value);
}

enum NotificationIntervalResponseKey {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('doesnt-repeat')
  doesntRepeat('doesnt-repeat'),
  @JsonValue('repeat-daily')
  repeatDaily('repeat-daily'),
  @JsonValue('repeat-weekly')
  repeatWeekly('repeat-weekly'),
  @JsonValue('repeat-bi-weekly')
  repeatBiWeekly('repeat-bi-weekly'),
  @JsonValue('repeat-monthly')
  repeatMonthly('repeat-monthly'),
  @JsonValue('repeat-annually')
  repeatAnnually('repeat-annually');

  final String? value;

  const NotificationIntervalResponseKey(this.value);
}

enum CreateScheduledNotificationInputNotificationType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('game-update')
  gameUpdate('game-update'),
  @JsonValue('new-features')
  newFeatures('new-features'),
  @JsonValue('system-maintenance')
  systemMaintenance('system-maintenance'),
  @JsonValue('exclusive-offers')
  exclusiveOffers('exclusive-offers'),
  @JsonValue('community-news')
  communityNews('community-news'),
  @JsonValue('other')
  other('other'),
  @JsonValue('call')
  call('call'),
  @JsonValue('message')
  message('message'),
  @JsonValue('friend-request')
  friendRequest('friend-request'),
  @JsonValue('friend-added')
  friendAdded('friend-added'),
  @JsonValue('match')
  match('match'),
  @JsonValue('reminder')
  reminder('reminder'),
  @JsonValue('ban')
  ban('ban'),
  @JsonValue('suspend')
  suspend('suspend');

  final String? value;

  const CreateScheduledNotificationInputNotificationType(this.value);
}

enum CreateScheduledNotificationInputInterval {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('doesnt-repeat')
  doesntRepeat('doesnt-repeat'),
  @JsonValue('repeat-daily')
  repeatDaily('repeat-daily'),
  @JsonValue('repeat-weekly')
  repeatWeekly('repeat-weekly'),
  @JsonValue('repeat-bi-weekly')
  repeatBiWeekly('repeat-bi-weekly'),
  @JsonValue('repeat-monthly')
  repeatMonthly('repeat-monthly'),
  @JsonValue('repeat-annually')
  repeatAnnually('repeat-annually');

  final String? value;

  const CreateScheduledNotificationInputInterval(this.value);
}

enum CreateScheduledNotificationInputTargetGroup {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('all-users')
  allUsers('all-users'),
  @JsonValue('fortnite-players')
  fortnitePlayers('fortnite-players'),
  @JsonValue('apex-legends-players')
  apexLegendsPlayers('apex-legends-players'),
  @JsonValue('call-of-duty-players')
  callOfDutyPlayers('call-of-duty-players'),
  @JsonValue('rocket-league-players')
  rocketLeaguePlayers('rocket-league-players'),
  @JsonValue('individual-user')
  individualUser('individual-user');

  final String? value;

  const CreateScheduledNotificationInputTargetGroup(this.value);
}

enum UpdateScheduledNotificationInputNotificationType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('game-update')
  gameUpdate('game-update'),
  @JsonValue('new-features')
  newFeatures('new-features'),
  @JsonValue('system-maintenance')
  systemMaintenance('system-maintenance'),
  @JsonValue('exclusive-offers')
  exclusiveOffers('exclusive-offers'),
  @JsonValue('community-news')
  communityNews('community-news'),
  @JsonValue('other')
  other('other'),
  @JsonValue('call')
  call('call'),
  @JsonValue('message')
  message('message'),
  @JsonValue('friend-request')
  friendRequest('friend-request'),
  @JsonValue('friend-added')
  friendAdded('friend-added'),
  @JsonValue('match')
  match('match'),
  @JsonValue('reminder')
  reminder('reminder'),
  @JsonValue('ban')
  ban('ban'),
  @JsonValue('suspend')
  suspend('suspend');

  final String? value;

  const UpdateScheduledNotificationInputNotificationType(this.value);
}

enum UpdateScheduledNotificationInputInterval {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('doesnt-repeat')
  doesntRepeat('doesnt-repeat'),
  @JsonValue('repeat-daily')
  repeatDaily('repeat-daily'),
  @JsonValue('repeat-weekly')
  repeatWeekly('repeat-weekly'),
  @JsonValue('repeat-bi-weekly')
  repeatBiWeekly('repeat-bi-weekly'),
  @JsonValue('repeat-monthly')
  repeatMonthly('repeat-monthly'),
  @JsonValue('repeat-annually')
  repeatAnnually('repeat-annually');

  final String? value;

  const UpdateScheduledNotificationInputInterval(this.value);
}

enum UpdateScheduledNotificationInputTargetGroup {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('all-users')
  allUsers('all-users'),
  @JsonValue('fortnite-players')
  fortnitePlayers('fortnite-players'),
  @JsonValue('apex-legends-players')
  apexLegendsPlayers('apex-legends-players'),
  @JsonValue('call-of-duty-players')
  callOfDutyPlayers('call-of-duty-players'),
  @JsonValue('rocket-league-players')
  rocketLeaguePlayers('rocket-league-players'),
  @JsonValue('individual-user')
  individualUser('individual-user');

  final String? value;

  const UpdateScheduledNotificationInputTargetGroup(this.value);
}

enum TGMDExceptionResponseOrigin {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('HTTP')
  http('HTTP'),
  @JsonValue('Mongo')
  mongo('Mongo'),
  @JsonValue('TGMD')
  tgmd('TGMD'),
  @JsonValue('Unknown')
  unknown('Unknown');

  final String? value;

  const TGMDExceptionResponseOrigin(this.value);
}

enum UserStatusResponseType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('active')
  active('active'),
  @JsonValue('inactive')
  inactive('inactive'),
  @JsonValue('banned')
  banned('banned'),
  @JsonValue('reported')
  reported('reported'),
  @JsonValue('suspended')
  suspended('suspended'),
  @JsonValue('pending')
  pending('pending');

  final String? value;

  const UserStatusResponseType(this.value);
}

enum UserResponseGender {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('male')
  male('male'),
  @JsonValue('female')
  female('female'),
  @JsonValue('non-binary')
  nonBinary('non-binary'),
  @JsonValue('prefer-not-to-respond')
  preferNotToRespond('prefer-not-to-respond');

  final String? value;

  const UserResponseGender(this.value);
}

enum UserResponseRole {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('user')
  user('user'),
  @JsonValue('admin')
  admin('admin'),
  @JsonValue('superadmin')
  superadmin('superadmin');

  final String? value;

  const UserResponseRole(this.value);
}

enum UserResponseSignupType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('social')
  social('social'),
  @JsonValue('manual')
  manual('manual');

  final String? value;

  const UserResponseSignupType(this.value);
}

enum UserGroupResponseKey {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('all-users')
  allUsers('all-users'),
  @JsonValue('fortnite-players')
  fortnitePlayers('fortnite-players'),
  @JsonValue('apex-legends-players')
  apexLegendsPlayers('apex-legends-players'),
  @JsonValue('call-of-duty-players')
  callOfDutyPlayers('call-of-duty-players'),
  @JsonValue('rocket-league-players')
  rocketLeaguePlayers('rocket-league-players'),
  @JsonValue('individual-user')
  individualUser('individual-user');

  final String? value;

  const UserGroupResponseKey(this.value);
}

enum UserGameDataResponseGame {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('call-of-duty')
  callOfDuty('call-of-duty'),
  @JsonValue('fortnite')
  fortnite('fortnite'),
  @JsonValue('apex-legends')
  apexLegends('apex-legends'),
  @JsonValue('rocket-league')
  rocketLeague('rocket-league');

  final String? value;

  const UserGameDataResponseGame(this.value);
}

enum UserReportResponseReportReason {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('harrasment-and-bullying')
  harrasmentAndBullying('harrasment-and-bullying'),
  @JsonValue('inappropriate-content')
  inappropriateContent('inappropriate-content'),
  @JsonValue('spam-and-scams')
  spamAndScams('spam-and-scams'),
  @JsonValue('violence-or-threats')
  violenceOrThreats('violence-or-threats'),
  @JsonValue('hate-speech-or-discrimination')
  hateSpeechOrDiscrimination('hate-speech-or-discrimination'),
  @JsonValue('privacy-violations')
  privacyViolations('privacy-violations'),
  @JsonValue('violation-of-platform-policies')
  violationOfPlatformPolicies('violation-of-platform-policies'),
  @JsonValue('safety-concerns')
  safetyConcerns('safety-concerns');

  final String? value;

  const UserReportResponseReportReason(this.value);
}

enum UserWarningTypeResponseKey {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('inappropriate-behavior')
  inappropriateBehavior('inappropriate-behavior'),
  @JsonValue('cheating-or-exploiting')
  cheatingOrExploiting('cheating-or-exploiting'),
  @JsonValue('impersonation-or-false-identity')
  impersonationOrFalseIdentity('impersonation-or-false-identity'),
  @JsonValue('violating-community-guidelines')
  violatingCommunityGuidelines('violating-community-guidelines'),
  @JsonValue('repeated-disruptions')
  repeatedDisruptions('repeated-disruptions'),
  @JsonValue('inactivity-or-abandonment')
  inactivityOrAbandonment('inactivity-or-abandonment');

  final String? value;

  const UserWarningTypeResponseKey(this.value);
}

enum UserReportTypeResponseKey {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('harrasment-and-bullying')
  harrasmentAndBullying('harrasment-and-bullying'),
  @JsonValue('inappropriate-content')
  inappropriateContent('inappropriate-content'),
  @JsonValue('spam-and-scams')
  spamAndScams('spam-and-scams'),
  @JsonValue('violence-or-threats')
  violenceOrThreats('violence-or-threats'),
  @JsonValue('hate-speech-or-discrimination')
  hateSpeechOrDiscrimination('hate-speech-or-discrimination'),
  @JsonValue('privacy-violations')
  privacyViolations('privacy-violations'),
  @JsonValue('violation-of-platform-policies')
  violationOfPlatformPolicies('violation-of-platform-policies'),
  @JsonValue('safety-concerns')
  safetyConcerns('safety-concerns');

  final String? value;

  const UserReportTypeResponseKey(this.value);
}

enum UserWarningInputWarning {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('inappropriate-behavior')
  inappropriateBehavior('inappropriate-behavior'),
  @JsonValue('cheating-or-exploiting')
  cheatingOrExploiting('cheating-or-exploiting'),
  @JsonValue('impersonation-or-false-identity')
  impersonationOrFalseIdentity('impersonation-or-false-identity'),
  @JsonValue('violating-community-guidelines')
  violatingCommunityGuidelines('violating-community-guidelines'),
  @JsonValue('repeated-disruptions')
  repeatedDisruptions('repeated-disruptions'),
  @JsonValue('inactivity-or-abandonment')
  inactivityOrAbandonment('inactivity-or-abandonment');

  final String? value;

  const UserWarningInputWarning(this.value);
}

enum UserGameResponseGame {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('call-of-duty')
  callOfDuty('call-of-duty'),
  @JsonValue('fortnite')
  fortnite('fortnite'),
  @JsonValue('apex-legends')
  apexLegends('apex-legends'),
  @JsonValue('rocket-league')
  rocketLeague('rocket-league');

  final String? value;

  const UserGameResponseGame(this.value);
}

enum NotificationDataResponseNotificationType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('game-update')
  gameUpdate('game-update'),
  @JsonValue('new-features')
  newFeatures('new-features'),
  @JsonValue('system-maintenance')
  systemMaintenance('system-maintenance'),
  @JsonValue('exclusive-offers')
  exclusiveOffers('exclusive-offers'),
  @JsonValue('community-news')
  communityNews('community-news'),
  @JsonValue('other')
  other('other'),
  @JsonValue('call')
  call('call'),
  @JsonValue('message')
  message('message'),
  @JsonValue('friend-request')
  friendRequest('friend-request'),
  @JsonValue('friend-added')
  friendAdded('friend-added'),
  @JsonValue('match')
  match('match'),
  @JsonValue('reminder')
  reminder('reminder'),
  @JsonValue('ban')
  ban('ban'),
  @JsonValue('suspend')
  suspend('suspend');

  final String? value;

  const NotificationDataResponseNotificationType(this.value);
}

enum GameResponseGame {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('call-of-duty')
  callOfDuty('call-of-duty'),
  @JsonValue('fortnite')
  fortnite('fortnite'),
  @JsonValue('apex-legends')
  apexLegends('apex-legends'),
  @JsonValue('rocket-league')
  rocketLeague('rocket-league');

  final String? value;

  const GameResponseGame(this.value);
}

enum SliderOptionResponseAttribute {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('arena')
  arena('arena'),
  @JsonValue('duo')
  duo('duo'),
  @JsonValue('intermediate')
  intermediate('intermediate'),
  @JsonValue('aggressive')
  aggressive('aggressive'),
  @JsonValue('team-player')
  teamPlayer('team-player'),
  @JsonValue('find-people')
  findPeople('find-people'),
  @JsonValue('center-circle')
  centerCircle('center-circle'),
  @JsonValue('casual')
  casual('casual'),
  @JsonValue('hoops')
  hoops('hoops'),
  @JsonValue('2v2')
  value_2v2('2v2'),
  @JsonValue('beginner')
  beginner('beginner'),
  @JsonValue('playing-level')
  playingLevel('playing-level'),
  @JsonValue('how-you-play')
  howYouPlay('how-you-play'),
  @JsonValue('mixtape')
  mixtape('mixtape'),
  @JsonValue('control')
  control('control'),
  @JsonValue('battle-royale')
  battleRoyale('battle-royale'),
  @JsonValue('battle-royale-build')
  battleRoyaleBuild('battle-royale-build'),
  @JsonValue('battle-royale-no-build')
  battleRoyaleNoBuild('battle-royale-no-build'),
  @JsonValue('advanced')
  advanced('advanced'),
  @JsonValue('creative-mode')
  creativeMode('creative-mode'),
  @JsonValue('trio')
  trio('trio'),
  @JsonValue('squad')
  squad('squad'),
  @JsonValue('first-time')
  firstTime('first-time'),
  @JsonValue('competitive')
  competitive('competitive'),
  @JsonValue('pro')
  pro('pro'),
  @JsonValue('legend')
  legend('legend'),
  @JsonValue('chase-kill')
  chaseKill('chase-kill'),
  @JsonValue('zone-walk')
  zoneWalk('zone-walk'),
  @JsonValue('resurgence')
  resurgence('resurgence'),
  @JsonValue('plunder')
  plunder('plunder'),
  @JsonValue('gun-game')
  gunGame('gun-game'),
  @JsonValue('ranked')
  ranked('ranked'),
  @JsonValue('tournaments')
  tournaments('tournaments'),
  @JsonValue('snow-day')
  snowDay('snow-day'),
  @JsonValue('dropshot')
  dropshot('dropshot'),
  @JsonValue('rumble')
  rumble('rumble'),
  @JsonValue('3v3')
  value_3v3('3v3'),
  @JsonValue('4v4')
  value_4v4('4v4'),
  @JsonValue('training')
  training('training'),
  @JsonValue('firing-range')
  firingRange('firing-range'),
  @JsonValue('ranked-league')
  rankedLeague('ranked-league'),
  @JsonValue('assault')
  assault('assault'),
  @JsonValue('skirmisher')
  skirmisher('skirmisher'),
  @JsonValue('recon')
  recon('recon'),
  @JsonValue('controller')
  controller('controller'),
  @JsonValue('support')
  support('support'),
  @JsonValue('team-deathmatch')
  teamDeathmatch('team-deathmatch'),
  @JsonValue('run-gun')
  runGun('run-gun'),
  @JsonValue('scorer')
  scorer('scorer'),
  @JsonValue('offensive')
  offensive('offensive'),
  @JsonValue('extras')
  extras('extras'),
  @JsonValue('firing-squad')
  firingSquad('firing-squad'),
  @JsonValue('demo-heavy')
  demoHeavy('demo-heavy'),
  @JsonValue('passer')
  passer('passer'),
  @JsonValue('anchor')
  anchor('anchor'),
  @JsonValue('1v1')
  value_1v1('1v1'),
  @JsonValue('offensive-scorer')
  offensiveScorer('offensive-scorer'),
  @JsonValue('offensive-passer')
  offensivePasser('offensive-passer'),
  @JsonValue('mid-scorer')
  midScorer('mid-scorer'),
  @JsonValue('mid-defender')
  midDefender('mid-defender'),
  @JsonValue('defensive-scorer')
  defensiveScorer('defensive-scorer'),
  @JsonValue('defensive-passer')
  defensivePasser('defensive-passer'),
  @JsonValue('warzone')
  warzone('warzone'),
  @JsonValue('quick-games')
  quickGames('quick-games'),
  @JsonValue('starting-timestamp')
  startingTimestamp('starting-timestamp'),
  @JsonValue('ending-timestamp')
  endingTimestamp('ending-timestamp');

  final String? value;

  const SliderOptionResponseAttribute(this.value);
}

enum GamePreferenceInputResponseType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('select')
  select('select'),
  @JsonValue('multi-select')
  multiSelect('multi-select'),
  @JsonValue('slider')
  slider('slider'),
  @JsonValue('dropdown')
  dropdown('dropdown');

  final String? value;

  const GamePreferenceInputResponseType(this.value);
}

enum SelectOptionResponseAttribute {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('arena')
  arena('arena'),
  @JsonValue('duo')
  duo('duo'),
  @JsonValue('intermediate')
  intermediate('intermediate'),
  @JsonValue('aggressive')
  aggressive('aggressive'),
  @JsonValue('team-player')
  teamPlayer('team-player'),
  @JsonValue('find-people')
  findPeople('find-people'),
  @JsonValue('center-circle')
  centerCircle('center-circle'),
  @JsonValue('casual')
  casual('casual'),
  @JsonValue('hoops')
  hoops('hoops'),
  @JsonValue('2v2')
  value_2v2('2v2'),
  @JsonValue('beginner')
  beginner('beginner'),
  @JsonValue('playing-level')
  playingLevel('playing-level'),
  @JsonValue('how-you-play')
  howYouPlay('how-you-play'),
  @JsonValue('mixtape')
  mixtape('mixtape'),
  @JsonValue('control')
  control('control'),
  @JsonValue('battle-royale')
  battleRoyale('battle-royale'),
  @JsonValue('battle-royale-build')
  battleRoyaleBuild('battle-royale-build'),
  @JsonValue('battle-royale-no-build')
  battleRoyaleNoBuild('battle-royale-no-build'),
  @JsonValue('advanced')
  advanced('advanced'),
  @JsonValue('creative-mode')
  creativeMode('creative-mode'),
  @JsonValue('trio')
  trio('trio'),
  @JsonValue('squad')
  squad('squad'),
  @JsonValue('first-time')
  firstTime('first-time'),
  @JsonValue('competitive')
  competitive('competitive'),
  @JsonValue('pro')
  pro('pro'),
  @JsonValue('legend')
  legend('legend'),
  @JsonValue('chase-kill')
  chaseKill('chase-kill'),
  @JsonValue('zone-walk')
  zoneWalk('zone-walk'),
  @JsonValue('resurgence')
  resurgence('resurgence'),
  @JsonValue('plunder')
  plunder('plunder'),
  @JsonValue('gun-game')
  gunGame('gun-game'),
  @JsonValue('ranked')
  ranked('ranked'),
  @JsonValue('tournaments')
  tournaments('tournaments'),
  @JsonValue('snow-day')
  snowDay('snow-day'),
  @JsonValue('dropshot')
  dropshot('dropshot'),
  @JsonValue('rumble')
  rumble('rumble'),
  @JsonValue('3v3')
  value_3v3('3v3'),
  @JsonValue('4v4')
  value_4v4('4v4'),
  @JsonValue('training')
  training('training'),
  @JsonValue('firing-range')
  firingRange('firing-range'),
  @JsonValue('ranked-league')
  rankedLeague('ranked-league'),
  @JsonValue('assault')
  assault('assault'),
  @JsonValue('skirmisher')
  skirmisher('skirmisher'),
  @JsonValue('recon')
  recon('recon'),
  @JsonValue('controller')
  controller('controller'),
  @JsonValue('support')
  support('support'),
  @JsonValue('team-deathmatch')
  teamDeathmatch('team-deathmatch'),
  @JsonValue('run-gun')
  runGun('run-gun'),
  @JsonValue('scorer')
  scorer('scorer'),
  @JsonValue('offensive')
  offensive('offensive'),
  @JsonValue('extras')
  extras('extras'),
  @JsonValue('firing-squad')
  firingSquad('firing-squad'),
  @JsonValue('demo-heavy')
  demoHeavy('demo-heavy'),
  @JsonValue('passer')
  passer('passer'),
  @JsonValue('anchor')
  anchor('anchor'),
  @JsonValue('1v1')
  value_1v1('1v1'),
  @JsonValue('offensive-scorer')
  offensiveScorer('offensive-scorer'),
  @JsonValue('offensive-passer')
  offensivePasser('offensive-passer'),
  @JsonValue('mid-scorer')
  midScorer('mid-scorer'),
  @JsonValue('mid-defender')
  midDefender('mid-defender'),
  @JsonValue('defensive-scorer')
  defensiveScorer('defensive-scorer'),
  @JsonValue('defensive-passer')
  defensivePasser('defensive-passer'),
  @JsonValue('warzone')
  warzone('warzone'),
  @JsonValue('quick-games')
  quickGames('quick-games'),
  @JsonValue('starting-timestamp')
  startingTimestamp('starting-timestamp'),
  @JsonValue('ending-timestamp')
  endingTimestamp('ending-timestamp');

  final String? value;

  const SelectOptionResponseAttribute(this.value);
}

enum ApiV1UsersGetStatus {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('active')
  active('active'),
  @JsonValue('inactive')
  inactive('inactive'),
  @JsonValue('banned')
  banned('banned'),
  @JsonValue('reported')
  reported('reported'),
  @JsonValue('suspended')
  suspended('suspended'),
  @JsonValue('pending')
  pending('pending');

  final String? value;

  const ApiV1UsersGetStatus(this.value);
}

enum ApiV1StatisticsUsersNewUsersRegisteredGetGroupBy {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('day')
  day('day'),
  @JsonValue('week')
  week('week'),
  @JsonValue('month')
  month('month'),
  @JsonValue('year')
  year('year');

  final String? value;

  const ApiV1StatisticsUsersNewUsersRegisteredGetGroupBy(this.value);
}
