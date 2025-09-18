import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tm8_game_admin/app/constants/constants.dart';
import 'package:tm8_game_admin/app/constants/fonts.dart';
import 'package:tm8_game_admin/app/constants/palette.dart';
import 'package:tm8_game_admin/app/widgets/tm8_table_widget.dart';
import 'package:tm8_game_admin/gen/assets.gen.dart';
import 'package:tm8_game_admin/manage_users/presentation/logic/table_on_hover_cubit/table_on_hover_cubit.dart';
import 'package:tm8_game_admin/notifications/presentation/logic/selected_notification_row_cubit/selected_notification_row_cubit.dart';
import 'package:tm8_game_admin/swagger_generated_code/swagger.swagger.dart';

class Tm8NotificationTableWidget extends StatefulWidget {
  const Tm8NotificationTableWidget({
    super.key,
    required this.columnNames,
    required this.onSortAscending,
    required this.onSortDescending,
    required this.items,
    this.sort,
    required this.onRowPressed,
    required this.onActionRowEditPressed,
    required this.onActionRowDeletePressed,
  });

  final List<Tm8MainRow> columnNames;
  final Function(String) onSortAscending;
  final Function(String) onSortDescending;
  final List<ScheduledNotificationResponse> items;
  final String? sort;
  final Function(ScheduledNotificationResponse) onRowPressed;
  final Function(ScheduledNotificationResponse) onActionRowEditPressed;
  final Function(ScheduledNotificationResponse) onActionRowDeletePressed;

  @override
  State<Tm8NotificationTableWidget> createState() =>
      _Tm8NotificationTableWidgetState();
}

class _Tm8NotificationTableWidgetState
    extends State<Tm8NotificationTableWidget> {
  var selectedValues = <bool>[];

  @override
  void initState() {
    super.initState();
    selectedValues = List.generate(widget.items.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SelectedNotificationRowCubit, List<String>>(
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
                  1: const FlexColumnWidth(0.08),
                  2: const FlexColumnWidth(0.08),
                  3: const FlexColumnWidth(0.1),
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
    return TableCell(
      child: InkWell(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        onTap: () {
          widget.onRowPressed(widget.items[itemIndex]);
        },
        onHover: (value) {
          context
              .read<TableOnHoverCubit>()
              .changeHoverState(isHover: true, index: itemIndex);
        },
        child: SizedBox(
          height: 48,
          child: cellIndex == widget.columnNames.length
              ? Padding(
                  padding: const EdgeInsets.only(right: 25),
                  child: BlocBuilder<TableOnHoverCubit, TableHoverClass>(
                    builder: (context, state) {
                      if (state.isHover && state.index == itemIndex) {
                        return SizedBox(
                          height: 15,
                          width: 15,
                          child: Row(
                            children: [
                              InkWell(
                                overlayColor: MaterialStateProperty.all(
                                  Colors.transparent,
                                ),
                                onTap: () {
                                  widget.onActionRowEditPressed(
                                    widget.items[itemIndex],
                                  );
                                },
                                child: SvgPicture.asset(
                                  Assets.common.edit.path,
                                ),
                              ),
                              w6,
                              InkWell(
                                overlayColor: MaterialStateProperty.all(
                                  Colors.transparent,
                                ),
                                onTap: () {
                                  widget.onActionRowDeletePressed(
                                    widget.items[itemIndex],
                                  );
                                },
                                child: SvgPicture.asset(
                                  Assets.common.delete.path,
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (selectedValues[itemIndex]) {
                        return SizedBox(
                          height: 15,
                          width: 15,
                          child: Row(
                            children: [
                              SvgPicture.asset(Assets.common.edit.path),
                              w6,
                              SvgPicture.asset(Assets.common.delete.path),
                            ],
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                )
              : Row(
                  children: [
                    if (cellIndex == 0) ...[
                      BlocBuilder<SelectedNotificationRowCubit, List<String>>(
                        builder: (context, state) {
                          final mainValue = state.any(
                            (element) => element == widget.items[itemIndex].id,
                          );
                          return Checkbox(
                            onChanged: (value) {
                              if (value != null) {
                                context
                                    .read<SelectedNotificationRowCubit>()
                                    .addSelectedNotification(
                                      widget.items[itemIndex].id,
                                    );
                              }
                            },
                            fillColor: MaterialStatePropertyAll(
                              mainValue ? primaryTeal : Colors.transparent,
                            ),
                            activeColor: primaryTeal,
                            value: mainValue,
                          );
                        },
                      ),
                      w24,
                    ],
                    Text(
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
                      BlocBuilder<SelectedNotificationRowCubit, List<String>>(
                        builder: (context, state) {
                          return Checkbox(
                            onChanged: (value) {
                              if (value != null) {
                                selectedValues.every((element) => true);

                                context
                                    .read<TableOnHoverCubit>()
                                    .changeHoverState(isHover: true, index: 0);
                                context
                                    .read<SelectedNotificationRowCubit>()
                                    .addRemoveAllNotifications(
                                      value: value,
                                      selectedNotificationIds: List.generate(
                                        widget.items.length,
                                        (index) => widget.items[index].id,
                                      ),
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
                                  ? widget.sort!.contains('+title') &&
                                              widget.columnNames[i].name ==
                                                  'Title' ||
                                          widget.sort!.contains(
                                                '+notificationId',
                                              ) &&
                                              widget.columnNames[i].name ==
                                                  'Notification ID'
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
                                  ? widget.sort!.contains('-title') &&
                                              widget.columnNames[i].name ==
                                                  'Title' ||
                                          widget.sort!.contains(
                                                '-notificationId',
                                              ) &&
                                              widget.columnNames[i].name ==
                                                  'Notification ID'
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
        return widget.items[itemIndex].data.title;
      case 1:
        return widget.items[itemIndex].uniqueId;
      case 2:
        return notificationTypeMap[
                widget.items[itemIndex].data.notificationType] ??
            '-';
      case 3:
        return targetGroupMap[widget.items[itemIndex].data.targetGroup] ?? '-';
      case 4:
        return widget.items[itemIndex].interval;
      default:
        return '';
    }
  }
}

final Map<ScheduledNotificationDataResponseNotificationType, String>
    notificationTypeMap = {
  ScheduledNotificationDataResponseNotificationType.other: 'Other',
  ScheduledNotificationDataResponseNotificationType.communityNews:
      'Community news',
  ScheduledNotificationDataResponseNotificationType.exclusiveOffers:
      'Exclusive offers',
  ScheduledNotificationDataResponseNotificationType.gameUpdate: 'Game update',
  ScheduledNotificationDataResponseNotificationType.newFeatures: 'New features',
  ScheduledNotificationDataResponseNotificationType.systemMaintenance:
      'System maintenance',
};

final Map<ScheduledNotificationDataResponseTargetGroup, String> targetGroupMap =
    {
  ScheduledNotificationDataResponseTargetGroup.allUsers: 'All players',
  ScheduledNotificationDataResponseTargetGroup.apexLegendsPlayers:
      'Apex Legends players',
  ScheduledNotificationDataResponseTargetGroup.callOfDutyPlayers:
      'Call of Duty players',
  ScheduledNotificationDataResponseTargetGroup.fortnitePlayers:
      'Fortnite players',
  ScheduledNotificationDataResponseTargetGroup.rocketLeaguePlayers:
      'Rocket League players',
  ScheduledNotificationDataResponseTargetGroup.individualUser:
      'Individual player',
};
