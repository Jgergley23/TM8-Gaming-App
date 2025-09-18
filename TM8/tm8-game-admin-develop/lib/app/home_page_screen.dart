//will be removed in the future after implementation of home screen

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isoweek/isoweek.dart';
import 'package:tm8_game_admin/app/constants/routing_names.dart';
import 'package:tm8_game_admin/app/services/service_locator.dart';
import 'package:tm8_game_admin/app/widgets/tm8_side_menu_widget.dart';
import 'package:tm8_game_admin/manage_admins/presentation/logic/add_admin_cubit/add_admin_cubit.dart';
import 'package:tm8_game_admin/manage_admins/presentation/logic/manage_admins_cubit/manage_admins_cubit.dart';
import 'package:tm8_game_admin/manage_admins/presentation/logic/delete_admin_cubit/delete_admin_cubit.dart';
import 'package:tm8_game_admin/manage_admins/presentation/logic/selected_admin_row_cubit/selected_admin_row_cubit.dart';
import 'package:tm8_game_admin/manage_admins/presentation/view/manage_admins_screen.dart';
import 'package:tm8_game_admin/manage_users/presentation/logic/ban_users_cubit/ban_users_cubit.dart';
import 'package:tm8_game_admin/manage_users/presentation/logic/registered_users_cubit/registered_users_cubit.dart';
import 'package:tm8_game_admin/manage_users/presentation/logic/reset_users_cubit/reset_users_cubit.dart';
import 'package:tm8_game_admin/manage_users/presentation/logic/table_on_hover_cubit/table_on_hover_cubit.dart';
import 'package:tm8_game_admin/manage_users/presentation/logic/manage_users_cubit/manage_users_cubit.dart';
import 'package:tm8_game_admin/manage_users/presentation/logic/onboarding_completion_cubit/onboarding_completion_cubit.dart';
import 'package:tm8_game_admin/manage_users/presentation/logic/selected_row_users/selected_row_users_cubit.dart';
import 'package:tm8_game_admin/manage_users/presentation/logic/total_users_cubit/total_users_cubit.dart';
import 'package:tm8_game_admin/manage_users/presentation/logic/unfocus_drop_down_cubit/unfocus_drop_down_cubit.dart';
import 'package:tm8_game_admin/manage_users/presentation/view/manage_users_screen.dart';
import 'package:tm8_game_admin/notification_add/presentation/logic/refetch_notification_table_cubit/refetch_notification_table_cubit.dart';
import 'package:tm8_game_admin/notifications/presentation/logic/delete_notification_cubit/delete_notification_cubit.dart';
import 'package:tm8_game_admin/notifications/presentation/logic/fetch_notifications/fetch_notifications_cubit.dart';
import 'package:tm8_game_admin/notifications/presentation/logic/fetch_notifications_types_cubit/fetch_notification_types_cubit.dart';
import 'package:tm8_game_admin/notifications/presentation/logic/fetch_user_groups_cubit/fetch_user_groups_cubit.dart';
import 'package:tm8_game_admin/notifications/presentation/logic/selected_notification_row_cubit/selected_notification_row_cubit.dart';
import 'package:tm8_game_admin/notifications/presentation/logic/show_filters_cubit/show_filters_cubit.dart';
import 'package:tm8_game_admin/notifications/presentation/view/notifications_screen.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.enums.swagger.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.initialPage});

  final int initialPage;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController = PageController();
  final manageUserCubit = sl<ManageUsersCubit>();
  final unfocusDropDownCubit = sl<UnfocusDropDownCubit>();
  final totalUsersCubit = sl<TotalUsersCubit>()..fetchTotalUser();
  final onboardingCompletionCubit = sl<OnboardingCompletionCubit>()
    ..fetchOnboardingCompletion();
  final selectedUserRow = sl<SelectedRowUsersCubit>();
  final banUsers = sl<BanUsersCubit>();
  final tableHover = sl<TableOnHoverCubit>();
  final resetUsers = sl<ResetUserCubit>();
  final registeredUsersCubit = sl<RegisteredUsersCubit>();
  final fetchNotificationsCubit = sl<FetchNotificationsCubit>();
  final fetchNotificationTypesCubit = sl<FetchNotificationTypesCubit>()
    ..fetchNotificationTypes();
  final fetchUserGroupsCubit = sl<FetchUserGroupsCubit>()..fetchUserGroups();
  final deleteNotificationCubit = sl<DeleteNotificationCubit>();
  final selectedNotificationRowCubit = sl<SelectedNotificationRowCubit>();
  final showFiltersCubit = sl<ShowFiltersCubit>();
  final mangeAdminsCubit = sl<ManageAdminsCubit>();
  final selectedAdminRowCubit = sl<SelectedAdminRowCubit>();
  final addAdminCubit = sl<AddAdminCubit>();
  final removeAdminCubit = sl<DeleteAdminCubit>();
  int mainIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.initialPage);
    mainIndex = widget.initialPage;
    Week currentWeek = Week.current();
    registeredUsersCubit.fetchRegisteredUsersGraph(
      startDate: currentWeek.days.first.toString(),
      endDate: currentWeek.days.last.toString(),
      groupBy: ApiV1StatisticsUsersNewUsersRegisteredGetGroupBy.day,
      timeSelected: TimeSelected.weekly,
      selectedValue: 'Weekly',
    );
    manageUserCubit.fetchTableData(
      filters: UsersTableDataFilters(
        page: 1,
        rowSize: 5,
      ),
    );
    fetchNotificationsCubit.fetchNotificationsData(
      filters: NotificationTableDataFilters(
        page: 1,
        rowSize: 10,
      ),
    );
    mangeAdminsCubit.fetchAdminsData(
      filters: AdminsTableDataFilters(page: 1, rowSize: 10),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Tm8SideMenuWidget(
            pageIndex: (value) {
              setState(() {
                mainIndex = value;
                // pageController.jumpToPage(mainIndex);
                if (mainIndex == 0) {
                  context.beamToNamed(
                    home,
                  );
                } else if (mainIndex == 1) {
                  context.beamToNamed(
                    notifications,
                  );
                } else {
                  context.beamToNamed(
                    manageAdmins,
                  );
                }
              });
            },
            currentIndex: mainIndex,
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: manageUserCubit,
                    ),
                    BlocProvider.value(
                      value: unfocusDropDownCubit,
                    ),
                    BlocProvider(
                      create: (context) => totalUsersCubit,
                    ),
                    BlocProvider(
                      create: (context) => onboardingCompletionCubit,
                    ),
                    BlocProvider(
                      create: (context) => selectedUserRow,
                    ),
                    BlocProvider(
                      create: (context) => banUsers,
                    ),
                    BlocProvider(
                      create: (context) => tableHover,
                    ),
                    BlocProvider(
                      create: (context) => resetUsers,
                    ),
                    BlocProvider(
                      create: (context) => registeredUsersCubit,
                    ),
                  ],
                  child: const ManageUsersScreen(),
                ),
                MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => fetchNotificationsCubit,
                    ),
                    BlocProvider(
                      create: (context) => tableHover,
                    ),
                    BlocProvider.value(
                      value: unfocusDropDownCubit,
                    ),
                    BlocProvider(
                      create: (context) => fetchNotificationTypesCubit,
                    ),
                    BlocProvider(
                      create: (context) => fetchUserGroupsCubit,
                    ),
                    BlocProvider(
                      create: (context) => deleteNotificationCubit,
                    ),
                    BlocProvider(
                      create: (context) => selectedNotificationRowCubit,
                    ),
                    BlocProvider(
                      create: (context) => showFiltersCubit,
                    ),
                    BlocProvider.value(
                      value: sl<RefetchNotificationTableCubit>(),
                    ),
                  ],
                  child: const NotificationsScreen(),
                ),
                MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => mangeAdminsCubit,
                    ),
                    BlocProvider(
                      create: (context) => selectedAdminRowCubit,
                    ),
                    BlocProvider(
                      create: (context) => tableHover,
                    ),
                    BlocProvider.value(
                      value: unfocusDropDownCubit,
                    ),
                    BlocProvider(
                      create: (context) => addAdminCubit,
                    ),
                    BlocProvider(
                      create: (context) => removeAdminCubit,
                    ),
                  ],
                  child: const ManageAdminsScreen(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
