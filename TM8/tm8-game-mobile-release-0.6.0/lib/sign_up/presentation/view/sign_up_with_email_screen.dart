import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loggy/loggy.dart';
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
import 'package:tm8/gen/assets.gen.dart';
import 'package:tm8/login/presentation/widgets/tm8_loading_overlay_widget.dart';
import 'package:tm8/sign_up/presentation/logic/manual_sign_up_cubit/manual_sign_up_cubit.dart';
import 'package:tm8/sign_up/presentation/widgets/tm8_date_of_birth_widget.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

@RoutePage() //SignUpRoute.page
class SignUpWithEmailScreen extends StatefulWidget {
  const SignUpWithEmailScreen({super.key});

  @override
  State<SignUpWithEmailScreen> createState() => _SignUpWithEmailScreenState();
}

class _SignUpWithEmailScreenState extends State<SignUpWithEmailScreen> {
  final formKey = GlobalKey<FormBuilderState>();
  final manualSignUpCubit = sl<ManualSignUpCubit>();
  var country = 'USA';
  var timeZone = 'EST+00';

  @override
  void initState() {
    super.initState();

    _getLocationAndTimezone();
  }

  Future<void> _getLocationAndTimezone() async {
    final result = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );
    final places =
        await placemarkFromCoordinates(result.latitude, result.longitude);
    final date = DateTime.now();
    var hours = date.timeZoneOffset.inHours;
    // Determine the sign
    final sign = hours < 0 ? "-" : "+";
    // Format hours with leading zeros
    String formattedHours = hours.abs().toString().padLeft(2, '0');

    timeZone = "${date.timeZoneName}$sign$formattedHours";
    final place = places[0].toJson();
    country = place['isoCountryCode'];
    logInfo('timeZone: $timeZone');
    logInfo('Location: ${places[0].toJson()}');
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
        create: (context) => manualSignUpCubit,
        child: BlocListener<ManualSignUpCubit, ManualSignUpState>(
          listener: (context, state) {
            state.whenOrNull(
              loading: () {
                context.loaderOverlay.show();
              },
              loaded: (email) {
                context.loaderOverlay.hide();
                context.pushRoute(
                  SignUpManualAddPhoneRoute(email: email),
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
            child: FormBuilder(
              key: formKey,
              child: Padding(
                padding: screenPadding,
                child: Scaffold(
                  body: Column(
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
                        'Sign up with email',
                        style: heading2Regular.copyWith(color: achromatic100),
                      ),
                      h12,
                      Text(
                        'Please enter your email address and create a password that is at least 8 characters long, contains at least 1 capital letter and 1 number. ',
                        style: body1Regular.copyWith(color: achromatic200),
                        textAlign: TextAlign.center,
                      ),
                      h24,
                      Tm8InputFormWidget(
                        name: 'email',
                        hintText: 'Add email address',
                        labelText: 'Email Address',
                        validator: emailValidator,
                      ),
                      h12,
                      Tm8InputFormWidget(
                        name: 'username',
                        hintText: 'Set your username',
                        labelText: 'Username',
                        validator: usernameValidator,
                      ),
                      h12,
                      Tm8InputFormWidget(
                        name: 'password',
                        hintText: 'Enter password',
                        labelText: 'Password',
                        validator: passwordValidator,
                        obscureText: true,
                        suffixIcon: [
                          Assets.common.notVisible.path,
                          Assets.common.visible.path,
                        ],
                      ),
                      h12,
                      const Tm8DateOfBirthWidget(
                        name: 'date_of_birth',
                        hintText: 'Set date of birth',
                        labelText: 'Date of Birth',
                      ),
                      h24,
                      Tm8MainButtonWidget(
                        onTap: () async {
                          final state = formKey.currentState!;
                          if (state.saveAndValidate()) {
                            final email = state.fields['email']!.value;
                            final password = state.fields['password']!.value;
                            final username = state.fields['username']!.value;
                            final dateOfBirth =
                                state.fields['date_of_birth']!.value;
                            final notificationToken =
                                await FirebaseMessaging.instance.getToken();
                            manualSignUpCubit.manualSignUp(
                              body: RegisterInput(
                                email: email,
                                username: username,
                                dateOfBirth: DateFormat('yyyy-MM-dd')
                                    .format(DateTime.parse(dateOfBirth))
                                    .toString(),
                                password: password,
                                timezone: timeZone,
                                country: country,
                                notificationToken: notificationToken,
                              ),
                            );
                          }
                        },
                        buttonColor: primaryTeal,
                        text: 'Sign Up',
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
