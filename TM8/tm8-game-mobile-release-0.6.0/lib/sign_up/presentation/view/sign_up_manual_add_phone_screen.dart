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
import 'package:tm8/login/presentation/widgets/tm8_loading_overlay_widget.dart';
import 'package:tm8/sign_up/presentation/logic/manual_sign_upp_add_phone_cubit/add_phone_number_cubit.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

@RoutePage() //SignUpManualAddPhone.page
class SignUpManualAddPhoneScreen extends StatefulWidget {
  const SignUpManualAddPhoneScreen({
    super.key,
    required this.email,
  });

  final String email;

  @override
  State<SignUpManualAddPhoneScreen> createState() =>
      _SignUpManualAddPhoneScreenState();
}

class _SignUpManualAddPhoneScreenState
    extends State<SignUpManualAddPhoneScreen> {
  final PhoneController controller = PhoneController();
  final formKey = GlobalKey<FormState>();
  final addPhoneNumberCubit = sl<AddPhoneNumberCubit>();
  bool checkbox = false;

  @override
  void dispose() {
    controller.dispose();
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
        create: (context) => addPhoneNumberCubit,
        child: BlocListener<AddPhoneNumberCubit, AddPhoneNumberState>(
          listener: (context, state) {
            state.whenOrNull(
              loading: () {
                context.loaderOverlay.show();
              },
              loaded: (phoneNumber) {
                context.loaderOverlay.hide();
                context.pushRoute(
                  SignUpManualVerifyPhoneRoute(phoneNumber: phoneNumber),
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
                      const Expanded(
                        child: SizedBox(),
                      ),
                      Text(
                        'Phone number',
                        style: heading2Regular.copyWith(color: achromatic100),
                      ),
                      h12,
                      Text(
                        'Please provide your phone number ',
                        style: body1Regular.copyWith(color: achromatic200),
                        textAlign: TextAlign.center,
                      ),
                      h24,
                      Tm8PhoneFieldWidget(
                        controller: controller,
                      ),
                      h12,
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
                            child: Text(
                              'I agree to receive 2FA codes on every sign-up or login from Twilio, at the above-provided phone number. Standard message and data rates may apply, reply STOP to opt-out.',
                              style:
                                  body1Regular.copyWith(color: achromatic200),
                            ),
                          ),
                        ],
                      ),
                      h24,
                      Tm8MainButtonWidget(
                        onTap: () {
                          if (checkbox) {
                            if (formKey.currentState!.validate()) {
                              logInfo(controller.value);
                              addPhoneNumberCubit.addPhoneNumber(
                                body: SetUserPhoneInput(
                                  email: widget.email,
                                  phoneNumber:
                                      '+${controller.value.countryCode}${controller.value.nsn}',
                                ),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              Tm8SnackBar.snackBar(
                                color: glassEffectColor,
                                text:
                                    'Agreement for 2FA conditions has to be approved',
                                error: true,
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
