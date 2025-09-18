import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tm8_game_admin/app/constants/fonts.dart';
import 'package:tm8_game_admin/app/constants/palette.dart';

class Tm8SearchWidget extends StatefulWidget {
  const Tm8SearchWidget({
    super.key,
    this.width = 290,
    required this.hintText,
    this.maxLines = 1,
    required this.onChanged,
    this.dropDownHeight,
    this.constraints,
    this.textEditingController,
  });
  final double width;
  final String hintText;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  final double? dropDownHeight;
  final BoxConstraints? constraints;
  final TextEditingController? textEditingController;

  @override
  State<Tm8SearchWidget> createState() => _Tm8InputFormWidgetState();
}

class _Tm8InputFormWidgetState extends State<Tm8SearchWidget> {
  late FocusNode focusNode;

  @override
  void initState() {
    focusNode = FocusNode();
    focusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.dropDownHeight ?? 40,
      constraints: widget.constraints,
      child: TextField(
        obscureText: false,
        focusNode: focusNode,
        textAlignVertical: TextAlignVertical.center,
        cursorColor: achromatic100,
        textInputAction: TextInputAction.search,
        cursorHeight: 18,
        onChanged: widget.onChanged,
        controller: widget.textEditingController,
        maxLines: widget.maxLines,
        enableInteractiveSelection: true,
        style: body1Regular.copyWith(color: achromatic100),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          isDense: true,
          hintText: focusNode.hasFocus ? '' : widget.hintText,
          hintMaxLines: 1,
          hintStyle: body1Regular.copyWith(color: achromatic300),
          filled: true,
          fillColor: focusNode.hasFocus ? achromatic500 : achromatic600,
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
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset('assets/common/search.svg'),
          ),
          prefixIconColor: achromatic200,
        ),
      ),
    );
  }
}
