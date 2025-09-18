import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tm8_game_admin/app/app_bloc/app_bloc.dart';
import 'package:tm8_game_admin/app/constants/constants.dart';
import 'package:tm8_game_admin/app/constants/fonts.dart';
import 'package:tm8_game_admin/app/constants/palette.dart';
import 'package:tm8_game_admin/app/constants/routing_names.dart';
import 'package:tm8_game_admin/app/constants/validators.dart';
import 'package:tm8_game_admin/app/services/service_locator.dart';
import 'package:tm8_game_admin/app/widgets/tm8_input_form_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_loading_overlay_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_main_button_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_main_container_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_secondary_button_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_snack_bar.dart';
import 'package:tm8_game_admin/login/presentation/logic/login_cubit/login_cubit.dart';
import 'package:tm8_game_admin/login/presentation/widgets/login_app_bar_widget.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
        body: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            state.whenOrNull(
              loading: () {
                context.loaderOverlay.show();
              },
              loaded: (email) {
                context.loaderOverlay.hide();
                sl<AppBloc>().add(const AppEvent.checkStatus());
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
                        width: 320,
                        padding: 24,
                        borderRadius: 20,
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Welcome back',
                              style: heading1Regular.copyWith(
                                color: achromatic100,
                              ),
                            ),
                            h12,
                            Text(
                              'Log into your admin account using your email address and password.',
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
                            h12,
                            Tm8InputFormWidget(
                              name: 'password',
                              hintText: 'Enter password',
                              labelText: 'Password',
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
                                if (state.validate()) {
                                  final value = state.fields;
                                  context.read<LoginCubit>().login(
                                        loginInput: AuthLoginInput(
                                          email:
                                              value['email']!.value.toString(),
                                          password: value['password']!
                                              .value
                                              .toString(),
                                        ),
                                      );
                                }
                              },
                              buttonColor: primaryTeal,
                              text: 'Log in',
                            ),
                            h12,
                            Tm8SecondaryButtonWidget(
                              onPressed: () {
                                context.beamToNamed(forgotPasswordEmail);
                              },
                              text: 'Forgot password?',
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
