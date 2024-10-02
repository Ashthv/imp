import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_design_system/uikit/foundation/credit_card_accordian_widget.dart';
import 'package:tcs_dff_design_system/utils/credit_card_accordian_template_model.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

class CreditCardAccordianScreen extends StatefulWidget {
  const CreditCardAccordianScreen({super.key});

  @override
  State<CreditCardAccordianScreen> createState() =>
      _CreditCardAccordianScreenState();
}

class _CreditCardAccordianScreenState extends State<CreditCardAccordianScreen> {
  @override
  Widget build(final BuildContext context) {
    final locale = context.locale;
    return Scaffold(
      body: SingleChildScrollView(
        child: CreditCardAccordianWidget(
          creditCardAccordianTemplateData: CreditCardAccordianTemplateData(
            applicationNumberText: locale.txt(key: 'applicationnumber'),
            appliedOnDateText: locale.txt(key: 'appliedon'),
            remarksText: locale.txt(key: 'remarks'),
            showText: 'Show',
            statusText: locale.txt(key: 'status'),
            lessText: 'less',
            headingText: locale.txt(key: 'creditcardapplication'),
            moreText: 'more',
            applicationNumber: 'ABCDEFGHIJ',
            appliedOnDate: '22ND April 2020',
            status: 'Pending',
            cardImage: ImageWidget(
              imageType: ImageType.assetImage,
              fit: BoxFit.cover,
              path: 'images/card_example.png',
              package: 'uikit',
            ),
            remarks:
                // ignore: lines_longer_than_80_chars
                'Congratulations {first name}! Your application for SBI {Card type} Card has been approved in principle subject to submission of requisite document &amp,their verification. We would need some additional information from you to process your application.Our representative will contact you shortly to faclitate the same. The final approval would be subject to submission of requisite documnets  their verification. SBI Card reserves the right to change the approved card type or credit limit at itssole discreation.For further assistance please contactSBI Card helpline 1860 180 1290 or 020202',
          ),
        ),
      ),
    );
  }
}
