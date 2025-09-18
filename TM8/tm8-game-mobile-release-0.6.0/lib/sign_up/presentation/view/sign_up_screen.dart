// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:tm8/app/app_bloc/app_bloc.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/router/router.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/widgets/tm8_alert_dialog_widget.dart';
import 'package:tm8/app/widgets/tm8_body_container_widget.dart';
import 'package:tm8/app/widgets/tm8_social_button_widget.dart';
import 'package:tm8/env/env.dart';
import 'package:tm8/gen/assets.gen.dart';
import 'package:tm8/login/presentation/widgets/apple_sign_in_use_widget.dart';
import 'package:tm8/sign_up/presentation/logic/google_sign_up_cubit/google_sign_up_cubit.dart';
import 'package:tm8/app/widgets/tm8_snack_bar_widget.dart';
import 'package:tm8/login/presentation/widgets/tm8_loading_overlay_widget.dart';
import 'package:tm8/sign_up/presentation/logic/apple_sign_up_cubit/apple_sign_up_cubit.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage() //SignUpRoute.page
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final appleSignUpCubit = sl<AppleSignUpCubit>();
  final googleSignUpCubit = sl<GoogleSignUpCubit>();
  final googleSignInAndroid = GoogleSignIn(
    scopes: ['email'],
  );
  final GoogleSignIn googleSignInIOS = GoogleSignIn(
    clientId: Env.clientID,
  );
  bool checkbox = false;
  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidgetBuilder: (progress) {
        return Tm8LoadingOverlayWidget(progress: progress);
      },
      overlayColor: Colors.transparent,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => appleSignUpCubit,
          ),
          BlocProvider(
            create: (context) => googleSignUpCubit,
          ),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<AppleSignUpCubit, AppleSignUpState>(
              listener: (context, state) {
                state.whenOrNull(
                  loading: () {
                    context.loaderOverlay.show();
                  },
                  loaded: (response) {
                    context.loaderOverlay.hide();
                    if (response.dateOfBirth == null) {
                      context.router.push(const SignUpAddDOBRoute());
                    } else {
                      sl<AppBloc>().add(const AppEvent.checkStatus());
                    }
                  },
                  error: (error) {
                    context.loaderOverlay.hide();
                    context.loaderOverlay.hide();
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    if (error ==
                        'Apple user not found. Please provide an email.') {
                      tm8PopUpDialogWidget(
                        context,
                        padding: 12,
                        width: 300,
                        borderRadius: 20,
                        popup: (context) => const AppleSignInUseWidget(),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        Tm8SnackBar.snackBar(
                          color: glassEffectColor,
                          text: error,
                          error: true,
                        ),
                      );
                    }
                  },
                );
              },
            ),
            BlocListener<GoogleSignUpCubit, GoogleSignUpState>(
              listener: (context, state) {
                state.whenOrNull(
                  loading: () {
                    context.loaderOverlay.show();
                  },
                  loaded: (response) {
                    context.loaderOverlay.hide();
                    if (response.dateOfBirth == null) {
                      context.router.push(const SignUpAddDOBRoute());
                    } else {
                      sl<AppBloc>().add(const AppEvent.checkStatus());
                    }
                  },
                  error: (error) {
                    context.loaderOverlay.hide();
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      Tm8SnackBar.snackBar(
                        color: glassEffectColor,
                        text: error,
                        error: true,
                      ),
                    );
                  },
                );
              },
            ),
          ],
          child: Tm8BodyContainerWidget(
            child: Scaffold(
              body: Padding(
                padding: screenPadding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    expanded,
                    Text(
                      'Welcome to TM8!',
                      style: heading2Regular.copyWith(color: achromatic100),
                    ),
                    h12,
                    Text(
                      'Create your account to continue.',
                      style: body1Regular.copyWith(color: achromatic200),
                    ),
                    h24,
                    if (Platform.isIOS) ...[
                      Tm8SocialButtonWidget(
                        onTap: () async {
                          try {
                            context.loaderOverlay.show();
                            final credential =
                                await SignInWithApple.getAppleIDCredential(
                              scopes: [
                                AppleIDAuthorizationScopes.email,
                                AppleIDAuthorizationScopes.fullName,
                              ],
                            );
                            final notificationToken =
                                await FirebaseMessaging.instance.getToken();
                            //identity token always available
                            appleSignUpCubit.appleSignUp(
                              body: VerifyAppleIdInput(
                                token: credential.identityToken!,
                                email: credential.email,
                                fullName:
                                    '${credential.givenName} ${credential.familyName}',
                                notificationToken: notificationToken,
                              ),
                            );
                          } catch (error) {
                            context.loaderOverlay.hide();
                          }
                        },
                        icon: Assets.common.appleIcon.path,
                        text: 'Continue with Apple',
                      ),
                      h12,
                    ],
                    Tm8SocialButtonWidget(
                      onTap: () {
                        if (checkbox) {
                          if (Platform.isAndroid) {
                            _handleSignInAndroid();
                          } else {
                            _handleSignInIOS();
                          }
                        } else {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            Tm8SnackBar.snackBar(
                              color: glassEffectColor,
                              text:
                                  'Terms of Use and Privacy Policy need to be accepted',
                              error: true,
                            ),
                          );
                        }
                      },
                      icon: Assets.common.googleIcon.path,
                      text: 'Continue with Google',
                    ),
                    h12,
                    Tm8SocialButtonWidget(
                      onTap: () {
                        if (checkbox) {
                          context.pushRoute(const SignUpWithEmailRoute());
                        } else {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            Tm8SnackBar.snackBar(
                              color: glassEffectColor,
                              text:
                                  'Terms of Use and Privacy Policy need to be accepted',
                              error: true,
                            ),
                          );
                        }
                      },
                      icon: Assets.common.emailIcon.path,
                      text: 'Sign up with email',
                    ),
                    h24,
                    RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: body1Regular.copyWith(color: achromatic200),
                        children: [
                          TextSpan(
                            text: ' Log in',
                            style: body1Bold.copyWith(color: achromatic100),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.maybePop();
                              },
                          ),
                        ],
                      ),
                    ),
                    expanded,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          visualDensity: VisualDensity.compact,
                          value: checkbox,
                          onChanged: (bool? value) {
                            if (value != null) {
                              setState(() {
                                checkbox = value;
                              });
                            }
                          },
                        ),
                        Expanded(
                          child: RichText(
                            // textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'By signing up, you agree to our ',
                              style:
                                  body1Regular.copyWith(color: achromatic200),
                              children: [
                                TextSpan(
                                  text: 'Terms of Use',
                                  style:
                                      body1Bold.copyWith(color: achromatic100),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      openUrl(
                                        url:
                                            'http://tm8-frontend-d-lan-d3s8.s3-website-us-east-1.amazonaws.com/terms-of-service',
                                      );
                                    },
                                ),
                                TextSpan(
                                  text: ' and ',
                                  style: body1Regular.copyWith(
                                    color: achromatic200,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style:
                                      body1Bold.copyWith(color: achromatic100),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      openUrl(
                                        url:
                                            'http://tm8-frontend-d-lan-d3s8.s3-website-us-east-1.amazonaws.com/privacy-policy',
                                      );
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> openUrl({required String url}) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _handleSignInAndroid() async {
    try {
      context.loaderOverlay.show();
      GoogleSignInAccount? google = await googleSignInAndroid.signIn();
      if (google != null) {
        final auth = await google.authentication;
        final notificationToken = await FirebaseMessaging.instance.getToken();
        googleSignUpCubit.googleSingUp(
          body: VerifyGoogleIdInput(
            token: auth.accessToken!,
            fullName: google.displayName,
            notificationToken: notificationToken,
          ),
        );
      }
      context.loaderOverlay.hide();
    } catch (error) {
      context.loaderOverlay.hide();
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        Tm8SnackBar.snackBar(
          color: glassEffectColor,
          text: error.toString(),
          error: true,
        ),
      );
    }
  }

  Future<void> _handleSignInIOS() async {
    try {
      context.loaderOverlay.show();
      GoogleSignInAccount? google = await googleSignInIOS.signIn();
      final notificationToken = await FirebaseMessaging.instance.getToken();
      if (google != null) {
        final auth = await google.authentication;
        googleSignUpCubit.googleSingUp(
          body: VerifyGoogleIdInput(
            token: auth.accessToken!,
            fullName: google.displayName,
            notificationToken: notificationToken,
          ),
        );
      }
      context.loaderOverlay.hide();
    } catch (error) {
      context.loaderOverlay.hide();
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        Tm8SnackBar.snackBar(
          color: glassEffectColor,
          text: error.toString(),
          error: true,
        ),
      );
    }
  }
}
