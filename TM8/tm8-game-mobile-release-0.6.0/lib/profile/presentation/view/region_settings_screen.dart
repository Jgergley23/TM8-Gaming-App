import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/storage/tm8_storage.dart';
import 'package:tm8/app/widgets/tm8_body_container_widget.dart';
import 'package:tm8/app/widgets/tm8_main_app_bar_scaffold_widget.dart';
import 'package:tm8/app/widgets/tm8_radio_button_widget.dart';
import 'package:tm8/app/widgets/tm8_snack_bar_widget.dart';
import 'package:tm8/gen/assets.gen.dart';
import 'package:tm8/login/presentation/widgets/tm8_loading_overlay_widget.dart';
import 'package:tm8/profile/presentation/logic/update_user_info_cubit/update_user_info_cubit.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

@RoutePage() //RegionSettingsRoute.page
class RegionSettingsScreen extends StatefulWidget {
  const RegionSettingsScreen({
    super.key,
    required this.regions,
  });

  final List<String> regions;

  @override
  State<RegionSettingsScreen> createState() => _RegionSettingsScreenState();
}

class _RegionSettingsScreenState extends State<RegionSettingsScreen> {
  final formKey = GlobalKey<FormBuilderState>();
  final updateUserInfoCubit = sl<UpdateUserInfoCubit>();

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidgetBuilder: (progress) {
        return Tm8LoadingOverlayWidget(progress: progress);
      },
      overlayColor: Colors.transparent,
      child: BlocProvider(
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
                    text: 'Region updated successfully',
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
          child: Tm8BodyContainerWidget(
            child: FormBuilder(
              key: formKey,
              child: Scaffold(
                appBar: Tm8MainAppBarScaffoldWidget(
                  onActionPressed: () {
                    final state = formKey.currentState!;
                    if (state.saveAndValidate()) {
                      final value = state.fields;
                      final region = value['regions']!.value;
                      sl<Tm8Storage>().region = region;
                      updateUserInfoCubit.updateRegion(
                        body: ChangeUserInfoInput(
                          regions: [region],
                        ),
                      );
                    }
                  },
                  title: 'Region',
                  leading: true,
                  navigationPadding: const EdgeInsets.only(top: 12, left: 12),
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
                      Tm8RadioButtonWidget(
                        name: 'regions',
                        initialValue: widget.regions.isNotEmpty
                            ? regionStatus[widget.regions[0]]
                            : null,
                        options: [
                          FormBuilderFieldOption(
                            value: 'north-america',
                            child: Text(
                              'North America',
                              style:
                                  body1Regular.copyWith(color: achromatic100),
                            ),
                          ),
                          FormBuilderFieldOption(
                            value: 'south-america',
                            child: Text(
                              'South America',
                              style:
                                  body1Regular.copyWith(color: achromatic100),
                            ),
                          ),
                          FormBuilderFieldOption(
                            value: 'europe',
                            child: Text(
                              'Europe',
                              style:
                                  body1Regular.copyWith(color: achromatic100),
                            ),
                          ),
                          FormBuilderFieldOption(
                            value: 'asia',
                            child: Text(
                              'Asia',
                              style:
                                  body1Regular.copyWith(color: achromatic100),
                            ),
                          ),
                          FormBuilderFieldOption(
                            value: 'africa',
                            child: Text(
                              'Africa',
                              style:
                                  body1Regular.copyWith(color: achromatic100),
                            ),
                          ),
                          FormBuilderFieldOption(
                            value: 'australia-and-oceania',
                            child: Text(
                              'Australia and Oceania',
                              style:
                                  body1Regular.copyWith(color: achromatic100),
                            ),
                          ),
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

  final Map<String, String> regionStatus = {
    'North America': 'north-america',
    'South America': 'south-america',
    'Europe': 'europe',
    'Asia': 'asia',
    'Africa': 'africa',
    'Australia and Oceania': 'australia-and-oceania',
  };
}
