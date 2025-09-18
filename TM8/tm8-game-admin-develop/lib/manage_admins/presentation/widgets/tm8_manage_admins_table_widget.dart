import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:tm8_game_admin/app/constants/constants.dart';
import 'package:tm8_game_admin/app/constants/fonts.dart';
import 'package:tm8_game_admin/app/constants/palette.dart';
import 'package:tm8_game_admin/app/services/service_locator.dart';
import 'package:tm8_game_admin/app/storage/tm8_game_admin_storage.dart';
import 'package:tm8_game_admin/gen/assets.gen.dart';
import 'package:tm8_game_admin/manage_admins/presentation/logic/selected_admin_row_cubit/selected_admin_row_cubit.dart';
import 'package:tm8_game_admin/manage_users/presentation/logic/table_on_hover_cubit/table_on_hover_cubit.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

class Tm8ManageAdminsTableWidget extends StatefulWidget {
  const Tm8ManageAdminsTableWidget({
    super.key,
    required this.columnNames,
    required this.onSortAscending,
    required this.onSortDescending,
    required this.items,
    this.sort,
    required this.onRowPressed,
    required this.onActionRowPressed,
  });

  final List<Tm8MainAdminRow> columnNames;
  final List<UserResponse> items;
  final String? sort;
  final Function(String) onSortAscending;
  final Function(String) onSortDescending;
  final Function(String) onRowPressed;
  final Function(UserResponse) onActionRowPressed;

  @override
  State<Tm8ManageAdminsTableWidget> createState() =>
      _Tm8ManageAdminsTableWidgetState();
}

