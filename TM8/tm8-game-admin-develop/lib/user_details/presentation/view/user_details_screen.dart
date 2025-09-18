import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tm8_game_admin/app/constants/constants.dart';
import 'package:tm8_game_admin/app/constants/fonts.dart';
import 'package:tm8_game_admin/app/constants/palette.dart';
import 'package:tm8_game_admin/app/constants/routing_names.dart';
import 'package:tm8_game_admin/app/constants/validators.dart';
import 'package:tm8_game_admin/app/services/service_locator.dart';
import 'package:tm8_game_admin/app/widgets/tm8_alert_dialog_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_drop_down_form_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_error_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_input_form_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_logout_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_main_button_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_main_container_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_radio_button_form_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_side_menu_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_snack_bar.dart';
import 'package:tm8_game_admin/gen/assets.gen.dart';
import 'package:tm8_game_admin/manage_users/presentation/logic/ban_users_cubit/ban_users_cubit.dart';
import 'package:tm8_game_admin/manage_users/presentation/logic/reset_users_cubit/reset_users_cubit.dart';
import 'package:tm8_game_admin/manage_users/presentation/logic/unfocus_drop_down_cubit/unfocus_drop_down_cubit.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';
import 'package:tm8_game_admin/user_details/presentation/logic/actions_controller_cubit/actions_controller_cubit.dart';
import 'package:tm8_game_admin/user_details/presentation/logic/added_games_cubit/added_games_cubit.dart';
import 'package:tm8_game_admin/user_details/presentation/logic/control_note_button_cubit/control_note_button_cubit.dart';
import 'package:tm8_game_admin/user_details/presentation/logic/fetch_user_reports_cubit/fetch_user_reports_cubit.dart';
import 'package:tm8_game_admin/user_details/presentation/logic/fetch_warnings_cubit/fetch_warnings_cubit.dart';
import 'package:tm8_game_admin/user_details/presentation/logic/send_user_notes_cubit/send_user_notes_cubit.dart';
import 'package:tm8_game_admin/user_details/presentation/logic/send_user_warning_cubit/send_user_warning_cubit.dart';
import 'package:tm8_game_admin/user_details/presentation/logic/suspend_user_cubit/suspend_user_cubit.dart';
import 'package:tm8_game_admin/user_details/presentation/logic/user_details_cubit/user_details_cubit.dart';
import 'package:tm8_game_admin/user_details/presentation/widgets/game_container_widget.dart';
import 'package:tm8_game_admin/user_details/presentation/widgets/main_user_details_widget.dart';
import 'package:tm8_game_admin/user_details/presentation/widgets/tm8_notes_input_widget.dart';
import 'package:tm8_game_admin/user_details/presentation/widgets/user_details_actions_widget.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key, required this.userId});

  final String userId;

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final List<UserWarningTypeResponse> mainUserWarnings = [];
  final UnfocusDropDownCubit unfocusDropDownCubit = sl<UnfocusDropDownCubit>();
  final FetchWarningsCubit fetchWarningsCubit = sl<FetchWarningsCubit>()
    ..fetchWarnings();
  final TextEditingController controller = TextEditingController();
  var notes = '';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => unfocusDropDownCubit,
      child: Scaffold(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Tm8SideMenuWidget(
              pageIndex: (value) {
                if (value == 0) {
                  context.beamBack();
                } else if (value == 1) {
                  if (controller.text == notes) {
                    context.beamToNamed(
                      notifications,
                    );
                  } else {
                    tm8PopUpDialogWidget(
                      context,
                      padding: 24,
                      width: 360,
                      borderRadius: 20,
                      barrierDismissible: false,
                      popup: _buildChangesUnsavedPopUp(
                        context: context,
                        onSaved: () {
                          context
                              .read<ControlNoteButtonCubit>()
                              .changeButtonState(false);
                          context.read<SendUserNotesCubit>().sendUserNotes(
                                notes: UserNoteInput(note: controller.text),
                                userId: widget.userId,
                              );
                        },
                        onDiscard: () {
                          context.beamToNamed(
                            notifications,
                          );
                        },
                      ),
                    );
                  }
                } else {
                  if (controller.text == notes) {
                    context.beamToNamed(
                      manageAdmins,
                    );
                  } else {
                    tm8PopUpDialogWidget(
                      context,
                      padding: 24,
                      width: 360,
                      borderRadius: 20,
                      barrierDismissible: false,
                      popup: _buildChangesUnsavedPopUp(
                        context: context,
                        onSaved: () {
                          context
                              .read<ControlNoteButtonCubit>()
                              .changeButtonState(false);
                          context.read<SendUserNotesCubit>().sendUserNotes(
                                notes: UserNoteInput(note: controller.text),
                                userId: widget.userId,
                              );
                        },
                        onDiscard: () {
                          context.beamToNamed(
                            notifications,
                          );
                        },
                      ),
                    );
                  }
                }
              },
              currentIndex: 0,
            ),
            MultiBlocListener(
              listeners: [
                BlocListener<SendUserWarningCubit, SendUserWarningState>(
                  listener: (context, state) {
                    state.whenOrNull(
                      error: (error) {
                        context
                            .read<ActionsControllerCubit>()
                            .changeControllerState(true);
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
                ),
                BlocListener<SuspendUserCubit, SuspendUserState>(
                  listener: (context, state) {
                    state.whenOrNull(
                      loaded: (users) {
                        context
                            .read<UserDetailsCubit>()
                            .fetchUserDetails(userId: widget.userId);
                      },
                      error: (error) {
                        context
                            .read<ActionsControllerCubit>()
                            .changeControllerState(true);
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
                ),
                BlocListener<BanUsersCubit, BanUsersState>(
                  listener: (context, state) {
                    state.whenOrNull(
                      loaded: (users, undo, note, rowAction) {
                        context
                            .read<UserDetailsCubit>()
                            .fetchUserDetails(userId: widget.userId);
                      },
                      error: (error) {
                        context
                            .read<ActionsControllerCubit>()
                            .changeControllerState(true);
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
                ),
                BlocListener<ResetUserCubit, ResetUserState>(
                  listener: (context, state) {
                    state.whenOrNull(
                      loaded: (users, undo, note, rowAction) {
                        context
                            .read<UserDetailsCubit>()
                            .fetchUserDetails(userId: widget.userId);
                      },
                      error: (error) {
                        context
                            .read<ActionsControllerCubit>()
                            .changeControllerState(true);
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
                ),
                BlocListener<UserDetailsCubit, UserDetailsState>(
                  listener: (context, state) {
                    state.whenOrNull(
                      loading: () {
                        context
                            .read<ActionsControllerCubit>()
                            .changeControllerState(true);
                      },
                      loaded: (userDetails) {
                        notes = userDetails.note ?? '';
                      },
                    );
                  },
                ),
                BlocListener<SendUserNotesCubit, SendUserNotesState>(
                  listener: (context, state) {
                    state.whenOrNull(
                      loaded: (userDetails) {
                        context
                            .read<UserDetailsCubit>()
                            .fetchUserDetails(userId: widget.userId);
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          Tm8SnackBar.snackBar(
                            color: achromatic600,
                            text: 'Successfully updated notes.',
                            textColor: achromatic100,
                            button: false,
                          ),
                        );
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
                ),
              ],
              child: Expanded(
                child: _buildUserDetails(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView _buildUserDetails(BuildContext context) {
    return ListView(
      padding: screenPadding,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                if (controller.text == notes) {
                  if (context.canBeamBack) {
                    context.beamBack();
                  } else {
                    context.beamToNamed(home);
                  }
                } else {
                  tm8PopUpDialogWidget(
                    context,
                    padding: 24,
                    width: 360,
                    borderRadius: 20,
                    barrierDismissible: false,
                    popup: _buildChangesUnsavedPopUp(
                      context: context,
                      onSaved: () {
                        context
                            .read<ControlNoteButtonCubit>()
                            .changeButtonState(false);
                        context.read<SendUserNotesCubit>().sendUserNotes(
                              notes: UserNoteInput(note: controller.text),
                              userId: widget.userId,
                            );
                      },
                      onDiscard: () {
                        if (context.canBeamBack) {
                          context.beamBack();
                        } else {
                          context.beamToNamed(home);
                        }
                      },
                    ),
                  );
                }
              },
              child: SvgPicture.asset(
                Assets.common.navigationBackArrow.path,
              ),
            ),
            const Tm8LogoutWidget(),
          ],
        ),
        h28,
        BlocBuilder<UserDetailsCubit, UserDetailsState>(
          builder: (context, state) {
            return state.when(
              initial: SizedBox.new,
              loading: () {
                return Skeletonizer(
                  child: UserDetailsActionsWidget(
                    onBanPressed: () {},
                    onSuspensionPressed: () {},
                    onWarningPressed: () {},
                    onResetPressed: () {},
                    user: UserResponse(
                      id: '',
                      email: 'email',
                      gender: UserResponseGender.male,
                      role: UserResponseRole.admin,
                      signupType: UserResponseSignupType.manual,
                      phoneNumber: 'phoneNumber',
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                      status: const UserStatusResponse(
                        type: UserStatusResponseType.active,
                      ),
                    ),
                  ),
                );
              },
              loaded: (user) {
                return UserDetailsActionsWidget(
                  onBanPressed: () {
                    tm8PopUpDialogWidget(
                      context,
                      borderRadius: 20,
                      padding: 24,
                      width: 360,
                      popup: _buildBanUserPopUp(context),
                    );
                  },
                  onSuspensionPressed: () {
                    tm8PopUpDialogWidget(
                      context,
                      borderRadius: 20,
                      padding: 24,
                      width: 360,
                      popup: _buildSuspendUserPopUp(),
                    );
                  },
                  onWarningPressed: () {
                    tm8PopUpDialogWidget(
                      context,
                      borderRadius: 20,
                      padding: 24,
                      width: 360,
                      popup: _buildWarningPopUp(context),
                    );
                  },
                  onResetPressed: () {
                    context
                        .read<ActionsControllerCubit>()
                        .changeControllerState(false);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                          Tm8SnackBar.snackBar(
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                            },
                            color: achromatic600,
                            text: 'User reset successfully.',
                            textColor: achromatic200,
                            button: true,
                            buttonText: 'Undo',
                            buttonStyle: body2Bold.copyWith(
                              color: achromatic100,
                            ),
                            duration: 4,
                          ),
                        )
                        .closed
                        .then((reason) {
                      if (reason == SnackBarClosedReason.timeout) {
                        context.read<ResetUserCubit>().resetUser(
                              userResetInput: UserResetInput(
                                userIds: [widget.userId],
                              ),
                              note: '',
                              undo: false,
                              rowAction: false,
                            );
                      } else {
                        context
                            .read<ActionsControllerCubit>()
                            .changeControllerState(true);
                      }
                    });
                  },
                  user: user,
                );
              },
              error: (message) {
                return Tm8ErrorWidget(
                  onTapRetry: () {
                    context
                        .read<UserDetailsCubit>()
                        .fetchUserDetails(userId: widget.userId);
                  },
                );
              },
            );
          },
        ),
        h24,
        Text(
          'User details',
          style: heading4Regular.copyWith(color: achromatic100),
        ),
        h16,
        BlocBuilder<UserDetailsCubit, UserDetailsState>(
          builder: (context, state) {
            return state.when(
              initial: SizedBox.new,
              loading: () {
                return _buildLoadingUserDetails();
              },
              loaded: (user) {
                return _buildLoadedUserDetails(user);
              },
              error: (message) {
                return Tm8ErrorWidget(
                  onTapRetry: () {
                    context
                        .read<UserDetailsCubit>()
                        .fetchUserDetails(userId: widget.userId);
                  },
                );
              },
            );
          },
        ),
        h16,
        _buildUserNotes(context),
        h16,
        BlocBuilder<AddedGamesCubit, AddedGamesState>(
          builder: (context, state) {
            return state.when(
              initial: SizedBox.new,
              loading: () {
                return _buildLoadingGameDetails();
              },
              loaded: (userGameDataResponse) {
                if (userGameDataResponse.isEmpty) {
                  return Center(
                    child: Text(
                      'No Game Preferences found for this user.',
                      style: body1Regular.copyWith(color: achromatic200),
                    ),
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Games added',
                        style: heading4Regular.copyWith(color: achromatic100),
                      ),
                      h16,
                      Wrap(
                        runSpacing: 16,
                        spacing: 16,
                        children: userGameDataResponse
                            .map(
                              (game) => GameContainerWidget(
                                gameData: game,
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  );
                }
              },
              error: (message) {
                if (message == 'Game preferences not found') {
                  return Center(
                    child: Text(
                      message,
                      style: body1Regular.copyWith(color: achromatic200),
                    ),
                  );
                } else {
                  return Tm8ErrorWidget(
                    error: message,
                    onTapRetry: () {
                      context
                          .read<AddedGamesCubit>()
                          .fetchUserGames(userId: widget.userId);
                    },
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }

  BlocBuilder _buildUserNotes(BuildContext context) {
    return BlocBuilder<UserDetailsCubit, UserDetailsState>(
      builder: (context, state) {
        return state.when(
          initial: SizedBox.new,
          loading: () {
            return _buildLoadingUserNotes(context);
          },
          loaded: (userDetails) {
            return _buildLoadedUserNotes(context, userDetails);
          },
          error: (String error) {
            return Tm8ErrorWidget(
              error: error,
              onTapRetry: () {
                context.read<UserDetailsCubit>().fetchUserDetails(
                      userId: widget.userId,
                    );
              },
            );
          },
        );
      },
    );
  }

  BlocBuilder _buildLoadedUserNotes(
    BuildContext context,
    UserResponse userDetails,
  ) {
    final Map<UserReportResponseReportReason, String> statusMapReasons = {
      UserReportResponseReportReason.harrasmentAndBullying:
          'User reported for harassment and bullying',
      UserReportResponseReportReason.hateSpeechOrDiscrimination:
          'User reported for hate speech or discrimination',
      UserReportResponseReportReason.inappropriateContent:
          'User reported for inappropriate content',
      UserReportResponseReportReason.privacyViolations:
          'User reported for privacy violations',
      UserReportResponseReportReason.safetyConcerns:
          'User reported for safety concerns',
      UserReportResponseReportReason.spamAndScams:
          'User reported for spam and scams',
      UserReportResponseReportReason.violationOfPlatformPolicies:
          'User reported for violation of platform policies',
      UserReportResponseReportReason.violenceOrThreats:
          'User reported for violence or threats',
    };

    return BlocBuilder<FetchUserReportsCubit, FetchUserReportsState>(
      builder: (context, state) {
        return state.when(
          initial: SizedBox.new,
          loading: () {
            return _buildLoadingUserNotes(
              context,
            );
          },
          loaded: (reports) {
            if (reports.isEmpty) {
              return _buildOnlyNotesWidget(userDetails, context);
            } else {
              return _buildNotesAndReportsWidget(
                userDetails,
                reports,
                statusMapReasons,
              );
            }
          },
          error: (error) {
            return Tm8ErrorWidget(
              onTapRetry: () {
                context
                    .read<FetchUserReportsCubit>()
                    .fetchUserReports(userId: widget.userId);
              },
            );
          },
        );
      },
    );
  }

  LayoutBuilder _buildNotesAndReportsWidget(
    UserResponse userDetails,
    List<UserReportResponse> reports,
    Map<UserReportResponseReportReason, String> statusMapReasons,
  ) {
    var key = GlobalKey();
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final isSmallScreen = maxWidth < 768;
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Text(
                    'Notes',
                    style: heading4Regular.copyWith(color: achromatic100),
                  ),
                ),
                w12,
                Expanded(
                  child: Text(
                    'Reports',
                    style: heading4Regular.copyWith(color: achromatic100),
                  ),
                ),
              ],
            ),
            h10,
            if (isSmallScreen) ...[
              _buildNarrowScreenNotesAndReports(
                key,
                userDetails,
                context,
                reports,
                statusMapReasons,
              ),
            ] else
              _buildWideScreenNotesAndReports(
                key,
                userDetails,
                context,
                reports,
                statusMapReasons,
              ),
          ],
        );
      },
    );
  }

  IntrinsicHeight _buildNarrowScreenNotesAndReports(
    GlobalKey<State<StatefulWidget>> key,
    UserResponse userDetails,
    BuildContext context,
    List<UserReportResponse> reports,
    Map<UserReportResponseReportReason, String> statusMapReasons,
  ) {
    final formKey = GlobalKey<FormBuilderState>();
    return IntrinsicHeight(
      child: FormBuilder(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                key: key,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: achromatic800,
                ),
                constraints: const BoxConstraints(
                  maxHeight: 200,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(Assets.user.notesIcon.path),
                    w12,
                    Tm8NotesInputWidget(
                      onChanged: (value) {
                        if (value != null &&
                            value.isNotEmpty &&
                            value != userDetails.note) {
                          context
                              .read<ControlNoteButtonCubit>()
                              .changeButtonState(
                                true,
                              );
                        } else {
                          context
                              .read<ControlNoteButtonCubit>()
                              .changeButtonState(
                                false,
                              );
                        }
                      },
                      name: 'note',
                      hintText: 'Add notes ...',
                      initialValue: userDetails.note,
                      validator: userNoteValidator,
                      controller: controller,
                      // containerKey: key,
                      inputFormatters: [
                        FirstLetterUpperCaseTextFormatter(),
                      ],
                    ),
                    w12,
                    BlocBuilder<ControlNoteButtonCubit, bool>(
                      builder: (context, state) {
                        return Tm8MainButtonWidget(
                          onPressed: () {
                            if (state) {
                              final state = formKey.currentState!;
                              if (state.saveAndValidate()) {
                                final note = state.fields['note']!.value
                                    .toString()
                                    .trim();
                                context
                                    .read<ControlNoteButtonCubit>()
                                    .changeButtonState(
                                      false,
                                    );
                                context
                                    .read<SendUserNotesCubit>()
                                    .sendUserNotes(
                                      userId: widget.userId,
                                      notes: UserNoteInput(note: note),
                                    );
                              }
                            }
                          },
                          buttonColor: state ? primaryTeal : achromatic600,
                          text: 'Save',
                          textColor: state ? achromatic100 : achromatic400,
                          width: 80,
                          height: 45,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            h12,
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: achromatic800,
                ),
                constraints: const BoxConstraints(
                  maxHeight: 200,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (var items in reports) ...[
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: achromatic600,
                          ),
                          child: Text(
                            '${statusMapReasons[items.reportReason] ?? ''}, by ${items.reporter}, ${DateFormat('dd/MM/yyyy @ HH:mm a').format(items.createdAt)}',
                            style: body1Regular.copyWith(
                              color: achromatic100,
                            ),
                          ),
                        ),
                        if (reports.length > 1) h12,
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IntrinsicHeight _buildWideScreenNotesAndReports(
    GlobalKey<State<StatefulWidget>> key,
    UserResponse userDetails,
    BuildContext context,
    List<UserReportResponse> reports,
    Map<UserReportResponseReportReason, String> statusMapReasons,
  ) {
    final formKey = GlobalKey<FormBuilderState>();
    return IntrinsicHeight(
      child: FormBuilder(
        key: formKey,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                key: key,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: achromatic800,
                ),
                constraints: const BoxConstraints(
                  maxHeight: 200,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(Assets.user.notesIcon.path),
                    w12,
                    Tm8NotesInputWidget(
                      onChanged: (value) {
                        if (value != null &&
                            value.isNotEmpty &&
                            value != userDetails.note) {
                          context
                              .read<ControlNoteButtonCubit>()
                              .changeButtonState(
                                true,
                              );
                        } else {
                          if (userDetails.note == null) {
                            context
                                .read<ControlNoteButtonCubit>()
                                .changeButtonState(
                                  false,
                                );
                          }
                        }
                      },
                      name: 'note',
                      hintText: 'Add notes ...',
                      initialValue: userDetails.note,
                      validator: userNoteValidator,
                      controller: controller,
                      // containerKey: key,
                      inputFormatters: [
                        FirstLetterUpperCaseTextFormatter(),
                      ],
                    ),
                    w12,
                    BlocBuilder<ControlNoteButtonCubit, bool>(
                      builder: (context, state) {
                        return Tm8MainButtonWidget(
                          onPressed: () {
                            if (state) {
                              final state = formKey.currentState!;
                              if (state.saveAndValidate()) {
                                final note = state.fields['note']!.value
                                    .toString()
                                    .trim();
                                context
                                    .read<ControlNoteButtonCubit>()
                                    .changeButtonState(
                                      false,
                                    );
                                context
                                    .read<SendUserNotesCubit>()
                                    .sendUserNotes(
                                      userId: widget.userId,
                                      notes: UserNoteInput(note: note),
                                    );
                              }
                            }
                          },
                          buttonColor: state ? primaryTeal : achromatic600,
                          text: 'Save',
                          textColor: state ? achromatic100 : achromatic400,
                          width: 80,
                          height: 45,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            w12,
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: achromatic800,
                ),
                constraints: const BoxConstraints(
                  maxHeight: 200,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (var items in reports) ...[
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: achromatic600,
                          ),
                          child: Text(
                            '${statusMapReasons[items.reportReason] ?? ''}, by ${items.reporter}, ${DateFormat('dd/MM/yyyy @ HH:mm a').format(items.createdAt)}',
                            style: body1Regular.copyWith(
                              color: achromatic100,
                            ),
                          ),
                        ),
                        if (reports.length > 1) h12,
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  FormBuilder _buildOnlyNotesWidget(
    UserResponse userDetails,
    BuildContext context,
  ) {
    final formKey = GlobalKey<FormBuilderState>();
    return FormBuilder(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Notes',
            style: heading4Regular.copyWith(color: achromatic100),
          ),
          h10,
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: achromatic800,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(Assets.user.notesIcon.path),
                w12,
                Tm8NotesInputWidget(
                  onChanged: (value) {
                    if (value != null &&
                        value.isNotEmpty &&
                        value != userDetails.note) {
                      context.read<ControlNoteButtonCubit>().changeButtonState(
                            true,
                          );
                    } else {
                      context.read<ControlNoteButtonCubit>().changeButtonState(
                            false,
                          );
                    }
                  },
                  name: 'note',
                  hintText: 'Add notes ...',
                  initialValue: userDetails.note,
                  validator: userNoteValidator,
                  controller: controller,
                  // containerKey: GlobalKey(debugLabel: 'notesKey'),
                  inputFormatters: [
                    FirstLetterUpperCaseTextFormatter(),
                  ],
                ),
                w12,
                BlocBuilder<ControlNoteButtonCubit, bool>(
                  builder: (context, state) {
                    return Tm8MainButtonWidget(
                      onPressed: () {
                        if (state) {
                          final state = formKey.currentState!;
                          if (state.saveAndValidate()) {
                            final note = state.fields['note']!.value;
                            context
                                .read<ControlNoteButtonCubit>()
                                .changeButtonState(
                                  false,
                                );
                            context.read<SendUserNotesCubit>().sendUserNotes(
                                  userId: widget.userId,
                                  notes: UserNoteInput(note: note),
                                );
                          }
                        }
                      },
                      buttonColor: state ? primaryTeal : achromatic600,
                      text: 'Save',
                      textColor: state ? achromatic100 : achromatic400,
                      width: 80,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Skeletonizer _buildLoadingUserNotes(
    BuildContext context,
  ) {
    return Skeletonizer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Notes',
            style: heading4Regular.copyWith(color: achromatic100),
          ),
          h10,
          Tm8MainContainerWidget(
            padding: 16,
            borderRadius: 20,
            width: MediaQuery.of(context).size.width * 0.9,
            content: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(Assets.user.notesIcon.path),
                w12,
                Tm8InputFormWidget(
                  onChanged: (value) {},
                  name: 'note',
                  hintText: 'Add notes ...',
                  initialValue: '',
                  validator: userNoteValidator,
                  width: MediaQuery.of(context).size.width * 0.6,
                  inputFormatters: [
                    FirstLetterUpperCaseTextFormatter(),
                  ],
                ),
                w12,
                BlocBuilder<ControlNoteButtonCubit, bool>(
                  builder: (context, state) {
                    return Tm8MainButtonWidget(
                      onPressed: () {},
                      buttonColor: state ? primaryTeal : achromatic600,
                      text: 'Save',
                      textColor: state ? achromatic100 : achromatic400,
                      width: 80,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  FormBuilder _buildBanUserPopUp(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    return FormBuilder(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ban User',
                style: heading2Regular.copyWith(
                  color: achromatic100,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: SvgPicture.asset(
                  Assets.common.close.path,
                ),
              ),
            ],
          ),
          h16,
          Text(
            'If you ban this user, they will lose access to TM8 until you reset their account. ',
            style: body1Regular.copyWith(
              color: achromatic200,
            ),
          ),
          h16,
          Text(
            'Provide a note about why you banned this user:',
            style: body1Regular.copyWith(
              color: achromatic200,
            ),
          ),
          h4,
          Tm8InputFormWidget(
            name: 'note',
            hintText: 'Add note...',
            validator: noteValidator,
            maxLines: 2,
            width: 400,
            inputFormatters: [
              FirstLetterUpperCaseTextFormatter(),
            ],
          ),
          h16,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Tm8MainButtonWidget(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                buttonColor: achromatic600,
                text: 'Cancel',
                width: 150,
              ),
              Tm8MainButtonWidget(
                onPressed: () {
                  final state = formKey.currentState!;
                  if (state.saveAndValidate()) {
                    Navigator.of(context).pop();
                    final note = state.fields['note']!.value;
                    context
                        .read<ActionsControllerCubit>()
                        .changeControllerState(false);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                          Tm8SnackBar.snackBar(
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                            },
                            color: achromatic600,
                            text: 'User banned successfully.',
                            textColor: achromatic200,
                            button: true,
                            buttonText: 'Undo',
                            buttonStyle: body2Bold.copyWith(
                              color: achromatic100,
                            ),
                            duration: 4,
                            width: 320,
                          ),
                        )
                        .closed
                        .then((reason) {
                      if (reason == SnackBarClosedReason.timeout) {
                        context.read<BanUsersCubit>().banUser(
                              userBanInput: UserBanInput(
                                userIds: [widget.userId],
                                note: note,
                              ),
                              undo: false,
                              rowAction: false,
                            );
                      } else {
                        context
                            .read<ActionsControllerCubit>()
                            .changeControllerState(true);
                      }
                    });
                  }
                },
                buttonColor: errorColor,
                text: 'Ban',
                width: 150,
              ),
            ],
          ),
        ],
      ),
    );
  }

  FormBuilder _buildSuspendUserPopUp() {
    final formKey = GlobalKey<FormBuilderState>();
    return FormBuilder(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Suspend user',
                style: heading2Regular.copyWith(
                  color: achromatic100,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: SvgPicture.asset(
                  Assets.common.close.path,
                ),
              ),
            ],
          ),
          h16,
          Text(
            'If you suspend this user, they will lose access to TM8 for a length of time you choose.',
            style: body1Regular.copyWith(
              color: achromatic200,
            ),
          ),
          h16,
          Tm8RadioButtonWidget(
            name: 'radio',
            options: [
              FormBuilderFieldOption(
                value: 1,
                child: Text(
                  'Suspend for 7 days',
                  style: body1Regular.copyWith(color: achromatic100),
                ),
              ),
              FormBuilderFieldOption(
                value: 2,
                child: Text(
                  'Suspend for 30 days',
                  style: body1Regular.copyWith(color: achromatic100),
                ),
              ),
              FormBuilderFieldOption(
                value: 3,
                child: Text(
                  'Suspend for 3 months',
                  style: body1Regular.copyWith(color: achromatic100),
                ),
              ),
            ],
            width: 450,
          ),
          h16,
          Tm8InputFormWidget(
            name: 'note',
            hintText: 'Add note...',
            validator: noteValidator,
            maxLines: 2,
            width: 400,
            labelText: 'Provide a note about why you are suspending this user:',
            inputFormatters: [
              FirstLetterUpperCaseTextFormatter(),
            ],
          ),
          h16,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Tm8MainButtonWidget(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                buttonColor: achromatic600,
                text: 'Cancel',
                width: 150,
              ),
              Tm8MainButtonWidget(
                onPressed: () {
                  final state = formKey.currentState!;
                  if (state.saveAndValidate()) {
                    final note = state.fields['note']!.value;
                    final radio = state.fields['radio']!.value;
                    final until = _getUntilDate(radio);
                    Navigator.of(context).pop();
                    context
                        .read<ActionsControllerCubit>()
                        .changeControllerState(false);
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                          Tm8SnackBar.snackBar(
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                            },
                            color: achromatic600,
                            text: 'User suspended successfully.',
                            textColor: achromatic200,
                            button: true,
                            buttonText: 'Undo',
                            buttonStyle: body2Bold.copyWith(
                              color: achromatic100,
                            ),
                            duration: 4,
                            width: 320,
                          ),
                        )
                        .closed
                        .then((reason) {
                      if (reason == SnackBarClosedReason.timeout) {
                        context.read<SuspendUserCubit>().suspendUser(
                              userSuspendInput: UserSuspendInput(
                                userIds: [widget.userId],
                                note: note,
                                until: until,
                              ),
                            );
                      } else {
                        context
                            .read<ActionsControllerCubit>()
                            .changeControllerState(true);
                      }
                    });
                  }
                },
                buttonColor: errorColor,
                text: 'Suspend',
                width: 150,
              ),
            ],
          ),
        ],
      ),
    );
  }

  DateTime _getUntilDate(radio) {
    final now = DateTime.now();
    switch (radio) {
      case 1:
        return DateTime(now.year, now.month, now.day + 7);
      case 2:
        return DateTime(now.year, now.month, now.day + 30);
      case 3:
        return DateTime(now.year, now.month + 3, now.day);
      default:
        return DateTime(now.year, now.month, now.day + 7);
    }
  }

  Portal _buildWarningPopUp(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    var dropDownValue = '';

    return Portal(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => fetchWarningsCubit,
          ),
          BlocProvider(
            create: (context) => unfocusDropDownCubit,
          ),
        ],
        child: FormBuilder(
          key: formKey,
          child: GestureDetector(
            onTap: () {
              unfocusDropDownCubit.unfocus();
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Send warning',
                      style: heading2Regular.copyWith(
                        color: achromatic100,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: SvgPicture.asset(
                        'assets/common/close.svg',
                      ),
                    ),
                  ],
                ),
                h16,
                Text(
                  'If you send the user a warning he will receive a notification.',
                  style: body1Regular.copyWith(
                    color: achromatic200,
                  ),
                ),
                h16,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Please select a warning',
                    style: body1Regular.copyWith(color: achromatic200),
                  ),
                ),
                h4,
                BlocBuilder<FetchWarningsCubit, FetchWarningsState>(
                  builder: (context, state) {
                    return state.when(
                      initial: SizedBox.new,
                      loading: () {
                        return Skeletonizer(
                          child: Tm8DropDownFormWidget(
                            dropDownSelection: (value) {},
                            width: 400,
                            mainCategory: 'Warning 1',
                            categories: List.generate(
                              3,
                              (index) => 'Warning ${index + 1}',
                            ),
                            itemKeys: List.generate(
                              3,
                              (index) => 'Warning ${index + 1}',
                            ),
                            selectedItem: 'Warning 1',
                            followerAlignment: Alignment.topCenter,
                            isScrollable: true,
                          ),
                        );
                      },
                      loaded: (userWarnings, failedValidation) {
                        return Tm8DropDownFormWidget(
                          dropDownSelection: (value) {
                            final mainValue = userWarnings.firstWhere(
                              (element) => element.name == value,
                            );
                            dropDownValue = mainValue.key.name;
                          },
                          width: 400,
                          mainCategory: userWarnings.first.name,
                          categories: List.generate(
                            userWarnings.length,
                            (index) => userWarnings[index].name,
                          ),
                          itemKeys: List.generate(
                            userWarnings.length,
                            (index) => userWarnings[index].name,
                          ),
                          selectedItem: userWarnings.first.name,
                          followerAlignment: Alignment.topCenter,
                          isScrollable: true,
                          failedValidation: failedValidation,
                          hintText: 'Select warning...',
                        );
                      },
                      error: (error) {
                        return Tm8ErrorWidget(
                          error: error,
                          onTapRetry: () {
                            context.read<FetchWarningsCubit>().fetchWarnings();
                          },
                        );
                      },
                    );
                  },
                ),
                h8,
                Tm8InputFormWidget(
                  name: 'note',
                  hintText: 'Add note...',
                  validator: noteValidator,
                  maxLines: 2,
                  width: 400,
                  labelText: 'Add notes',
                  inputFormatters: [
                    FirstLetterUpperCaseTextFormatter(),
                  ],
                ),
                h16,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Tm8MainButtonWidget(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      buttonColor: achromatic600,
                      text: 'Cancel',
                      width: 150,
                    ),
                    Tm8MainButtonWidget(
                      onPressed: () {
                        final state = formKey.currentState!;
                        if (state.saveAndValidate()) {
                          final note = state.fields['note']!.value.toString();
                          if (dropDownValue != '') {
                            context
                                .read<ActionsControllerCubit>()
                                .changeControllerState(false);
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                                  Tm8SnackBar.snackBar(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                    },
                                    color: achromatic600,
                                    text: 'Warning sent successfully.',
                                    textColor: achromatic200,
                                    button: true,
                                    buttonText: 'Undo',
                                    buttonStyle: body2Bold.copyWith(
                                      color: achromatic100,
                                    ),
                                    duration: 4,
                                  ),
                                )
                                .closed
                                .then((reason) {
                              if (reason == SnackBarClosedReason.timeout) {
                                context
                                    .read<SendUserWarningCubit>()
                                    .sendUserWarning(
                                      userWarningInput: UserWarningInput(
                                        userIds: [widget.userId],
                                        note: note,
                                        warning: UserWarningInputWarning.values
                                            .firstWhere(
                                          (element) =>
                                              element.name == dropDownValue,
                                        ),
                                      ),
                                    );
                              } else {
                                context
                                    .read<ActionsControllerCubit>()
                                    .changeControllerState(true);
                              }
                            });
                          } else {
                            fetchWarningsCubit.reEmitted();
                          }
                        } else {
                          fetchWarningsCubit.reEmitted();
                        }
                      },
                      buttonColor: primaryTeal,
                      text: 'Send warning',
                      width: 150,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Skeletonizer _buildLoadingGameDetails() {
    return Skeletonizer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Games added',
            style: heading4Regular.copyWith(color: achromatic100),
          ),
          h16,
          Wrap(
            runSpacing: 16,
            spacing: 16,
            children: [
              GameContainerWidget(
                gameData: UserGameDataResponse(
                  id: 'id',
                  user: widget.userId,
                  game: UserGameDataResponseGame.fortnite,
                  preferences: List.generate(
                    3,
                    (index) => const GamePreferenceResponse(
                      key: 'loading',
                      title: 'Loading',
                      values: [
                        GamePreferenceValueResponse(
                          key: '',
                          selectedValue: 'loading',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GameContainerWidget(
                gameData: UserGameDataResponse(
                  id: 'id',
                  user: widget.userId,
                  game: UserGameDataResponseGame.rocketLeague,
                  preferences: List.generate(
                    5,
                    (index) => const GamePreferenceResponse(
                      key: 'loading',
                      title: 'Loading',
                      values: [
                        GamePreferenceValueResponse(
                          key: '',
                          selectedValue: 'loading',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GameContainerWidget(
                gameData: UserGameDataResponse(
                  id: 'id',
                  user: widget.userId,
                  game: UserGameDataResponseGame.apexLegends,
                  preferences: List.generate(
                    3,
                    (index) => const GamePreferenceResponse(
                      key: 'loading',
                      title: 'Loading',
                      values: [
                        GamePreferenceValueResponse(
                          key: '',
                          selectedValue: 'loading',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GameContainerWidget(
                gameData: UserGameDataResponse(
                  id: 'id',
                  user: widget.userId,
                  game: UserGameDataResponseGame.callOfDuty,
                  preferences: List.generate(
                    5,
                    (index) => const GamePreferenceResponse(
                      key: 'loading',
                      title: 'Loading',
                      values: [
                        GamePreferenceValueResponse(
                          key: '',
                          selectedValue: 'loading',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  MainUserDetailsWidget _buildLoadedUserDetails(UserResponse user) {
    return MainUserDetailsWidget(
      user: user,
    );
  }

  Skeletonizer _buildLoadingUserDetails() {
    return Skeletonizer(
      child: MainUserDetailsWidget(
        user: UserResponse(
          id: '',
          username: 'testing username',
          email: 'test@gmail.cm',
          gender: UserResponseGender.male,
          role: UserResponseRole.user,
          signupType: UserResponseSignupType.manual,
          phoneNumber: '+380000000000',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          status: const UserStatusResponse(type: UserStatusResponseType.active),
          rating: const UserRatingResponse(
            average: 1,
            ratings: [1],
          ),
        ),
      ),
    );
  }

  Column _buildChangesUnsavedPopUp({
    required BuildContext context,
    required VoidCallback onSaved,
    required VoidCallback onDiscard,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Changes unsaved',
              style: heading2Regular.copyWith(
                color: achromatic100,
              ),
            ),
            InkWell(
              onTap: () {
                onDiscard();
                Navigator.of(context).pop();
              },
              child: SvgPicture.asset(
                Assets.common.close.path,
              ),
            ),
          ],
        ),
        h16,
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Do you want to discard the changes you made in notes?',
            style: body1Regular.copyWith(
              color: achromatic200,
            ),
          ),
        ),
        h16,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Tm8MainButtonWidget(
              onPressed: () {
                onDiscard();
                Navigator.of(context).pop();
              },
              buttonColor: achromatic600,
              text: "Don't save",
              width: 150,
            ),
            Tm8MainButtonWidget(
              onPressed: () {
                onSaved();
                Navigator.of(context).pop();
              },
              buttonColor: primaryTeal,
              text: 'Save',
              width: 150,
            ),
          ],
        ),
      ],
    );
  }
}
