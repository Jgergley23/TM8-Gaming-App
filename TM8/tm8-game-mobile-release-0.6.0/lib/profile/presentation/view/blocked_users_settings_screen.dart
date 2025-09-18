// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/widgets/tm8_body_container_widget.dart';
import 'package:tm8/app/widgets/tm8_error_widget.dart';
import 'package:tm8/app/widgets/tm8_main_app_bar_scaffold_widget.dart';
import 'package:tm8/app/widgets/tm8_main_button_widget.dart';
import 'package:tm8/app/widgets/tm8_snack_bar_widget.dart';
import 'package:tm8/env/env.dart';
import 'package:tm8/login/presentation/widgets/tm8_loading_overlay_widget.dart';
import 'package:tm8/profile/presentation/logic/fetch_blocked_users_cubit/fetch_blocked_users_cubit.dart';
import 'package:tm8/profile/presentation/logic/selected_blocked_users_cubit/selected_blocked_users_cubit.dart';
import 'package:tm8/profile/presentation/logic/unblock_blocked_users_cubit/unblock_blocked_users_cubit.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

@RoutePage() //BlockedUsersSettingsRoute.page
class BlockedUsersSettingsScreen extends StatefulWidget {
  const BlockedUsersSettingsScreen({
    super.key,
  });

  @override
  State<BlockedUsersSettingsScreen> createState() =>
      _BlockedUsersSettingsScreenState();
}

