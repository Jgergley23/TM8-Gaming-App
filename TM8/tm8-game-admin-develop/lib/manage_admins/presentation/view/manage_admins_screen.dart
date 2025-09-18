import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tm8_game_admin/app/constants/constants.dart';
import 'package:tm8_game_admin/app/constants/fonts.dart';
import 'package:tm8_game_admin/app/constants/palette.dart';
import 'package:tm8_game_admin/app/constants/validators.dart';
import 'package:tm8_game_admin/app/services/service_locator.dart';
import 'package:tm8_game_admin/app/storage/tm8_game_admin_storage.dart';
import 'package:tm8_game_admin/app/widgets/tm8_alert_dialog_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_drop_down_form_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_error_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_input_form_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_logout_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_main_button_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_pagination_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_search_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_snack_bar.dart';
import 'package:tm8_game_admin/gen/assets.gen.dart';
import 'package:tm8_game_admin/manage_admins/presentation/logic/add_admin_cubit/add_admin_cubit.dart';
import 'package:tm8_game_admin/manage_admins/presentation/logic/delete_admin_cubit/delete_admin_cubit.dart';
import 'package:tm8_game_admin/manage_admins/presentation/logic/manage_admins_cubit/manage_admins_cubit.dart';
import 'package:tm8_game_admin/manage_admins/presentation/logic/selected_admin_row_cubit/selected_admin_row_cubit.dart';
import 'package:tm8_game_admin/manage_admins/presentation/widgets/tm8_manage_admins_table_widget.dart';
import 'package:tm8_game_admin/manage_users/presentation/logic/table_on_hover_cubit/table_on_hover_cubit.dart';
import 'package:tm8_game_admin/notifications/presentation/widgets/filter_empty_result_widget.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

class ManageAdminsScreen extends StatefulWidget {
  const ManageAdminsScreen({super.key});

  @override
  State<ManageAdminsScreen> createState() => _ManageAdminsScreenState();
}

