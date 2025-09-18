import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tm8/app/app_bloc/app_bloc.dart';
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
import 'package:tm8/app/widgets/tm8_secondary_button_widget.dart';
import 'package:tm8/app/widgets/tm8_snack_bar_widget.dart';
import 'package:tm8/gen/assets.gen.dart';
import 'package:tm8/login/presentation/logic/manual_login_cubit/manual_login_cubit.dart';
import 'package:tm8/login/presentation/widgets/tm8_loading_overlay_widget.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

@RoutePage() //ManualLoginScreen.page
class ManualLoginScreen extends StatefulWidget {
  const ManualLoginScreen({super.key});

  @override
  State<ManualLoginScreen> createState() => _ManualLoginScreenState();
}

class _ManualLoginScreenState extends State<ManualLoginScreen> {
  final formKey = GlobalKey<FormBuilderState>();
  final manualLoginCubit = sl<ManualLoginCubit>();
  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidgetBuilder: (progress) {
        return Tm8LoadingOverlayWidget(progress: progress);
      },
      overlayColor: Colors.transparent,
      child: BlocProvider(
        create: (context) => manualLoginCubit,
        child: BlocListener<ManualLoginCubit, ManualLoginState>(
          listener: (context, state) {
            state.whenOrNull(
              loading: () {
                context.loaderOverlay.show();
              },
              loaded: (response) {
                context.loaderOverlay.hide();
                sl<AppBloc>().add(const AppEvent.checkStatus());
              },
              error: (error, email) {
                context.loaderOverlay.hide();
                if (error ==
                    'Phone number not verified. Please verify your phone number to continue.') {
                  context.loaderOverlay.hide();
                  context.pushRoute(
                    SignUpManualAddPhoneRoute(email: email),
                  );
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    Tm8SnackBar.snackBar(
                      color: glassEffectColor,
                      text: 'Redirected to finish manual sign-up',
                      error: false,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
          child: Tm8BodyContainerWidget(
            child: FormBuilder(
              key: formKey,
              child: Scaffold(
                body: Padding(
                  padding: screenPadding,
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
                        'Log In',
                        style: heading2Regular.copyWith(color: achromatic100),
                      ),
                      h24,
                      Tm8InputFormWidget(
                        name: 'email',
                        labelText: 'Email address',
                        hintText: 'address@email.com',
                        validator: emailValidator,
                      ),
                      h12,
                      Tm8InputFormWidget(
                        name: 'password',
                        hintText: 'Enter password',
                        labelText: 'Password',
                        validator: passwordValidatorLogin,
                        obscureText: true,
                        suffixIcon: [
                          Assets.common.notVisible.path,
                          Assets.common.visible.path,
                        ],
                      ),
                      h24,
                      Tm8MainButtonWidget(
                        onTap: () async {
                          final state = formKey.currentState!;
                          if (state.saveAndValidate()) {
                            final email = state.fields['email']!.value;
                            final password = state.fields['password']!.value;
                            final notificationToken =
                                await FirebaseMessaging.instance.getToken();
                            manualLoginCubit.loginUser(
                              body: AuthLoginInput(
                                email: email,
                                password: password,
                                notificationToken: notificationToken,
                              ),
                            );
                          }
                        },
                        buttonColor: primaryTeal,
                        text: 'Log In',
                      ),
                      h12,
                      Tm8SecondaryButtonWidget(
                        onPressed: () {
                          context.pushRoute(const ForgotPasswordRoute());
                        },
                        textColor: achromatic100,
                        textStyle: body1Bold,
                        text: 'Forgot password?',
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
