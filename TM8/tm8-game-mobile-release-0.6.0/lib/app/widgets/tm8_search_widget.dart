import 'package:flutter/material.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/gen/assets.gen.dart';

class Tm8SearchWidget extends StatefulWidget {
  const Tm8SearchWidget({
    super.key,
    this.width = 290,
    required this.hintText,
    this.maxLines = 1,
    required this.onChanged,
    this.dropDownHeight,
    // required this.focusNode,
  });
  final double width;
  final double? dropDownHeight;
  final String hintText;
  final int maxLines;
  final ValueChanged<String> onChanged;
  // final FocusNode focusNode;

  @override
  State<Tm8SearchWidget> createState() => _Tm8InputFormWidgetState();
}

class _Tm8InputFormWidgetState extends State<Tm8SearchWidget> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // widget.focusNode.addListener(() {
    //   setState(() {});
    // });

    textEditingController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.dropDownHeight ?? 40,
      child: TextField(
        obscureText: false,
        // focusNode: widget.focusNode,
        textAlignVertical: TextAlignVertical.center,
        cursorColor: achromatic100,
        textInputAction: TextInputAction.search,
        cursorHeight: 18,
        onChanged: widget.onChanged,
        controller: textEditingController,
        maxLines: widget.maxLines,
        enableInteractiveSelection: true,
        style: body1Regular.copyWith(color: achromatic100),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 14, right: 14),
          isDense: true,
          hintText: widget.hintText,
          hintMaxLines: 1,
          hintStyle: body1Regular.copyWith(color: achromatic300),
          filled: true,
          fillColor: achromatic500,
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
            child: Assets.common.search.svg(),
          ),
          prefixIconColor: achromatic200,
          suffixIcon: textEditingController.text != ''
              ? GestureDetector(
                  onTap: () {
                    textEditingController.clear();
                    widget.onChanged('');
                  },
                  child: Assets.common.x
                      .svg(height: 15, width: 15, fit: BoxFit.scaleDown),
                )
              : null,
        ),
      ),
    );
  }
}
