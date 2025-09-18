import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:tm8_game_admin/app/constants/constants.dart';
import 'package:tm8_game_admin/app/constants/fonts.dart';
import 'package:tm8_game_admin/app/constants/palette.dart';
import 'package:tm8_game_admin/gen/assets.gen.dart';
import 'package:tm8_game_admin/manage_users/presentation/logic/table_on_hover_cubit/table_on_hover_cubit.dart';
import 'package:tm8_game_admin/manage_users/presentation/logic/selected_row_users/selected_row_users_cubit.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

class Tm8UserTableWidget extends StatefulWidget {
  const Tm8UserTableWidget({
    super.key,
    required this.columnNames,
    required this.onSortAscending,
    required this.onSortDescending,
    required this.items,
    this.sort,
    required this.onRowPressed,
    required this.onActionRowPressed,
  });

  final List<Tm8MainRow> columnNames;
  final Function(String) onSortAscending;
  final Function(String) onSortDescending;
  final List<UserResponse> items;
  final String? sort;
  final Function(String) onRowPressed;
  final Function(UserResponse) onActionRowPressed;

  @override
  State<Tm8UserTableWidget> createState() => _Tm8UserTableWidgetState();
}

class _Tm8UserTableWidgetState extends State<Tm8UserTableWidget> {
  var selectedValues = <bool>[];

