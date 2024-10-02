import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/uikit/foundation/input_field/account_number_textfield.dart';
import 'package:tcs_dff_shared_library/validators/validators.dart';

class AccountFieldScreen extends StatefulWidget {
  const AccountFieldScreen({super.key});

  @override
  State<AccountFieldScreen> createState() => _AccountFieldScreenState();
}

class _AccountFieldScreenState extends State<AccountFieldScreen> {
  TextEditingController accountController1 = TextEditingController();
  TextEditingController accountController2 = TextEditingController();
  bool isVerified = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    if (!mounted) {
      accountController1.dispose();
      accountController2.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => Column(
        children: [
          AccountNumberTextField(
            label: 'Account Number',
            controller: accountController1,
            maskText: true,
            maxLength: 10,
            infoText: 'Hey there I am using this app to test the fun',
            // mandatory: true,
            textFieldtypeText: 'Optional',
          ),
          AccountNumberTextField(
            label: 'Re-Enter Account Number',
            controller: accountController2,
            maskText: true,
            maxLength: 10,
            infoText: 'Hey there I am using this app to test the fun',
            textFieldtypeText: 'Optional',
            validators: [
              MatchValueValidator(accountController1.text, errorText: 'Error'),
            ],
            verified: isVerified,
            onChanged: (final text) {
              setState(() {
                if (accountController1.text == text &&
                    accountController1.text.isNotEmpty &&
                    text.isNotEmpty) {
                  isVerified = true;
                } else {
                  isVerified = false;
                }
              });
            },
          ),
        ],
      );
}
