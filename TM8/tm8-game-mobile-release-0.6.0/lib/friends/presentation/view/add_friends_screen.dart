import 'dart:async';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/router/router.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/storage/tm8_storage.dart';
import 'package:tm8/app/widgets/tm8_alert_dialog_widget.dart';
import 'package:tm8/app/widgets/tm8_body_container_widget.dart';
import 'package:tm8/app/widgets/tm8_error_widget.dart';
import 'package:tm8/app/widgets/tm8_main_app_bar_scaffold_widget.dart';
import 'package:tm8/app/widgets/tm8_main_button_widget.dart';
import 'package:tm8/app/widgets/tm8_search_widget.dart';
import 'package:tm8/app/widgets/tm8_snack_bar_widget.dart';
import 'package:tm8/env/env.dart';
import 'package:tm8/friends/presentation/logic/fetch_friends_cubit/fetch_friends_cubit.dart';
import 'package:tm8/friends/presentation/logic/remove_friend_cubit/remove_friend_cubit.dart';
import 'package:tm8/gen/assets.gen.dart';
import 'package:tm8/login/presentation/widgets/tm8_loading_overlay_widget.dart';
import 'package:tm8/messages/presentation/logic/add_friend_cubit/add_friend_cubit.dart';
import 'package:tm8/messages/presentation/logic/search_users_cubit/search_users_cubit.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

@RoutePage() //AddFriendsRoute.page
class AddFriendsScreen extends StatefulWidget {
  const AddFriendsScreen({super.key});

  @override
  State<AddFriendsScreen> createState() => _AddFriendsScreenState();
}

