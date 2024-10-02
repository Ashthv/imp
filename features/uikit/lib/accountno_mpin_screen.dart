import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

class AccountNoMpinScreen extends StatefulWidget {
  const AccountNoMpinScreen({super.key});

  @override
  State<AccountNoMpinScreen> createState() => _AccountNoMpinScreenState();
}

class _AccountNoMpinScreenState extends State<AccountNoMpinScreen> {
  String pinEntered = '';

  @override
  Widget build(final BuildContext context) {
    final style = Theme.of(context).appTextStyles;
    final color = Theme.of(context).appColor;
    final size = Theme.of(context).appSize;
    final locale = context.locale;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.size20.dp),
            child: TextWidget(
              text: locale.txt(key: 'accountNumber'),
              style: style.h414pxRegular.copyWith(
                color: color.clrPrimaryPurple,
                fontSize: size.size14.dp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.size20.dp),
            child: AccountNoMpinWidget(
              getAccountPin: (final textPin) {
                pinEntered = textPin;
              },
              mpinLength: 6,
              accountNumber: 'XXXX XXX XX',
            ),
          ),
        ],
      ),
    );
  }
}
