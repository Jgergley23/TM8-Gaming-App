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
class EditGamesPreferencesScreen extends StatefulWidget {
  const EditGamesPreferencesScreen({
    super.key,
    required this.selectedGame,
  });

  final UserGameDataResponse selectedGame;

  @override
  State<EditGamesPreferencesScreen> createState() =>
      _EditGamesPreferencesScreenState();
}

class _EditGamesPreferencesScreenState
    extends State<EditGamesPreferencesScreen> {
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
      game: widget.selectedGame.game.value ?? '',
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
                              'Successfully edited preferences for Call of Duty',
                          error: false,
                        ),
                      );

                      context.router.pushAndPopUntil(
                        const HomePageRoute(),
                        predicate: (_) => false,
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
                          text: 'Successfully edited preferences for Fortnite',
                          error: false,
                        ),
                      );

                      context.router.pushAndPopUntil(
                        const HomePageRoute(),
                        predicate: (_) => false,
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
                              'Successfully edited preferences for Apex Legends',
                          error: false,
                        ),
                      );

                      context.router.pushAndPopUntil(
                        const HomePageRoute(),
                        predicate: (_) => false,
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
                              'Successfully edited preferences for Rocket League',
                          error: false,
                        ),
                      );

                      context.router.pushAndPopUntil(
                        const HomePageRoute(),
                        predicate: (_) => false,
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
              ),
              BlocListener<AddPreferencesCubit, Map<String, dynamic>>(
                listener: (context, state) {
                  preferencesMap = state;
                },
              ),
              BlocListener<OnboardingPreferencesCubit,
                  OnboardingPreferencesState>(
                listener: (context, state) {
                  state.whenOrNull(
                    loaded: (inputResponse, game, index) {
                      _preferencesMapSelection(inputResponse);
                    },
                  );
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
                    title: 'Edit preferences',
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
                                            widget.selectedGame.preferences,
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

// this function is used to map the preferences to the preferencesMap
// which is then passed to widgets so that the preferences can be edited, and displayed correctly
  void _preferencesMapSelection(
    List<GamePreferenceInputResponse> inputResponse,
  ) {
    preferencesMap = {
      widget.selectedGame.game.value!: {},
    };
    for (final item in widget.selectedGame.preferences) {
      for (final mainItem in item.values) {
        if (mainItem.numericValue != null) {
          preferencesMap[widget.selectedGame.game.value][mainItem.key] =
              mainItem.numericValue;
        } else {
          var element =
              inputResponse.where((element) => element.title == item.title);
          //cascade logic
          if (element.isEmpty) {
            for (final input in inputResponse) {
              for (final inputCascade in input.selectOptions!) {
                if (inputCascade.cascade != null) {
                  final cascadeOptions = inputCascade.cascade;
                  if (cascadeOptions!.title == item.title) {
                    if (cascadeOptions.type ==
                        GamePreferenceInputResponseType.multiSelect) {
                      if (preferencesMap[widget.selectedGame.game.value]
                              [item.title] !=
                          null) {
                        preferencesMap[widget.selectedGame.game.value]
                                [item.title] =
                            preferencesMap[widget.selectedGame.game.value]
                                    [item.title] +
                                [mainItem.key];
                      } else {
                        preferencesMap[widget.selectedGame.game.value]
                            [item.title] = [mainItem.key];
                      }
                    } else {
                      preferencesMap[widget.selectedGame.game.value]
                          [item.title] = mainItem.key;
                    }
                  }
                }
              }
            }
          } else {
            if (element.first.type ==
                GamePreferenceInputResponseType.multiSelect) {
              if (preferencesMap[widget.selectedGame.game.value][item.title] !=
                  null) {
                preferencesMap[widget.selectedGame.game.value][item.title] =
                    preferencesMap[widget.selectedGame.game.value][item.title] +
                        [mainItem.key];
              } else {
                preferencesMap[widget.selectedGame.game.value]
                    [item.title] = [mainItem.key];
              }
            } else {
              preferencesMap[widget.selectedGame.game.value][item.title] =
                  mainItem.key;
            }
          }
        }
      }
    }
    addPreferencesCubit.addWholeMap(
      preferences: preferencesMap,
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
    List<GamePreferenceResponse> gameAddedPreferences,
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
              selectedPreference: _selectedPreferencesSelector(
                gameAddedPreferences: gameAddedPreferences,
                item: item,
              ),
              cascadeSelectedPreference: _selectedCascadePreferencesSelector(
                gameAddedPreferences: gameAddedPreferences,
                item: item,
              ),
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
              selectedPreference: _selectedPreferences(
                gameAddedPreferences: gameAddedPreferences,
                item: item,
              ),
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
              selectedItem: gameAddedPreferences
                      .where((element) => element.title == item.title)
                      .isNotEmpty
                  ? gameAddedPreferences
                          .where((element) => element.title == item.title)
                          .first
                          .values
                          .first
                          .selectedValue ??
                      ''
                  : '',
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
                index: 0,
                game: game,
                added: true,
              );
            } else if (game == 'fortnite') {
              setFortnitePreferencesCubit.setFortnitePreferences(
                map: preferencesMap,
                index: 0,
                game: game,
                added: true,
              );
            } else if (game == 'apex-legends') {
              setApexLegendsPreferencesCubit.setApexLegendsPreferences(
                map: preferencesMap,
                index: 0,
                game: game,
                added: true,
              );
            } else if (game == 'rocket-league') {
              setRocketLeaguePreferencesCubit.setRocketLeaguePreferences(
                map: preferencesMap,
                index: 0,
                game: game,
                added: true,
              );
            }
          },
          buttonColor: primaryTeal,
          text: 'Continue',
        ),
        h12,
        Tm8MainButtonWidget(
          onTap: () {
            context.maybePop();
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
  List<double> _selectedPreferences({
    required GamePreferenceInputResponse item,
    required List<GamePreferenceResponse> gameAddedPreferences,
  }) {
    final selectedPreferences = <double>[];

    final index = gameAddedPreferences
        .indexWhere((element) => element.title == item.title);

    for (final slider in item.sliderOptions!) {
      final gamePref = gameAddedPreferences[index]
          .values
          .where((element) => element.key == slider.attribute.value);
      selectedPreferences.add(
        gamePref.isNotEmpty ? gamePref.first.numericValue ?? 3 : 3,
      );
    }

    return selectedPreferences;
  }

  List<String> _selectedPreferencesSelector({
    required GamePreferenceInputResponse item,
    required List<GamePreferenceResponse> gameAddedPreferences,
  }) {
    final selectedPreferences = <String>[];

    final gamePref =
        gameAddedPreferences.where((element) => element.title == item.title);

    for (final item in gamePref) {
      if (item.values.isNotEmpty) {
        for (final mainItem in item.values) {
          selectedPreferences.add(mainItem.selectedValue ?? '');
        }
      }
    }

    return selectedPreferences;
  }
}

List<String> _selectedCascadePreferencesSelector({
  required GamePreferenceInputResponse item,
  required List<GamePreferenceResponse> gameAddedPreferences,
}) {
  final selectedPreferences = <String>[];

  final gamePref =
      item.selectOptions!.where((element) => element.cascade != null);

  if (gamePref.isNotEmpty) {
    for (final item in gamePref) {
      final mainItem = gameAddedPreferences
          .where((element) => element.title == item.cascade!.title);
      if (mainItem.isNotEmpty) {
        for (var item in mainItem.first.values) {
          selectedPreferences.add(item.selectedValue ?? '');
        }
      }
    }
  }

  return selectedPreferences;
}

extension StringExtension on String {
  String capitalize() {
    return this[0].toUpperCase() + substring(1);
  }
}
