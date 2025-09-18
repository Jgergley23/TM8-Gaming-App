import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:tm8l/app/constants/routing_names.dart';
import 'package:tm8l/landing_page/view/landing_page_screen.dart';
import 'package:tm8l/terms_of_service/view/privacy_policy_screen.dart';
import 'package:tm8l/terms_of_service/view/terms_of_service_screen.dart';

final beam = Beams();

@singleton
class AppRouter {
  final routerDelegate = BeamerDelegate(
    locationBuilder: RoutesLocationBuilder(
      routes: {
        // Return either Widgets or BeamPages if more customization is needed
        home: (context, state, data) {
          {
            return beam.delegateBeamPage(
              child: const LandingPageScreen(
                page: 0,
              ),
              title: 'Home',
              type: BeamPageType.fadeTransition,
              key: 'home',
            );
          }
        },
        about: (context, state, data) {
          {
            return beam.delegateBeamPage(
              child: const LandingPageScreen(
                page: 1,
              ),
              title: 'About',
              type: BeamPageType.fadeTransition,
              key: 'about',
            );
          }
        },
        contact: (context, state, data) {
          {
            return beam.delegateBeamPage(
              child: const LandingPageScreen(
                page: 2,
              ),
              title: 'Contact',
              type: BeamPageType.fadeTransition,
              key: 'contact',
            );
          }
        },
        termsOfService: (context, state, data) {
          {
            return beam.delegateBeamPage(
              child: const TermsOfServiceScreen(),
              title: 'Terms of Service',
              type: BeamPageType.fadeTransition,
              key: 'termsOfService',
            );
          }
        },
        privacyPolicy: (context, state, data) {
          {
            return beam.delegateBeamPage(
              child: const PrivacyPolicyScreen(),
              title: 'Privacy Policy',
              type: BeamPageType.fadeTransition,
              key: 'privacyPolicy',
            );
          }
        },
      },
    ).call,
  );
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
      type: BeamPageType.fadeTransition,
      child: child,
      key: ValueKey(key),
    );
  }
}
