import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/router/router.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/widgets/tm8_body_container_widget.dart';
import 'package:tm8/app/widgets/tm8_drop_down_widget.dart';
import 'package:tm8/app/widgets/tm8_error_widget.dart';
import 'package:tm8/app/widgets/tm8_game_preferences_slider_widget.dart';
import 'package:tm8/app/widgets/tm8_game_preferences_widget.dart';
import 'package:tm8/app/widgets/tm8_main_app_bar_scaffold_widget.dart';
import 'package:tm8/app/widgets/tm8_main_button_widget.dart';
import 'package:tm8/app/widgets/tm8_snack_bar_widget.dart';
import 'package:tm8/gen/assets.gen.dart';
import 'package:tm8/login/presentation/widgets/tm8_loading_overlay_widget.dart';
import 'package:tm8/onboarding_preferences/presentation/logic/add_preferences_cubit/add_preferences_cubit.dart';
import 'package:tm8/onboarding_preferences/presentation/logic/set_rocket_league_preferences_cubit/set_rocket_league_preferences_cubit.dart';
import 'package:tm8/onboarding_preferences/presentation/logic/onboarding_preferences_cubit/onboarding_preferences_cubit.dart';
import 'package:tm8/onboarding_preferences/presentation/logic/set_apex_legends_preferences_cubit/set_apex_legends_preferences_cubit.dart';
import 'package:tm8/onboarding_preferences/presentation/logic/set_call_of_duty_preferences_cubit/set_call_of_duty_preferences_cubit.dart';
import 'package:tm8/onboarding_preferences/presentation/logic/set_fortnite_preferences_cubit/set_fortnite_preferences_cubit.dart';
import 'package:tm8/onboarding_preferences/presentation/logic/unfocus_drop_down_cubit/unfocus_drop_down_cubit.dart';
import 'package:tm8/onboarding_preferences/presentation/widgets/onboarding_asset_game_widget.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

@RoutePage() //AddGamesPreferencesRoute.page
class AddGamesPreferencesScreen extends StatefulWidget {
  const AddGamesPreferencesScreen({
    super.key,
    required this.selectedGames,
  });

  final List<String> selectedGames;

  @override
  State<AddGamesPreferencesScreen> createState() =>
      _AddGamesPreferencesScreenState();
}

// this class is responsible for the UI of the AddGamesPreferencesScreen
// if receives the selected preferences from bE which are then displayed dynamically on the screen
class _AddGamesPreferencesScreenState extends State<AddGamesPreferencesScreen> {
  final onboardingPreferencesCubit = sl<OnboardingPreferencesCubit>();
  final unfocusDropDownCubit = sl<UnfocusDropDownCubit>();
  final setCallOfDutyPreferencesCubit = sl<SetCallOfDutyPreferencesCubit>();
  final setFortnitePreferencesCubit = sl<SetFortnitePreferencesCubit>();
  final setApexLegendsPreferencesCubit = sl<SetApexLegendsPreferencesCubit>();
  final setRocketLeaguePreferencesCubit = sl<SetRocketLeaguePreferencesCubit>();
  final addPreferencesCubit = sl<AddPreferencesCubit>();
  var preferencesMap = <String, dynamic>{};

