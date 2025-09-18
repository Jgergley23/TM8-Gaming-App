import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';

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

enum UserResponseTimezone {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('IDLW')
  idlw('IDLW'),
  @JsonValue('NUT')
  nut('NUT'),
  @JsonValue('SST')
  sst('SST'),
  @JsonValue('CKT')
  ckt('CKT'),
  @JsonValue('HAST')
  hast('HAST'),
  @JsonValue('TAHT')
  taht('TAHT'),
  @JsonValue('AKST')
  akst('AKST'),
  @JsonValue('PST')
  pst('PST'),
  @JsonValue('MST')
  mst('MST'),
  @JsonValue('CST')
  cst('CST'),
  @JsonValue('EST')
  est('EST'),
  @JsonValue('AST')
  ast('AST'),
  @JsonValue('NDT')
  ndt('NDT'),
  @JsonValue('BRST')
  brst('BRST'),
  @JsonValue('BRT')
  brt('BRT'),
  @JsonValue('ART')
  art('ART'),
  @JsonValue('NST')
  nst('NST'),
  @JsonValue('UTC')
  utc('UTC'),
  @JsonValue('WET')
  wet('WET'),
  @JsonValue('CET')
  cet('CET'),
  @JsonValue('EET')
  eet('EET'),
  @JsonValue('MSK')
  msk('MSK'),
  @JsonValue('IST')
  ist('IST'),
  @JsonValue('NPT')
  npt('NPT'),
  @JsonValue('BST')
  bst('BST'),
  @JsonValue('MMT')
  mmt('MMT'),
  @JsonValue('ICT')
  ict('ICT'),
  @JsonValue('WIB')
  wib('WIB'),
  @JsonValue('MYT')
  myt('MYT'),
  @JsonValue('SGT')
  sgt('SGT'),
  @JsonValue('AWST')
  awst('AWST'),
  @JsonValue('JST')
  jst('JST'),
  @JsonValue('KST')
  kst('KST'),
  @JsonValue('ACST')
  acst('ACST'),
  @JsonValue('AEST')
  aest('AEST'),
  @JsonValue('VUT')
  vut('VUT'),
  @JsonValue('NZST')
  nzst('NZST'),
  @JsonValue('CHADT')
  chadt('CHADT'),
  @JsonValue('PHOT')
  phot('PHOT'),
  @JsonValue('LINT')
  lint('LINT'),
  @JsonValue('CHST')
  chst('CHST'),
  @JsonValue('WAKT')
  wakt('WAKT');

  final String? value;

  const UserResponseTimezone(this.value);
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

enum AuthResponseNextStep {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('avaiting-verify-email')
  avaitingVerifyEmail('avaiting-verify-email'),
  @JsonValue('completed')
  completed('completed'),
  @JsonValue('proceed-to-reset-password')
  proceedToResetPassword('proceed-to-reset-password');

  final String? value;

  const AuthResponseNextStep(this.value);
}

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
  other('other');

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
  other('other');

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
  other('other');

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
  other('other');

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
