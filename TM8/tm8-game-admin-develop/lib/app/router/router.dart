import 'package:beamer/beamer.dart';
import 'package:injectable/injectable.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8_game_admin/app/app_bloc/app_bloc.dart';
import 'package:tm8_game_admin/app/constants/routing_names.dart';
import 'package:tm8_game_admin/app/router/beam_locations.dart';
import 'package:tm8_game_admin/app/services/service_locator.dart';

@LazySingleton()
class AppRouter {
  final routerDelegate = BeamerDelegate(
    locationBuilder: BeamerLocationBuilder(
      beamLocations: [
        ForgetPasswordLocation(),
        UsersLocation(),
        NotificationLocation(),
        AdminLocation(),
      ],
    ).call,
    guards: [
      BeamGuard(
        // on which path patterns (from incoming routes) to perform the check
        pathPatterns: ['/users'],
        // perform the check on all patterns that **don't** have a match in pathPatterns
        guardNonMatching: false,
        // return false to redirect
        check: (context, location) {
          // can only be used with sync functions
          final state = sl<AppBloc>().state;
          logInfo('Check AppBloc state: $state');
          if (state == const AppState.authenticated()) {
            return true;
          } else {
            return false;
          }
        },
        // where to redirect on a false check
        beamToNamed: (origin, target) => '/',
      ),
      BeamGuard(
        pathPatterns: ['/forgot-password/*'],
        guardNonMatching: false,
        check: (context, location) {
          if (location.history.isEmpty) {
            return false;
          } else if (location.history.isNotEmpty) {
            if (location.history.first.routeInformation.uri.toString() ==
                '/forgot-password/email') {
              return true;
            }
            if (location.history.length == 1) {
              return false;
            } else {
              return true;
            }
          }
          return true;
        },
        beamToNamed: (origin, target) => forgotPasswordEmail,
      ),
    ],
    notFoundRedirectNamed: home,
  );
}
