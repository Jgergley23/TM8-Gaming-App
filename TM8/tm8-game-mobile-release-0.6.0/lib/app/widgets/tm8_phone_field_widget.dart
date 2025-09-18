import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loggy/loggy.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:tm8/app/constants/constants.dart';
import 'package:tm8/app/constants/fonts.dart';
import 'package:tm8/app/constants/palette.dart';
import 'package:tm8/gen/assets.gen.dart';

class Tm8PhoneFieldWidget extends StatefulWidget {
  const Tm8PhoneFieldWidget({
    super.key,
    required this.controller,
  });

  final PhoneController controller;

  @override
  State<Tm8PhoneFieldWidget> createState() => _Tm8PhoneFieldWidgetState();
}

class _Tm8PhoneFieldWidgetState extends State<Tm8PhoneFieldWidget> {
  late FocusNode focusNode;
  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    focusNode.addListener(() {
      setState(() {
        logInfo(
          'Focus updated phone picker: hasFocus: ${focusNode.hasFocus}',
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Phone Number',
          style: body1Regular.copyWith(color: achromatic200),
        ),
        h4,
        PhoneFormField(
          focusNode: focusNode,
          controller: widget.controller,
          countryButtonStyle: CountryButtonStyle(
            textStyle: body1Regular.copyWith(color: achromatic100),
            showIsoCode: true,
            showDialCode: false,
            showFlag: false,
          ),
          autofillHints: const [AutofillHints.telephoneNumber],
          countrySelectorNavigator: CountrySelectorNavigator.modalBottomSheet(
            titleStyle: body1Regular.copyWith(color: achromatic100),
            subtitleStyle: body1Regular.copyWith(color: achromatic100),
            noResultMessage: 'No result found',
            searchBoxTextStyle: body1Regular.copyWith(color: achromatic100),
            searchBoxDecoration: InputDecoration(
              hintText: 'Search',
              hintMaxLines: 1,
              contentPadding: EdgeInsets.zero,
              hintStyle: body1Regular.copyWith(color: achromatic300),
              filled: true,
              fillColor:
                  focusNode.hasFocus == true ? achromatic400 : achromatic500,
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
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  width: 2,
                  color: achromatic600,
                ),
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  Assets.common.search.path,
                  fit: BoxFit.scaleDown,
                ),
              ),
              prefixIconColor: achromatic200,
            ),
          ),
          style: body1Regular.copyWith(color: achromatic100),
          cursorColor: achromatic100,
          cursorHeight: 21,
          enabled: true,
          showCursor: true,
          enableInteractiveSelection: true,
          autovalidateMode: AutovalidateMode.disabled,
          validator: PhoneValidator.compose(
            [
              PhoneValidator.required(
                context,
                errorText: 'Please provide a phone number',
              ),
              PhoneValidator.validMobile(
                context,
                errorText: 'Invalid phone number',
              ),
            ],
          ),
          decoration: InputDecoration(
            hintText: '00-000-000',
            hintMaxLines: 1,
            hintStyle: body1Regular.copyWith(color: achromatic300),
            filled: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            fillColor:
                focusNode.hasFocus == true ? achromatic400 : achromatic500,
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
            errorMaxLines: 1,
            errorStyle: body2Regular.copyWith(
              color: errorTextColor,
            ),
          ),
        ),
      ],
    );
  }
}
