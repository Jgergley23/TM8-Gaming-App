import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/router/router.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/widgets/tm8_body_container_widget.dart';
import 'package:tm8/app/widgets/tm8_main_app_bar_widget.dart';
import 'package:tm8/app/widgets/tm8_main_button_widget.dart';
import 'package:tm8/app/widgets/tm8_pin_code_widget.dart';
import 'package:tm8/app/widgets/tm8_snack_bar_widget.dart';
import 'package:tm8/login/presentation/widgets/tm8_loading_overlay_widget.dart';
import 'package:tm8/sign_up/presentation/logic/manual_sign_up_resend_code_cubit/manual_sign_up_resend_code_cubit.dart';
import 'package:tm8/sign_up/presentation/logic/manual_sign_up_verify_phone_cubit/manual_sign_up_verify_phone_cubit.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

@RoutePage() //SignUpManualVerifyPhoneRoute.page
class SignUpManualVerifyPhoneScreen extends StatefulWidget {
  const SignUpManualVerifyPhoneScreen({
    super.key,
    required this.phoneNumber,
  });

  final String phoneNumber;
  @override
  State<SignUpManualVerifyPhoneScreen> createState() =>
      _SignUpManualVerifyPhoneScreenState();
}

class _SignUpManualVerifyPhoneScreenState
    extends State<SignUpManualVerifyPhoneScreen> {
  final formKey = GlobalKey<FormState>();
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  final manualSignUpVerifyPhoneCubit = sl<ManualSignUpVerifyPhoneCubit>();
  final manualSignUpResendCodeCubit = sl<ManualSignUpResendCodeCubit>();

  bool hasError = false;
  var currentPin = '';

  @override
  void dispose() {
    errorController.close();
    super.dispose();
  }

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
            create: (context) => manualSignUpVerifyPhoneCubit,
          ),
          BlocProvider(
            create: (context) => manualSignUpResendCodeCubit,
          ),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<ManualSignUpVerifyPhoneCubit,
                ManualSignUpVerifyPhoneState>(
              listener: (context, state) {
                state.whenOrNull(
                  loading: () {
                    context.loaderOverlay.show();
                  },
                  loaded: (response) {
                    context.loaderOverlay.hide();
                    context.pushRoute(const OnboardingPreferencesRoute());
                  },
                  error: (error) {
                    context.loaderOverlay.hide();
                    errorController.add(ErrorAnimationType.shake);
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
            BlocListener<ManualSignUpResendCodeCubit,
                ManualSignUpResendCodeState>(
              listener: (context, state) {
                state.whenOrNull(
                  loading: () {
                    context.loaderOverlay.show();
                  },
                  loaded: () {
                    context.loaderOverlay.hide();
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      Tm8SnackBar.snackBar(
                        color: glassEffectColor,
                        text: 'Code re-sent to ${widget.phoneNumber}.',
                        error: false,
                      ),
                    );
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
            child: Form(
              key: formKey,
              child: Scaffold(
                body: Padding(
                  padding: screenPadding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Tm8MainAppBarWidget(
                        leading: true,
                      ),
                      expanded,
                      Text(
                        'Enter verification code',
                        style: heading2Regular.copyWith(color: achromatic100),
                      ),
                      h12,
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text:
                              'Please enter 6-digit code sent to ${widget.phoneNumber}. ',
                          style: body1Regular.copyWith(color: achromatic200),
                          children: [
                            TextSpan(
                              text: ' Wrong number?',
                              style: body1Bold.copyWith(color: achromatic100),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.maybePop();
                                },
                            ),
                          ],
                        ),
                      ),
                      h24,
                      Tm8PinCodeWidget(
                        onCompleted: (code) {
                          currentPin = code;
                        },
                        errorController: errorController,
                        hasError: hasError,
                      ),
                      h24,
                      Tm8MainButtonWidget(
                        onTap: () {
                          final state = formKey.currentState;
                          _validationOfPinCode(
                            state,
                            context,
                          );
                        },
                        buttonColor: primaryTeal,
                        text: 'Continue',
                      ),
                      h12,
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Didn't receive the code? ",
                          style: body1Regular.copyWith(color: achromatic200),
                          children: [
                            TextSpan(
                              text: 'Resend',
                              style: body1Bold.copyWith(color: achromatic100),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  manualSignUpResendCodeCubit
                                      .manualSignUpResendCode(
                                    body: PhoneVerificationInput(
                                      phoneNumber: widget.phoneNumber,
                                    ),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                      expanded,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _validationOfPinCode(FormState? state, BuildContext context) {
    if (state!.validate()) {
      if (currentPin.length != 6) {
        errorController.add(ErrorAnimationType.shake);
        setState(() {
          hasError = true;
        });
      } else {
        final code = double.tryParse(currentPin);
        if (code == null) {
          errorController.add(ErrorAnimationType.shake);
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            Tm8SnackBar.snackBar(
              color: achromatic600,
              text: 'Please enter a 6 digit code.',
              error: true,
            ),
          );
        } else {
          manualSignUpVerifyPhoneCubit.manualSignUpVerifyPhone(
            body: VerifyCodeInput(code: code),
          );
        }
      }
    }
  }
}