class _BlockedUsersSettingsScreenState
    extends State<BlockedUsersSettingsScreen> {
  final fetchBlockedUsersCubit = sl<FetchBlockedUsersCubit>();
  final selectedBlockedUsersCubit = sl<SelectedBlockedUsersCubit>();
  final unblockBlockedUsersCubit = sl<UnblockBlockedUsersCubit>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => fetchBlockedUsersCubit..fetchBlockedUsers(),
        ),
        BlocProvider(
          create: (context) => selectedBlockedUsersCubit,
        ),
        BlocProvider(
          create: (context) => unblockBlockedUsersCubit,
        ),
      ],
      child: LoaderOverlay(
        useDefaultLoading: false,
        overlayWidgetBuilder: (progress) {
          return Tm8LoadingOverlayWidget(progress: progress);
        },
        overlayColor: Colors.transparent,
        child: MultiBlocListener(
          listeners: [
            BlocListener<FetchBlockedUsersCubit, FetchBlockedUsersState>(
              listener: (context, state) {
                state.whenOrNull(
                  loaded: (blockedUsers, fakeDelete, ids) {
                    selectedBlockedUsersCubit.init(blockedUsers.items.length);
                    if (fakeDelete) {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                            Tm8SnackBar.snackBar(
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .removeCurrentSnackBar();
                              },
                              color: glassEffectColor,
                              text: 'User(s) unblocked successfully.',
                              error: false,
                              button: true,
                              buttonText: 'Undo',
                            ),
                          )
                          .closed
                          .then((reason) {
                        if (reason == SnackBarClosedReason.timeout) {
                          unblockBlockedUsersCubit.unblockUsers(
                            body: GetUsersByIdsParams(
                              userIds: ids,
                            ),
                          );
                        } else if (reason == SnackBarClosedReason.hide) {
                          unblockBlockedUsersCubit.unblockUsers(
                            body: GetUsersByIdsParams(
                              userIds: ids,
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          fetchBlockedUsersCubit.fetchBlockedUsers();
                        }
                      });
                    }
                  },
                );
              },
            ),
            BlocListener<UnblockBlockedUsersCubit, UnblockBlockedUsersState>(
              listener: (context, state) {
                state.whenOrNull(
                  loading: () {
                    context.loaderOverlay.show();
                  },
                  loaded: () {
                    context.loaderOverlay.hide();
                    fetchBlockedUsersCubit.fetchBlockedUsers();
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
          ],
          child: Tm8BodyContainerWidget(
            child: Scaffold(
              appBar: Tm8MainAppBarScaffoldWidget(
                title: 'Blocked Users',
                leading: true,
                navigationPadding: screenPadding,
              ),
              body: SingleChildScrollView(
                padding: screenPadding,
                child:
                    BlocBuilder<FetchBlockedUsersCubit, FetchBlockedUsersState>(
                  builder: (context, state) {
                    return state.when(
                      initial: SizedBox.new,
                      loading: () {
                        return Skeletonizer(
                          child: ListView.separated(
                            itemBuilder: (context, index) {
                              return _buildLoadingListItem();
                            },
                            separatorBuilder: (context, index) => h12,
                            itemCount: 5,
                            shrinkWrap: true,
                          ),
                        );
                      },
                      loaded: (blockedUsers, fakeDelete, mainIds) {
                        if (blockedUsers.items.isEmpty) {
                          return Center(
                            child: Text(
                              'No blocked users yet. All blocked users will appear here.',
                              style: body1Regular.copyWith(
                                color: achromatic100,
                              ),
                            ),
                          );
                        }
                        return Column(
                          children: [
                            ListView.separated(
                              itemBuilder: (context, index) {
                                return _buildLoadedListItem(
                                  blockedUsers,
                                  index,
                                );
                              },
                              separatorBuilder: (context, index) => h12,
                              itemCount: blockedUsers.items.length,
                              shrinkWrap: true,
                            ),
                            h12,
                            Align(
                              alignment: AlignmentDirectional.bottomCenter,
                              child: BlocBuilder<SelectedBlockedUsersCubit,
                                  List<bool>>(
                                builder: (context, state) {
                                  return Tm8MainButtonWidget(
                                    onTap: () {
                                      final selected =
                                          state.any((element) => true);
                                      if (selected) {
                                        final indexes = state
                                            .asMap()
                                            .entries
                                            .where((entry) => entry.value)
                                            .map((entry) => entry.key)
                                            .toList();
                                        final ids = indexes
                                            .map(
                                              (index) =>
                                                  blockedUsers.items[index].id,
                                            )
                                            .toList();

                                        if (ids.isEmpty) {
                                          return;
                                        }
                                        fetchBlockedUsersCubit.fakeUnblockUsers(
                                          ids: ids,
                                          meta: blockedUsers.meta,
                                        );
                                      }
                                    },
                                    buttonColor:
                                        state.any((element) => element == true)
                                            ? primaryTeal
                                            : achromatic600,
                                    text: 'Unblock',
                                    textColor:
                                        state.any((element) => element == true)
                                            ? achromatic100
                                            : achromatic400,
                                  );
                                },
                              ),
                            ),
                            h12,
                          ],
                        );
                      },
                      error: (error) {
                        return Tm8ErrorWidget(
                          onTapRetry: () {
                            fetchBlockedUsersCubit.fetchBlockedUsers();
                          },
                          error: error,
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container _buildLoadingListItem() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: achromatic600,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: achromatic500,
                ),
                child: Center(
                  child: Text(
                    'M',
                    style: body1Bold.copyWith(
                      color: achromatic100,
                    ),
                  ),
                ),
              ),
              w8,
              Text(
                'username',
                style: body1Regular.copyWith(
                  color: achromatic100,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16,
            width: 16,
            child: Checkbox(
              onChanged: (value) {},
              fillColor: const WidgetStatePropertyAll(
                Colors.transparent,
              ),
              activeColor: primaryTeal,
              value: false,
            ),
          ),
        ],
      ),
    );
  }

  BlocBuilder _buildLoadedListItem(
    UserPaginatedResponse blockedUsers,
    int index,
  ) {
    return BlocBuilder<SelectedBlockedUsersCubit, List<bool>>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            selectedBlockedUsersCubit.changeState(index);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: achromatic600,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (blockedUsers.items[index].photoKey == null) ...[
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: achromatic500,
                        ),
                        child: Center(
                          child: Text(
                            blockedUsers.items[index].username![0]
                                .toUpperCase(),
                            style: body1Regular.copyWith(
                              color: achromatic100,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ] else ...[
                      ClipOval(
                        child: Image.network(
                          '${Env.stagingUrlAmazon}/${blockedUsers.items[index].photoKey}',
                          height: 20,
                          width: 20,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ],
                    w8,
                    Text(
                      blockedUsers.items[index].username ?? '',
                      style: body1Regular.copyWith(
                        color: achromatic100,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                  width: 16,
                  child: Checkbox(
                    onChanged: (value) {
                      if (value != null) {
                        selectedBlockedUsersCubit.changeState(index);
                      }
                    },
                    fillColor: WidgetStatePropertyAll(
                      state[index] ? primaryTeal : Colors.transparent,
                    ),
                    activeColor: primaryTeal,
                    value: state[index],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
