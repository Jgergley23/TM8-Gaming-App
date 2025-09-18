import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8l/app/constants/fonts.dart';
import 'package:tm8l/app/constants/palette.dart';

class Tm8CheckBoxFormWidget extends StatefulWidget {
  const Tm8CheckBoxFormWidget({
    super.key,
    required this.labelText,
    this.width = 290,
    required this.name,
    this.onChanged,
    required this.validator,
  });

  final Widget labelText;
  final double width;
  final String name;
  final void Function(String?)? onChanged;
  final String? Function(bool?)? validator;

  @override
  State<Tm8CheckBoxFormWidget> createState() => _Tm8CheckBoxFormWidgetState();
}

class _Tm8CheckBoxFormWidgetState extends State<Tm8CheckBoxFormWidget> {
  late FocusNode focusNode;
  bool mainValue = false;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    focusNode.addListener(() {
      setState(() {
        logInfo(
          'Focus updated ${widget.name}: hasFocus: ${focusNode.hasFocus}',
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: widget.width,
          child: FormBuilderCheckbox(
            onChanged: (value) {
              if (value != null) {
                mainValue = value;
              }
            },
            focusNode: focusNode,
            validator: widget.validator,
            initialValue: false,
            name: widget.name,
            activeColor: primaryTeal,
            checkColor: achromatic100,
            decoration: InputDecoration(
              fillColor: mainValue ? primaryTeal : Colors.transparent,
              errorMaxLines: 2,
              errorStyle:
                  body1Regular.copyWith(color: errorTextColor, height: 0),
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
            title: widget.labelText,
          ),
        ),
      ],
    );
  }
}
