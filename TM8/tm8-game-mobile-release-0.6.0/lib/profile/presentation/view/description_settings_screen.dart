import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/constants/validators.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/widgets/tm8_body_container_widget.dart';
import 'package:tm8/app/widgets/tm8_input_form_widget.dart';
import 'package:tm8/app/widgets/tm8_main_app_bar_scaffold_widget.dart';
import 'package:tm8/app/widgets/tm8_snack_bar_widget.dart';
import 'package:tm8/gen/assets.gen.dart';
import 'package:tm8/login/presentation/widgets/tm8_loading_overlay_widget.dart';
import 'package:tm8/profile/presentation/logic/update_user_description_cubit/update_user_description_cubit.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

@RoutePage() //DescriptionSettingsRoute.page
class DescriptionSettingsScreen extends StatefulWidget {
  const DescriptionSettingsScreen({super.key, required this.description});

  final String? description;

  @override
  State<DescriptionSettingsScreen> createState() =>
      _DescriptionSettingsScreenState();
}

class _DescriptionSettingsScreenState extends State<DescriptionSettingsScreen> {
  final formKey = GlobalKey<FormBuilderState>();
  final updateDescriptionCubit = sl<UpdateUserDescriptionCubit>();
  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidgetBuilder: (progress) {
        return Tm8LoadingOverlayWidget(progress: progress);
      },
      overlayColor: Colors.transparent,
      child: BlocProvider(
        create: (context) => updateDescriptionCubit,
        child: BlocListener<UpdateUserDescriptionCubit,
            UpdateUserDescriptionState>(
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
                    text: 'Description updated successfully',
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
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Tm8BodyContainerWidget(
              child: FormBuilder(
                key: formKey,
                child: Scaffold(
                  appBar: Tm8MainAppBarScaffoldWidget(
                    onActionPressed: () {
                      final currentState = formKey.currentState;
                      if (currentState!.saveAndValidate()) {
                        final description =
                            currentState.fields['description']!.value as String;
                        if (description != widget.description) {
                          updateDescriptionCubit.updateDescription(
                            body: ChangeUserInfoInput(
                              description: description,
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            Tm8SnackBar.snackBar(
                              color: glassEffectColor,
                              text: 'Cannot update with the same description',
                              error: false,
                            ),
                          );
                        }
                      }
                    },
                    title: 'Description',
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Tm8InputFormWidget(
                          name: 'description',
                          hintText: 'Description',
                          validator: descriptionValidator,
                          labelText: 'Description',
                          initialValue: widget.description,
                          maxLines: 4,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r"\n")),
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
      ),
    );
  }
}
