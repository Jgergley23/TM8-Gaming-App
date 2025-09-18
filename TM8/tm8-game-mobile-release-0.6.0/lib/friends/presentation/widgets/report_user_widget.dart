import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/app/services/service_locator.dart';
import 'package:tm8/app/widgets/tm8_error_widget.dart';
import 'package:tm8/app/widgets/tm8_main_button_widget.dart';
import 'package:tm8/app/widgets/tm8_snack_bar_widget.dart';
import 'package:tm8/gen/assets.gen.dart';
import 'package:tm8/messages/presentation/logic/fetch_report_types_cubit/fetch_report_types_cubit.dart';
import 'package:tm8/messages/presentation/logic/selected_reports_cubit/selected_reports_cubit.dart';

class ReportUserWidget extends StatefulWidget {
  const ReportUserWidget({super.key, required this.onTap});
  final Function(String) onTap;

  @override
  State<ReportUserWidget> createState() => _ReportUserWidgetState();
}

class _ReportUserWidgetState extends State<ReportUserWidget> {
  final selectedReportsCubit = sl<SelectedReportsCubit>();
  final fetchReportTypesCubit = sl<FetchReportTypesCubit>();
  var selectedReports = <String>[];
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => selectedReportsCubit,
            ),
            BlocProvider(
              create: (context) => fetchReportTypesCubit..fetchReportTypes(),
            ),
          ],
          child: BlocListener<SelectedReportsCubit, List<String>>(
            listener: (context, state) {
              selectedReports = state;
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Report User',
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
                BlocBuilder<FetchReportTypesCubit, FetchReportTypesState>(
                  builder: (context, state) {
                    return state.when(
                      initial: SizedBox.new,
                      loading: () {
                        return _loadingReports();
                      },
                      loaded: (reportTypes) {
                        return ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                context.read<SelectedReportsCubit>().addReport(
                                      report:
                                          reportTypes[index].key.value ?? '',
                                    );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  BlocBuilder<SelectedReportsCubit,
                                      List<String>>(
                                    builder: (context, state) {
                                      return Checkbox(
                                        onChanged: (value) {
                                          context
                                              .read<SelectedReportsCubit>()
                                              .addReport(
                                                report: reportTypes[index]
                                                        .key
                                                        .value ??
                                                    '',
                                              );
                                        },
                                        fillColor: WidgetStatePropertyAll(
                                          state.contains(
                                            reportTypes[index].key.value,
                                          )
                                              ? primaryTeal
                                              : Colors.transparent,
                                        ),
                                        activeColor: primaryTeal,
                                        checkColor: achromatic100,
                                        value: state.contains(
                                          reportTypes[index].key.value,
                                        ),
                                        visualDensity: VisualDensity.compact,
                                      );
                                    },
                                  ),
                                  Text(
                                    reportTypes[index].name,
                                    style: body1Regular.copyWith(
                                      color: achromatic100,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return h8;
                          },
                          itemCount: reportTypes.length,
                        );
                      },
                      error: (error) {
                        return Tm8ErrorWidget(
                          onTapRetry: () {
                            fetchReportTypesCubit.fetchReportTypes();
                          },
                          error: error,
                        );
                      },
                    );
                  },
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
                        if (selectedReports.isEmpty) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            Tm8SnackBar.snackBar(
                              color: glassEffectColor,
                              text: 'No Report Selected',
                              error: false,
                            ),
                          );
                          return;
                        }
                        widget.onTap(selectedReports.first);

                        Navigator.of(context).pop();
                      },
                      buttonColor: errorTextColor,
                      text: 'Report',
                      width: 130,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Skeletonizer _loadingReports() {
    return Skeletonizer(
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BlocBuilder<SelectedReportsCubit, List<String>>(
                  builder: (context, state) {
                    return Checkbox(
                      onChanged: (value) {},
                      fillColor: const WidgetStatePropertyAll(
                        Colors.transparent,
                      ),
                      activeColor: primaryTeal,
                      checkColor: achromatic100,
                      value: false,
                      visualDensity: VisualDensity.compact,
                    );
                  },
                ),
                Text(
                  'Report Type harassment',
                  style: body1Regular.copyWith(
                    color: achromatic100,
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return h8;
        },
        itemCount: 8,
      ),
    );
  }
}
