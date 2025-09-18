import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/router/router.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/widgets/tm8_body_container_widget.dart';
import 'package:tm8/app/widgets/tm8_main_button_widget.dart';
import 'package:tm8/app/widgets/tm8_snack_bar_widget.dart';
import 'package:tm8/login/presentation/widgets/tm8_loading_overlay_widget.dart';
import 'package:tm8/sign_up/presentation/logic/social_sign_up_dob_cubit/social_sign_up_dob_cubit.dart';
import 'package:tm8/sign_up/presentation/widgets/tm8_date_of_birth_widget.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

@RoutePage() //SignUpAddDOBRoute.page
class SignUpAddDOBScreen extends StatefulWidget {
  const SignUpAddDOBScreen({super.key});

  @override
  State<SignUpAddDOBScreen> createState() => _SignUpAddDOBScreenState();
}

class _SignUpAddDOBScreenState extends State<SignUpAddDOBScreen> {
  final socialSignUpDOBCubit = sl<SocialSignUpDobCubit>();
  // final epicGamesFirstRunCheckCubit = sl<EpicGamesFirstRunCheckCubit>();
  final formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidgetBuilder: (progress) {
        return Tm8LoadingOverlayWidget(progress: progress);
      },
      overlayColor: Colors.transparent,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => socialSignUpDOBCubit,
          ),
          // BlocProvider(
          //   create: (context) => epicGamesFirstRunCheckCubit,
          // ),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<SocialSignUpDobCubit, SocialSignUpDobState>(
              listener: (context, state) {
                state.whenOrNull(
                  loading: () {
                    context.loaderOverlay.show();
                  },
                  loaded: () {
                    context.loaderOverlay.hide();
                    // epicGamesFirstRunCheckCubit.firstRunCheck();
                    context.pushRoute(const OnboardingPreferencesRoute());
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
            ),
            // BlocListener<EpicGamesFirstRunCheckCubit,
            //     EpicGamesFirstRunCheckState>(
            //   listener: (context, state) {
            //     state.whenOrNull(
            //       skip: () {
            //         sl<AppBloc>().add(const AppEvent.checkStatus());
            //       },
            //       execute: () {
            //         context.pushRoute(const EpicGamesRoute());
            //       },
            //     );
            //   },
            // ),
          ],
          child: Tm8BodyContainerWidget(
            child: Scaffold(
              body: Padding(
                padding: screenPadding,
                child: FormBuilder(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      expanded,
                      Text(
                        'Add Date of Birth',
                        style: heading2Regular.copyWith(color: achromatic100),
                      ),
                      h12,
                      Text(
                        'Please enter your date of birth to continue.',
                        style: body1Regular.copyWith(color: achromatic200),
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
                            final dateOfBirth =
                                state.fields['date_of_birth']!.value;
                            final format = DateFormat('yyyy-MM-dd')
                                .format(DateTime.parse(dateOfBirth));
                            socialSignUpDOBCubit.addDob(
                              body: SetDateOfBirthInput(
                                dateOfBirth: format,
                              ),
                            );
                          }
                        },
                        buttonColor: primaryTeal,
                        text: 'Continue',
                      ),
                      h12,
                      Tm8MainButtonWidget(
                        onTap: () async {
                          context.maybePop();
                        },
                        buttonColor: achromatic500,
                        text: 'Back',
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
