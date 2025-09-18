import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:tm8/app/app_bloc/app_bloc.dart';
import 'package:tm8/app/home_page_screen.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/entrypoint.dart';
import 'package:tm8/epic_games/presentation/view/epic_gamas_webview_screen.dart';
import 'package:tm8/epic_games/presentation/view/epic_games_screen.dart';
import 'package:tm8/friends/presentation/view/add_friends_screen.dart';
import 'package:tm8/friends/presentation/view/friends_details_screen.dart';
import 'package:tm8/friends/presentation/view/friends_screen.dart';
import 'package:tm8/friends/presentation/view/qr_code_scanning_screen.dart';
import 'package:tm8/friends/presentation/view/qr_code_screen.dart';
import 'package:tm8/games/presentation/view/add_games_preferences_screen.dart';
import 'package:tm8/games/presentation/view/add_games_screen.dart';
import 'package:tm8/games/presentation/view/edit_game_preferences_screen.dart';
import 'package:tm8/games/presentation/view/match_screen.dart';
import 'package:tm8/games/presentation/view/matchmaking_screen.dart';
import 'package:tm8/games/presentation/view/random_matchmaking_screen.dart';
import 'package:tm8/messages/presentation/view/messages_profile_details_screen.dart';
import 'package:tm8/messages/presentation/view/call_screen.dart';
import 'package:tm8/messages/presentation/view/messages_screen.dart';
import 'package:tm8/messages/presentation/view/messaging_screen.dart';
import 'package:tm8/messages/presentation/view/search_user_messages_screen.dart';
import 'package:tm8/notifications/presentation/view/notification_details_screen.dart';
import 'package:tm8/notifications/presentation/view/notifications_screen.dart';
import 'package:tm8/profile/presentation/view/audio_intro_settings_screen.dart';
import 'package:tm8/profile/presentation/view/blocked_users_settings_screen.dart';
import 'package:tm8/profile/presentation/view/change_email_settings_screen.dart';
import 'package:tm8/profile/presentation/view/change_email_verify_settings_screen.dart';
import 'package:tm8/profile/presentation/view/change_password_screen.dart';
import 'package:tm8/profile/presentation/view/country_settings_screen.dart';
import 'package:tm8/profile/presentation/view/delete_account_settings_screen.dart';
import 'package:tm8/profile/presentation/view/description_settings_screen.dart';
import 'package:tm8/profile/presentation/view/display_name_settings_screen.dart';
import 'package:tm8/profile/presentation/view/email_address_settings_screen.dart';
import 'package:tm8/profile/presentation/view/epic_games_settings_screen.dart';
import 'package:tm8/profile/presentation/view/gender_settings_screen.dart';
import 'package:tm8/profile/presentation/view/languages_settings_screen.dart';
import 'package:tm8/profile/presentation/view/notification_settings_screen.dart';
import 'package:tm8/profile/presentation/view/profile_screen.dart';
import 'package:tm8/forgot_password/presentation/view/forgot_password_new_password_screen.dart';
import 'package:tm8/forgot_password/presentation/view/forgot_password_screen.dart';
import 'package:tm8/forgot_password/presentation/view/forgot_password_verification_screen.dart';
import 'package:tm8/games/presentation/view/games_screen.dart';
import 'package:tm8/login/presentation/view/login_screen.dart';
import 'package:tm8/login/presentation/view/manual_login_screen.dart';
import 'package:tm8/onboarding_preferences/presentation/view/onboarding_preferences_screen.dart';
import 'package:tm8/onboarding_preferences/presentation/view/set_onboarding_preferences_screen.dart';
import 'package:tm8/profile/presentation/view/profile_settings_screen.dart';
import 'package:tm8/profile/presentation/view/region_settings_screen.dart';
import 'package:tm8/profile/presentation/view/settings_screen.dart';
import 'package:tm8/sign_up/presentation/view/sign_up_add_dob_screen.dart';
import 'package:tm8/sign_up/presentation/view/sign_up_manual_add_phone_screen.dart';
import 'package:tm8/sign_up/presentation/view/sign_up_screen.dart';
import 'package:tm8/sign_up/presentation/view/sign_up_with_email_screen.dart';
import 'package:tm8/sign_up/presentation/view/sign_up_manual_verify_phone_screen.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';
import 'package:webview_flutter/webview_flutter.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
@singleton
class AppRouter extends _$AppRouter {
  @override
  final List<AdaptiveRoute> routes = [
    AdaptiveRoute(
      path: '/',
      page: EntryPointRoute.page,
      children: [
        AutoRoute(
          page: LoginRoute.page,
        ),
        AutoRoute(
          page: ManualLoginRoute.page,
        ),
        AutoRoute(
          page: SignUpRoute.page,
        ),
        AutoRoute(
          page: SignUpWithEmailRoute.page,
        ),
        AutoRoute(
          page: SignUpManualAddPhoneRoute.page,
        ),
        AutoRoute(
          page: SignUpManualVerifyPhoneRoute.page,
        ),
        AutoRoute(
          page: ForgotPasswordRoute.page,
        ),
        AutoRoute(
          page: ForgotPasswordVerificationRoute.page,
        ),
        AutoRoute(
          page: ForgotPasswordNewPasswordRoute.page,
        ),
        AutoRoute(
          page: HomePageRoute.page,
          children: [
            AutoRoute(
              page: GamesRoute.page,
            ),
            AutoRoute(
              page: FriendsRoute.page,
            ),
            AutoRoute(
              page: MessagesRoute.page,
            ),
            AutoRoute(
              page: NotificationsRoute.page,
            ),
            AutoRoute(
              page: ProfileRoute.page,
            ),
          ],
          guards: [AuthGuard()],
        ),
        AutoRoute(
          page: EpicGamesRoute.page,
        ),
        AutoRoute(
          page: EpicGamesWebViewRoute.page,
        ),
        AdaptiveRoute(
          page: OnboardingPreferencesRoute.page,
        ),
        AdaptiveRoute(
          page: SetOnboardingPreferencesRoute.page,
        ),
        AdaptiveRoute(
          page: AddGameRoute.page,
        ),
        AdaptiveRoute(
          page: AddGamesPreferencesRoute.page,
        ),
        AdaptiveRoute(
          page: EditGamesPreferencesRoute.page,
        ),
        AdaptiveRoute(
          page: SearchUsersMessagesRoute.page,
        ),
        AdaptiveRoute(
          page: MessagingRoute.page,
        ),
        AdaptiveRoute(
          page: MessagesProfileDetailsRoute.page,
        ),
        AdaptiveRoute(
          page: CallRoute.page,
        ),
        AdaptiveRoute(
          page: AddFriendsRoute.page,
        ),
        AdaptiveRoute(
          page: FriendsDetailsRoute.page,
        ),
        AdaptiveRoute(
          page: QRCodeRoute.page,
        ),
        AdaptiveRoute(
          page: QRCodeScanningRoute.page,
        ),
        AdaptiveRoute(
          page: SettingsRoute.page,
        ),
        AdaptiveRoute(
          page: ProfileSettingsRoute.page,
        ),
        AdaptiveRoute(
          page: DisplayNameSettingsRoute.page,
        ),
        AdaptiveRoute(
          page: DescriptionSettingsRoute.page,
        ),
        AdaptiveRoute(
          page: AudioIntroSettingsRoute.page,
        ),
        AdaptiveRoute(
          page: CountrySettingsRoute.page,
        ),
        AdaptiveRoute(
          page: GenderSettingsRoute.page,
        ),
        AdaptiveRoute(
          page: ChangePasswordRoute.page,
        ),
        AdaptiveRoute(
          page: EmailAddressSettingsRoute.page,
        ),
        AdaptiveRoute(
          page: ChangeEmailSettingsRoute.page,
        ),
        AdaptiveRoute(
          page: ChangeEmailVerifySettingsRoute.page,
        ),
        AdaptiveRoute(
          page: EpicGamesSettingsRoute.page,
        ),
        AdaptiveRoute(
          page: LanguagesSettingsRoute.page,
        ),
        AdaptiveRoute(
          page: RegionSettingsRoute.page,
        ),
        AdaptiveRoute(
          page: BlockedUsersSettingsRoute.page,
        ),
        AdaptiveRoute(
          page: DeleteAccountSettingsRoute.page,
        ),
        AdaptiveRoute(
          page: NotificationDetailsRoute.page,
        ),
        AutoRoute(
          page: SignUpAddDOBRoute.page,
        ),
        AdaptiveRoute(
          page: MatchMakingRoute.page,
        ),
        AdaptiveRoute(
          page: NotificationDetailsRoute.page,
        ),
        AdaptiveRoute(
          page: NotificationSettingsRoute.page,
        ),
        AdaptiveRoute(
          page: RandomMatchMakingRoute.page,
        ),
        AdaptiveRoute(
          page: MatchRoute.page,
        ),
      ],
    ),
  ];
}

@AutoRouterConfig()
class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (router.current.name == 'Root') {
      resolver.next(true);
      return;
    }
    final authenticated = sl<AppBloc>().state;
    if (authenticated == const AppState.authenticated()) {
      resolver.next(true);
    } else {
      resolver.redirect(
        const LoginRoute(),
      );
    }
  }
}
