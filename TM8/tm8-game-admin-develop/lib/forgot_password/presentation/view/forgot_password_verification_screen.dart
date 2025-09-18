import 'dart:async';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tm8_game_admin/app/constants/constants.dart';
import 'package:tm8_game_admin/app/constants/fonts.dart';
import 'package:tm8_game_admin/app/constants/palette.dart';
import 'package:tm8_game_admin/app/constants/routing_names.dart';
import 'package:tm8_game_admin/app/widgets/tm8_loading_overlay_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_main_button_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_main_container_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_pin_code_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_snack_bar.dart';
import 'package:tm8_game_admin/forgot_password/presentation/logic/forgot_password_verification_cubit/forgot_password_verification_cubit.dart';
import 'package:tm8_game_admin/login/presentation/widgets/login_app_bar_widget.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

class ForgotPasswordVerificationScreen extends StatefulWidget {
  const ForgotPasswordVerificationScreen({super.key});

  @override
  State<ForgotPasswordVerificationScreen> createState() =>
      _ForgotPasswordVerificationScreenState();
}

class _ForgotPasswordVerificationScreenState
    extends State<ForgotPasswordVerificationScreen> {
  final formKey = GlobalKey<FormState>();
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  var currentText = '';
  bool hasError = false;

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
      child: Scaffold(
        appBar: const LoginAppBarWidget(),
        body: BlocListener<ForgotPasswordVerificationCubit,
            ForgotPasswordVerificationState>(
          listener: (context, state) {
            state.whenOrNull(
              loading: () {
                context.loaderOverlay.show();
              },
              loaded: () {
                context.loaderOverlay.hide();
                context.beamToNamed(forgotPasswordReset);
              },
              error: (error) {
                context.loaderOverlay.hide();
                errorController.add(ErrorAnimationType.shake);
                setState(() {
                  hasError = true;
                });
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  Tm8SnackBar.snackBar(
                    color: achromatic600,
                    text: error,
                    textColor: errorTextColor,
                    button: false,
                    width: 350,
                  ),
                );
              },
            );
          },
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Tm8MainContainerWidget(
                        width: 340,
                        padding: 24,
                        borderRadius: 20,
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: InkWell(
                                    onTap: () {
                                      context.beamBack();
                                    },
                                    child: SvgPicture.asset(
                                      'assets/common/navigation_back_arrow.svg',
                                    ),
                                  ),
                                ),
                                Text(
                                  'Enter code',
                                  style: heading1Regular.copyWith(
                                    color: achromatic100,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(),
                              ],
                            ),
                            h12,
                            Text(
                              'Enter the 6-digit code we’ve sent to your email address.',
                              style: body1Regular.copyWith(
                                color: achromatic200,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            h24,
                            Tm8PinCodeWidget(
                              onCompleted: (val) {
                                currentText = val;
                              },
                              errorController: errorController,
                              hasError: hasError,
                            ),
                            h24,
                            Tm8MainButtonWidget(
                              onPressed: () {
                                final state = formKey.currentState;
                                _validationOfPinCode(state, context);
                              },
                              buttonColor: primaryTeal,
                              text: 'Continue',
                            ),
                          ],
                        ),
                      ),
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

  void _validationOfPinCode(FormState? state, BuildContext context) {
    if (state!.validate()) {
      if (currentText.length != 6) {
        errorController.add(ErrorAnimationType.shake);
        setState(() {
          hasError = true;
        });
      } else {
        final code = double.tryParse(currentText);
        if (code == null) {
          errorController.add(ErrorAnimationType.shake);
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            Tm8SnackBar.snackBar(
              color: achromatic600,
              text: 'Please enter a 6 digit code.',
              textColor: errorTextColor,
              button: false,
            ),
          );
        } else {
          context.read<ForgotPasswordVerificationCubit>().verifyCode(
                verifyCodeInput: VerifyCodeInput(code: code),
              );
        }
      }
    }
  }
}
