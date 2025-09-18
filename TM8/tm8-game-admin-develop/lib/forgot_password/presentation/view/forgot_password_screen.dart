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
import 'package:tm8_game_admin/forgot_password/presentation/logic/forgot_password_cubit/forgot_password_cubit.dart';
import 'package:tm8_game_admin/login/presentation/widgets/login_app_bar_widget.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
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
        body: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
          listener: (context, state) {
            state.whenOrNull(
              loading: () {
                context.loaderOverlay.show();
              },
              loaded: () {
                context.loaderOverlay.hide();
                context.beamToNamed(forgotPasswordVerificationCode);
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
                                    if (context.canBeamBack) {
                                      context.beamBack();
                                    } else {
                                      context.beamToNamed(login);
                                    }
                                  },
                                  child: SvgPicture.asset(
                                    'assets/common/navigation_back_arrow.svg',
                                  ),
                                ),
                                Text(
                                  'Forgot password',
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
                              'Type in your email address to reset your password. After that, enter the confirmation code we sent you to reset your password.',
                              style: body1Regular.copyWith(
                                color: achromatic200,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            h24,
                            Tm8InputFormWidget(
                              name: 'email',
                              hintText: 'Enter email',
                              labelText: 'Email address',
                              validator: emailValidator,
                            ),
                            h24,
                            Tm8MainButtonWidget(
                              onPressed: () {
                                final state = _formKey.currentState!;
                                if (state.validate()) {
                                  final value = state.fields;
                                  context
                                      .read<ForgotPasswordCubit>()
                                      .forgetPasswordEmail(
                                        forgotPasswordInput:
                                            ForgotPasswordInput(
                                          email: value['email']!.value,
                                        ),
                                      );
                                }
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
}
