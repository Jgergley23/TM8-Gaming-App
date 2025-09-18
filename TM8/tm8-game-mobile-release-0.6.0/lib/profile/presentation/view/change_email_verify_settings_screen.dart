import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/router/router.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/widgets/tm8_body_container_widget.dart';
import 'package:tm8/app/widgets/tm8_main_app_bar_scaffold_widget.dart';
import 'package:tm8/app/widgets/tm8_main_button_widget.dart';
import 'package:tm8/app/widgets/tm8_pin_code_widget.dart';
import 'package:tm8/app/widgets/tm8_snack_bar_widget.dart';
import 'package:tm8/login/presentation/widgets/tm8_loading_overlay_widget.dart';
import 'package:tm8/profile/presentation/logic/verify_change_email_cubit/verify_change_email_cubit.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

@RoutePage() //ChangeEmailVerifySettingsRoute.page
class ChangeEmailVerifySettingsScreen extends StatefulWidget {
  const ChangeEmailVerifySettingsScreen({super.key});

  @override
  State<ChangeEmailVerifySettingsScreen> createState() =>
      _ChangeEmailVerifySettingsScreenState();
}

class _ChangeEmailVerifySettingsScreenState
    extends State<ChangeEmailVerifySettingsScreen> {
  final verifyChangeEmailCubit = sl<VerifyChangeEmailCubit>();
  final formKey = GlobalKey<FormState>();
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
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
      child: BlocProvider(
        create: (context) => verifyChangeEmailCubit,
        child: BlocListener<VerifyChangeEmailCubit, VerifyChangeEmailState>(
          listener: (context, state) {
            state.whenOrNull(
              loading: () {
                context.loaderOverlay.show();
              },
              loaded: () {
                context.loaderOverlay.hide();
                context.router.pushAndPopUntil(
                  const HomePageRoute(),
                  predicate: (_) => false,
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
          child: Tm8BodyContainerWidget(
            child: Scaffold(
              appBar: Tm8MainAppBarScaffoldWidget(
                title: 'Verify Email address',
                leading: true,
                navigationPadding: screenPadding,
              ),
              body: FormBuilder(
                key: formKey,
                child: Padding(
                  padding: screenPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      expanded,
                      Text(
                        'We have sent a verification email to your new email address. Please verify your email address to continue.',
                        style: body1Regular.copyWith(
                          color: achromatic200,
                        ),
                      ),
                      h12,
                      Tm8PinCodeWidget(
                        onCompleted: (code) {
                          currentPin = code;
                        },
                        errorController: errorController,
                        hasError: hasError,
                        keyboardType: TextInputType.text,
                        length: 7,
                      ),
                      h24,
                      Tm8MainButtonWidget(
                        onTap: () {
                          if (currentPin.length != 7) {
                            errorController.add(ErrorAnimationType.shake);
                            setState(() {
                              hasError = true;
                            });
                          } else {
                            verifyChangeEmailCubit.verifyEmail(
                              body: VerifyEmailChangeInput(code: currentPin),
                            );
                          }
                        },
                        buttonColor: primaryTeal,
                        text: 'Verify Email',
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
}
