import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tm8_game_admin/app/constants/fonts.dart';
import 'package:tm8_game_admin/app/constants/palette.dart';

class Tm8PinCodeWidget extends StatefulWidget {
  const Tm8PinCodeWidget({
    super.key,
    required this.onCompleted,
    required this.errorController,
    required this.hasError,
  });

  final Function(String) onCompleted;
  final StreamController<ErrorAnimationType> errorController;
  final bool hasError;

  @override
  State<Tm8PinCodeWidget> createState() => _Tm8PinCodeWidgetState();
}

class _Tm8PinCodeWidgetState extends State<Tm8PinCodeWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        children: [
          PinCodeTextField(
            appContext: context,
            length: 6,
            errorAnimationController: widget.errorController,
            onChanged: widget.onCompleted,
            errorTextMargin: const EdgeInsets.only(top: 42),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
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
              activeFillColor: achromatic600,
              inactiveFillColor: achromatic600,
              selectedFillColor: achromatic500,
              borderRadius: BorderRadius.circular(10),
              fieldWidth: 40,
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
      ),
    );
  }
}
