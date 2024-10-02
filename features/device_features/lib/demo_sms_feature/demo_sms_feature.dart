// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_device_feature/sms_feature/otp_details.dart';
import 'package:tcs_dff_device_feature/sms_feature/receive_sms_template.dart';
import 'package:tcs_dff_device_feature/sms_feature/sim_detail.dart';
import 'package:tcs_dff_device_feature/sms_feature/sms_feature.dart';

class DemoSMSFeature extends StatefulWidget {
  const DemoSMSFeature({super.key});

  @override
  State<DemoSMSFeature> createState() => _DemoSMSFeatureState();
}

class _DemoSMSFeatureState extends State<DemoSMSFeature> {
  String receivedMsg = '';
  late SMSFeature _smsFeature;

  List<SIMDetail> simList = [];
  SIMDetail? selectedSIM;
  bool isSIMInformationChanged = false;

  void receivedSMS(final OTPDetails otpDetails) {
    setState(() {
      receivedMsg = otpDetails.otp!;
    });
  }

  @override
  void initState() {
    super.initState();
    _smsFeature = SMSFeature();
    WidgetsBinding.instance.addPostFrameCallback((final _) {
      getSIMInformation();
      _smsFeature.registerToListenIncomingSMS(
        receivedMessage: receivedSMS,
        receiveSMSTemplate: ReceiveSMSTemplate(
          smsTemplate:
              'Dear Customer, \$\$\$\$ is your OTP. Please do not share this with anyone',
          specialCharacter: '\$',
          // otpLength: 4,
        ),
      );
      _smsFeature.onSIMChangeInformation().listen(onSIMChanged);
      checkSIMInformationChanged();
    });
  }

  @override
  void dispose() {
    _smsFeature.unRegisterToListenIncomingSMS();
    super.dispose();
  }

  Future<void> getSIMInformation() async {
    simList = await _smsFeature.getSIMInformation();
    setState(() {});
  }

  Future<void> checkSIMInformationChanged() async {
    isSIMInformationChanged = await _smsFeature.isSimInformationChanged();
    setState(() {});
  }

  void onSIMChanged(final List<SIMDetail> simDetails) {
    simList
      ..clear()
      ..addAll(simDetails);
    setState(() {});
  }

  @override
  Widget build(final BuildContext context) {
    final textStyle = Theme.of(context).appTextStyles;
    final color = Theme.of(context).appColor;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 30,
          ),
          Text(
            'SIM information',
            style: textStyle.bodyCopy2Link16SemiBold
                .copyWith(color: color.clrPrimaryPurple),
          ),
          const SizedBox(
            height: 10,
          ),
          if (simList.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                simList.length,
                (final index) => Row(
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: Text(
                        'Slot:${simList[index].simSlotIndex}\nDisplayname:${simList[index].simDisplayName}\nSubscriptionId:${simList[index].subscriptionID}\nCarrierName:${simList[index].carrierName}',
                        style: textStyle.bodyCopy2Link16SemiBold
                            .copyWith(color: color.bronzeDark),
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            const Text('No SIM card is available'),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Is SIM information changed: $isSIMInformationChanged',
            style: textStyle.bodyCopy2Medium16SemiBold
                .copyWith(color: color.goldDark),
          ),
          const Divider(
            height: 50,
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'SIM Selection, Send SMS and Show received SMS',
              style: textStyle.bodyCopy2Link16SemiBold
                  .copyWith(color: color.clrPrimaryPurple),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: simList
                    .map(
                      (final sim) => SizedBox(
                        width: 150,
                        child: RadioListTile(
                          title: Text(
                            sim.simDisplayName!,
                            style: textStyle.bodyCopy2Link16SemiBold
                                .copyWith(color: color.clrPrimaryPurple),
                          ),
                          value: sim,
                          groupValue: selectedSIM,
                          onChanged: (final value) {
                            setState(() {
                              selectedSIM = value!;
                            });
                          },
                        ),
                      ),
                    )
                    .toList(),
              ),
              TextButton(
                onPressed: () {
                  if (selectedSIM != null) {
                    _smsFeature.sendSMS(
                      selectedSIM!.subscriptionID,
                      '9766587296',
                      'Dear Customer, 1234 is your OTP. Please do not share this with anyone',
                    );
                  } else {
                    setState(() {
                      receivedMsg = 'Select SIM and click on send sms';
                    });
                  }
                },
                child: const Text(
                  'Send SMS',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Received OTP: ',
            style: textStyle.bodyCopy2Link16SemiBold
                .copyWith(color: color.clrPrimaryPurple),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Text(
              receivedMsg,
              style: textStyle.bodyCopy2Link16SemiBold
                  .copyWith(color: color.clrPrimaryPurple),
              maxLines: 10,
            ),
          ),
        ],
      ),
    );
  }
}
