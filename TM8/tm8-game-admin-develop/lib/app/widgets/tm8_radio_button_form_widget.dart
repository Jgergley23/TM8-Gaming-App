import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8_game_admin/app/constants/validators.dart';

class Tm8RadioButtonWidget extends StatefulWidget {
  const Tm8RadioButtonWidget({
    super.key,
    this.width = 290,
    required this.name,
    required this.options,
  });

  final double width;
  final String name;
  final List<FormBuilderFieldOption> options;

  @override
  State<Tm8RadioButtonWidget> createState() => _Tm8RadioButtonWidgetState();
}

class _Tm8RadioButtonWidgetState extends State<Tm8RadioButtonWidget> {
  late FocusNode focusNode;

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
    return SizedBox(
      width: widget.width,
      child: FormBuilderRadioGroup(
        options: widget.options,
        focusNode: focusNode,
        validator: requiredRadioValidator,
        initialValue: null,
        name: widget.name,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
