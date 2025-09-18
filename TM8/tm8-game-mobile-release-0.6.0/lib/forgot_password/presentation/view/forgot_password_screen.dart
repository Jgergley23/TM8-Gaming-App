import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loggy/loggy.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/router/router.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/widgets/tm8_body_container_widget.dart';
import 'package:tm8/app/widgets/tm8_main_app_bar_widget.dart';
import 'package:tm8/app/widgets/tm8_main_button_widget.dart';
import 'package:tm8/app/widgets/tm8_phone_field_widget.dart';
import 'package:tm8/app/widgets/tm8_snack_bar_widget.dart';
import 'package:tm8/forgot_password/presentation/logic/forgot_password/forgot_password_cubit.dart';
import 'package:tm8/login/presentation/widgets/tm8_loading_overlay_widget.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

@RoutePage() //ForgotPasswordRoute.page
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final PhoneController controller = PhoneController();
  final _formKey = GlobalKey<FormState>();
  final forgotPasswordCubit = sl<ForgotPasswordCubit>();
  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidgetBuilder: (progress) {
        return Tm8LoadingOverlayWidget(progress: progress);
      },
      overlayColor: Colors.transparent,
      child: BlocProvider(
        create: (context) => forgotPasswordCubit,
        child: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
          listener: (context, state) {
            state.whenOrNull(
              loading: () {
                context.loaderOverlay.show();
              },
              loaded: (phoneNumber) {
                context.loaderOverlay.hide();
                context.pushRoute(
                  ForgotPasswordVerificationRoute(phoneNumber: phoneNumber),
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
            child: Form(
              key: _formKey,
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
                        'Forgot password',
                        style: heading2Regular.copyWith(color: achromatic100),
                      ),
                      h12,
                      Text(
                        'Enter your phone number to reset your password.',
                        style: body1Regular.copyWith(
                          color: achromatic200,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      h24,
                      Tm8PhoneFieldWidget(
                        controller: controller,
                      ),
                      h24,
                      Tm8MainButtonWidget(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            logInfo(controller.value);
                            forgotPasswordCubit.forgotPassword(
                              body: ForgotPasswordInput(
                                phoneNumber:
                                    '+${controller.value.countryCode}${controller.value.nsn}',
                              ),
                            );
                          }
                        },
                        buttonColor: primaryTeal,
                        text: 'Continue',
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
