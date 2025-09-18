import 'dart:async';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tm8_game_admin/app/constants/constants.dart';
import 'package:tm8_game_admin/app/constants/fonts.dart';
import 'package:tm8_game_admin/app/constants/palette.dart';
import 'package:tm8_game_admin/app/constants/validators.dart';
import 'package:tm8_game_admin/app/widgets/tm8_alert_dialog_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_drop_down_form_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_error_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_input_form_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_logout_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_main_button_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_pagination_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_search_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_snack_bar.dart';
import 'package:tm8_game_admin/app/widgets/tm8_table_widget.dart';
import 'package:tm8_game_admin/manage_users/presentation/logic/ban_users_cubit/ban_users_cubit.dart';
import 'package:tm8_game_admin/manage_users/presentation/logic/manage_users_cubit/manage_users_cubit.dart';
import 'package:tm8_game_admin/manage_users/presentation/logic/reset_users_cubit/reset_users_cubit.dart';
import 'package:tm8_game_admin/manage_users/presentation/logic/selected_row_users/selected_row_users_cubit.dart';
import 'package:tm8_game_admin/manage_users/presentation/logic/total_users_cubit/total_users_cubit.dart';
import 'package:tm8_game_admin/manage_users/presentation/logic/unfocus_drop_down_cubit/unfocus_drop_down_cubit.dart';
import 'package:tm8_game_admin/manage_users/presentation/widgets/total_onboarding_register_widget.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

class ManageUsersScreen extends StatefulWidget {
  const ManageUsersScreen({super.key});

