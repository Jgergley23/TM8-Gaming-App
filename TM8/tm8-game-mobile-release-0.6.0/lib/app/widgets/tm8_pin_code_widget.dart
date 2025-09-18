import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';

class Tm8PinCodeWidget extends StatefulWidget {
  const Tm8PinCodeWidget({
    super.key,
    required this.onCompleted,
    required this.errorController,
    required this.hasError,
    this.keyboardType = TextInputType.number,
    this.length = 6,
  });

  final Function(String) onCompleted;
  final StreamController<ErrorAnimationType> errorController;
  final bool hasError;
  final TextInputType keyboardType;
  final int length;

  @override
  State<Tm8PinCodeWidget> createState() => _Tm8PinCodeWidgetState();
}

class _Tm8PinCodeWidgetState extends State<Tm8PinCodeWidget> {
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PinCodeTextField(
          appContext: context,
          length: widget.length,
          errorAnimationController: widget.errorController,
          onChanged: widget.onCompleted,
          errorTextMargin: const EdgeInsets.only(top: 42),
          keyboardType: widget.keyboardType,
          inputFormatters: <TextInputFormatter>[
            if (widget.keyboardType == TextInputType.number)
              FilteringTextInputFormatter.digitsOnly,
          ],
          textStyle: body1Regular.copyWith(color: achromatic100),
          enableActiveFill: true,
          enablePinAutofill: true,
          showCursor: false,
          hintCharacter: '_',
          hintStyle: body1Regular.copyWith(color: achromatic300),
          animationDuration: const Duration(milliseconds: 300),
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderWidth: 1,
            activeColor: Colors.transparent,
            inactiveColor: Colors.transparent,
            selectedColor: Colors.transparent,
            activeFillColor: achromatic500,
            inactiveFillColor: achromatic500,
            selectedFillColor: achromatic400,
            borderRadius: BorderRadius.circular(10),
            fieldWidth: 43,
            fieldHeight: 40,
            errorBorderColor: errorTextColor,
            errorBorderWidth: 2,
          ),
        ),
        if (widget.hasError) ...[
          Transform.translate(
            offset: const Offset(0, -14),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Invalid code',
                style: body1Regular.copyWith(color: errorTextColor),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
