import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8_game_admin/app/constants/constants.dart';
import 'package:tm8_game_admin/app/constants/fonts.dart';
import 'package:tm8_game_admin/app/constants/palette.dart';

class Tm8BodyInputWidget extends StatefulWidget {
  const Tm8BodyInputWidget({
    super.key,
    required this.name,
    required this.hintText,
    this.initialValue,
    this.validator,
    this.labelText,
    required this.width,
    this.constraints,
    this.onChanged,
    this.inputFormatters,
    this.onTap,
  });

  final String name;
  final String hintText;
  final String? initialValue;
  final String? Function(String?)? validator;
  final String? labelText;
  final double width;
  final BoxConstraints? constraints;
  final void Function(String?)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback? onTap;
  @override
  State<Tm8BodyInputWidget> createState() => _Tm8BodyInputWidgetState();
}

class _Tm8BodyInputWidgetState extends State<Tm8BodyInputWidget> {
  late FocusNode focusNode;
  int maxLines = 12;
  String? _numberOfLetters;

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
    _numberOfLetters = widget.initialValue;
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null) ...[
          h4,
          Container(
            width: widget.width,
            constraints: widget.constraints,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.labelText!,
                  style: body1Regular.copyWith(color: achromatic200),
                ),
                Row(
                  children: [
                    Text(
                      _numberOfLetters?.length.toString() ?? '0',
                      style: body2Regular.copyWith(color: achromatic200),
                    ),
                    Text(
                      '/150',
                      style: body2Regular.copyWith(color: achromatic200),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
        Container(
          width: widget.width,
          constraints: widget.constraints,
          child: FormBuilderTextField(
            onTap: () {
              if (widget.onTap != null) {
                widget.onTap!();
              }
            },
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _numberOfLetters = value;
                });
              }
            },
            focusNode: focusNode,
            textAlignVertical: TextAlignVertical.center,
            cursorColor: achromatic100,
            scrollPadding: EdgeInsets.zero,
            keyboardType: TextInputType.multiline,
            cursorHeight: 21,
            enableInteractiveSelection: true,
            minLines: maxLines,
            maxLines: maxLines,
            validator: widget.validator,
            initialValue: widget.initialValue,
            inputFormatters: widget.inputFormatters,
            style: body1Regular.copyWith(color: achromatic100),
            decoration: InputDecoration(
              isDense: true,
              hintText: focusNode.hasFocus ? '' : widget.hintText,
              hintStyle: body1Regular.copyWith(color: achromatic300),
              filled: true,
              fillColor:
                  focusNode.hasFocus == true ? achromatic500 : achromatic600,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  width: 2,
                  color: achromatic600,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  width: 2,
                  color: achromatic600,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  width: 2,
                  color: errorTextColor,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  width: 2,
                  color: errorTextColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  width: 2,
                  color: achromatic600,
                ),
              ),
              errorMaxLines: 2,
              errorStyle:
                  body2Regular.copyWith(color: errorTextColor, height: 0),
            ),
            name: widget.name,
          ),
        ),
      ],
    );
  }
}
