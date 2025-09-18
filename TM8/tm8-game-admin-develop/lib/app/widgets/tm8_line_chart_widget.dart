import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tm8_game_admin/app/constants/constants.dart';
import 'package:tm8_game_admin/app/constants/fonts.dart';
import 'package:tm8_game_admin/app/constants/palette.dart';

class Tm8LineChartWidget extends StatefulWidget {
  const Tm8LineChartWidget({
    super.key,
    required this.maxX,
    required this.maxY,
    required this.flSpot,
    required this.titles,
    required this.selectedValue,
  });

  final double maxX;
  final double maxY;
  final List<FlSpot> flSpot;
  final List<String> titles;
  final String selectedValue;

  @override
  State<Tm8LineChartWidget> createState() => _Tm8LineChartWidgetState();
}

class _Tm8LineChartWidgetState extends State<Tm8LineChartWidget> {
  var interval = 0;
  var yearlyTitles = ['Q1', 'Q2', 'Q3', 'Q4'];

  @override
  void initState() {
    super.initState();
    interval = widget.selectedValue == 'Yearly'
        ? widget.maxY ~/ 40
        : widget.selectedValue == 'All time'
            ? widget.maxY ~/ 40
            : widget.maxY ~/ 10;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 206,
      child: Stack(
        children: [
          if (widget.flSpot.isEmpty)
            Center(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: achromatic600,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'No chart data for selected period',
                  style: body1Regular.copyWith(color: achromatic200),
                ),
              ),
            ),
          LineChart(
            LineChartData(
              maxX: widget.maxX,
              maxY: widget.maxY,
              clipData: const FlClipData(
                top: false,
                bottom: false,
                left: false,
                right: false,
              ),
              lineTouchData: LineTouchData(
                enabled: true,
                touchTooltipData: LineTouchTooltipData(
                  getTooltipItems: (touchedBarSpots) {
                    return touchedBarSpots.map(
                      (barSpot) {
                        final flSpot = barSpot;
                        final title = widget.titles[flSpot.x.toInt()];
                        return LineTooltipItem(
                          '${flSpot.y} users',
                          body1Regular.copyWith(color: achromatic100),
                          children: [
                            TextSpan(
                              text: '\n$title',
                              style: captionRegular.copyWith(
                                color: achromatic200,
                              ),
                            ),
                          ],
                        );
                      },
                    ).toList();
                  },
                  tooltipBgColor: achromatic600,
                  tooltipRoundedRadius: 8,
                ),
              ),
              borderData: FlBorderData(
                border: const Border(),
              ),
              gridData: FlGridData(
                drawVerticalLine: false,
                drawHorizontalLine: true,
                show: true,
                horizontalInterval: interval == 0 ? 10 : widget.maxY / interval,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: achromatic600,
                    strokeWidth: 1,
                  );
                },
                checkToShowHorizontalLine: (value) {
                  return value == 0.0 ? false : true;
                },
              ),
              titlesData: FlTitlesData(
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                  ),
                ),
                leftTitles: AxisTitles(
                  axisNameSize: 40,
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: interval == 0 ? 10 : widget.maxY / interval,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        (value).toStringAsFixed(0),
                        style: body2Regular.copyWith(color: achromatic300),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  axisNameSize: 40,
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: _getInterval(),
                    getTitlesWidget: (value, meta) {
                      if (widget.selectedValue == 'Yearly' ||
                          widget.selectedValue == 'All time') {
                        return Column(
                          children: [
                            h5,
                            Text(
                              value == 0
                                  ? yearlyTitles[0]
                                  : value == 13
                                      ? yearlyTitles[1]
                                      : value == 26
                                          ? yearlyTitles[2]
                                          : value == 39
                                              ? yearlyTitles[3]
                                              : '',
                              style:
                                  body2Regular.copyWith(color: achromatic300),
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            h5,
                            Text(
                              widget.titles[value.toInt()],
                              style:
                                  body2Regular.copyWith(color: achromatic300),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  barWidth: 3,
                  isStrokeCapRound: true,
                  curveSmoothness: 0.05,
                  isStrokeJoinRound: true,
                  show: true,
                  isCurved: true,
                  color: primaryTeal,
                  preventCurveOverShooting: true,
                  spots: widget.flSpot,
                  dotData: const FlDotData(show: true),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _getInterval() {
    double interval = 1;
    if (widget.selectedValue == 'Monthly') {
      interval = 2;
    } else if (widget.selectedValue == 'Yearly' ||
        widget.selectedValue == 'All time') {
      interval = 13;
    }
    return interval;
  }
}
