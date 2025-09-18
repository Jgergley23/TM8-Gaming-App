import 'dart:async';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/router/router.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/widgets/tm8_body_container_widget.dart';
import 'package:tm8/app/widgets/tm8_error_widget.dart';
import 'package:tm8/app/widgets/tm8_main_app_bar_scaffold_widget.dart';
import 'package:tm8/app/widgets/tm8_search_widget.dart';
import 'package:tm8/env/env.dart';
import 'package:tm8/messages/presentation/logic/fetch_channels_cubit/fetch_channels_cubit.dart';
import 'package:tm8/messages/presentation/logic/search_users_cubit/search_users_cubit.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

@RoutePage() //SearchUsersMessagesRoute.page
class SearchUsersMessagesScreen extends StatefulWidget {
  const SearchUsersMessagesScreen({super.key});

  @override
  State<SearchUsersMessagesScreen> createState() =>
      _SearchUsersMessagesScreenState();
}

class _SearchUsersMessagesScreenState extends State<SearchUsersMessagesScreen> {
  final searchUsersCubit = sl<SearchUsersCubit>();
  String search = '';
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
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => searchUsersCubit,
      child: GestureDetector(
        onTap: () {
          focusNode.unfocus();
        },
        child: Tm8BodyContainerWidget(
          child: Scaffold(
            appBar: Tm8MainAppBarScaffoldWidget(
              leading: true,
              title: 'New message',
              navigationPadding: screenPadding,
              focusNode: focusNode,
            ),
            body: SingleChildScrollView(
              padding: screenPadding,
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
                    hintText: 'Search',
                    width: 270,
                  ),
                  h12,
                  BlocBuilder<SearchUsersCubit, SearchUsersState>(
                    builder: (context, state) {
                      return state.when(
                        initial: SizedBox.new,
                        loading: () {
                          return _buildSearchUsersLoading();
                        },
                        loaded: (users) {
                          return ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return _buildUserItem(users, index);
                            },
                            separatorBuilder: (context, index) {
                              return h12;
                            },
                            itemCount: users.length,
                          );
                        },
                        error: (error) {
                          return Tm8ErrorWidget(
                            onTapRetry: () {},
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

  Skeletonizer _buildSearchUsersLoading() {
    return Skeletonizer(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return _buildUserItem(
            [
              const UserSearchResponse(
                id: '',
                username: 'testing',
                friend: false,
              ),
              const UserSearchResponse(
                id: '',
                username: 'testing',
                friend: false,
              ),
              const UserSearchResponse(
                id: '',
                username: 'testing',
                friend: false,
              ),
              const UserSearchResponse(
                id: '',
                username: 'testing',
                friend: false,
              ),
            ],
            index,
          );
        },
        separatorBuilder: (context, index) {
          return h12;
        },
        itemCount: 4,
      ),
    );
  }

  GestureDetector _buildUserItem(List<UserSearchResponse> users, int index) {
    return GestureDetector(
      onTap: () {
        context
            .pushRoute(
          MessagingRoute(
            username: users[index].username,
            userId: users[index].id,
          ),
        )
            .whenComplete(() {
          sl<FetchChannelsCubit>().refetchMessages();
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: achromatic700,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
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
                  fit: BoxFit.fill,
                ),
              ),
            ],
            w8,
            Text(
              users[index].username,
              style: body1Regular.copyWith(color: achromatic100),
            ),
          ],
        ),
      ),
    );
  }
}
