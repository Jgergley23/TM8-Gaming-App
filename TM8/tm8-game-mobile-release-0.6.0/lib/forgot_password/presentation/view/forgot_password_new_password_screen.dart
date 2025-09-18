import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/constants/validators.dart';
import 'package:tm8/app/router/router.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/widgets/tm8_body_container_widget.dart';
import 'package:tm8/app/widgets/tm8_input_form_widget.dart';
import 'package:tm8/app/widgets/tm8_main_app_bar_widget.dart';
import 'package:tm8/app/widgets/tm8_main_button_widget.dart';
import 'package:tm8/app/widgets/tm8_snack_bar_widget.dart';
import 'package:tm8/forgot_password/presentation/logic/forgot_password_reset_cubit/forgot_password_reset_cubit.dart';
import 'package:tm8/gen/assets.gen.dart';
import 'package:tm8/login/presentation/widgets/tm8_loading_overlay_widget.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

@RoutePage() //ForgotPasswordNewPasswordRoute.page
class ForgotPasswordNewPasswordScreen extends StatefulWidget {
  const ForgotPasswordNewPasswordScreen({super.key, required this.phoneNumber});

  final String phoneNumber;

  @override
  State<ForgotPasswordNewPasswordScreen> createState() =>
      _ForgotPasswordNewPasswordScreenState();
}

class _ForgotPasswordNewPasswordScreenState
    extends State<ForgotPasswordNewPasswordScreen> {
  final formKey = GlobalKey<FormBuilderState>();
  final forgotPasswordResetCubit = sl<ForgotPasswordResetCubit>();
  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidgetBuilder: (progress) {
        return Tm8LoadingOverlayWidget(progress: progress);
      },
      overlayColor: Colors.transparent,
      child: BlocProvider(
        create: (context) => forgotPasswordResetCubit,
        child: BlocListener<ForgotPasswordResetCubit, ForgotPasswordResetState>(
          listener: (context, state) {
            state.whenOrNull(
              loading: () {
                context.loaderOverlay.show();
              },
              loaded: (phoneNumber) {
                context.loaderOverlay.hide();
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  Tm8SnackBar.snackBar(
                    color: glassEffectColor,
                    text: 'Successfully reset password',
                    error: false,
                  ),
                );
                context.router.pushAndPopUntil(
                  const LoginRoute(),
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
              body: Padding(
                padding: screenPadding,
                child: FormBuilder(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Tm8MainAppBarWidget(
                        leading: true,
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      Text(
                        'Set new password',
                        style: heading2Regular.copyWith(color: achromatic100),
                      ),
                      h12,
                      Text(
                        'Please create a new password. Must be at least 8 characters long, contain at least 1 capital letter and 1 number. ',
                        style: body1Regular.copyWith(color: achromatic200),
                        textAlign: TextAlign.center,
                      ),
                      h24,
                      Tm8InputFormWidget(
                        name: 'newPassword',
                        hintText: 'Set new password',
                        labelText: 'New Password',
                        validator: passwordValidator,
                        obscureText: true,
                        suffixIcon: [
                          Assets.common.notVisible.path,
                          Assets.common.visible.path,
                        ],
                      ),
                      h12,
                      Tm8InputFormWidget(
                        name: 'repeatPassword',
                        hintText: 'Repeat new password',
                        labelText: 'Repeat new Password',
                        validator: passwordValidator,
                        obscureText: true,
                        suffixIcon: [
                          Assets.common.notVisible.path,
                          Assets.common.visible.path,
                        ],
                      ),
                      h24,
                      Tm8MainButtonWidget(
                        onTap: () {
                          final state = formKey.currentState!;
                          if (state.saveAndValidate()) {
                            final value = state.fields;
                            final newPassword = value['newPassword']!.value;
                            final repeatPassword =
                                value['repeatPassword']!.value;
                            if (newPassword == repeatPassword) {
                              forgotPasswordResetCubit.forgotPasswordReset(
                                body: ResetPasswordInput(
                                  password: newPassword,
                                  phoneNumber: widget.phoneNumber,
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                Tm8SnackBar.snackBar(
                                  color: glassEffectColor,
                                  text: 'Passwords do not match',
                                  error: true,
                                ),
                              );
                            }
                          }
                        },
                        buttonColor: primaryTeal,
                        text: 'Reset password',
                      ),
                      const Expanded(
                        child: SizedBox(),
                      ),
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
