import 'package:beamer/beamer.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tm8l/app/constants/constants.dart';
import 'package:tm8l/app/constants/fonts.dart';
import 'package:tm8l/app/constants/palette.dart';
import 'package:tm8l/app/constants/routing_names.dart';
import 'package:tm8l/app/constants/validators.dart';
import 'package:tm8l/landing_page/logic/send_contact_form_cubit/send_contact_form_cubit.dart';
import 'package:tm8l/landing_page/widgets/landing_page_button_widget.dart';
import 'package:tm8l/landing_page/widgets/landing_page_footer_widget.dart';
import 'package:tm8l/landing_page/widgets/tm8_checkbox_form_widget.dart';
import 'package:tm8l/landing_page/widgets/tm8_input_form_widget.dart';
import 'package:tm8l/landing_page/widgets/tm8_snack_bar_widget.dart';
import 'package:tm8l/swagger_generated_code/swagger.swagger.dart';

class ContactPageScreen extends StatefulWidget {
  const ContactPageScreen({super.key});

  @override
  State<ContactPageScreen> createState() => _ContactPageScreenState();
}

class _ContactPageScreenState extends State<ContactPageScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        final maxWidth = constrains.maxWidth;
        final isSmallScreen = maxWidth < 768;
        return BlocListener<SendContactFormCubit, SendContactFormState>(
          listener: (context, state) {
            state.whenOrNull(
              loaded: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  Tm8SnackBar.snackBar(
                    color: achromatic600,
                    text: 'Successfully sent message.',
                    textColor: achromatic100,
                    button: false,
                    duration: 4,
                  ),
                );
                _formKey.currentState?.reset();
              },
              error: (error) {
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
          child: ListView(
            children: [
              FormBuilder(
                key: _formKey,
                child: Container(
                  color: achromatic800,
                  padding: EdgeInsets.only(
                    top: isSmallScreen ? 80 : 165,
                    bottom: isSmallScreen ? 100 : 200,
                    left: isSmallScreen ? 24 : 0,
                    right: isSmallScreen ? 24 : 0,
                  ),
                  child: Center(
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 480),
                      child: Column(
                        children: [
                          Text(
                            'Get in touch',
                            style: landingPageHeading2.copyWith(
                              color: achromatic100,
                            ),
                          ),
                          h20,
                          Text(
                            'Our friendly team would love to hear from you.',
                            style: landingPageHeading3.copyWith(
                              color: achromatic200,
                            ),
                          ),
                          h48,
                          Wrap(
                            spacing: 32,
                            runSpacing: 24,
                            children: [
                              Tm8InputFormWidget(
                                name: 'firstName',
                                hintText: 'Enter First Name',
                                validator: requiredValidator,
                                labelText: 'First name (required)',
                                width: isSmallScreen ? 480 : 224,
                                inputFormatters: [
                                  FirstLetterUpperCaseTextFormatter(),
                                ],
                              ),
                              Tm8InputFormWidget(
                                name: 'lastName',
                                hintText: 'Enter Last Name',
                                validator: requiredValidator,
                                labelText: 'Last name (required)',
                                width: isSmallScreen ? 480 : 224,
                                inputFormatters: [
                                  FirstLetterUpperCaseTextFormatter(),
                                ],
                              ),
                            ],
                          ),
                          h24,
                          Tm8InputFormWidget(
                            name: 'emailAddress',
                            hintText: 'address@email.com',
                            validator: emailValidator,
                            labelText: 'Email address (required)',
                            width: 480,
                          ),
                          h24,
                          Tm8InputFormWidget(
                            name: 'message',
                            hintText: 'Enter your message here',
                            validator: messageValidator,
                            labelText: 'Your message (required)',
                            width: 480,
                            maxLines: 5,
                          ),
                          h24,
                          Tm8CheckBoxFormWidget(
                            labelText: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'You agree to our ',
                                    style: body1Regular.copyWith(
                                      color: achromatic200,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: body1Regular.copyWith(
                                      color: achromatic100,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        context.beamToNamed(privacyPolicy);
                                      },
                                  ),
                                ],
                              ),
                            ),
                            name: 'checkbox',
                            validator: checkBoxValidator,
                            width: 480,
                          ),
                          isSmallScreen ? h16 : h34,
                          BlocBuilder<SendContactFormCubit,
                              SendContactFormState>(
                            builder: (context, state) {
                              return state.when(
                                initial: () {
                                  return _buildActiveButton(context);
                                },
                                loading: () {
                                  return _buildLoadingButton(context);
                                },
                                loaded: () {
                                  return _buildActiveButton(context);
                                },
                                error: (error) {
                                  return _buildActiveButton(context);
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              isSmallScreen ? h20 : h64,
              LandingPageFooterWidget(
                onPressed: (value) {
                  if (value == 0) {
                    context.beamToNamed(home, data: value);
                  } else if (value == 1) {
                    context.beamToNamed(about, data: value);
                  } else {
                    context.beamToNamed(contact, data: value);
                  }
                },
                isSmallScreen: isSmallScreen,
                maxWidth: maxWidth,
              ),
            ],
          ),
        );
      },
    );
  }

  Skeletonizer _buildLoadingButton(BuildContext context) {
    return Skeletonizer(
      child: LandingPageButtonWidget(
        onPressed: () {},
        buttonColor: primaryTeal,
        text: 'Send message',
        width: 480,
      ),
    );
  }

  LandingPageButtonWidget _buildActiveButton(BuildContext context) {
    return LandingPageButtonWidget(
      onPressed: () {
        final state = _formKey.currentState!;
        if (state.validate()) {
          final fields = state.fields;
          context.read<SendContactFormCubit>().sendContactForm(
                body: ContactFormInput(
                  firstName: fields['firstName']!.value.toString(),
                  lastName: fields['lastName']!.value.toString(),
                  email: fields['emailAddress']!.value.toString(),
                  message: fields['message']!.value.toString(),
                ),
              );
        }
      },
      buttonColor: primaryTeal,
      text: 'Send message',
      width: 480,
    );
  }
}
