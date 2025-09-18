import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loggy/loggy.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tm8_game_admin/app/constants/constants.dart';
import 'package:tm8_game_admin/app/constants/fonts.dart';
import 'package:tm8_game_admin/app/constants/palette.dart';
import 'package:tm8_game_admin/app/widgets/tm8_search_widget.dart';
import 'package:tm8_game_admin/gen/assets.gen.dart';
import 'package:tm8_game_admin/notification_add/presentation/logic/fetch_search_users_cubit/fetch_search_users_cubit.dart';
import 'package:tm8_game_admin/notification_add/presentation/logic/reset_search_cubit/reset_search_cubit.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';
import 'package:tm8_game_admin/user_details/presentation/logic/user_details_cubit/user_details_cubit.dart';

class SearchPortalWidget extends StatefulWidget {
  const SearchPortalWidget({
    super.key,
    required this.width,
    required this.followerAlignment,
    required this.selectedIndividual,
    this.userId,
  });

  final double width;
  final Alignment followerAlignment;
  final Function(String?) selectedIndividual;
  final String? userId;

  @override
  State<SearchPortalWidget> createState() => _SearchPortalWidgetState();
}

class _SearchPortalWidgetState extends State<SearchPortalWidget> {
  String? search;
  Timer? _debounce;
  late FocusNode focusNode;
  UserResponse? selectedUser;
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();

    focusNode.addListener(() {
      logInfo(
        'Focus updated search user: hasFocus: ${focusNode.hasFocus}',
      );
    });
    if (widget.userId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context
            .read<UserDetailsCubit>()
            .fetchUserDetails(userId: widget.userId!);
      });
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    controller.dispose();
    super.dispose();
  }

  void _onSearchChanged(String? search) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (search != null) {
        context
            .read<FetchSearchUsersCubit>()
            .fetchNotificationIntervals(username: search);
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UserDetailsCubit, UserDetailsState>(
          listener: (context, state) {
            state.whenOrNull(
              loaded: (userDetails) {
                selectedUser = userDetails;
                setState(() {});
              },
            );
          },
        ),
        BlocListener<ResetSearchCubit, bool>(
          listener: (context, state) {
            controller.clear();
            search = '';
            setState(() {});
          },
        ),
      ],
      child: PortalTarget(
        visible: focusNode.hasFocus,
        portalFollower: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            h24,
            BlocBuilder<FetchSearchUsersCubit, FetchSearchUsersState>(
              builder: (context, state) {
                return state.maybeWhen(
                  loading: () {
                    return _buildLoadingSearchResults();
                  },
                  loaded: (users) {
                    if (users.isEmpty) {
                      return Container(
                        width: widget.width * 0.22,
                        height: 200,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: achromatic800,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [overlayShadow],
                        ),
                        child: Center(
                          child: Text(
                            'No search results found.',
                            style: body1Regular.copyWith(
                              color: achromatic200,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return _buildLoadedSearchResults(
                        onTap: (index) {
                          selectedUser = users[index];
                          widget.selectedIndividual(users[index].id);
                          focusNode.unfocus();
                          setState(() {});
                        },
                        users: users,
                      );
                    }
                  },
                  orElse: SizedBox.new,
                );
              },
            ),
          ],
        ),
        anchor: Aligned(
          follower: widget.followerAlignment,
          target: Alignment.center,
        ),
        child: Focus(
          focusNode: focusNode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              h16,
              if (selectedUser == null)
                Tm8SearchWidget(
                  onChanged: (value) {
                    if (search != value) {
                      search = value;
                      if (value.length > 2) {
                        _onSearchChanged(search);
                        if (!focusNode.hasFocus) {
                          focusNode.requestFocus();
                        }
                      } else if (value.isEmpty) {
                        if (focusNode.hasFocus) {
                          focusNode.unfocus();
                        }
                        _onSearchChanged(null);
                      }
                    }
                  },
                  hintText: 'Search users...',
                  width: widget.width * 0.22,
                  dropDownHeight: 54,
                  constraints: const BoxConstraints(minWidth: 270),
                  textEditingController: controller,
                )
              else
                Container(
                  width: widget.width * 0.22,
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  constraints: const BoxConstraints(minWidth: 270),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            selectedUser!.name ?? '',
                            style: body1Regular.copyWith(
                              color: achromatic200,
                            ),
                          ),
                          Text(
                            selectedUser?.email ?? '',
                            style: body2Regular.copyWith(
                              color: achromatic300,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                selectedUser = null;
                                widget.selectedIndividual(null);
                              });
                            },
                            child: SvgPicture.asset(Assets.common.close.path),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildLoadedSearchResults({
    required Function(int) onTap,
    required List<UserResponse> users,
  }) {
    return Container(
      width: widget.width * 0.22,
      height: 200,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: achromatic800,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [overlayShadow],
      ),
      child: ListView.separated(
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 54,
            child: InkWell(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              onTap: () {
                onTap(index);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        users[index].name ?? '',
                        style: body1Regular.copyWith(
                          color: achromatic200,
                        ),
                      ),
                      Text(
                        users[index].email ?? '',
                        style: body2Regular.copyWith(
                          color: achromatic300,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return h8;
        },
        itemCount: users.length,
      ),
    );
  }

  Skeletonizer _buildLoadingSearchResults() {
    return Skeletonizer(
      child: Container(
        width: widget.width * 0.22,
        height: 200,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: achromatic800,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [overlayShadow],
        ),
        child: ListView.separated(
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return SizedBox(
              height: 54,
              child: InkWell(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                onTap: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'loading name',
                          style: body1Regular.copyWith(
                            color: achromatic200,
                          ),
                        ),
                        Text(
                          'loadingname@gmail.com',
                          style: body2Regular.copyWith(
                            color: achromatic300,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return h8;
          },
          itemCount: 3,
        ),
      ),
    );
  }
}