  @override
  void initState() {
    super.initState();
    onboardingPreferencesCubit.onboardingPreferencesGet(
      game: widget.selectedGames.first,
      index: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Portal(
      child: LoaderOverlay(
        useDefaultLoading: false,
        overlayWidgetBuilder: (progress) {
          return Tm8LoadingOverlayWidget(progress: progress);
        },
        overlayColor: Colors.transparent,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => onboardingPreferencesCubit,
            ),
            BlocProvider(
              create: (context) => unfocusDropDownCubit,
            ),
            BlocProvider(
              create: (context) => setCallOfDutyPreferencesCubit,
            ),
            BlocProvider(
              create: (context) => addPreferencesCubit,
            ),
            BlocProvider(
              create: (context) => setFortnitePreferencesCubit,
            ),
            BlocProvider(
              create: (context) => setApexLegendsPreferencesCubit,
            ),
            BlocProvider(
              create: (context) => setRocketLeaguePreferencesCubit,
            ),
          ],
          child: MultiBlocListener(
            listeners: [
              BlocListener<SetCallOfDutyPreferencesCubit,
                  SetCallOfDutyPreferencesState>(
                listener: (context, state) {
                  state.whenOrNull(
                    loading: () {
                      context.loaderOverlay.show();
                    },
                    loaded: (gameDateResponse, index) {
                      context.loaderOverlay.hide();
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        Tm8SnackBar.snackBar(
                          color: glassEffectColor,
                          text:
                              'Successfully added preferences for Call of Duty',
                          error: false,
                        ),
                      );
                      if (index != widget.selectedGames.length - 1) {
                        onboardingPreferencesCubit.onboardingPreferencesGet(
                          game: widget.selectedGames[index + 1],
                          index: index + 1,
                        );
                      } else {
                        context.router.pushAndPopUntil(
                          const HomePageRoute(),
                          predicate: (_) => false,
                        );
                      }
                      addPreferencesCubit.reset();
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
              BlocListener<SetFortnitePreferencesCubit,
                  SetFortnitePreferencesState>(
                listener: (context, state) {
                  state.whenOrNull(
                    loading: () {
                      context.loaderOverlay.show();
                    },
                    loaded: (gameDateResponse, index) {
                      context.loaderOverlay.hide();
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        Tm8SnackBar.snackBar(
                          color: glassEffectColor,
                          text: 'Successfully added preferences for Fortnite',
                          error: false,
                        ),
                      );
                      if (index != widget.selectedGames.length - 1) {
                        onboardingPreferencesCubit.onboardingPreferencesGet(
                          game: widget.selectedGames[index + 1],
                          index: index + 1,
                        );
                      } else {
                        context.router.pushAndPopUntil(
                          const HomePageRoute(),
                          predicate: (_) => false,
                        );
                      }
                      addPreferencesCubit.reset();
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
              BlocListener<SetApexLegendsPreferencesCubit,
                  SetApexLegendsPreferencesState>(
                listener: (context, state) {
                  state.whenOrNull(
                    loading: () {
                      context.loaderOverlay.show();
                    },
                    loaded: (gameDateResponse, index) {
                      context.loaderOverlay.hide();
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        Tm8SnackBar.snackBar(
                          color: glassEffectColor,
                          text:
                              'Successfully added preferences for Apex Legends',
                          error: false,
                        ),
                      );
                      if (index != widget.selectedGames.length - 1) {
                        onboardingPreferencesCubit.onboardingPreferencesGet(
                          game: widget.selectedGames[index + 1],
                          index: index + 1,
                        );
                      } else {
                        context.router.pushAndPopUntil(
                          const HomePageRoute(),
                          predicate: (_) => false,
                        );
                      }
                      addPreferencesCubit.reset();
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
              BlocListener<SetRocketLeaguePreferencesCubit,
                  SetRocketLeaguePreferencesState>(
                listener: (context, state) {
                  state.whenOrNull(
                    loading: () {
                      context.loaderOverlay.show();
                    },
                    loaded: (gameDateResponse, index) {
                      context.loaderOverlay.hide();
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        Tm8SnackBar.snackBar(
                          color: glassEffectColor,
                          text:
                              'Successfully added preferences for Rocket League',
                          error: false,
                        ),
                      );
                      if (index != widget.selectedGames.length - 1) {
                        onboardingPreferencesCubit.onboardingPreferencesGet(
                          game: widget.selectedGames[index + 1],
                          index: index + 1,
                        );
                      } else {
                        context.router.pushAndPopUntil(
                          const HomePageRoute(),
                          predicate: (_) => false,
                        );
                      }
                      addPreferencesCubit.reset();
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
              BlocListener<AddPreferencesCubit, Map<String, dynamic>>(
                listener: (context, state) {
                  preferencesMap = state;
                },
              ),
            ],
            child: Tm8BodyContainerWidget(
              child: GestureDetector(
                onTap: () {
                  unfocusDropDownCubit.unfocus();
                },
                child: Scaffold(
                  appBar: Tm8MainAppBarScaffoldWidget(
                    leading: true,
                    title: 'Set preferences',
                    navigationPadding: screenPadding,
                  ),
                  body: Padding(
                    padding: screenPadding,
                    child: CustomScrollView(
                      slivers: [
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, i) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  BlocBuilder<OnboardingPreferencesCubit,
                                      OnboardingPreferencesState>(
                                    builder: (context, state) {
                                      return state.when(
                                        initial: SizedBox.new,
                                        loading: () {
                                          return _buildLoadingOnboardingPreferences();
                                        },
                                        loaded: (inputResponse, game, index) {
                                          return _buildLoadedPreferencesSettings(
                                            game,
                                            inputResponse,
                                            index,
                                          );
                                        },
                                        error: (error, game, index) {
                                          return Tm8ErrorWidget(
                                            onTapRetry: () {
                                              onboardingPreferencesCubit
                                                  .onboardingPreferencesGet(
                                                game: game,
                                                index: index,
                                              );
                                            },
                                            error: error,
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                            childCount: 1,
                          ),
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

  Skeletonizer _buildLoadingOnboardingPreferences() {
    return Skeletonizer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          h12,
          OnboardingAssetGameWidget(
            gameName: 'Apex Legends',
            assetImage: Assets.games.apexLegendsIcon.path,
          ),
          h24,
          Tm8GamePreferencesWidget(
            selected: (value) {},
            cascadeSelected: (value) {},
            mainPreference: 'Playing',
            choice: GamePreferenceInputResponseType.select,
            choices: List.generate(
              3,
              (index) => const SelectOptionResponse(
                display: 'loading',
                attribute: SelectOptionResponseAttribute.advanced,
              ),
            ),
          ),
          h24,
          Tm8GamePreferencesWidget(
            selected: (value) {},
            cascadeSelected: (value) {},
            mainPreference: 'Settings',
            choice: GamePreferenceInputResponseType.select,
            choices: List.generate(
              4,
              (index) => const SelectOptionResponse(
                display: 'loading',
                attribute: SelectOptionResponseAttribute.advanced,
              ),
            ),
          ),
          h24,
          Tm8GamePreferencesWidget(
            selected: (value) {},
            cascadeSelected: (value) {},
            mainPreference: 'Testing',
            choice: GamePreferenceInputResponseType.select,
            choices: List.generate(
              6,
              (index) => const SelectOptionResponse(
                display: 'loading',
                attribute: SelectOptionResponseAttribute.advanced,
              ),
            ),
          ),
          h24,
          Tm8GamePreferencesSliderWidget(
            onChanged: (values, index) {},
            mainPreference: 'Loading',
            titles: List.generate(
              3,
              (index) => const SliderOptionResponse(
                minValue: 'loading',
                maxValue: 'loading',
                attribute: SliderOptionResponseAttribute.advanced,
              ),
            ),
          ),
          h24,
          Tm8MainButtonWidget(
            onTap: () {},
            buttonColor: primaryTeal,
            text: 'Continue',
          ),
          h12,
          Tm8MainButtonWidget(
            onTap: () {},
            buttonColor: achromatic500,
            text: 'Skip',
          ),
        ],
      ),
    );
  }

  Column _buildLoadedPreferencesSettings(
    String game,
    List<GamePreferenceInputResponse> inputResponse,
    int index,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        h12,
        OnboardingAssetGameWidget(
          gameName: statusMapName[game]!,
          assetImage: statusMapImage[game]!,
        ),
        h24,
        for (final item in inputResponse)
          if (item.type == GamePreferenceInputResponseType.select ||
              item.type == GamePreferenceInputResponseType.multiSelect) ...[
            Tm8GamePreferencesWidget(
              selected: (value) {
                unfocusDropDownCubit.unfocus();
                if (item.type == GamePreferenceInputResponseType.multiSelect) {
                  addPreferencesCubit.addToMap(
                    name: item.title,
                    valueListString: [value.value ?? ''],
                    gameName: game,
                  );
                } else {
                  addPreferencesCubit.addToMap(
                    name: item.title,
                    valueString: value.value,
                    gameName: game,
                  );
                }
              },
              cascadeSelected: (value) {
                unfocusDropDownCubit.unfocus();
                final cascade = item.selectOptions!
                    .firstWhere((element) => element.cascade != null)
                    .cascade;
                if (cascade != null) {
                  if (cascade.type ==
                      GamePreferenceInputResponseType.multiSelect) {
                    addPreferencesCubit.addToMap(
                      name: cascade.title,
                      valueListString: [value.value ?? ''],
                      gameName: game,
                    );
                  } else {
                    addPreferencesCubit.addToMap(
                      name: cascade.title,
                      valueString: value.value,
                      gameName: game,
                    );
                  }
                }
              },
              mainPreference: item.title,
              choice: item.type,
              choices: item.selectOptions!,
            ),
            h24,
          ] else if (item.type == GamePreferenceInputResponseType.slider) ...[
            Tm8GamePreferencesSliderWidget(
              onChanged: (value, index) {
                unfocusDropDownCubit.unfocus();
                addPreferencesCubit.addToMap(
                  name: item.sliderOptions![index].attribute.value ?? '',
                  valueDouble: value,
                  gameName: game,
                );
              },
              mainPreference: item.title,
              titles: item.sliderOptions!,
            ),
            h24,
          ] else ...[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                item.title,
                style: heading4Regular.copyWith(
                  color: achromatic100,
                ),
              ),
            ),
            h12,
            Tm8DropDownWidget(
              dropDownSelection: (selected) {
                addPreferencesCubit.addToMap(
                  name: item.title,
                  valueString: item.dropdownOptions!
                      .where((element) => element.display == selected)
                      .first
                      .attribute,
                  gameName: game,
                );
              },
              categories: _changeDropDownOptions(
                item.dropdownOptions!,
              ),
              followerAlignment: Alignment.center,
              selectedItem: '',
              hintText: 'Please select rank',
            ),
            h24,
          ],
        h24,
        Tm8MainButtonWidget(
          onTap: () {
            for (var item in inputResponse) {
              if (item.sliderOptions != null) {
                if (item.sliderOptions!.isEmpty) {
                  if (!preferencesMap[game].containsKey(item.title)) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      Tm8SnackBar.snackBar(
                        color: glassEffectColor,
                        text: 'Not all fields are selected',
                        error: true,
                      ),
                    );
                    return;
                  } else {
                    //cascade option validation
                    if (item.selectOptions != null) {
                      final selectedItem = preferencesMap[game][item.title]!;
                      if (item.type ==
                          GamePreferenceInputResponseType.multiSelect) {
                        for (var mainItem in selectedItem) {
                          final mainOption = item.selectOptions!
                              .where(
                                (element) =>
                                    element.attribute.value == mainItem,
                              )
                              .firstOrNull;
                          if (mainOption != null) {
                            if (mainOption.cascade != null) {
                              final cascade = mainOption.cascade;
                              if (!preferencesMap[game]
                                  .containsKey(cascade!.title)) {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  Tm8SnackBar.snackBar(
                                    color: glassEffectColor,
                                    text: 'Not all fields are selected',
                                    error: true,
                                  ),
                                );
                                return;
                              }
                            }
                          }
                        }
                      } else if (item.type ==
                          GamePreferenceInputResponseType.select) {
                        final mainOption = item.selectOptions!
                            .where(
                              (element) =>
                                  element.attribute.value == selectedItem,
                            )
                            .firstOrNull;
                        if (mainOption != null) {
                          if (mainOption.cascade != null) {
                            final cascade = mainOption.cascade;
                            if (!preferencesMap[game]
                                .containsKey(cascade!.title)) {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              ScaffoldMessenger.of(context).showSnackBar(
                                Tm8SnackBar.snackBar(
                                  color: glassEffectColor,
                                  text: 'Not all fields are selected',
                                  error: true,
                                ),
                              );
                              return;
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
            if (game == 'call-of-duty') {
              setCallOfDutyPreferencesCubit.setCallOfDutyPreferences(
                map: preferencesMap,
                index: index,
                game: game,
                added: false,
              );
            } else if (game == 'fortnite') {
              setFortnitePreferencesCubit.setFortnitePreferences(
                map: preferencesMap,
                index: index,
                game: game,
                added: false,
              );
            } else if (game == 'apex-legends') {
              setApexLegendsPreferencesCubit.setApexLegendsPreferences(
                map: preferencesMap,
                index: index,
                game: game,
                added: false,
              );
            } else if (game == 'rocket-league') {
              setRocketLeaguePreferencesCubit.setRocketLeaguePreferences(
                map: preferencesMap,
                index: index,
                game: game,
                added: false,
              );
            }
          },
          buttonColor: primaryTeal,
          text: 'Continue',
        ),
        h12,
        Tm8MainButtonWidget(
          onTap: () {
            if (index != widget.selectedGames.length - 1) {
              onboardingPreferencesCubit.onboardingPreferencesGet(
                game: widget.selectedGames[index + 1],
                index: index + 1,
              );
            } else {
              context.maybePop();
            }
          },
          buttonColor: achromatic500,
          text: 'Cancel',
        ),
      ],
    );
  }

  List<String> _changeDropDownOptions(List<DropdownOptionResponse> items) {
    final mainDisplayItems = <String>[];
    for (final item in items) {
      mainDisplayItems.add(item.display);
    }
    return mainDisplayItems;
  }

  final Map<String, String> statusMapImage = {
    'apex-legends': Assets.games.apexLegendsIcon.path,
    'fortnite': Assets.games.fortniteIcon.path,
    'call-of-duty': Assets.games.callOfDutyIcon.path,
    'rocket-league': Assets.games.rocketLeagueIcon.path,
  };

  final Map<String, String> statusMapName = {
    'apex-legends': 'Apex Legends',
    'fortnite': 'Fortnite',
    'call-of-duty': 'Call of Duty',
    'rocket-league': 'Rocket League',
  };
}
