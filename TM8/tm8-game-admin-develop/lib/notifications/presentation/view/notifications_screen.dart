import 'dart:async';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tm8_game_admin/app/constants/constants.dart';
import 'package:tm8_game_admin/app/constants/fonts.dart';
import 'package:tm8_game_admin/app/constants/palette.dart';
import 'package:tm8_game_admin/app/constants/routing_names.dart';
import 'package:tm8_game_admin/app/services/service_locator.dart';
import 'package:tm8_game_admin/app/widgets/tm8_alert_dialog_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_drop_down_form_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_error_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_logout_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_main_button_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_pagination_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_search_widget.dart';
import 'package:tm8_game_admin/app/widgets/tm8_snack_bar.dart';
import 'package:tm8_game_admin/app/widgets/tm8_table_widget.dart';
import 'package:tm8_game_admin/gen/assets.gen.dart';
import 'package:tm8_game_admin/manage_users/presentation/logic/unfocus_drop_down_cubit/unfocus_drop_down_cubit.dart';
import 'package:tm8_game_admin/notification_add/presentation/logic/refetch_notification_table_cubit/refetch_notification_table_cubit.dart';
import 'package:tm8_game_admin/notifications/presentation/logic/delete_notification_cubit/delete_notification_cubit.dart';
import 'package:tm8_game_admin/notifications/presentation/logic/fetch_notifications/fetch_notifications_cubit.dart';
import 'package:tm8_game_admin/notifications/presentation/logic/fetch_notifications_types_cubit/fetch_notification_types_cubit.dart';
import 'package:tm8_game_admin/notifications/presentation/logic/fetch_user_groups_cubit/fetch_user_groups_cubit.dart';
import 'package:tm8_game_admin/notifications/presentation/logic/selected_notification_row_cubit/selected_notification_row_cubit.dart';
import 'package:tm8_game_admin/notifications/presentation/logic/show_filters_cubit/show_filters_cubit.dart';
import 'package:tm8_game_admin/notifications/presentation/widgets/details_popup_item_widget.dart';
import 'package:tm8_game_admin/notifications/presentation/widgets/empty_state_notifications_widget.dart';
import 'package:tm8_game_admin/notifications/presentation/widgets/filter_empty_result_widget.dart';
import 'package:tm8_game_admin/notifications/presentation/widgets/tm8_notification_table_widget.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  var rowSize = 10;
  var page = 1;
  String? sort;
  String? search;
  String? userGroups;
  String? types;
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String? search) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      context.read<FetchNotificationsCubit>().fetchNotificationsData(
            filters: NotificationTableDataFilters(
              page: page,
              rowSize: rowSize,
              sort: sort,
              title: search,
              userGroups: userGroups,
              types: types,
            ),
          );
      context.read<SelectedNotificationRowCubit>().addRemoveAllNotifications(
        value: false,
        selectedNotificationIds: [],
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
            BlocListener<FetchNotificationsCubit, FetchNotificationsState>(
              listener: (context, state) {
                state.whenOrNull(
                  loaded: (
                    notificationPaginatedResponse,
                    filters,
                    message,
                  ) {
                    page = filters.page;
                    rowSize = filters.rowSize;
                    sort = filters.sort;
                    search = filters.title;
                    userGroups = filters.userGroups;
                    types = filters.types;
                    if (notificationPaginatedResponse.items.isEmpty &&
                        message == null) {
                      context.read<ShowFiltersCubit>().changeVisibility(false);
                    } else {
                      context.read<ShowFiltersCubit>().changeVisibility(true);
                    }
                  },
                );
              },
            ),
            BlocListener<DeleteNotificationCubit, DeleteNotificationState>(
              listener: (context, state) {
                state.whenOrNull(
                  loaded: (notificationId) {
                    context
                        .read<FetchNotificationsCubit>()
                        .fetchNotificationsData(
                          filters: NotificationTableDataFilters(
                            page: page,
                            rowSize: rowSize,
                            sort: sort,
                            title: search,
                            userGroups: userGroups,
                            types: types,
                          ),
                        );
                    context
                        .read<SelectedNotificationRowCubit>()
                        .addRemoveAllNotifications(
                      value: false,
                      selectedNotificationIds: [],
                    );
                  },
                  error: (error) {
                    context
                        .read<FetchNotificationsCubit>()
                        .fetchNotificationsData(
                          filters: NotificationTableDataFilters(
                            page: page,
                            rowSize: rowSize,
                            sort: sort,
                            title: search,
                            userGroups: userGroups,
                            types: types,
                          ),
                        );
                    context
                        .read<SelectedNotificationRowCubit>()
                        .addRemoveAllNotifications(
                      value: false,
                      selectedNotificationIds: [],
                    );
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
            BlocListener<RefetchNotificationTableCubit, bool>(
              listener: (context, state) {
                if (state) {
                  context
                      .read<FetchNotificationsCubit>()
                      .fetchNotificationsData(
                        filters: NotificationTableDataFilters(
                          page: page,
                          rowSize: rowSize,
                        ),
                      );
                  sl<RefetchNotificationTableCubit>().refetch(false);
                }
              },
            ),
          ],
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
                            'Notifications',
                            style:
                                heading1Regular.copyWith(color: achromatic100),
                          ),
                          h4,
                          BlocBuilder<FetchNotificationsCubit,
                              FetchNotificationsState>(
                            builder: (context, state) {
                              return state.maybeWhen(
                                loading: (len) {
                                  return _buildNotificationNumberLoading();
                                },
                                loaded: (
                                  notificationPaginatedResponse,
                                  filters,
                                  message,
                                ) {
                                  return Text(
                                    '${notificationPaginatedResponse.meta.itemCount} notifications',
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
                      BlocBuilder<ShowFiltersCubit, bool>(
                        builder: (context, state) {
                          if (state) {
                            return _buildLoadedFilters(context);
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ],
                  ),
                  h24,
                  BlocBuilder<FetchNotificationsCubit, FetchNotificationsState>(
                    builder: (context, state) {
                      return state.when(
                        initial: SizedBox.new,
                        loading: (length) {
                          return _buildLoadingNotificationTableWidget(length);
                        },
                        loaded:
                            (notificationPaginatedResponse, filters, message) {
                          return _buildNotificationTableWidget(
                            notificationPaginatedResponse,
                            context,
                            message,
                          );
                        },
                        error: (error) {
                          return Tm8ErrorWidget(
                            onTapRetry: () {
                              context
                                  .read<FetchNotificationsCubit>()
                                  .fetchNotificationsData(
                                    filters: NotificationTableDataFilters(
                                      page: 1,
                                      rowSize: 10,
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
      ),
    );
  }

  Padding _buildLoadedFilters(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Wrap(
        runSpacing: 12,
        spacing: 8,
        children: [
          BlocBuilder<SelectedNotificationRowCubit, List<String>>(
            builder: (context, state) {
              if (state.length > 1) {
                return Tm8MainButtonWidget(
                  onPressed: () {
                    tm8PopUpDialogWidget(
                      context,
                      borderRadius: 20,
                      padding: 24,
                      width: 360,
                      popup: _buildDeleteNotificationPopUp(
                        context,
                        state,
                      ),
                    );
                  },
                  buttonColor: errorColor,
                  text: 'Delete (${state.length})',
                  textColor: achromatic100,
                  width: 80,
                );
              } else {
                return const SizedBox();
              }
            },
          ),
          Tm8SearchWidget(
            onChanged: (value) {
              if (search != value) {
                search = value;
                if (value.length > 1) {
                  _onSearchChanged(search);
                } else if (value.isEmpty) {
                  _onSearchChanged(null);
                }
              }
            },
            hintText: 'Search',
            width: 250,
          ),
          BlocBuilder<FetchNotificationTypesCubit, FetchNotificationTypesState>(
            builder: (context, state) {
              return state.maybeWhen(
                loading: () {
                  return _buildLoadingNotificationTypes(
                    context,
                  );
                },
                loaded: (
                  notificationTypes,
                  failedValidation,
                ) {
                  return _buildLoadedNotificationTypes(
                    context,
                    notificationTypes,
                  );
                },
                orElse: SizedBox.new,
              );
            },
          ),
          BlocBuilder<FetchUserGroupsCubit, FetchUserGroupsState>(
            builder: (context, state) {
              return state.maybeWhen(
                loading: () {
                  return _buildLoadingUserGroups();
                },
                loaded: (userGroups, failedValidation) {
                  return _buildLoadedUserGroups(
                    userGroups,
                  );
                },
                orElse: SizedBox.new,
              );
            },
          ),
          Tm8MainButtonWidget(
            onPressed: () {
              context.beamToNamed(notificationAdd);
            },
            buttonColor: primaryTeal,
            text: 'New',
            asset: Assets.common.plus.path,
            assetColor: achromatic100,
            width: 75,
          ),
        ],
      ),
    );
  }

  Tm8DropDownFormWidget _buildLoadedUserGroups(
    List<UserGroupResponseAddedCount> userGroupsResponse,
  ) {
    return Tm8DropDownFormWidget(
      dropDownSelection: (value) {
        _dropDownUserGroupsSelection(
          context: context,
          value: value,
          userGroupsResponse: userGroupsResponse,
        );
      },
      mainCategory: '',
      categories: userGroupsResponse
          .map((e) => '${e.name} ${e.count != null ? '(${e.count})' : ''}')
          .toList(),
      itemKeys: userGroupsResponse
          .map((e) => '${e.name} ${e.count != null ? '(${e.count})' : ''}')
          .toList(),
      followerAlignment: Alignment.topCenter,
      selectedItem: '',
      hintText: 'All groups',
      width: 250,
    );
  }

  Skeletonizer _buildLoadingUserGroups() {
    return Skeletonizer(
      child: Tm8DropDownFormWidget(
        dropDownSelection: (value) {},
        mainCategory: '',
        categories: const [
          'All users',
          'Fortnite players',
          'Rocket League players',
          'Apex Legends players',
          'Call of duty players',
          'Individual user',
        ],
        itemKeys: const [
          'All users',
          'Fortnite players',
          'Rocket League players',
          'Apex Legends players',
          'Call of duty players',
          'Individual user',
        ],
        followerAlignment: Alignment.topCenter,
        selectedItem: '',
        hintText: 'All groups',
        width: 250,
      ),
    );
  }

  Tm8DropDownFormWidget _buildLoadedNotificationTypes(
    BuildContext context,
    List<NotificationTypeResponse> notificationTypes,
  ) {
    return Tm8DropDownFormWidget(
      dropDownSelection: (value) {
        _dropDownTypesSelection(
          context: context,
          value: value,
          notificationTypes: notificationTypes,
        );
      },
      mainCategory: '',
      categories: notificationTypes.map((e) => e.name).toList(),
      itemKeys: notificationTypes.map((e) => e.name).toList(),
      followerAlignment: Alignment.topCenter,
      selectedItem: '',
      hintText: 'All types',
      width: 250,
    );
  }

  Skeletonizer _buildLoadingNotificationTypes(BuildContext context) {
    return Skeletonizer(
      child: Tm8DropDownFormWidget(
        dropDownSelection: (value) {},
        mainCategory: '',
        categories: const [
          'Game update',
          'New features',
          'System maintenance',
          'Exclusive offers',
          'Community news',
          'Other',
        ],
        itemKeys: const [
          'Game update',
          'New features',
          'System maintenance',
          'Exclusive offers',
          'Community news',
          'Other',
        ],
        followerAlignment: Alignment.topCenter,
        selectedItem: '',
        hintText: 'All types',
        width: 250,
      ),
    );
  }

  Skeletonizer _buildNotificationNumberLoading() {
    return Skeletonizer(
      child: Text(
        '34 notifications',
        style: body2Regular.copyWith(
          color: achromatic200,
        ),
      ),
    );
  }

  Skeletonizer _buildLoadingNotificationTableWidget(int length) {
    return Skeletonizer(
      child: Column(
        children: [
          Tm8NotificationTableWidget(
            onRowPressed: (value) {},
            onSortAscending: (value) {},
            onSortDescending: (value) {},
            onActionRowEditPressed: (value) {},
            onActionRowDeletePressed: (value) {},
            sort: sort,
            items: List.generate(
              length,
              (index) => ScheduledNotificationResponse(
                id: '21312312',
                users: [],
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
                data: const ScheduledNotificationDataResponse(
                  title: 'Title',
                  targetGroup: ScheduledNotificationDataResponseTargetGroup
                      .apexLegendsPlayers,
                  description: 'desc',
                  notificationType:
                      ScheduledNotificationDataResponseNotificationType
                          .communityNews,
                ),
                receivedBy: 20,
                uniqueId: 'Loading',
                interval: 'every day',
                openedBy: 10,
                date: DateTime.now(),
              ),
            ),
            columnNames: const [
              Tm8MainRow(
                name: 'Title',
                sort: true,
              ),
              Tm8MainRow(
                name: 'Notification ID',
                sort: true,
              ),
              Tm8MainRow(
                name: 'Type',
                sort: false,
              ),
              Tm8MainRow(
                name: 'Target group',
                sort: false,
              ),
              Tm8MainRow(
                name: 'Repeat',
                sort: false,
              ),
            ],
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

  ListView _buildNotificationTableWidget(
    ScheduledNotificationPaginatedResponse notificationPaginatedResponse,
    BuildContext context,
    String? message,
  ) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        if (notificationPaginatedResponse.items.isEmpty && message == null) ...[
          const EmptyStateNotificationsWidget(),
        ] else ...[
          Tm8NotificationTableWidget(
            onRowPressed: (value) {
              tm8PopUpDialogWidget(
                context,
                borderRadius: 20,
                padding: 24,
                width: 620,
                popup: _buildDetailsNotificationPupUp(context, value),
              );
            },
            onSortAscending: (value) {
              _sortAscValidation(value, context);
            },
            onSortDescending: (value) {
              _sortDescValidation(value, context);
            },
            onActionRowEditPressed: (value) {
              context.beamToNamed(
                notificationDetails.replaceFirst(':notificationId', value.id),
              );
            },
            onActionRowDeletePressed: (value) {
              tm8PopUpDialogWidget(
                context,
                borderRadius: 20,
                padding: 24,
                width: 360,
                popup: _buildDeleteNotificationPopUp(context, [value.id]),
              );
            },
            sort: sort,
            items: notificationPaginatedResponse.items,
            columnNames: const [
              Tm8MainRow(
                name: 'Title',
                sort: true,
              ),
              Tm8MainRow(
                name: 'Notification ID',
                sort: true,
              ),
              Tm8MainRow(
                name: 'Type',
                sort: false,
              ),
              Tm8MainRow(
                name: 'Target group',
                sort: false,
              ),
              Tm8MainRow(
                name: 'Repeat',
                sort: false,
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
                      context
                          .read<FetchNotificationsCubit>()
                          .fetchNotificationsData(
                            filters: NotificationTableDataFilters(
                              page: 1,
                              rowSize: int.parse(value),
                              sort: sort,
                              title: search,
                              userGroups: userGroups,
                              types: types,
                            ),
                          );
                      context
                          .read<SelectedNotificationRowCubit>()
                          .addRemoveAllNotifications(
                        value: false,
                        selectedNotificationIds: [],
                      );
                    },
                    mainCategory:
                        notificationPaginatedResponse.meta.limit.toString(),
                    width: 75,
                    selectedItem:
                        notificationPaginatedResponse.meta.limit.toString(),
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
                    if (value <= notificationPaginatedResponse.meta.pageCount) {
                      context
                          .read<FetchNotificationsCubit>()
                          .fetchNotificationsData(
                            filters: NotificationTableDataFilters(
                              page: value,
                              rowSize: rowSize,
                              sort: sort,
                              title: search,
                              userGroups: userGroups,
                              types: types,
                            ),
                          );
                      context
                          .read<SelectedNotificationRowCubit>()
                          .addRemoveAllNotifications(
                        value: false,
                        selectedNotificationIds: [],
                      );
                    }
                  }
                },
                meta: notificationPaginatedResponse.meta,
              ),
            ],
          ),
        ],
      ],
    );
  }

  Column _buildDetailsNotificationPupUp(
    BuildContext context,
    ScheduledNotificationResponse value,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Notification ${value.uniqueId}',
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              constraints: const BoxConstraints(minWidth: 280, maxWidth: 285),
              child: DetailsPupUpItemWidget(
                name: 'Notification title',
                value: value.data.title,
              ),
            ),
            Container(
              constraints: const BoxConstraints(minWidth: 130, maxWidth: 135),
              child: DetailsPupUpItemWidget(
                name: 'Notification type',
                value:
                    statusMapNotificationTypes[value.data.notificationType] ??
                        '-',
              ),
            ),
            Container(
              constraints: const BoxConstraints(minWidth: 130, maxWidth: 135),
              child: DetailsPupUpItemWidget(
                name: 'Received by',
                value: '${value.receivedBy.toStringAsFixed(0)} users',
              ),
            ),
          ],
        ),
        h12,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              constraints: const BoxConstraints(
                minWidth: 280,
                maxWidth: 285,
                minHeight: 100,
              ),
              child: DetailsPupUpItemWidget(
                name: 'Content',
                value: value.data.description,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints:
                      const BoxConstraints(minWidth: 130, maxWidth: 135),
                  child: DetailsPupUpItemWidget(
                    name: 'User group',
                    value: statusMapNotificationGroup[value.data.targetGroup] ??
                        '-',
                  ),
                ),
                h12,
                Container(
                  constraints:
                      const BoxConstraints(minWidth: 130, maxWidth: 135),
                  child: DetailsPupUpItemWidget(
                    name: 'Schedule',
                    value: value.interval,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  constraints:
                      const BoxConstraints(minWidth: 130, maxWidth: 135),
                  child: DetailsPupUpItemWidget(
                    name: 'Opened by',
                    value: '${value.openedBy.toStringAsFixed(0)} users',
                  ),
                ),
                h50,
              ],
            ),
          ],
        ),
        h16,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Tm8MainButtonWidget(
              onPressed: () {
                Navigator.of(context).pop();
                tm8PopUpDialogWidget(
                  context,
                  borderRadius: 20,
                  padding: 24,
                  width: 360,
                  popup: _buildDeleteNotificationPopUp(
                    context,
                    [value.id],
                  ),
                );
              },
              buttonColor: errorSurfaceColor,
              text: 'Delete',
              width: 95,
              textColor: errorColor,
              asset: Assets.common.delete.path,
              assetColor: errorColor,
            ),
            w12,
            Tm8MainButtonWidget(
              onPressed: () {
                Navigator.of(context).pop();
                context.beamToNamed(
                  notificationDetails.replaceFirst(':notificationId', value.id),
                );
              },
              buttonColor: achromatic600,
              text: 'Edit',
              width: 75,
              asset: Assets.common.edit.path,
              assetColor: achromatic100,
            ),
          ],
        ),
      ],
    );
  }

  Column _buildDeleteNotificationPopUp(
    BuildContext context,
    List<String> ids,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Delete ${ids.length > 1 ? '(${ids.length})' : ''} notification?',
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
          "Are you sure you want to delete ${ids.length > 1 ? 'these' : 'this'} notification? Deleting ${ids.length > 1 ? 'them' : 'it'} won't take back what's already been received, but if it's scheduled for later, it won't be sent.",
          style: body1Regular.copyWith(
            color: achromatic200,
          ),
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
                Navigator.of(context).pop();
                context
                    .read<FetchNotificationsCubit>()
                    .emitLoading(rowSize: rowSize);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context)
                    .showSnackBar(
                      Tm8SnackBar.snackBar(
                        onPressed: () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        },
                        color: achromatic600,
                        text: 'Notification successfully deleted.',
                        textColor: achromatic200,
                        button: true,
                        buttonText: 'Undo',
                        buttonStyle: body2Bold.copyWith(
                          color: achromatic100,
                        ),
                        duration: 4,
                        width: 350,
                      ),
                    )
                    .closed
                    .then((reason) {
                  if (reason == SnackBarClosedReason.timeout) {
                    context.read<DeleteNotificationCubit>().deleteNotification(
                          notificationsInput: DeleteScheduledNotificationsInput(
                            notificationIds: ids,
                          ),
                        );
                  } else {
                    context
                        .read<FetchNotificationsCubit>()
                        .fetchNotificationsData(
                          filters: NotificationTableDataFilters(
                            page: page,
                            rowSize: rowSize,
                            sort: sort,
                            types: types,
                            userGroups: userGroups,
                            title: search,
                          ),
                        );
                  }
                });
              },
              buttonColor: errorColor,
              text: 'Delete ${ids.length > 1 ? '(${ids.length})' : ''}',
              width: 150,
            ),
          ],
        ),
      ],
    );
  }

  void _sortAscValidation(String value, BuildContext context) {
    if (value == 'Title') {
      if (sort != null) {
        if (sort!.contains('+title')) {
          sort = sort!.replaceAll('+title', '');
          if (sort == '') {
            sort = null;
          }
        } else if (sort!.contains('-title')) {
          sort = sort!.replaceAll('-title', '+title');
        } else {
          sort = '${sort!},+title';
        }
      } else {
        sort = '+title';
      }
    } else {
      if (sort != null) {
        if (sort!.contains('+notificationId')) {
          sort = sort!.replaceAll('+notificationId', '');
          if (sort == '') {
            sort = null;
          }
        } else if (sort!.contains('-notificationId')) {
          sort = sort!.replaceAll('-notificationId', '+notificationId');
        } else {
          sort = '${sort!}+notificationId';
        }
      } else {
        sort = '+notificationId';
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

    context.read<FetchNotificationsCubit>().fetchNotificationsData(
          filters: NotificationTableDataFilters(
            page: page,
            rowSize: rowSize,
            sort: sort,
            title: search,
          ),
        );
    context.read<SelectedNotificationRowCubit>().addRemoveAllNotifications(
      value: false,
      selectedNotificationIds: [],
    );
  }

  void _sortDescValidation(String value, BuildContext context) {
    if (value == 'Title') {
      if (sort != null) {
        if (sort!.contains('-title')) {
          sort = sort!.replaceAll('-title', '');
          if (sort == '') {
            sort = null;
          }
        } else if (sort!.contains('+title')) {
          sort = sort!.replaceAll('+title', '-title');
        } else {
          sort = '${sort!},-title';
        }
      } else {
        sort = '-title';
      }
    } else {
      if (sort != null) {
        if (sort!.contains('-notificationId')) {
          sort = sort!.replaceAll('-notificationId', '');
          if (sort == '') {
            sort = null;
          }
        } else if (sort!.contains('+notificationId')) {
          sort = sort!.replaceAll('+notificationId', '-notificationId');
        } else {
          sort = '${sort!},-notificationId';
        }
      } else {
        sort = '-notificationId';
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

    context.read<FetchNotificationsCubit>().fetchNotificationsData(
          filters: NotificationTableDataFilters(
            page: page,
            rowSize: rowSize,
            sort: sort,
            title: search,
            userGroups: userGroups,
            types: types,
          ),
        );
    context.read<SelectedNotificationRowCubit>().addRemoveAllNotifications(
      value: false,
      selectedNotificationIds: [],
    );
  }

  void _dropDownTypesSelection({
    required BuildContext context,
    required String value,
    required List<NotificationTypeResponse> notificationTypes,
  }) {
    final indexOf =
        notificationTypes.indexWhere((element) => element.name == value);
    if (indexOf != -1) {
      if (types == notificationTypes[indexOf].key.value) {
        types = null;
      } else {
        types = notificationTypes[indexOf].key.value;
      }
    } else {
      types = null;
    }
    context.read<FetchNotificationsCubit>().fetchNotificationsData(
          filters: NotificationTableDataFilters(
            page: 1,
            rowSize: rowSize,
            sort: sort,
            title: search,
            userGroups: userGroups,
            types: types,
          ),
        );
    context.read<SelectedNotificationRowCubit>().addRemoveAllNotifications(
      value: false,
      selectedNotificationIds: [],
    );
  }

  void _dropDownUserGroupsSelection({
    required BuildContext context,
    required String value,
    required List<UserGroupResponseAddedCount> userGroupsResponse,
  }) {
    final mainValue = value.split('(').first.trim();
    final indexOf =
        userGroupsResponse.indexWhere((element) => element.name == mainValue);
    if (indexOf != -1) {
      if (userGroups == userGroupsResponse[indexOf].key.value) {
        userGroups = null;
      } else {
        userGroups = userGroupsResponse[indexOf].key.value;
      }
    } else {
      userGroups = null;
    }
    context.read<FetchNotificationsCubit>().fetchNotificationsData(
          filters: NotificationTableDataFilters(
            page: 1,
            rowSize: rowSize,
            sort: sort,
            title: search,
            userGroups: userGroups,
            types: types,
          ),
        );
    context.read<SelectedNotificationRowCubit>().addRemoveAllNotifications(
      value: false,
      selectedNotificationIds: [],
    );
  }
}

final Map<ScheduledNotificationDataResponseNotificationType, String>
    statusMapNotificationTypes = {
  ScheduledNotificationDataResponseNotificationType.gameUpdate: 'Game update',
  ScheduledNotificationDataResponseNotificationType.communityNews:
      'Community news',
  ScheduledNotificationDataResponseNotificationType.exclusiveOffers:
      'Exclusive offers',
  ScheduledNotificationDataResponseNotificationType.newFeatures: 'New features',
  ScheduledNotificationDataResponseNotificationType.other: 'Other',
  ScheduledNotificationDataResponseNotificationType.systemMaintenance:
      'System maintenance',
};

final Map<ScheduledNotificationDataResponseTargetGroup, String>
    statusMapNotificationGroup = {
  ScheduledNotificationDataResponseTargetGroup.allUsers: 'All users',
  ScheduledNotificationDataResponseTargetGroup.apexLegendsPlayers:
      'Apex Legends players',
  ScheduledNotificationDataResponseTargetGroup.callOfDutyPlayers:
      'Call of Duty players',
  ScheduledNotificationDataResponseTargetGroup.fortnitePlayers:
      'Fortnite players',
  ScheduledNotificationDataResponseTargetGroup.individualUser:
      'Individual user',
  ScheduledNotificationDataResponseTargetGroup.rocketLeaguePlayers:
      'Rocket League players',
};
