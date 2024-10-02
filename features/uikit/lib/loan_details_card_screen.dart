import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/uikit/container/card/card_config.dart';
import 'package:tcs_dff_design_system/uikit/container/loan_details_with_lone_type_card_widget.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

class LoanDetailsCardScreen extends StatelessWidget {
  const LoanDetailsCardScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final locale = context.locale;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(context.theme.appSize.size8),
        child: LoanDetailsWithloanTypeCardWidget(
          cardModel: CardConfig(
            backgroundColor: context.theme.appColor.clrPrimaryPurple110,
            elevation: context.theme.appSize.size5,
            margin: EdgeInsets.all(context.theme.appSize.size10),
          ),
          cardHeaderTitle: locale.txt(key: 'PersonalLoan'),
          cardSubHeaderTitle: locale.txt(key: 'accountNumber'),
          cardSubHeaderTitleText: locale.txt(key: 'accNumberText'),
          cardSubHeaderTitle1: locale.txt(key: 'PersonalLoan'),
          cardSubHeaderTitle1Text: locale.txt(key: 'loanAmount'),
          imagePath: 'images/keyboard_arrow_right.svg',
          imagePackage: 'uikit',
          customPattern: 'XXXXXXX####',
          onpressed: () {},
        ),
      ),
    );
  }
}
