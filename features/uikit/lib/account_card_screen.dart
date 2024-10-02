import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/uikit/container/card/account_card_widget.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

class AccountCardScreen extends StatefulWidget {
  const AccountCardScreen({super.key});

  @override
  State<AccountCardScreen> createState() => _AccountCardScreenState();
}

bool isSelected = false;
bool isDropdownArrow = true;

class _AccountCardScreenState extends State<AccountCardScreen> {
  @override
  Widget build(final BuildContext context) {
    final locale = context.locale;
    return Center(
      child: AccountCardWidget(
        accountNumber: locale.txt(key: 'cardNo'),
        accountType: locale.txt(key: 'card1'),
        balance: locale.txt(key: 'balance'),
        lableText: locale.txt(key: 'availableBalance'),
        onCardTap: () {
          setState(() {
            isDropdownArrow = false;
            isSelected = !isSelected;
          });
        },
        isSelected: isSelected,
      ),
    );
  }
}
