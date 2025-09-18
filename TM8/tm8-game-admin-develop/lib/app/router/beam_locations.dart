import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tm8_game_admin/app/constants/routing_names.dart';
import 'package:tm8_game_admin/app/home_page_screen.dart';
import 'package:tm8_game_admin/app/services/service_locator.dart';
import 'package:tm8_game_admin/app/storage/tm8_game_admin_storage.dart';
import 'package:tm8_game_admin/entrypoint.dart';
import 'package:tm8_game_admin/forgot_password/presentation/logic/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:tm8_game_admin/forgot_password/presentation/logic/forgot_password_reset_cubit/forgot_password_reset_cubit.dart';
import 'package:tm8_game_admin/forgot_password/presentation/logic/forgot_password_verification_cubit/forgot_password_verification_cubit.dart';
import 'package:tm8_game_admin/forgot_password/presentation/view/forgot_password_conformation_screen.dart';
import 'package:tm8_game_admin/forgot_password/presentation/view/forgot_password_reset_screen.dart';
import 'package:tm8_game_admin/forgot_password/presentation/view/forgot_password_screen.dart';
import 'package:tm8_game_admin/forgot_password/presentation/view/forgot_password_verification_screen.dart';
import 'package:tm8_game_admin/manage_users/presentation/logic/ban_users_cubit/ban_users_cubit.dart';
import 'package:tm8_game_admin/manage_users/presentation/logic/reset_users_cubit/reset_users_cubit.dart';
import 'package:tm8_game_admin/manage_users/presentation/logic/unfocus_drop_down_cubit/unfocus_drop_down_cubit.dart';
import 'package:tm8_game_admin/notification_add/presentation/logic/add_notification_cubit/add_notification_cubit.dart';
import 'package:tm8_game_admin/notification_add/presentation/logic/fetch_notification_intervals_cubit/fetch_notification_intervals_cubit.dart';
import 'package:tm8_game_admin/notification_add/presentation/logic/fetch_search_users_cubit/fetch_search_users_cubit.dart';
import 'package:tm8_game_admin/notification_add/presentation/logic/reset_search_cubit/reset_search_cubit.dart';
import 'package:tm8_game_admin/notification_add/presentation/logic/show_search_user_cubit/show_search_user_cubit.dart';
import 'package:tm8_game_admin/notification_add/presentation/view/notification_add_screen.dart';
import 'package:tm8_game_admin/notification_details/presentation/logic/edit_notification_cubit/edit_notification_cubit.dart';
import 'package:tm8_game_admin/notification_details/presentation/logic/fetch_notification_details/fetch_notification_details_cubit.dart';
import 'package:tm8_game_admin/notification_details/presentation/view/notification_details_screen.dart';
import 'package:tm8_game_admin/notifications/presentation/logic/fetch_notifications_types_cubit/fetch_notification_types_cubit.dart';
import 'package:tm8_game_admin/notifications/presentation/logic/fetch_user_groups_cubit/fetch_user_groups_cubit.dart';
import 'package:tm8_game_admin/user_details/presentation/logic/actions_controller_cubit/actions_controller_cubit.dart';
import 'package:tm8_game_admin/user_details/presentation/logic/added_games_cubit/added_games_cubit.dart';
import 'package:tm8_game_admin/user_details/presentation/logic/control_note_button_cubit/control_note_button_cubit.dart';
import 'package:tm8_game_admin/user_details/presentation/logic/fetch_user_reports_cubit/fetch_user_reports_cubit.dart';
import 'package:tm8_game_admin/user_details/presentation/logic/send_user_notes_cubit/send_user_notes_cubit.dart';
import 'package:tm8_game_admin/user_details/presentation/logic/send_user_warning_cubit/send_user_warning_cubit.dart';
import 'package:tm8_game_admin/user_details/presentation/logic/suspend_user_cubit/suspend_user_cubit.dart';
import 'package:tm8_game_admin/user_details/presentation/logic/user_details_cubit/user_details_cubit.dart';
import 'package:tm8_game_admin/user_details/presentation/view/user_details_screen.dart';

