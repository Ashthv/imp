import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/uikit/container/radio_button_accno_balance.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

class BankAccountDetailsAndAvailableAmountScreen extends StatelessWidget {
  const BankAccountDetailsAndAvailableAmountScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final locale = context.locale;

    return Container(
      child: Column(
        children: [
          RadioButtonAccnoBalance(
            isRadioButtonSelected: true,
            onChanged: (final _) {},
            accountNumber: '12345679867',
            accountTypeTitle: locale.txt(key: 'card1'),
            amountTitle: locale.txt(key: 'balanceTxt'),
            availableAmount: 'Rs. 2,00,000',
          ),
          RadioButtonAccnoBalance(
            isRadioButtonSelected: false,
            onChanged: (final _) {},
            accountNumber: '12345679867',
            accountTypeTitle: locale.txt(key: 'card1'),
            amountTitle: locale.txt(key: 'balanceTxt'),
            availableAmount: 'Rs. 2,00,000',
          ),
        ],
      ),
    );
  }
}
