import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/constants/validators.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/widgets/tm8_body_container_widget.dart';
import 'package:tm8/app/widgets/tm8_input_form_widget.dart';
import 'package:tm8/app/widgets/tm8_main_app_bar_scaffold_widget.dart';
import 'package:tm8/app/widgets/tm8_snack_bar_widget.dart';
import 'package:tm8/gen/assets.gen.dart';
import 'package:tm8/login/presentation/widgets/tm8_loading_overlay_widget.dart';
import 'package:tm8/profile/presentation/logic/change_password_cubit/change_password_cubit.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

@RoutePage() //CountrySettingsScreen.page
class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({
    super.key,
  });

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final changePasswordCubit = sl<ChangePasswordCubit>();
  final formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => changePasswordCubit,
      child: BlocListener<ChangePasswordCubit, ChangePasswordState>(
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
                  text: 'Password updated successfully',
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
                      final newPassword = value['newPassword']!.value;
                      final repeatPassword = value['repeatPassword']!.value;
                      if (newPassword == repeatPassword) {
                        changePasswordCubit.changePassword(
                          body: ChangePasswordInput(
                            oldPassword: value['currentPassword']!.value,
                            newPassword: newPassword,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          Tm8SnackBar.snackBar(
                            color: glassEffectColor,
                            text: 'New passwords do not match',
                            error: true,
                          ),
                        );
                      }
                    }
                  },
                  title: 'Change Password',
                  leading: true,
                  navigationPadding: screenPadding,
                  action: true,
                  actionIcon: Assets.settings.checkmark.svg(),
                  actionPadding: EdgeInsets.zero,
                ),
                body: SingleChildScrollView(
                  padding: screenPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      h12,
                      Text(
                        'Password must be at least 8 characters long, contain at least 1 capital letter and 1 number. ',
                        style: body1Regular.copyWith(
                          color: achromatic200,
                        ),
                      ),
                      h12,
                      Tm8InputFormWidget(
                        name: 'currentPassword',
                        hintText: 'Your current password',
                        labelText: 'Current password',
                        validator: passwordValidator,
                        obscureText: true,
                        suffixIcon: [
                          Assets.common.notVisible.path,
                          Assets.common.visible.path,
                        ],
                      ),
                      h12,
                      Tm8InputFormWidget(
                        name: 'newPassword',
                        hintText: 'Set new password',
                        labelText: 'Set new password',
                        validator: passwordValidator,
                        obscureText: true,
                        suffixIcon: [
                          Assets.common.notVisible.path,
                          Assets.common.visible.path,
                        ],
                      ),
                      h12,
                      Tm8InputFormWidget(
                        name: 'repeatPassword',
                        hintText: 'Repeat new password',
                        labelText: 'Repeat new password',
                        validator: passwordValidator,
                        obscureText: true,
                        suffixIcon: [
                          Assets.common.notVisible.path,
                          Assets.common.visible.path,
                        ],
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
