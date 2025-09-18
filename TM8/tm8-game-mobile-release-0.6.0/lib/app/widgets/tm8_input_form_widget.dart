import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';

class Tm8InputFormWidget extends StatefulWidget {
  const Tm8InputFormWidget({
    super.key,
    this.labelText,
    required this.name,
    required this.hintText,
    this.maxLines = 1,
    this.onChanged,
    required this.validator,
    this.initialValue,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    this.textCapitalization = TextCapitalization.none,
    this.height = 45,
  });

  final String? labelText;
  final String name;
  final String hintText;
  final int maxLines;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final List<String>? suffixIcon;
  final bool? obscureText;
  final TextCapitalization textCapitalization;
  final double height;
  @override
  State<Tm8InputFormWidget> createState() => _Tm8InputFormWidgetState();
}

class _Tm8InputFormWidgetState extends State<Tm8InputFormWidget> {
  late FocusNode focusNode;
  bool? suffixIconChange;
  int suffixIconIndex = 0;
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
    suffixIconChange = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null) ...[
          Text(
            widget.labelText!,
            style: body1Regular.copyWith(color: achromatic200),
          ),
          h4,
        ],
        FormBuilderTextField(
          obscureText: suffixIconChange == null ? false : suffixIconChange!,
          focusNode: focusNode,
          textAlignVertical: TextAlignVertical.center,
          textCapitalization: widget.textCapitalization,
          cursorColor: achromatic100,
          cursorHeight: 21,
          scrollPadding: EdgeInsets.zero,
          maxLines: widget.maxLines,
          onChanged: widget.onChanged,
          validator: widget.validator,
          initialValue: widget.initialValue,
          inputFormatters: widget.inputFormatters,
          style: body1Regular.copyWith(color: achromatic100),
          decoration: InputDecoration(
            contentPadding: widget.height != 60
                ? const EdgeInsets.only(
                    left: 12,
                    right: 12,
                    top: 2,
                    bottom: 2,
                  )
                : null,
            hintText: focusNode.hasFocus ? '' : widget.hintText,
            hintMaxLines: 1,
            hintStyle: body1Regular.copyWith(color: achromatic300),
            filled: true,
            fillColor:
                focusNode.hasFocus == true ? achromatic400 : achromatic500,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 2,
                color: achromatic500,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 2,
                color: achromatic500,
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
                color: achromatic500,
              ),
            ),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon != null
                ? InkWell(
                    onTap: () {
                      setState(() {
                        if (suffixIconChange != null) {
                          suffixIconChange = !suffixIconChange!;
                        }
                        if (suffixIconIndex == 0) {
                          suffixIconIndex = 1;
                        } else {
                          suffixIconIndex = 0;
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: SizedBox(
                        height: 15,
                        width: 15,
                        child: SvgPicture.asset(
                          fit: BoxFit.scaleDown,
                          widget.suffixIcon![suffixIconIndex],
                          colorFilter: ColorFilter.mode(
                            achromatic100,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  )
                : null,
            prefixIconColor: achromatic200,
            suffixIconColor: achromatic200,
            errorMaxLines: 1,
            errorStyle: body2Regular.copyWith(
              color: errorTextColor,
            ),
          ),
          name: widget.name,
        ),
      ],
    );
  }
}