class _AddFriendsScreenState extends State<AddFriendsScreen> {
  final searchUsersCubit = sl<SearchUsersCubit>();
  final addFriendCubit = sl<AddFriendCubit>();
  final removeFriendCubit = sl<RemoveFriendCubit>();
  String? search;
  Timer? _debounce;
  FocusNode focusNode = FocusNode();
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String? search) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (search != null) {
        searchUsersCubit.searchUsers(username: search);
      } else {
        searchUsersCubit.searchUsers(username: '');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidgetBuilder: (progress) {
        return Tm8LoadingOverlayWidget(progress: progress);
      },
      overlayColor: Colors.transparent,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => searchUsersCubit,
          ),
          BlocProvider(
            create: (context) => addFriendCubit,
          ),
          BlocProvider(
            create: (context) => removeFriendCubit,
          ),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<RemoveFriendCubit, RemoveFriendState>(
              listener: (context, state) {
                state.whenOrNull(
                  loading: () {
                    context.loaderOverlay.show();
                  },
                  loaded: () {
                    context.loaderOverlay.hide();
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      Tm8SnackBar.snackBar(
                        color: glassEffectColor,
                        text: 'Friend successfully removed',
                        error: false,
                      ),
                    );
                    searchUsersCubit.searchUsers(username: search ?? '');
                    sl<FetchFriendsCubit>().fetchFriends(username: null);
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
            BlocListener<AddFriendCubit, AddFriendState>(
              listener: (context, state) {
                state.whenOrNull(
                  loading: () {
                    context.loaderOverlay.show();
                  },
                  loaded: () {
                    context.loaderOverlay.hide();
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      Tm8SnackBar.snackBar(
                        color: glassEffectColor,
                        text: 'Friend successfully added',
                        error: false,
                      ),
                    );
                    searchUsersCubit.searchUsers(username: search ?? '');
                    sl<FetchFriendsCubit>().fetchFriends(username: null);
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
          child: GestureDetector(
            onTap: () {
              focusNode.unfocus();
            },
            child: Tm8BodyContainerWidget(
              child: Scaffold(
                appBar: Tm8MainAppBarScaffoldWidget(
                  onActionPressed: () {
                    context.pushRoute(
                      QRCodeRoute(
                        userId: sl<Tm8Storage>().userId,
                        userName: sl<Tm8Storage>().userName,
                      ),
                    );
                  },
                  title: 'Add friends',
                  leading: true,
                  action: true,
                  actionIcon: Assets.common.qrCode.svg(),
                  navigationPadding: const EdgeInsets.only(top: 12, left: 12),
                  focusNode: focusNode,
                ),
                body: SingleChildScrollView(
                  padding: screenPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Enter username to search',
                        style: body1Regular.copyWith(color: achromatic200),
                      ),
                      h4,
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
                        hintText: 'Search users',
                        width: 270,
                      ),
                      h12,
                      BlocBuilder<SearchUsersCubit, SearchUsersState>(
                        builder: (context, state) {
                          return state.when(
                            initial: SizedBox.new,
                            loading: SizedBox.new,
                            loaded: (users) {
                              return ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return _buildUserItem(users, index, context);
                                },
                                separatorBuilder: (context, index) {
                                  return h12;
                                },
                                itemCount: users.length,
                              );
                            },
                            error: (error) {
                              return Tm8ErrorWidget(
                                onTapRetry: () {
                                  searchUsersCubit.searchUsers(username: '');
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
        ),
      ),
    );
  }

  GestureDetector _buildUserItem(
    List<UserSearchResponse> users,
    int index,
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () {
        context.pushRoute(FriendsDetailsRoute(userId: users[index].id));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: achromatic700,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (users[index].photoKey == null) ...[
                  Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: achromatic600,
                    ),
                    child: Center(
                      child: Text(
                        users[index].username[0].toUpperCase(),
                        style: heading4Bold.copyWith(
                          color: achromatic100,
                        ),
                      ),
                    ),
                  ),
                ] else ...[
                  ClipOval(
                    child: Image.network(
                      '${Env.stagingUrlAmazon}/${users[index].photoKey}',
                      height: 32,
                      width: 32,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ],
                w8,
                Text(
                  users[index].username,
                  style: body1Regular.copyWith(
                    color: achromatic100,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                if (users[index].friend) {
                  tm8PopUpDialogWidget(
                    context,
                    padding: 12,
                    width: 300,
                    borderRadius: 20,
                    popup: (context) => _buildRemoveFriendPopUp(
                      context,
                      users,
                      index,
                    ),
                  );
                } else {
                  tm8PopUpDialogWidget(
                    context,
                    padding: 12,
                    width: 300,
                    borderRadius: 20,
                    popup: (context) => _buildAddFriendPopUp(
                      context,
                      users,
                      index,
                    ),
                  );
                }
              },
              child: users[index].friend
                  ? Assets.common.friendIcon.svg(height: 16, width: 16)
                  : Assets.common.addFriend.svg(height: 16, width: 16),
            ),
          ],
        ),
      ),
    );
  }

  Column _buildRemoveFriendPopUp(
    BuildContext context,
    List<UserSearchResponse> user,
    int index,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Remove friend? ',
              style: heading4Regular.copyWith(
                color: achromatic100,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Assets.common.x.svg(),
            ),
          ],
        ),
        h18,
        Text(
          'Are you sure you want to remove your friend? ',
          style: body1Regular.copyWith(
            color: achromatic200,
          ),
          textAlign: TextAlign.left,
        ),
        h12,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Tm8MainButtonWidget(
              onTap: () async {
                Navigator.of(context).pop();
              },
              buttonColor: achromatic500,
              text: 'Cancel',
              width: 130,
            ),
            w12,
            Tm8MainButtonWidget(
              onTap: () {
                removeFriendCubit.removeFriend(userId: user[index].id);
                Navigator.of(context).pop();
              },
              buttonColor: errorTextColor,
              text: 'Remove',
              width: 130,
            ),
          ],
        ),
      ],
    );
  }

  Column _buildAddFriendPopUp(
    BuildContext context,
    List<UserSearchResponse> user,
    int index,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Add friend ',
              style: heading4Regular.copyWith(
                color: achromatic100,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Assets.common.x.svg(),
            ),
          ],
        ),
        h18,
        Text(
          'Are you sure you want to add ${user[index].username} as your friend? ',
          style: body1Regular.copyWith(
            color: achromatic200,
          ),
          textAlign: TextAlign.left,
        ),
        h12,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Tm8MainButtonWidget(
              onTap: () async {
                Navigator.of(context).pop();
              },
              buttonColor: achromatic500,
              text: 'Cancel',
              width: 130,
            ),
            w12,
            Tm8MainButtonWidget(
              onTap: () {
                addFriendCubit.addFriend(
                  userId: user[index].id,
                  username: user[index].username,
                );
                Navigator.of(context).pop();
              },
              buttonColor: primaryTeal,
              text: 'Add',
              width: 130,
            ),
          ],
        ),
      ],
    );
  }
}
