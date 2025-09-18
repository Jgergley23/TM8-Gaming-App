import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/constants/validators.dart';
import 'package:tm8/app/router/router.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/widgets/tm8_body_container_widget.dart';
import 'package:tm8/app/widgets/tm8_input_form_widget.dart';
import 'package:tm8/app/widgets/tm8_main_app_bar_scaffold_widget.dart';
import 'package:tm8/app/widgets/tm8_snack_bar_widget.dart';
import 'package:tm8/gen/assets.gen.dart';
import 'package:tm8/login/presentation/widgets/tm8_loading_overlay_widget.dart';
import 'package:tm8/profile/presentation/logic/update_user_email_cubit/update_user_email_cubit.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

@RoutePage() //ChangeEmailSettingsRoute.page
class ChangeEmailSettingsScreen extends StatefulWidget {
  const ChangeEmailSettingsScreen({super.key});

  @override
  State<ChangeEmailSettingsScreen> createState() =>
      _ChangeEmailSettingsScreenState();
}

class _ChangeEmailSettingsScreenState extends State<ChangeEmailSettingsScreen> {
  final updateUserEmailCubit = sl<UpdateUserEmailCubit>();
  final formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => updateUserEmailCubit,
      child: LoaderOverlay(
        useDefaultLoading: false,
        overlayWidgetBuilder: (progress) {
          return Tm8LoadingOverlayWidget(progress: progress);
        },
        overlayColor: Colors.transparent,
        child: BlocListener<UpdateUserEmailCubit, UpdateUserEmailState>(
          listener: (context, state) {
            state.whenOrNull(
              loading: () {
                context.loaderOverlay.show();
              },
              loaded: () {
                context.loaderOverlay.hide();
                context.pushRoute(const ChangeEmailVerifySettingsRoute());
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
              child: Scaffold(
                appBar: Tm8MainAppBarScaffoldWidget(
                  onActionPressed: () {
                    final state = formKey.currentState!;
                    if (state.saveAndValidate()) {
                      updateUserEmailCubit.updateEmail(
                        body: ChangeEmailInput(
                          email: state.value['email'],
                        ),
                      );
                    }
                  },
                  title: 'Edit Email address',
                  leading: true,
                  navigationPadding: screenPadding,
                  action: true,
                  actionIcon: Assets.settings.checkmark.svg(),
                  actionPadding: EdgeInsets.zero,
                ),
                body: Padding(
                  padding: screenPadding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      h12,
                      Tm8InputFormWidget(
                        name: 'email',
                        hintText: 'New email address',
                        labelText: 'New email address',
                        validator: emailValidator,
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
