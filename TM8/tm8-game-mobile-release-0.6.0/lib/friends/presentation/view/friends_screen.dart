import 'dart:async';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/router/router.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/widgets/tm8_alert_dialog_widget.dart';
import 'package:tm8/app/widgets/tm8_error_widget.dart';
import 'package:tm8/app/widgets/tm8_main_button_widget.dart';
import 'package:tm8/app/widgets/tm8_search_widget.dart';
import 'package:tm8/app/widgets/tm8_snack_bar_widget.dart';
import 'package:tm8/env/env.dart';
import 'package:tm8/friends/presentation/logic/fetch_friends_cubit/fetch_friends_cubit.dart';
import 'package:tm8/friends/presentation/logic/remove_friend_cubit/remove_friend_cubit.dart';
import 'package:tm8/gen/assets.gen.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

@RoutePage() //FriendsRoute.page
class FriendsScreen extends StatefulWidget {
  const FriendsScreen({
    super.key,
    required this.focusNode,
  });

  final FocusNode focusNode;

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  final removeFriendCubit = sl<RemoveFriendCubit>();

  final ScrollController _scrollController = ScrollController();

  String? search;
  Timer? _debounce;
  double page = 1;
  var friendList = <UserResponse>[];
  bool hasNextPage = true;

  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    sl<FetchFriendsCubit>().fetchFriends(username: '');
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // Reached the bottom of the list, add more items
        if (hasNextPage) {
          page = page + 1;
          sl<FetchFriendsCubit>().fetchNextPage(
            username: search,
            page: page.toInt(),
            friendList: friendList,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String? search) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (search != null) {
        sl<FetchFriendsCubit>().fetchFriends(username: search);
      } else {
        sl<FetchFriendsCubit>().fetchFriends(username: null);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
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
                  sl<FetchFriendsCubit>().fetchFriends(username: search);
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
          BlocListener<FetchFriendsCubit, FetchFriendsState>(
            listener: (context, state) {
              state.whenOrNull(
                loaded: (friendList, username) {
                  this.friendList = friendList.items;
                  page = friendList.meta.page;
                  hasNextPage = friendList.meta.hasNextPage;
                },
              );
            },
          ),
        ],
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
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
                hintText: 'Search friends',
                width: 270,
              ),
              BlocBuilder<FetchFriendsCubit, FetchFriendsState>(
                builder: (context, state) {
                  return state.when(
                    initial: SizedBox.new,
                    loading: (friendList) {
                      return Column(
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return _friendListItem(friendList, index);
                            },
                            separatorBuilder: (context, index) {
                              return h12;
                            },
                            itemCount: friendList.length,
                          ),
                          h12,
                          _buildLoadingFriendList(),
                        ],
                      );
                    },
                    loaded: (friendList, username) {
                      if (friendList.items.isEmpty && username == null) {
                        return _buildNoMessagesWidget();
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          h12,
                          if (friendList.items.isEmpty && username != null) ...[
                            Text(
                              'No friends found for search',
                              style: body1Regular.copyWith(
                                color: achromatic100,
                              ),
                            ),
                            h12,
                          ],
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return _friendListItem(friendList.items, index);
                            },
                            separatorBuilder: (context, index) {
                              return h12;
                            },
                            itemCount: friendList.items.length,
                          ),
                        ],
                      );
                    },
                    error: (error) {
                      return Tm8ErrorWidget(
                        onTapRetry: () {
                          sl<FetchFriendsCubit>()
                              .fetchFriends(username: search);
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
    );
  }

  Skeletonizer _buildLoadingFriendList() {
    return Skeletonizer(
      child: Column(
        children: [
          h12,
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return _friendListItem(
                [
                  const UserResponse(
                    id: '',
                    status: UserStatusResponse(
                      type: UserStatusResponseType.active,
                    ),
                    username: 'testerUsername',
                  ),
                  const UserResponse(
                    id: '',
                    status: UserStatusResponse(
                      type: UserStatusResponseType.active,
                    ),
                    username: 'testerUsername',
                  ),
                  const UserResponse(
                    id: '',
                    status: UserStatusResponse(
                      type: UserStatusResponseType.active,
                    ),
                    username: 'testerUsername',
                  ),
                  const UserResponse(
                    id: '',
                    status: UserStatusResponse(
                      type: UserStatusResponseType.active,
                    ),
                    username: 'testerUsername',
                  ),
                  const UserResponse(
                    id: '',
                    status: UserStatusResponse(
                      type: UserStatusResponseType.active,
                    ),
                    username: 'testerUsername',
                  ),
                  const UserResponse(
                    id: '',
                    status: UserStatusResponse(
                      type: UserStatusResponseType.active,
                    ),
                    username: 'testerUsername',
                  ),
                ],
                index,
              );
            },
            separatorBuilder: (context, index) {
              return h12;
            },
            itemCount: 6,
          ),
        ],
      ),
    );
  }

  GestureDetector _friendListItem(List<UserResponse> friendList, int index) {
    return GestureDetector(
      onTap: () {
        context.pushRoute(FriendsDetailsRoute(userId: friendList[index].id));
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
                if (friendList[index].photoKey == null) ...[
                  Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: achromatic600,
                    ),
                    child: Center(
                      child: Text(
                        friendList[index].username?[0].toUpperCase() ?? 'U',
                        style: heading4Bold.copyWith(
                          color: achromatic100,
                        ),
                      ),
                    ),
                  ),
                ] else ...[
                  ClipOval(
                    child: Image.network(
                      '${Env.stagingUrlAmazon}/${friendList[index].photoKey}',
                      height: 32,
                      width: 32,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ],
                w8,
                Text(
                  friendList[index].username ?? '',
                  style: body1Regular.copyWith(
                    color: achromatic100,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                tm8PopUpDialogWidget(
                  context,
                  padding: 12,
                  width: 300,
                  borderRadius: 20,
                  popup: (context) =>
                      _buildRemoveFriendPopUp(context, friendList, index),
                );
              },
              child: Assets.common.friendIcon.svg(height: 16, width: 16),
            ),
          ],
        ),
      ),
    );
  }

  Column _buildRemoveFriendPopUp(
    BuildContext context,
    List<UserResponse> friendList,
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
                removeFriendCubit.removeFriend(userId: friendList[index].id);
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

  Column _buildNoMessagesWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        h100,
        h100,
        h50,
        Text(
          'No friends yet',
          style: heading2Regular.copyWith(
            color: achromatic100,
          ),
        ),
        h12,
        Text(
          'No friends to show. All friends you add will appear here',
          style: body1Regular.copyWith(color: achromatic200),
          textAlign: TextAlign.center,
        ),
        h24,
        Tm8MainButtonWidget(
          onTap: () {
            context.pushRoute(const AddFriendsRoute());
          },
          buttonColor: primaryTeal,
          text: 'Add friend',
        ),
      ],
    );
  }
}
