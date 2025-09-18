import 'package:flutter/material.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/swagger_generated_code/swagger.swagger.dart';

class Tm8GamePreferencesSliderWidget extends StatefulWidget {
  const Tm8GamePreferencesSliderWidget({
    super.key,
    required this.onChanged,
    required this.mainPreference,
    required this.titles,
    this.selectedPreference,
  });

  final String mainPreference;
  final List<double>? selectedPreference;
  final void Function(double, int) onChanged;
  final List<SliderOptionResponse> titles;

  @override
  State<Tm8GamePreferencesSliderWidget> createState() =>
      _Tm8GamePreferencesSliderWidgetState();
}

class _Tm8GamePreferencesSliderWidgetState
    extends State<Tm8GamePreferencesSliderWidget> {
  var value = <double>[];

  @override
  void initState() {
    super.initState();
    if (widget.selectedPreference != null) {
      value = widget.selectedPreference!;
    } else {
      value = List.generate(widget.titles.length, (index) => 3);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.mainPreference,
          style: heading4Regular.copyWith(
            color: achromatic100,
          ),
        ),
        h12,
        Column(
          children: List.generate(
            widget.titles.length,
            (index) => Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.titles[index].minValue,
                      style: body1Regular.copyWith(
                        color: achromatic200,
                      ),
                    ),
                    Text(
                      widget.titles[index].maxValue,
                      style: body1Regular.copyWith(
                        color: achromatic200,
                      ),
                    ),
                  ],
                ),
                StatefulBuilder(
                  builder: (context, settState) {
                    return Slider(
                      value: value[index],
                      min: 1,
                      max: 5,
                      divisions: 4,
                      label: value[index].toStringAsFixed(0),
                      onChangeEnd: (val) {
                        widget.onChanged(val, index);
                      },
                      onChanged: (val) {
                        settState(() {
                          value[index] = val;
                        });
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