class _Tm8ManageAdminsTableWidgetState
    extends State<Tm8ManageAdminsTableWidget> {
  var selectedValues = <bool>[];

  @override
  void initState() {
    super.initState();
    selectedValues = List.generate(widget.items.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SelectedAdminRowCubit, List<String>>(
      listener: (context, state) {
        for (var itemIndex = 0; itemIndex < widget.items.length; itemIndex++) {
          final mainValue = state.any(
            (element) => element == widget.items[itemIndex].id,
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
                  2: const FlexColumnWidth(0.15),
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
    final roleName = widget.items[itemIndex].role?.name;

    return TableCell(
      child: InkWell(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        onTap: () {
          widget.onRowPressed(widget.items[itemIndex].id);
        },
        onHover: (value) {
          // you can't delete yourself or super admins
          if (roleName != 'superadmin' &&
              widget.items[itemIndex].email !=
                  sl<Tm8GameAdminStorage>().userEmail &&
              sl<Tm8GameAdminStorage>().userRole != 'admin') {
            context
                .read<TableOnHoverCubit>()
                .changeHoverState(isHover: true, index: itemIndex);
          }
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
                        if (state.isHover &&
                            state.index == itemIndex &&
                            roleName != 'superadmin' &&
                            widget.items[itemIndex].id !=
                                sl<Tm8GameAdminStorage>().userId) {
                          return SizedBox(
                            height: 15,
                            width: 15,
                            child: SvgPicture.asset(
                              Assets.common.delete.path,
                              fit: BoxFit.scaleDown,
                            ),
                          );
                        } else if (selectedValues[itemIndex] &&
                            roleName != 'superadmin' &&
                            widget.items[itemIndex].id !=
                                sl<Tm8GameAdminStorage>().userId) {
                          return SizedBox(
                            height: 15,
                            width: 15,
                            child: SvgPicture.asset(
                              Assets.common.delete.path,
                              fit: BoxFit.scaleDown,
                            ),
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
                      BlocBuilder<SelectedAdminRowCubit, List<String>>(
                        builder: (context, state) {
                          final mainValue = state.any(
                            (element) => element == widget.items[itemIndex].id,
                          );
                          if (widget.items[itemIndex].role?.name ==
                                  'superadmin' ||
                              sl<Tm8GameAdminStorage>().userRole == 'admin') {
                            return w30;
                          }
                          return Checkbox(
                            onChanged: (value) {
                              context
                                  .read<SelectedAdminRowCubit>()
                                  .addSelectedAdmin(widget.items[itemIndex].id);
                            },
                            fillColor: MaterialStatePropertyAll(
                              state.any(
                                (element) =>
                                    element == widget.items[itemIndex].id,
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
                              color: roleName == 'superadmin'
                                  ? successColor.withOpacity(0.17)
                                  : warningColor.withOpacity(0.21),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Center(
                              child: Text(
                                statusMapAdmin[roleName] ?? 'Non',
                                style: body1Regular.copyWith(
                                  color: roleName == 'superadmin'
                                      ? successColor
                                      : warningColor,
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
                      BlocBuilder<SelectedAdminRowCubit, List<String>>(
                        builder: (context, state) {
                          var selectable = <UserResponse>[];
                          selectable = widget.items
                              .where(
                                (element) => element.role?.name == 'admin',
                              )
                              .toList();
                          if (sl<Tm8GameAdminStorage>().userRole == 'admin') {
                            return w30;
                          }
                          return Checkbox(
                            onChanged: (value) {
                              if (value != null) {
                                selectedValues.every((element) => true);

                                if (selectable.isNotEmpty) {
                                  context
                                      .read<TableOnHoverCubit>()
                                      .changeHoverState(
                                        isHover: true,
                                        index: 0,
                                      );
                                  context
                                      .read<SelectedAdminRowCubit>()
                                      .addRemoveAllAdmins(
                                        value: value,
                                        selectedAdminId: value
                                            ? List.generate(
                                                selectable.length,
                                                (index) => selectable[index].id,
                                              )
                                            : [],
                                      );
                                }
                              }
                            },
                            fillColor: MaterialStatePropertyAll(
                              state.length == selectable.length &&
                                      state.isNotEmpty
                                  ? primaryTeal
                                  : Colors.transparent,
                            ),
                            activeColor: primaryTeal,
                            value: state.length == selectable.length &&
                                state.isNotEmpty,
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
                              widget.onSortAscending(
                                '+${widget.columnNames[i].key}',
                              );
                            },
                            child: SvgPicture.asset(
                              Assets.common.sortAscending.path,
                              colorFilter: widget.sort != null
                                  ? widget.sort!.contains('+name') &&
                                              widget.columnNames[i].name ==
                                                  'Name' ||
                                          widget.sort!.contains('+email') &&
                                              widget.columnNames[i].name ==
                                                  'Email address' ||
                                          widget.sort!.contains('+_id') &&
                                              widget.columnNames[i].name ==
                                                  'ID' ||
                                          widget.sort!.contains('+lastLogin') &&
                                              widget.columnNames[i].name ==
                                                  'Last login'
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
                              widget.onSortDescending(
                                '-${widget.columnNames[i].key}',
                              );
                            },
                            child: SvgPicture.asset(
                              Assets.common.sortDescending.path,
                              colorFilter: widget.sort != null
                                  ? widget.sort!.contains('-name') &&
                                              widget.columnNames[i].name ==
                                                  'Name' ||
                                          widget.sort!.contains('-email') &&
                                              widget.columnNames[i].name ==
                                                  'Email address' ||
                                          widget.sort!.contains('-_id') &&
                                              widget.columnNames[i].name ==
                                                  'ID' ||
                                          widget.sort!.contains('-lastLogin') &&
                                              widget.columnNames[i].name ==
                                                  'Last login'
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
        return widget.items[itemIndex].name ?? '-';
      case 1:
        return widget.items[itemIndex].email ?? '';
      case 2:
        return widget.items[itemIndex].id;
      case 4:
        return widget.items[itemIndex].lastLogin != null
            ? DateFormat('dd/MM/yyyy').format(
                widget.items[itemIndex].lastLogin!,
              )
            : '-';
      default:
        return '';
    }
  }
}

class Tm8MainAdminRow {
  const Tm8MainAdminRow({
    required this.name,
    required this.key,
    required this.sort,
  });

  final String name;
  final String key;
  final bool sort;
}

final Map<String, String> statusMapAdmin = {
  'admin': 'Admin',
  'superadmin': 'Superadmin',
};