  @override
  void initState() {
    super.initState();
    selectedValues = List.generate(widget.items.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SelectedRowUsersCubit, List<SelectedUser>>(
      listener: (context, state) {
        for (var itemIndex = 0; itemIndex < widget.items.length; itemIndex++) {
          final mainValue = state.any(
            (element) => element.id == widget.items[itemIndex].id,
          );
          selectedValues[itemIndex] = mainValue;
        }
      },
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8 < 1000
                ? 1000
                : MediaQuery.of(context).size.width * 0.8,
            child: Table(
              columnWidths: Map.from(
                {
                  0: const FlexColumnWidth(0.15),
                  1: const FlexColumnWidth(0.15),
                  2: const FlexColumnWidth(0.08),
                  3: const FlexColumnWidth(0.08),
                  4: const FlexColumnWidth(0.05),
                  5: const FlexColumnWidth(0.05),
                },
              ),
              children: [
                _buildMainRow(),
                for (var i = 0; i < widget.items.length * 2; i++)
                  if (i % 2 == 0)
                    TableRow(
                      decoration: BoxDecoration(
                        color: achromatic800,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      children: [
                        for (var j = 0; j < widget.columnNames.length + 1; j++)
                          _buildTableCell(
                            itemIndex: int.parse((i / 2).toString()),
                            cellIndex: j,
                            context: context,
                          ),
                      ],
                    )
                  else
                    _constantRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TableCell _buildTableCell({
    required int itemIndex,
    required int cellIndex,
    required BuildContext context,
  }) {
    final statusName = widget.items[itemIndex].status?.type.name;

    return TableCell(
      child: InkWell(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        onTap: () {
          widget.onRowPressed(widget.items[itemIndex].id);
        },
        onHover: (value) {
          context
              .read<TableOnHoverCubit>()
              .changeHoverState(isHover: true, index: itemIndex);
        },
        child: SizedBox(
          height: 48,
          child: cellIndex == widget.columnNames.length
              ? InkWell(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  onTap: () {
                    widget.onActionRowPressed(widget.items[itemIndex]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: BlocBuilder<TableOnHoverCubit, TableHoverClass>(
                      builder: (context, state) {
                        if (state.isHover && state.index == itemIndex) {
                          return SizedBox(
                            height: 15,
                            width: 15,
                            child: statusMapAssetImage[
                                widget.items[itemIndex].status?.type],
                          );
                        } else if (selectedValues[itemIndex]) {
                          return SizedBox(
                            height: 15,
                            width: 15,
                            child: statusMapAssetImage[
                                widget.items[itemIndex].status?.type],
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ),
                )
              : Row(
                  children: [
                    if (cellIndex == 0) ...[
                      BlocBuilder<SelectedRowUsersCubit, List<SelectedUser>>(
                        builder: (context, state) {
                          final mainValue = state.any(
                            (element) =>
                                element.id == widget.items[itemIndex].id,
                          );
                          return Checkbox(
                            onChanged: (value) {
                              context
                                  .read<SelectedRowUsersCubit>()
                                  .addSelectedUser(
                                    SelectedUser(
                                      id: widget.items[itemIndex].id,
                                      status: widget
                                              .items[itemIndex].status?.type ??
                                          UserStatusResponseType.active,
                                      note: widget
                                              .items[itemIndex].status?.note ??
                                          '',
                                    ),
                                  );
                            },
                            fillColor: MaterialStatePropertyAll(
                              state.any(
                                (element) =>
                                    element.id == widget.items[itemIndex].id,
                              )
                                  ? primaryTeal
                                  : Colors.transparent,
                            ),
                            activeColor: primaryTeal,
                            checkColor: achromatic100,
                            value: mainValue,
                          );
                        },
                      ),
                      w24,
                    ],
                    cellIndex == 3
                        ? Container(
                            height: 24,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            decoration: BoxDecoration(
                              color: statusName == 'active'
                                  ? successColor.withOpacity(0.17)
                                  : statusName == 'banned' ||
                                          statusName == 'suspended'
                                      ? warningColor.withOpacity(0.21)
                                      : achromatic600,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Center(
                              child: Text(
                                statusMap[statusName] ?? 'Non',
                                style: body1Regular.copyWith(
                                  color: statusName == 'active'
                                      ? successColor
                                      : statusName == 'banned' ||
                                              statusName == 'suspended'
                                          ? warningColor
                                          : achromatic200,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                        : Text(
                            _cellText(cellIndex, itemIndex),
                            style: body1Regular.copyWith(
                              color: achromatic100,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                  ],
                ),
        ),
      ),
    );
  }

  TableRow _constantRow() => const TableRow(children: [h8, h8, h8, h8, h8, h8]);

  TableRow _buildMainRow() {
    return TableRow(
      children: [
        for (var i = 0; i < widget.columnNames.length + 1; i++) ...[
          if (i == widget.columnNames.length) ...[
            const TableCell(
              child: SizedBox(
                height: 48,
              ),
            ),
          ] else
            TableCell(
              child: SizedBox(
                height: 48,
                child: Row(
                  children: [
                    if (i == 0) ...[
                      BlocBuilder<SelectedRowUsersCubit, List<SelectedUser>>(
                        builder: (context, state) {
                          return Checkbox(
                            onChanged: (value) {
                              if (value != null) {
                                selectedValues.every((element) => true);

                                context
                                    .read<TableOnHoverCubit>()
                                    .changeHoverState(isHover: true, index: 0);
                                context
                                    .read<SelectedRowUsersCubit>()
                                    .addRemoveAllUsers(
                                      value: value,
                                      mainSelectedUsers: value
                                          ? List.generate(
                                              widget.items.length,
                                              (index) => SelectedUser(
                                                id: widget.items[index].id,
                                                status: widget.items[index]
                                                        .status?.type ??
                                                    UserStatusResponseType
                                                        .active,
                                                note: widget.items[index].status
                                                        ?.note ??
                                                    '',
                                              ),
                                            )
                                          : [],
                                    );
                              }
                            },
                            fillColor: MaterialStatePropertyAll(
                              state.length == widget.items.length
                                  ? primaryTeal
                                  : Colors.transparent,
                            ),
                            activeColor: primaryTeal,
                            value: state.length == widget.items.length,
                          );
                        },
                      ),
                      w24,
                    ],
                    Text(
                      widget.columnNames[i].name,
                      style: body1Regular.copyWith(
                        color: achromatic300,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (widget.columnNames[i].sort) ...[
                      w6,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            onTap: () {
                              widget
                                  .onSortAscending(widget.columnNames[i].name);
                            },
                            child: SvgPicture.asset(
                              'assets/common/sort_ascending.svg',
                              colorFilter: widget.sort != null
                                  ? widget.sort!.contains('+username') &&
                                              widget.columnNames[i].name ==
                                                  'Username' ||
                                          widget.sort!.contains('+email') &&
                                              widget.columnNames[i].name ==
                                                  'Email address' ||
                                          widget.sort!.contains('+createdAt') &&
                                              widget.columnNames[i].name ==
                                                  'Joined'
                                      ? ColorFilter.mode(
                                          achromatic100,
                                          BlendMode.srcIn,
                                        )
                                      : null
                                  : null,
                            ),
                          ),
                          h2,
                          InkWell(
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            onTap: () {
                              widget
                                  .onSortDescending(widget.columnNames[i].name);
                            },
                            child: SvgPicture.asset(
                              'assets/common/sort_descending.svg',
                              colorFilter: widget.sort != null
                                  ? widget.sort!.contains('-username') &&
                                              widget.columnNames[i].name ==
                                                  'Username' ||
                                          widget.sort!.contains('-email') &&
                                              widget.columnNames[i].name ==
                                                  'Email address' ||
                                          widget.sort!.contains('-createdAt') &&
                                              widget.columnNames[i].name ==
                                                  'Joined'
                                      ? ColorFilter.mode(
                                          achromatic100,
                                          BlendMode.srcIn,
                                        )
                                      : null
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
        ],
      ],
    );
  }

  String _cellText(int cellIndex, int itemIndex) {
    switch (cellIndex) {
      case 0:
        return widget.items[itemIndex].username ?? '-';
      case 1:
        return widget.items[itemIndex].email ?? '';
      case 2:
        return DateFormat('dd/MM/yyyy').format(
          widget.items[itemIndex].createdAt ?? DateTime.now(),
        );
      case 4:
        return widget.items[itemIndex].country ?? '-';
      default:
        return '';
    }
  }
}

class Tm8MainRow {
  const Tm8MainRow({
    required this.name,
    required this.sort,
  });

  final String name;
  final bool sort;
}

final Map<String, String> statusMap = {
  'active': 'Active User',
  'inactive': 'Inactive User',
  'banned': 'Banned User',
  'reported': 'Reported User',
  'suspended': 'Suspended User',
};

final Map<UserStatusResponseType, SvgPicture?> statusMapAssetImage = {
  UserStatusResponseType.active: SvgPicture.asset(
    Assets.user.userBan.path,
    fit: BoxFit.scaleDown,
  ),
  UserStatusResponseType.banned: SvgPicture.asset(
    Assets.user.userReset.path,
    fit: BoxFit.scaleDown,
    colorFilter: ColorFilter.mode(primaryTeal, BlendMode.srcIn),
  ),
  UserStatusResponseType.inactive: null,
  UserStatusResponseType.pending: null,
  UserStatusResponseType.reported: SvgPicture.asset(
    Assets.user.userBan.path,
    fit: BoxFit.scaleDown,
  ),
  UserStatusResponseType.suspended: SvgPicture.asset(
    Assets.user.userReset.path,
    fit: BoxFit.scaleDown,
    colorFilter: ColorFilter.mode(primaryTeal, BlendMode.srcIn),
  ),
};
