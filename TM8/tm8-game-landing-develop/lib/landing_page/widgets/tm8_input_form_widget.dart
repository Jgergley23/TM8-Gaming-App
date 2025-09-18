import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8l/app/constants/constants.dart';
import 'package:tm8l/app/constants/fonts.dart';
import 'package:tm8l/app/constants/palette.dart';

class Tm8InputFormWidget extends StatefulWidget {
  const Tm8InputFormWidget({
    super.key,
    this.labelText,
    this.width = 290,
    required this.name,
    required this.hintText,
    this.maxLines = 1,
    this.onChanged,
    required this.validator,
    this.initialValue,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    this.textCapitalization = TextCapitalization.sentences,
    this.inputFormatters,
  });

  final String name;
  final String hintText;
  final String? labelText;
  final String? initialValue;
  final List<String>? suffixIcon;

  final bool? obscureText;
  final int maxLines;
  final double width;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<Tm8InputFormWidget> createState() => _Tm8InputFormWidgetState();
}

class _Tm8InputFormWidgetState extends State<Tm8InputFormWidget> {
  late FocusNode focusNode;
  int suffixIconIndex = 0;
  bool? obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;
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
        if (widget.labelText != null) ...[
          Text(
            widget.labelText!,
            style: body1Regular.copyWith(color: achromatic200),
          ),
          h4,
        ],
        SizedBox(
          width: widget.width,
          child: FormBuilderTextField(
            obscureText: obscureText == null ? false : obscureText!,
            focusNode: focusNode,
            textAlignVertical: TextAlignVertical.center,
            textCapitalization: widget.textCapitalization,
            cursorColor: achromatic100,
            cursorHeight: 21,
            maxLines: widget.maxLines,
            enableInteractiveSelection: true,
            onChanged: widget.onChanged,
            validator: widget.validator,
            inputFormatters: widget.inputFormatters,
            initialValue: widget.initialValue,
            style: body1Regular.copyWith(color: achromatic100),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintMaxLines: 1,
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
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon != null
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          if (obscureText != null) {
                            obscureText = !obscureText!;
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
                        child: SvgPicture.asset(
                          widget.suffixIcon![suffixIconIndex],
                          colorFilter:
                              ColorFilter.mode(achromatic200, BlendMode.srcIn),
                        ),
                      ),
                    )
                  : null,
              prefixIconColor: achromatic200,
              suffixIconColor: achromatic200,
              suffixIconConstraints: const BoxConstraints(
                maxHeight: 20,
                minWidth: 20,
              ),
              errorMaxLines: 2,
              errorStyle:
                  body1Regular.copyWith(color: errorTextColor, height: 0),
            ),
            name: widget.name,
          ),
        ),
      ],
    );
  }
}

class FirstLetterUpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: newValue.text);
    } else if (newValue.text.length == 1) {
      return newValue.copyWith(
        text: newValue.text.toUpperCase(),
        selection: const TextSelection.collapsed(offset: 1),
      );
    } else {
      return newValue;
    }
  }
}
