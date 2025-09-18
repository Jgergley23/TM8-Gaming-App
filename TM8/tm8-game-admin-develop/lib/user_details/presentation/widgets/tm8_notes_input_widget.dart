import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:loggy/loggy.dart';
import 'package:tm8_game_admin/app/constants/fonts.dart';
import 'package:tm8_game_admin/app/constants/palette.dart';

class Tm8NotesInputWidget extends StatefulWidget {
  const Tm8NotesInputWidget({
    super.key,
    required this.name,
    required this.hintText,
    this.initialValue,
    this.onChanged,
    this.validator,
    required this.controller,
    // required this.containerKey,
    this.inputFormatters,
  });

  final String name;
  final String hintText;
  final String? initialValue;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  // final GlobalKey containerKey;
  final List<TextInputFormatter>? inputFormatters;
  @override
  State<Tm8NotesInputWidget> createState() => _Tm8NotesInputWidgetState();
}

class _Tm8NotesInputWidgetState extends State<Tm8NotesInputWidget> {
  late FocusNode focusNode;
  int maxLines = 3;

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
    widget.controller.text = widget.initialValue ?? '';
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (widget.containerKey.currentContext != null) {
    //     final box =
    //         widget.containerKey.currentContext!.findRenderObject() as RenderBox;
    //     setState(() {
    //       maxLines = (box.size.height / 30).ceil();
    //     });
    //   }
    // });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FormBuilderTextField(
        controller: widget.controller,
        textAlignVertical: TextAlignVertical.center,
        cursorColor: achromatic100,
        scrollPadding: EdgeInsets.zero,
        keyboardType: TextInputType.multiline,
        cursorHeight: 21,
        enableInteractiveSelection: true,
        minLines: maxLines,
        maxLines: maxLines,
        focusNode: focusNode,
        inputFormatters: widget.inputFormatters,
        onChanged: widget.onChanged,
        style: body1Regular.copyWith(color: achromatic100),
        decoration: InputDecoration(
          isDense: true,
          hintText: focusNode.hasFocus ? '' : widget.hintText,
          hintStyle: body1Regular.copyWith(color: achromatic300),
          filled: true,
          fillColor: focusNode.hasFocus == true ? achromatic500 : achromatic600,
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
          errorStyle: body2Regular.copyWith(color: errorTextColor, height: 0),
        ),
        name: widget.name,
      ),
    );
  }
}
