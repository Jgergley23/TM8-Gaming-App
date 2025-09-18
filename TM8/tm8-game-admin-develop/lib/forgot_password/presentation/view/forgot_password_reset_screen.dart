import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tm8_game_admin/app/constants/constants.dart';
import 'package:tm8_game_admin/app/constants/fonts.dart';
import 'package:tm8_game_admin/app/constants/palette.dart';
import 'package:tm8_game_admin/app/constants/routing_names.dart';
import 'package:tm8_game_admin/app/constants/validators.dart';
import 'package:tm8_game_admin/app/widgets/tm8_input_form_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_loading_overlay_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_main_button_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_main_container_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_snack_bar.dart';
import 'package:tm8_game_admin/forgot_password/presentation/logic/forgot_password_reset_cubit/forgot_password_reset_cubit.dart';
import 'package:tm8_game_admin/login/presentation/widgets/login_app_bar_widget.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

class ForgotPasswordResetScreen extends StatefulWidget {
  const ForgotPasswordResetScreen({
    super.key,
    required this.email,
  });

  final String email;

  @override
  State<ForgotPasswordResetScreen> createState() =>
      _ForgotPasswordResetScreenState();
}

class _ForgotPasswordResetScreenState extends State<ForgotPasswordResetScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
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
        body: BlocListener<ForgotPasswordResetCubit, ForgotPasswordResetState>(
          listener: (context, state) {
            state.whenOrNull(
              loading: () {
                context.loaderOverlay.show();
              },
              loaded: () {
                context.loaderOverlay.hide();
                context.beamToNamed(forgotPasswordConformation);
              },
              error: (error) {
                context.loaderOverlay.hide();
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  Tm8SnackBar.snackBar(
                    color: achromatic600,
                    text: error,
                    textColor: errorTextColor,
                    button: false,
                  ),
                );
              },
            );
          },
          child: Center(
            child: SingleChildScrollView(
              child: FormBuilder(
                key: _formKey,
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
                                InkWell(
                                  onTap: () {
                                    context.beamBack();
                                  },
                                  child: SvgPicture.asset(
                                    'assets/common/navigation_back_arrow.svg',
                                  ),
                                ),
                                Text(
                                  'Set new password',
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
                              'Set your new password. Must be at least 8 characters long, contain at least 1 capital letter and 1 number.',
                              style: body1Regular.copyWith(
                                color: achromatic200,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            h24,
                            Tm8InputFormWidget(
                              name: 'new-password',
                              hintText: 'Enter new password',
                              labelText: 'New password',
                              validator: passwordValidator,
                              obscureText: true,
                              suffixIcon: const [
                                'assets/common/not_visible.svg',
                                'assets/common/visible.svg',
                              ],
                            ),
                            h24,
                            Tm8InputFormWidget(
                              name: 'repeat-password',
                              hintText: 'Re-enter new password',
                              labelText: 'Repeat new password',
                              validator: passwordValidator,
                              obscureText: true,
                              suffixIcon: const [
                                'assets/common/not_visible.svg',
                                'assets/common/visible.svg',
                              ],
                            ),
                            h24,
                            Tm8MainButtonWidget(
                              onPressed: () {
                                final state = _formKey.currentState!;
                                _validateResetPassword(state, context);
                              },
                              buttonColor: primaryTeal,
                              text: 'Reset password',
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

  void _validateResetPassword(FormBuilderState state, BuildContext context) {
    if (state.validate()) {
      final value = state.fields;
      final newPassword = value['new-password']!.value;
      final repeatPassword = value['repeat-password']!.value;
      if (newPassword == repeatPassword) {
        context.read<ForgotPasswordResetCubit>().resetPassword(
              resetPasswordInput: ResetPasswordInput(
                email: widget.email,
                password: newPassword,
              ),
            );
      } else {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          Tm8SnackBar.snackBar(
            color: achromatic600,
            text: 'Passwords do not match',
            textColor: errorTextColor,
            button: false,
          ),
        );
      }
    }
  }
}
