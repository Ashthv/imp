import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

class PaymentCardScreen extends StatefulWidget {
  const PaymentCardScreen({super.key});

  @override
  State<PaymentCardScreen> createState() => _PaymentCardScreenState();
}

class _PaymentCardScreenState extends State<PaymentCardScreen> {
  @override
  Widget build(final BuildContext context) {
    final color = context.theme.appColor;
    final size = context.theme.appSize;
    final locale = context.locale;
    return Column(
      children: [
        ScheduledPayment(
          onTap: () {},
          title: locale.txt(key: 'customerName'),
          subtitle: locale.txt(key: 'cardNo'),
          infoText: locale.txt(key: 'ifscCode'),
          amount: '8000',
          date: '02-11-2023',
          upComingEventIcon: 'images/event_upcoming.svg',
          package: 'uikit',
          profileImage: 'images/choose_doc.png',
          upComingEventText: locale.txt(key: 'upComingEventTextData'),
          profileCardType: ProfileCardType.infoText,
          width: size.size44.dp,
          height: size.size44.dp,
          borderColor: color.clrPrimaryPurple,
        ),
        ScheduledPayment(
          onTap: () {},
          title: locale.txt(key: 'customerName'),
          subtitle: locale.txt(key: 'cardNo'),
          infoText: locale.txt(key: 'ifscCode'),
          amount: '8000',
          date: '02-11-2023',
          upComingEventIcon: 'images/event_upcoming.svg',
          profileCardType: ProfileCardType.infoText,
          upComingEventText: locale.txt(key: 'upComingEventTextData'),
        ),
        ScheduledPayment(
          onTap: () {},
          title: locale.txt(key: 'customerName'),
          subtitle: locale.txt(key: 'cardNo'),
          infoText: locale.txt(key: 'ifscCode'),
          amount: '8000',
          date: '02-11-2023',
          package: 'uikit',
          profileImage: 'images/choose_doc.png',
          width: size.size44.dp,
          height: size.size44.dp,
          borderColor: color.clrPrimaryPurple,
          profileCardType: ProfileCardType.infoText,
        ),
        ScheduledPayment(
          onTap: () {},
          title: locale.txt(key: 'customerName'),
          subtitle: locale.txt(key: 'cardNo'),
          infoText: locale.txt(key: 'ifscCode'),
          amount: '8000',
          date: '02-11-2023',
          package: 'uikit',
          profileImage: 'images/choose_doc.png',
          width: size.size44.dp,
          height: size.size44.dp,
          borderColor: color.clrPrimaryPurple,
          profileCardType: ProfileCardType.infoText,
          onSuffixIconTap: () {},
        ),
      ],
    );
  }
}