class _ManageAdminsScreenState extends State<ManageAdminsScreen> {
  int page = 1;
  int rowSize = 10;
  String? sort;
  String? search;
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String? search) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      context.read<ManageAdminsCubit>().fetchAdminsData(
            filters: AdminsTableDataFilters(
              page: 1,
              rowSize: rowSize,
              search: search,
              sort: sort,
            ),
          );
      context.read<SelectedAdminRowCubit>().addRemoveAllAdmins(
        value: false,
        selectedAdminId: [],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ManageAdminsCubit, ManageAdminsState>(
          listener: (context, state) {
            state.whenOrNull(
              loaded: (adminResponse, message, filters) {
                page = filters.page;
                rowSize = filters.rowSize;
                sort = filters.sort;
                search = filters.search;
              },
            );
          },
        ),
        BlocListener<AddAdminCubit, AddAdminState>(
          listener: (context, state) {
            state.whenOrNull(
              loaded: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  Tm8SnackBar.snackBar(
                    color: achromatic600,
                    text: 'Admin added successfully',
                    textColor: achromatic100,
                    button: false,
                  ),
                );
                context.read<ManageAdminsCubit>().fetchAdminsData(
                      filters: AdminsTableDataFilters(
                        page: page,
                        rowSize: rowSize,
                        search: search,
                        sort: sort,
                      ),
                    );
                context.read<SelectedAdminRowCubit>().addRemoveAllAdmins(
                  value: false,
                  selectedAdminId: [],
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
        BlocListener<DeleteAdminCubit, DeleteAdminState>(
          listener: (context, state) {
            state.whenOrNull(
              loaded: () {
                context
                    .read<TableOnHoverCubit>()
                    .changeHoverState(isHover: false, index: 0);
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
      child: Portal(
        child: Scaffold(
          body: Center(
            child: ListView(
              padding: screenPadding,
              children: [
                const Tm8LogoutWidget(),
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
                          'Admins',
                          style: heading1Regular.copyWith(color: achromatic100),
                        ),
                        h4,
                        BlocBuilder<ManageAdminsCubit, ManageAdminsState>(
                          builder: (context, state) {
                            return state.maybeWhen(
                              loading: (len) {
                                return const Skeletonizer(
                                  child: Text('Loading...'),
                                );
                              },
                              loaded: (
                                adminResponse,
                                message,
                                filters,
                              ) {
                                return Text(
                                  '${adminResponse.meta.itemCount} admins',
                                  style: body2Regular.copyWith(
                                    color: achromatic200,
                                  ),
                                );
                              },
                              orElse: SizedBox.new,
                            );
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Wrap(
                        runSpacing: 12,
                        spacing: 8,
                        children: [
                          BlocBuilder<SelectedAdminRowCubit, List<String>>(
                            builder: (context, state) {
                              if (state.length > 1) {
                                return Tm8MainButtonWidget(
                                  onPressed: () {
                                    tm8PopUpDialogWidget(
                                      context,
                                      padding: 24,
                                      width: 360,
                                      borderRadius: 20,
                                      popup: _deleteAdminPopUp(
                                        context,
                                        state,
                                      ),
                                    );
                                  },
                                  buttonColor: errorColor,
                                  text: 'Delete (${state.length})',
                                  width: 100,
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
                            width: 270,
                          ),
                          Tm8MainButtonWidget(
                            onPressed: () {
                              if (sl<Tm8GameAdminStorage>().userRole ==
                                  'admin') {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  Tm8SnackBar.snackBar(
                                    color: achromatic600,
                                    text:
                                        'You do not have permission to add new admin',
                                    textColor: achromatic100,
                                    button: false,
                                    width: 400,
                                  ),
                                );
                              } else {
                                tm8PopUpDialogWidget(
                                  context,
                                  padding: 24,
                                  width: 360,
                                  borderRadius: 20,
                                  popup: _buildAddNewAdminPopUp(context),
                                );
                              }
                            },
                            buttonColor: primaryTeal,
                            text: 'New admin',
                            asset: Assets.common.plus.path,
                            assetColor: achromatic100,
                            width: 120,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                h24,
                BlocBuilder<ManageAdminsCubit, ManageAdminsState>(
                  builder: (context, state) {
                    return state.when(
                      initial: SizedBox.new,
                      loading: (len) {
                        return _buildLoadingAdminsTable(len);
                      },
                      loaded: (adminResponse, message, filters) {
                        return _buildLoadedAdminsTable(
                          adminResponse,
                          message,
                          context,
                        );
                      },
                      error: (error) {
                        return Tm8ErrorWidget(
                          onTapRetry: () {
                            context.read<ManageAdminsCubit>().fetchAdminsData(
                                  filters: AdminsTableDataFilters(
                                    page: page,
                                    rowSize: rowSize,
                                  ),
                                );
                          },
                          error: error,
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

  FormBuilder _buildAddNewAdminPopUp(BuildContext context) {
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
                'Add new admin',
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
          Tm8InputFormWidget(
            name: 'name',
            hintText: 'Enter full name',
            validator: nameValidator,
            labelText: 'Full Name',
            width: 320,
            inputFormatters: [
              FirstLetterUpperCaseTextFormatter(),
              FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z\s]+$')),
            ],
          ),
          h8,
          Tm8InputFormWidget(
            name: 'email',
            hintText: 'Enter email',
            validator: emailValidator,
            labelText: 'Email address',
            width: 320,
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
                    final name = state.fields['name']!.value;
                    final email = state.fields['email']!.value;
                    context.read<AddAdminCubit>().addAdmin(
                          body: CreateAdminInput(
                            fullName: name,
                            email: email,
                          ),
                        );
                    Navigator.of(context).pop();
                  }
                },
                buttonColor: primaryTeal,
                text: 'Add',
                width: 150,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Skeletonizer _buildLoadingAdminsTable(int len) {
    return Skeletonizer(
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Tm8ManageAdminsTableWidget(
            onRowPressed: (value) {},
            onSortAscending: (value) {},
            onSortDescending: (value) {},
            onActionRowPressed: (value) {},
            sort: sort,
            items: List.generate(
              len,
              (index) => UserResponse(
                id: '89723730712370213921',
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
              Tm8MainAdminRow(
                name: 'Name',
                sort: true,
                key: 'name',
              ),
              Tm8MainAdminRow(
                name: 'Email address',
                sort: true,
                key: 'email',
              ),
              Tm8MainAdminRow(
                name: 'ID',
                sort: true,
                key: '_id',
              ),
              Tm8MainAdminRow(
                name: 'Role',
                sort: false,
                key: 'role',
              ),
              Tm8MainAdminRow(
                name: 'Last login',
                sort: true,
                key: 'lastLogin',
              ),
            ],
          ),
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

  ListView _buildLoadedAdminsTable(
    UserPaginatedResponse adminResponse,
    String? message,
    BuildContext context,
  ) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Tm8ManageAdminsTableWidget(
          onRowPressed: (value) {},
          onSortAscending: (value) {
            _sortAscending(value, context);
          },
          onSortDescending: (value) {
            _sortDescending(value, context);
          },
          onActionRowPressed: (value) {
            tm8PopUpDialogWidget(
              context,
              padding: 24,
              width: 360,
              borderRadius: 20,
              popup: _deleteAdminPopUp(context, [value.id]),
            );
          },
          sort: sort,
          items: adminResponse.items,
          columnNames: const [
            Tm8MainAdminRow(
              name: 'Name',
              key: 'name',
              sort: true,
            ),
            Tm8MainAdminRow(
              name: 'Email address',
              sort: true,
              key: 'email',
            ),
            Tm8MainAdminRow(
              name: 'ID',
              sort: true,
              key: '_id',
            ),
            Tm8MainAdminRow(
              name: 'Role',
              sort: false,
              key: 'role',
            ),
            Tm8MainAdminRow(
              name: 'Last login',
              sort: true,
              key: 'lastLogin',
            ),
          ],
        ),
        if (message != null) ...[
          h8,
          FilterEmptyResultWidget(
            message: message,
          ),
          h20,
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
                    context.read<ManageAdminsCubit>().fetchAdminsData(
                          filters: AdminsTableDataFilters(
                            page: page,
                            rowSize: int.parse(value),
                            sort: sort,
                            search: search,
                          ),
                        );
                    context.read<SelectedAdminRowCubit>().addRemoveAllAdmins(
                      value: false,
                      selectedAdminId: [],
                    );
                  },
                  mainCategory: adminResponse.meta.limit.toString(),
                  width: 75,
                  selectedItem: adminResponse.meta.limit.toString(),
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
                  if (value <= adminResponse.meta.pageCount) {
                    context.read<ManageAdminsCubit>().fetchAdminsData(
                          filters: AdminsTableDataFilters(
                            page: value,
                            rowSize: rowSize,
                            sort: sort,
                            search: search,
                          ),
                        );
                    context.read<SelectedAdminRowCubit>().addRemoveAllAdmins(
                      value: false,
                      selectedAdminId: [],
                    );
                  }
                }
              },
              meta: adminResponse.meta,
            ),
          ],
        ),
      ],
    );
  }

  Column _deleteAdminPopUp(BuildContext context, List<String> ids) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Delete ${ids.length > 1 ? '(${ids.length})' : ''} admin${ids.length > 1 ? 's' : ''}',
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
          'Are you sure you want to delete ${ids.length > 1 ? 'these' : 'this'} admin${ids.length > 1 ? 's' : ''}?',
          style: body1Regular.copyWith(color: achromatic200),
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
                context.read<ManageAdminsCubit>().fakeDeletedAdmin(ids: ids);
                context.read<SelectedAdminRowCubit>().addRemoveAllAdmins(
                  value: false,
                  selectedAdminId: [],
                );
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                      Tm8SnackBar.snackBar(
                        onPressed: () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        },
                        color: achromatic600,
                        text: 'Admin deleted successfully',
                        textColor: achromatic100,
                        button: true,
                        buttonText: 'Undo',
                        width: 320,
                        buttonStyle: body2Bold.copyWith(color: achromatic100),
                        duration: 4,
                      ),
                    )
                    .closed
                    .then((reason) {
                  if (reason == SnackBarClosedReason.timeout) {
                    context.read<DeleteAdminCubit>().deleteAdmin(
                          body: DeleteUsersInput(userIds: ids),
                        );
                  } else {
                    context.read<ManageAdminsCubit>().fetchAdminsData(
                          filters: AdminsTableDataFilters(
                            page: page,
                            rowSize: rowSize,
                            sort: sort,
                            search: search,
                          ),
                        );
                  }
                });
                Navigator.of(context).pop();
              },
              buttonColor: errorColor,
              text: 'Delete',
              width: 150,
            ),
          ],
        ),
      ],
    );
  }

  void _sortDescending(String value, BuildContext context) {
    final mainValue = value;
    final oppositeValue = value.replaceFirst('-', '+');
    if (sort != null) {
      if (sort!.contains(mainValue)) {
        sort = sort!.replaceAll(',$mainValue', '');
        sort = sort!.replaceAll(mainValue, '');
      } else if (sort!.contains(oppositeValue)) {
        sort = sort!.replaceAll(oppositeValue, mainValue);
      } else {
        sort = '${sort!},$mainValue';
      }
      if (sort == '') {
        sort = null;
      } else if (sort!.substring(0, 1) == ',') {
        sort = sort!.substring(1);
      }
    } else {
      sort = mainValue;
    }

    if (sort == '') {
      sort = null;
    }

    if (sort != null) {
      if (sort!.startsWith(',')) {
        sort = sort!.replaceFirst(',', '');
      }
      if (sort!.endsWith(',')) {
        sort = sort!.substring(0, sort!.length - 1);
      }
    }
    context.read<ManageAdminsCubit>().fetchAdminsData(
          filters: AdminsTableDataFilters(
            page: page,
            rowSize: rowSize,
            sort: sort,
            search: search,
          ),
        );
    context.read<SelectedAdminRowCubit>().addRemoveAllAdmins(
      value: false,
      selectedAdminId: [],
    );
  }

  void _sortAscending(String value, BuildContext context) {
    final mainValue = value;
    final oppositeValue = value.replaceFirst('+', '-');
    if (sort != null) {
      if (sort!.contains(mainValue)) {
        sort = sort!.replaceAll(',$mainValue', '');
        sort = sort!.replaceAll(mainValue, '');
      } else if (sort!.contains(oppositeValue)) {
        sort = sort!.replaceAll(oppositeValue, mainValue);
      } else {
        sort = '${sort!},$mainValue';
      }
      if (sort == '') {
        sort = null;
      } else if (sort!.substring(0, 1) == ',') {
        sort = sort!.substring(1);
      }
    } else {
      sort = mainValue;
    }

    if (sort != null) {
      if (sort!.startsWith(',')) {
        sort = sort!.replaceFirst(',', '');
      }
      if (sort!.endsWith(',')) {
        sort = sort!.substring(0, sort!.length - 1);
      }
    }
    context.read<ManageAdminsCubit>().fetchAdminsData(
          filters: AdminsTableDataFilters(
            page: page,
            rowSize: rowSize,
            sort: sort,
            search: search,
          ),
        );
    context.read<SelectedAdminRowCubit>().addRemoveAllAdmins(
      value: false,
      selectedAdminId: [],
    );
  }
}