  @override
  State<ManageUsersScreen> createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> {
  var page = 1;
  var rowSize = 5;
  String? search;
  ApiV1UsersGetStatus? status;
  String? sort;
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String? search) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      context.read<ManageUsersCubit>().fetchTableData(
            filters: UsersTableDataFilters(
              page: 1,
              rowSize: rowSize,
              search: search,
              status: status,
              sort: sort,
            ),
          );
      context.read<SelectedRowUsersCubit>().addRemoveAllUsers(
        value: false,
        mainSelectedUsers: [],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Portal(
      child: GestureDetector(
        onTap: () {
          context.read<UnfocusDropDownCubit>().unfocus();
        },
        child: MultiBlocListener(
          listeners: [
            BlocListener<ManageUsersCubit, ManageUsersState>(
              listener: (context, state) {
                state.whenOrNull(
                  loaded: (userPaginationResponse, message, filters) {
                    page = filters.page;
                    rowSize = filters.rowSize;
                    search = filters.search;
                    status = filters.status;
                    sort = filters.sort;
                  },
                );
              },
            ),
            BlocListener<BanUsersCubit, BanUsersState>(
              listener: (context, state) {
                state.whenOrNull(
                  loaded: (userResponse, undo, note, rowAction) {
                    if (!undo) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        Tm8SnackBar.snackBar(
                          onPressed: () {
                            context.read<ResetUserCubit>().resetUser(
                                  userResetInput: UserResetInput(
                                    userIds:
                                        userResponse.map((e) => e.id).toList(),
                                  ),
                                  undo: true,
                                  note: note,
                                  rowAction: false,
                                );
                          },
                          color: achromatic600,
                          text:
                              '${userResponse.length} user${userResponse.length > 1 ? 's' : ''} has been banned',
                          textColor: achromatic200,
                          button: true,
                          buttonText: 'Undo',
                          buttonStyle: body2Bold.copyWith(color: achromatic100),
                          duration: 4,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    }
                    context.read<ManageUsersCubit>().fetchTableData(
                          filters: UsersTableDataFilters(
                            page: page,
                            rowSize: rowSize,
                            search: search,
                            status: status,
                            sort: sort,
                          ),
                        );
                    if (!rowAction) {
                      context.read<SelectedRowUsersCubit>().reEmitBanned();
                    } else {
                      context
                          .read<SelectedRowUsersCubit>()
                          .reEmitRowAction(id: userResponse.first.id);
                    }
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
            BlocListener<ResetUserCubit, ResetUserState>(
              listener: (context, state) {
                state.whenOrNull(
                  loaded: (userResponse, undo, note, rowAction) {
                    if (!undo) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context).showSnackBar(
                        Tm8SnackBar.snackBar(
                          onPressed: () {
                            context.read<BanUsersCubit>().banUser(
                                  userBanInput: UserBanInput(
                                    userIds:
                                        userResponse.map((e) => e.id).toList(),
                                    note: note,
                                  ),
                                  undo: true,
                                  rowAction: false,
                                );
                          },
                          color: achromatic600,
                          text:
                              '${userResponse.length} user${userResponse.length > 1 ? 's' : ''} reset successfully',
                          textColor: achromatic200,
                          button: true,
                          buttonText: 'Undo',
                          buttonStyle: body2Bold.copyWith(color: achromatic100),
                          duration: 4,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    }

                    context.read<ManageUsersCubit>().fetchTableData(
                          filters: UsersTableDataFilters(
                            page: page,
                            rowSize: rowSize,
                            search: search,
                            status: status,
                            sort: sort,
                          ),
                        );
                    if (!rowAction) {
                      context.read<SelectedRowUsersCubit>().reEmitReset();
                    } else {
                      context
                          .read<SelectedRowUsersCubit>()
                          .reEmitRowAction(id: userResponse.first.id);
                    }
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
          child: Scaffold(
            body: ListView(
              padding: screenPadding,
              children: [
                const Tm8LogoutWidget(),
                h24,
                Text(
                  'Users',
                  style: heading1Regular.copyWith(color: achromatic100),
                ),
                h24,
                const TotalOnboardingRegisterWidget(),
                h24,
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  runAlignment: WrapAlignment.spaceBetween,
                  runSpacing: 12,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Users',
                          style: heading4Bold.copyWith(
                            color: achromatic100,
                          ),
                        ),
                        BlocBuilder<TotalUsersCubit, TotalUsersState>(
                          builder: (context, state) {
                            return state.when(
                              initial: SizedBox.new,
                              loading: () {
                                return Skeletonizer(
                                  child: Text(
                                    '1029 users',
                                    style: body2Regular.copyWith(
                                      color: achromatic200,
                                    ),
                                  ),
                                );
                              },
                              loaded: (totalCount) {
                                return Text(
                                  '${totalCount.total} users',
                                  style: body2Regular.copyWith(
                                    color: achromatic200,
                                  ),
                                );
                              },
                              error: (error) {
                                return Tm8ErrorWidget(
                                  onTapRetry: () {
                                    context
                                        .read<TotalUsersCubit>()
                                        .fetchTotalUser();
                                  },
                                  error: error,
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    Wrap(
                      runSpacing: 12,
                      children: [
                        BlocBuilder<SelectedRowUsersCubit, List<SelectedUser>>(
                          builder: (context, state) {
                            final activeUsers = state
                                .where(
                                  (e) =>
                                      e.status ==
                                          UserStatusResponseType.active ||
                                      e.status ==
                                          UserStatusResponseType.reported,
                                )
                                .map((e) => e.id)
                                .toList()
                                .length;
                            final bannedUsers = state
                                .where(
                                  (e) =>
                                      e.status ==
                                          UserStatusResponseType.banned ||
                                      e.status ==
                                          UserStatusResponseType.suspended,
                                )
                                .map((e) => e.id)
                                .toList()
                                .length;
                            if (state.isEmpty) {
                              return const SizedBox();
                            } else if (activeUsers > 1 && bannedUsers > 1) {
                              return Wrap(
                                runSpacing: 12,
                                children: [
                                  Tm8MainButtonWidget(
                                    onPressed: () {
                                      tm8PopUpDialogWidget(
                                        context,
                                        borderRadius: 20,
                                        padding: 24,
                                        width: 360,
                                        popup: _buildBanPopUp(
                                          state,
                                          context,
                                          activeUsers,
                                          false,
                                        ),
                                      );
                                    },
                                    buttonColor: errorColor,
                                    text: 'Ban ($activeUsers)',
                                    textColor: achromatic100,
                                    width: 100,
                                    asset: 'assets/user/user_ban.svg',
                                    assetColor: achromatic100,
                                  ),
                                  w8,
                                  Tm8MainButtonWidget(
                                    onPressed: () {
                                      context.read<ResetUserCubit>().resetUser(
                                            userResetInput: UserResetInput(
                                              userIds: state
                                                  .where(
                                                    (e) =>
                                                        e.status ==
                                                            UserStatusResponseType
                                                                .banned ||
                                                        e.status ==
                                                            UserStatusResponseType
                                                                .suspended,
                                                  )
                                                  .map((e) => e.id)
                                                  .toList(),
                                            ),
                                            undo: false,
                                            note: state
                                                    .where(
                                                      (element) =>
                                                          element.note != null,
                                                    )
                                                    .first
                                                    .note ??
                                                '',
                                            rowAction: false,
                                          );
                                    },
                                    buttonColor: primaryTeal,
                                    text: 'Reset ($bannedUsers)',
                                    textColor: achromatic100,
                                    width: 100,
                                    asset: 'assets/user/user_reset.svg',
                                    assetColor: achromatic100,
                                  ),
                                  w8,
                                ],
                              );
                            } else if (activeUsers > 1) {
                              return Wrap(
                                runSpacing: 12,
                                children: [
                                  Tm8MainButtonWidget(
                                    onPressed: () {
                                      tm8PopUpDialogWidget(
                                        context,
                                        borderRadius: 20,
                                        padding: 24,
                                        width: 360,
                                        popup: _buildBanPopUp(
                                          state,
                                          context,
                                          activeUsers,
                                          false,
                                        ),
                                      );
                                    },
                                    buttonColor: errorColor,
                                    text: 'Ban ($activeUsers)',
                                    textColor: achromatic100,
                                    width: 100,
                                    asset: 'assets/user/user_ban.svg',
                                    assetColor: achromatic100,
                                  ),
                                  w8,
                                ],
                              );
                            } else if (bannedUsers > 1) {
                              return Wrap(
                                runSpacing: 12,
                                children: [
                                  Tm8MainButtonWidget(
                                    onPressed: () {
                                      context.read<ResetUserCubit>().resetUser(
                                            userResetInput: UserResetInput(
                                              userIds: state
                                                  .where(
                                                    (e) =>
                                                        e.status ==
                                                            UserStatusResponseType
                                                                .banned ||
                                                        e.status ==
                                                            UserStatusResponseType
                                                                .suspended,
                                                  )
                                                  .map((e) => e.id)
                                                  .toList(),
                                            ),
                                            undo: false,
                                            note: state
                                                    .where(
                                                      (element) =>
                                                          element.note != null,
                                                    )
                                                    .first
                                                    .note ??
                                                '',
                                            rowAction: false,
                                          );
                                    },
                                    buttonColor: primaryTeal,
                                    text: 'Reset ($bannedUsers)',
                                    textColor: achromatic100,
                                    width: 100,
                                    asset: 'assets/user/user_reset.svg',
                                    assetColor: achromatic100,
                                  ),
                                  w8,
                                ],
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                        Tm8SearchWidget(
                          onChanged: (text) {
                            if (search != text) {
                              search = text;
                              if (text.length > 1) {
                                _onSearchChanged(search);
                              } else if (text.isEmpty) {
                                _onSearchChanged(null);
                              }
                            }
                          },
                          hintText: 'Search',
                        ),
                        w8,
                        Tm8DropDownFormWidget(
                          mainText: 'Status: ',
                          dropDownSelection: (value) {
                            _dropDownSelection(value, context);
                          },
                          mainCategory: 'All',
                          selectedItem: 'All',
                          selected: true,
                          categories: const [
                            'All',
                            'Active users',
                            'Reported users',
                            'Inactive users',
                            'Suspended',
                            'Banned',
                          ],
                          itemKeys: const [
                            'All',
                            'Active users',
                            'Reported users',
                            'Inactive users',
                            'Suspended',
                            'Banned',
                          ],
                          followerAlignment: Alignment.topCenter,
                        ),
                      ],
                    ),
                  ],
                ),
                BlocBuilder<ManageUsersCubit, ManageUsersState>(
                  builder: (context, state) {
                    return state.when(
                      initial: () => const SizedBox(),
                      loading: (rowSized) {
                        return _buildLoadingTableWidget(
                          rowSized,
                          context,
                        );
                      },
                      loaded: (
                        userPaginatedResponse,
                        message,
                        filters,
                      ) {
                        return _buildLoadedTableWidget(
                          userPaginatedResponse,
                          message,
                          context,
                        );
                      },
                      error: (error) {
                        return Center(
                          child: Column(
                            children: [
                              h40,
                              Tm8ErrorWidget(
                                onTapRetry: () {
                                  context
                                      .read<ManageUsersCubit>()
                                      .fetchTableData(
                                        filters: UsersTableDataFilters(
                                          page: 1,
                                          rowSize: rowSize,
                                          status: status,
                                          search: search,
                                          sort: sort,
                                        ),
                                      );
                                },
                                error: error,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  FormBuilder _buildBanPopUp(
    List<SelectedUser> selectedUsers,
    BuildContext context,
    int activeUsers,
    bool rowAction,
  ) {
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
                'Ban User${activeUsers > 1 ? 's' : ''} ${activeUsers > 1 ? (activeUsers) : ''}',
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
            'If you ban ${activeUsers > 1 ? 'these' : 'this'} user${activeUsers > 1 ? 's' : ''}, they will lose access to TM8 until you reset their account${activeUsers > 1 ? 's' : ''}. ',
            style: body1Regular.copyWith(
              color: achromatic200,
            ),
          ),
          h16,
          Text(
            'Provide a note about why you banned ${activeUsers > 1 ? 'these' : 'this'} user${activeUsers > 1 ? 's' : ''}:',
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
                    context.read<BanUsersCubit>().banUser(
                          userBanInput: UserBanInput(
                            userIds: selectedUsers
                                .where(
                                  (e) =>
                                      e.status ==
                                          UserStatusResponseType.active ||
                                      e.status ==
                                          UserStatusResponseType.reported,
                                )
                                .map((e) => e.id)
                                .toList(),
                            note: state.fields['note']!.value,
                          ),
                          undo: false,
                          rowAction: rowAction,
                        );
                    Navigator.of(context).pop();
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

  void _dropDownSelection(String value, BuildContext context) {
    final Map<String, ApiV1UsersGetStatus?> statusMap = {
      'All': null,
      'Active users': ApiV1UsersGetStatus.active,
      'Reported users': ApiV1UsersGetStatus.reported,
      'Inactive users': ApiV1UsersGetStatus.inactive,
      'Suspended': ApiV1UsersGetStatus.suspended,
      'Banned': ApiV1UsersGetStatus.banned,
    };
    status = statusMap[value];
    context.read<ManageUsersCubit>().fetchTableData(
          filters: UsersTableDataFilters(
            page: 1,
            rowSize: rowSize,
            search: search,
            status: status,
            sort: sort,
          ),
        );
    context.read<SelectedRowUsersCubit>().addRemoveAllUsers(
      value: false,
      mainSelectedUsers: [],
    );
  }

  ListView _buildLoadedTableWidget(
    UserPaginatedResponse userPaginatedResponse,
    String? message,
    BuildContext context,
  ) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        if (message != null) ...[
          h50,
          Center(
            child: Text(
              message,
              style: body2Regular.copyWith(
                color: achromatic200,
              ),
            ),
          ),
          h50,
        ] else ...[
          Tm8UserTableWidget(
            onRowPressed: (value) {
              context.beamToNamed('/users/$value');
            },
            onSortAscending: (value) {
              _sortAscValidation(value, context);
            },
            onSortDescending: (value) {
              _sortDescValidation(value, context);
            },
            onActionRowPressed: (value) {
              if (value.status?.type == UserStatusResponseType.active ||
                  value.status?.type == UserStatusResponseType.reported) {
                tm8PopUpDialogWidget(
                  context,
                  borderRadius: 20,
                  padding: 24,
                  width: 360,
                  popup: _buildBanPopUp(
                    [
                      SelectedUser(
                        id: value.id,
                        status:
                            value.status?.type ?? UserStatusResponseType.active,
                        note: value.status?.note ?? '',
                      ),
                    ],
                    context,
                    1,
                    true,
                  ),
                );
              } else if (value.status?.type == UserStatusResponseType.banned ||
                  value.status?.type == UserStatusResponseType.suspended) {
                context.read<ResetUserCubit>().resetUser(
                      userResetInput: UserResetInput(userIds: [value.id]),
                      undo: false,
                      note: value.status?.note ?? '',
                      rowAction: true,
                    );
              }
            },
            sort: sort,
            items: userPaginatedResponse.items,
            columnNames: const [
              Tm8MainRow(
                name: 'Username',
                sort: true,
              ),
              Tm8MainRow(
                name: 'Email address',
                sort: true,
              ),
              Tm8MainRow(
                name: 'Joined',
                sort: true,
              ),
              Tm8MainRow(
                name: 'Status',
                sort: false,
              ),
              Tm8MainRow(
                name: 'Country',
                sort: false,
              ),
            ],
          ),
        ],
        h8,
        Wrap(
          runSpacing: 12,
          alignment: WrapAlignment.spaceBetween,
          runAlignment: WrapAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Tm8DropDownFormWidget(
                  dropDownSelection: (value) {
                    context.read<ManageUsersCubit>().fetchTableData(
                          filters: UsersTableDataFilters(
                            page: 1,
                            rowSize: int.parse(value),
                            search: search,
                            status: status,
                            sort: sort,
                          ),
                        );
                    context.read<SelectedRowUsersCubit>().addRemoveAllUsers(
                      value: false,
                      mainSelectedUsers: [],
                    );
                  },
                  mainCategory: userPaginatedResponse.meta.limit.toString(),
                  width: 75,
                  selectedItem: userPaginatedResponse.meta.limit.toString(),
                  categories: const [
                    '5',
                    '10',
                    '15',
                    '20',
                  ],
                  itemKeys: const [
                    '5',
                    '10',
                    '15',
                    '20',
                  ],
                  followerAlignment: Alignment.center,
                ),
                w8,
                Text(
                  'Rows per page',
                  style: body1Regular.copyWith(
                    color: achromatic200,
                  ),
                ),
              ],
            ),
            Tm8PaginationWidget(
              onTap: (value) {
                if (value >= 1) {
                  if (value <= userPaginatedResponse.meta.pageCount) {
                    context.read<ManageUsersCubit>().fetchTableData(
                          filters: UsersTableDataFilters(
                            page: value,
                            rowSize: rowSize,
                            search: search,
                            status: status,
                            sort: sort,
                          ),
                        );
                    context.read<SelectedRowUsersCubit>().addRemoveAllUsers(
                      value: false,
                      mainSelectedUsers: [],
                    );
                  }
                }
              },
              meta: userPaginatedResponse.meta,
            ),
          ],
        ),
        if (message != null) ...[
          h100,
          h100,
        ],
      ],
    );
  }

  void _sortAscValidation(String value, BuildContext context) {
    if (value == 'Username') {
      if (sort != null) {
        if (sort!.contains('+username')) {
          sort = sort!.replaceAll('+username', '');
          if (sort == '') {
            sort = null;
          }
        } else if (sort!.contains('-username')) {
          sort = sort!.replaceAll('-username', '+username');
        } else {
          sort = '${sort!},+username';
        }
      } else {
        sort = '+username';
      }
    } else if (value == 'Email address') {
      if (sort != null) {
        if (sort!.contains('+email')) {
          sort = sort!.replaceAll('+email', '');
          if (sort == '') {
            sort = null;
          }
        } else if (sort!.contains('-email')) {
          sort = sort!.replaceAll('-email', '+email');
        } else {
          sort = '${sort!},+email';
        }
      } else {
        sort = '+email';
      }
    } else {
      if (sort != null) {
        if (sort!.contains('+createdAt')) {
          sort = sort!.replaceAll('+createdAt', '');
          if (sort == '') {
            sort = null;
          }
        } else if (sort!.contains('-createdAt')) {
          sort = sort!.replaceAll('-createdAt', '+createdAt');
        } else {
          sort = '${sort!},+createdAt';
        }
      } else {
        sort = '+createdAt';
      }
    }
    if (sort != null) {
      if (sort!.startsWith(',')) {
        sort = sort!.replaceFirst(',', '');
      }
      if (sort!.endsWith(',')) {
        sort = sort!.substring(0, sort!.length - 1);
      }
    }

    context.read<ManageUsersCubit>().fetchTableData(
          filters: UsersTableDataFilters(
            page: page,
            rowSize: rowSize,
            search: search,
            status: status,
            sort: sort,
          ),
        );
    context.read<SelectedRowUsersCubit>().addRemoveAllUsers(
      value: false,
      mainSelectedUsers: [],
    );
  }

  void _sortDescValidation(String value, BuildContext context) {
    if (value == 'Username') {
      if (sort != null) {
        if (sort!.contains('-username')) {
          sort = sort!.replaceAll('-username', '');
          if (sort == '') {
            sort = null;
          }
        } else if (sort!.contains('+username')) {
          sort = sort!.replaceAll('+username', '-username');
        } else {
          sort = '${sort!},-username';
        }
      } else {
        sort = '-username';
      }
    } else if (value == 'Email address') {
      if (sort != null) {
        if (sort!.contains('-email')) {
          sort = sort!.replaceAll('-email', '');
          if (sort == '') {
            sort = null;
          }
        } else if (sort!.contains('+email')) {
          sort = sort!.replaceAll('+email', '-email');
        } else {
          sort = '${sort!},-email';
        }
      } else {
        sort = '-email';
      }
    } else {
      if (sort != null) {
        if (sort!.contains('-createdAt')) {
          sort = sort!.replaceAll('-createdAt', '');
          if (sort == '') {
            sort = null;
          }
        } else if (sort!.contains('+createdAt')) {
          sort = sort!.replaceAll('+createdAt', '-createdAt');
        } else {
          sort = '${sort!},-createdAt';
        }
      } else {
        sort = '-createdAt';
      }
    }

    if (sort != null) {
      if (sort!.startsWith(',')) {
        sort = sort!.replaceFirst(',', '');
      }
      if (sort!.endsWith(',')) {
        sort = sort!.substring(0, sort!.length - 1);
      }
    }

    context.read<ManageUsersCubit>().fetchTableData(
          filters: UsersTableDataFilters(
            page: page,
            rowSize: rowSize,
            search: search,
            status: status,
            sort: sort,
          ),
        );
    context.read<SelectedRowUsersCubit>().addRemoveAllUsers(
      value: false,
      mainSelectedUsers: [],
    );
  }

  Skeletonizer _buildLoadingTableWidget(int rowSized, BuildContext context) {
    return Skeletonizer(
      child: Column(
        children: [
          Tm8UserTableWidget(
            items: List.generate(
              rowSized,
              (index) => UserResponse(
                id: '',
                email: 'test@gmail.com',
                gender: UserResponseGender.male,
                role: UserResponseRole.admin,
                signupType: UserResponseSignupType.manual,
                phoneNumber: '',
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
                status: const UserStatusResponse(
                  type: UserStatusResponseType.active,
                ),
              ),
            ),
            columnNames: const [
              Tm8MainRow(
                name: 'Username',
                sort: true,
              ),
              Tm8MainRow(
                name: 'Email address',
                sort: true,
              ),
              Tm8MainRow(
                name: 'Joined',
                sort: true,
              ),
              Tm8MainRow(
                name: 'Status',
                sort: false,
              ),
              Tm8MainRow(
                name: 'Country',
                sort: false,
              ),
            ],
            onSortAscending: (value) {},
            onSortDescending: (value) {},
            onRowPressed: (value) {},
            onActionRowPressed: (value) {},
          ),
          h8,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Tm8DropDownFormWidget(
                    dropDownSelection: (value) {},
                    mainCategory: '5',
                    width: 75,
                    selectedItem: '5',
                    categories: const [
                      '5',
                      '10',
                      '15',
                      '20',
                    ],
                    itemKeys: const [
                      '5',
                      '10',
                      '15',
                      '20',
                    ],
                    followerAlignment: Alignment.center,
                  ),
                  w8,
                  Text(
                    'Rows per page',
                    style: body1Regular.copyWith(
                      color: achromatic200,
                    ),
                  ),
                ],
              ),
              Tm8PaginationWidget(
                onTap: (value) {},
                meta: const PaginationMetaResponse(
                  page: 1,
                  limit: 10,
                  itemCount: 50,
                  pageCount: 5,
                  hasPreviousPage: true,
                  hasNextPage: false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
