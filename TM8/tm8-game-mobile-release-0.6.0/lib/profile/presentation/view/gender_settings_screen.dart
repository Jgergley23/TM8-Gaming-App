import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/widgets/tm8_body_container_widget.dart';
import 'package:tm8/app/widgets/tm8_main_app_bar_scaffold_widget.dart';
import 'package:tm8/app/widgets/tm8_radio_button_widget.dart';
import 'package:tm8/app/widgets/tm8_snack_bar_widget.dart';
import 'package:tm8/gen/assets.gen.dart';
import 'package:tm8/login/presentation/widgets/tm8_loading_overlay_widget.dart';
import 'package:tm8/profile/presentation/logic/update_user_info_cubit/update_user_info_cubit.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

@RoutePage() //GenderSettingsRoute.page
class GenderSettingsScreen extends StatefulWidget {
  const GenderSettingsScreen({super.key, required this.gender});

  final String? gender;

  @override
  State<GenderSettingsScreen> createState() => _GenderSettingsScreenState();
}

class _GenderSettingsScreenState extends State<GenderSettingsScreen> {
  final updateUserInfoCubit = sl<UpdateUserInfoCubit>();
  final formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => updateUserInfoCubit,
      child: BlocListener<UpdateUserInfoCubit, UpdateUserInfoState>(
        listener: (context, state) {
          state.whenOrNull(
            loading: () {
              context.loaderOverlay.show();
            },
            loaded: () {
              context.loaderOverlay.hide();
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.maybePop();
              });
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                Tm8SnackBar.snackBar(
                  color: glassEffectColor,
                  text: 'Gender updated successfully',
                  error: false,
                ),
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
        child: LoaderOverlay(
          useDefaultLoading: false,
          overlayWidgetBuilder: (progress) {
            return Tm8LoadingOverlayWidget(progress: progress);
          },
          overlayColor: Colors.transparent,
          child: Tm8BodyContainerWidget(
            child: FormBuilder(
              key: formKey,
              child: Scaffold(
                appBar: Tm8MainAppBarScaffoldWidget(
                  onActionPressed: () {
                    final state = formKey.currentState!;
                    if (state.saveAndValidate()) {
                      final value = state.fields;
                      final gender = value['radio']!.value;
                      updateUserInfoCubit.updatedGender(
                        body: ChangeUserInfoInput(
                          gender: gender,
                        ),
                      );
                    }
                  },
                  title: 'Gender',
                  leading: true,
                  navigationPadding: const EdgeInsets.only(top: 12, left: 12),
                  action: true,
                  actionIcon: Assets.settings.checkmark.svg(),
                  actionPadding: EdgeInsets.zero,
                ),
                body: Padding(
                  padding: screenPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Tm8RadioButtonWidget(
                        name: 'radio',
                        options: [
                          FormBuilderFieldOption(
                            value: 'female',
                            child: Text(
                              'Female',
                              style:
                                  body1Regular.copyWith(color: achromatic100),
                            ),
                          ),
                          FormBuilderFieldOption(
                            value: 'male',
                            child: Text(
                              'Male',
                              style:
                                  body1Regular.copyWith(color: achromatic100),
                            ),
                          ),
                          FormBuilderFieldOption(
                            value: 'non-binary',
                            child: Text(
                              'Non-binary',
                              style:
                                  body1Regular.copyWith(color: achromatic100),
                            ),
                          ),
                          FormBuilderFieldOption(
                            value: 'prefer-not-to-respond',
                            child: Text(
                              'Prefer not to respond',
                              style:
                                  body1Regular.copyWith(color: achromatic100),
                            ),
                          ),
                        ],
                        initialValue: widget.gender,
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