class UsersLocation extends BeamLocation<BeamState> {
  @override
  List<Pattern> get pathPatterns => [
        login,
        home,
        usersDetails,
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final beam = Beams();

    final pages = [
      beam.delegateBeamPage(
        child: const EntryPointScreen(),
        title: 'Login',
        type: BeamPageType.fadeTransition,
        key: 'login',
      ),
      beam.delegateBeamPage(
        child: const HomePage(
          initialPage: 0,
        ),
        title: 'Users',
        type: BeamPageType.fadeTransition,
        key: 'user',
      ),
    ];
    final String? userIdParameter = state.pathParameters['userId'];
    if (userIdParameter != null) {
      pages.add(
        beam.delegateBeamPage(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => sl<UserDetailsCubit>()
                  ..fetchUserDetails(userId: userIdParameter),
              ),
              BlocProvider(
                create: (context) => sl<AddedGamesCubit>()
                  ..fetchUserGames(userId: userIdParameter),
              ),
              BlocProvider(
                create: (context) => sl<SendUserWarningCubit>(),
              ),
              BlocProvider(
                create: (context) => sl<SuspendUserCubit>(),
              ),
              BlocProvider(
                create: (context) => sl<BanUsersCubit>(),
              ),
              BlocProvider(
                create: (context) => sl<ResetUserCubit>(),
              ),
              BlocProvider(
                create: (context) => sl<ActionsControllerCubit>(),
              ),
              BlocProvider(
                create: (context) => sl<SendUserNotesCubit>(),
              ),
              BlocProvider(
                create: (context) => sl<ControlNoteButtonCubit>(),
              ),
              BlocProvider(
                create: (context) => sl<FetchUserReportsCubit>()
                  ..fetchUserReports(userId: userIdParameter),
              ),
            ],
            child: UserDetailsScreen(userId: userIdParameter),
          ),
          title: 'User Details',
          type: BeamPageType.fadeTransition,
          key: 'userDetails',
        ),
      );
      return pages;
    }

    return pages;
  }
}

class ForgetPasswordLocation extends BeamLocation<BeamState> {
  @override
  List<Pattern> get pathPatterns => [
        login,
        forgotPasswordEmail,
        forgotPasswordVerificationCode,
        forgotPasswordReset,
        forgotPasswordConformation,
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final beam = Beams();

    final pages = [
      beam.delegateBeamPage(
        child: const EntryPointScreen(),
        title: 'Login',
        type: BeamPageType.fadeTransition,
        key: 'login',
      ),
    ];
    if (state.pathPatternSegments.contains('email')) {
      pages.add(
        beam.delegateBeamPage(
          child: BlocProvider(
            create: (context) => sl<ForgotPasswordCubit>(),
            child: const ForgotPasswordScreen(),
          ),
          title: 'Forgot Password',
          type: BeamPageType.fadeTransition,
          key: 'forgot-password-email',
        ),
      );
    }
    if (state.pathPatternSegments.contains('verification-code')) {
      pages.add(
        beam.delegateBeamPage(
          child: BlocProvider(
            create: (context) => sl<ForgotPasswordVerificationCubit>(),
            child: const ForgotPasswordVerificationScreen(),
          ),
          title: 'Forgot Password',
          type: BeamPageType.fadeTransition,
          key: 'verification-code',
        ),
      );
    }

    if (state.pathPatternSegments.contains('reset')) {
      pages.add(
        beam.delegateBeamPage(
          child: BlocProvider(
            create: (context) => sl<ForgotPasswordResetCubit>(),
            child: ForgotPasswordResetScreen(
              email: sl<Tm8GameAdminStorage>().resetEmail,
            ),
          ),
          title: 'Forgot Password',
          type: BeamPageType.fadeTransition,
          key: 'password-reset',
        ),
      );
    }
    if (state.pathPatternSegments.contains('conformation')) {
      pages.add(
        beam.delegateBeamPage(
          child: const ForgotPasswordConformationScreen(),
          title: 'Forgot Password',
          type: BeamPageType.fadeTransition,
          key: 'password-conformation',
        ),
      );
    }

    return pages;
  }
}

