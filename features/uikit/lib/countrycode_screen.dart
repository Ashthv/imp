import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/uikit/container/country_code_widget.dart';
import 'package:tcs_dff_design_system/uikit/foundation/input_field/textfield_widget.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';
import 'package:tcs_dff_shared_library/validators/validators.dart';

class CountryCodeScreen extends StatefulWidget {
  const CountryCodeScreen({super.key});

  @override
  State<CountryCodeScreen> createState() => _CountryCodeScreenState();
}

class _CountryCodeScreenState extends State<CountryCodeScreen> {
  final mobileNumberController = TextEditingController();

  @override
  Widget build(final BuildContext context) {
    final locale = context.locale;
    return Column(
      children: [
        TextFieldWidget(
          label: locale.txt(key: 'mobNo'),
          controller: mobileNumberController,
          prefixWidget: Container(
            child: CountryCodeWideget(
              countryCode: locale.txt(key: 'countryCode'),
            ),
          ),
          maxLength: 10,
          validators: [
            MobileValidator(errorText: 'Invalid Mobile No.'),
          ],
          inputType: TextInputType.number,
        ),
      ],
    );
  }
}