class NotificationLocation extends BeamLocation<BeamState> {
  @override
  List<Pattern> get pathPatterns => [
        login,
        notifications,
        notificationAdd,
        notificationDetails,
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final beam = Beams();

    final pages = [
      beam.delegateBeamPage(
        child: const EntryPointScreen(),
        title: 'Login',
        type: BeamPageType.fadeTransition,
        key: 'login',
      ),
      beam.delegateBeamPage(
        child: const HomePage(
          initialPage: 1,
        ),
        title: 'Notifications',
        type: BeamPageType.fadeTransition,
        key: 'notifications',
      ),
    ];

    if (state.pathPatternSegments.contains('add')) {
      pages.add(
        beam.delegateBeamPage(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    sl<FetchNotificationTypesCubit>()..fetchNotificationTypes(),
              ),
              BlocProvider(
                create: (context) => sl<UnfocusDropDownCubit>(),
              ),
              BlocProvider(
                create: (context) =>
                    sl<FetchUserGroupsCubit>()..fetchUserGroups(),
              ),
              BlocProvider(
                create: (context) => sl<FetchNotificationIntervalsCubit>()
                  ..fetchNotificationIntervals(),
              ),
              BlocProvider(
                create: (context) => sl<AddNotificationCubit>(),
              ),
              BlocProvider(
                create: (context) => sl<ShowSearchUserCubit>(),
              ),
              BlocProvider(
                create: (context) => sl<FetchSearchUsersCubit>(),
              ),
              BlocProvider(
                create: (context) => sl<UserDetailsCubit>(),
              ),
              BlocProvider(
                create: (context) => sl<ResetSearchCubit>(),
              ),
            ],
            child: const NotificationAddScreen(),
          ),
          title: 'Add Notification',
          type: BeamPageType.fadeTransition,
          key: 'notification-add',
        ),
      );
    }

    final String? notificationIdParameter =
        state.pathParameters['notificationId'];
    if (notificationIdParameter != null) {
      pages.add(
        beam.delegateBeamPage(
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => sl<FetchNotificationDetailsCubit>()
                  ..fetchNotificationsData(
                    notificationId: notificationIdParameter,
                  ),
              ),
              BlocProvider(
                create: (context) =>
                    sl<FetchNotificationTypesCubit>()..fetchNotificationTypes(),
              ),
              BlocProvider(
                create: (context) => sl<UnfocusDropDownCubit>(),
              ),
              BlocProvider(
                create: (context) =>
                    sl<FetchUserGroupsCubit>()..fetchUserGroups(),
              ),
              BlocProvider(
                create: (context) => sl<FetchNotificationIntervalsCubit>()
                  ..fetchNotificationIntervals(),
              ),
              BlocProvider(
                create: (context) => sl<ShowSearchUserCubit>(),
              ),
              BlocProvider(
                create: (context) => sl<FetchSearchUsersCubit>(),
              ),
              BlocProvider(
                create: (context) => sl<UserDetailsCubit>(),
              ),
              BlocProvider(
                create: (context) => sl<EditNotificationCubit>(),
              ),
              BlocProvider(
                create: (context) => sl<ResetSearchCubit>(),
              ),
            ],
            child: NotificationDetailsScreen(
              notificationId: notificationIdParameter,
            ),
          ),
          title: 'Notification Details',
          type: BeamPageType.fadeTransition,
          key: 'notificationDetails',
        ),
      );
      return pages;
    }

    return pages;
  }
}

class AdminLocation extends BeamLocation<BeamState> {
  @override
  List<Pattern> get pathPatterns => [
        login,
        manageAdmins,
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    final beam = Beams();

    final pages = [
      beam.delegateBeamPage(
        child: const EntryPointScreen(),
        title: 'Login',
        type: BeamPageType.fadeTransition,
        key: 'login',
      ),
      beam.delegateBeamPage(
        child: const HomePage(
          initialPage: 2,
        ),
        title: 'Manage Admins',
        type: BeamPageType.fadeTransition,
        key: 'manage-admins',
      ),
    ];

    return pages;
  }
}

class Beams {
  BeamPage delegateBeamPage({
    required String title,
    String? popToNamed,
    required BeamPageType type,
    required Widget child,
    required String key,
  }) {
    return BeamPage(
      title: title,
      popToNamed: popToNamed,
      type: type,
      child: child,
      key: ValueKey(key),
    );
  }
}
