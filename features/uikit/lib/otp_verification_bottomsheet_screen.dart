import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/uikit/container/bottomsheet/otp_vertification_bottomsheet.dart';
import 'package:tcs_dff_design_system/utils/bottom_sheet.dart';
import 'package:tcs_dff_design_system/utils/otp_verification_bottomsheet_model.dart';
import 'package:tcs_dff_route/tcs_dff_route.dart';

class OtpVerificationBottomsheetScreen extends StatefulWidget {
  const OtpVerificationBottomsheetScreen({super.key});

  @override
  State<OtpVerificationBottomsheetScreen> createState() =>
      _OtpVerificationBottomsheetScreenState();
}

class _OtpVerificationBottomsheetScreenState
    extends State<OtpVerificationBottomsheetScreen> {
  bool isValids = false;
  String errorText = '';
  TextEditingController textEditingController = TextEditingController();
  String cpin = '123456';
  String? userEnteredPin;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Center(
          child: ElevatedButton(
            child: const Text('OTP Verification Bottomsheet'),
            onPressed: () {
              showBottomSheetModal(
                enableDrag: false,
                isDismissible: false,
                context,
                StatefulBuilder(
                  builder: (
                    final BuildContext context,
                    final StateSetter setState,
                  ) =>
                      OtpVerificationBottomsheetTemplate(
                    otpVerificationBottomsheetModel:
                        // ignore: lines_longer_than_80_chars
                        OtpVerificationBottomsheetModel(
                      title: 'Activation Code',
                      subTitle:
                          // ignore: lines_longer_than_80_chars
                          'Enter the activation code for Reference no. 9263857 received on XXXX XXX X83',
                      subTitleHighlightedText: ['9263857', 'XXXX XXX X83'],
                      onCloseButtonTap: () {
                        RouteNavigator.popDialog(context);
                      },
                      submitButtonTitle: 'Submit',
                      resendOtpDuration: const Duration(seconds: 10),
                      onResendOtpTap: () {},
                      resendOtpText: 'RESEND OTP',
                      resendOtpMaxAttempts: 5,
                      mPinLength: 6,
                      isPinInvalid: true,
                      enteredPin: (final pin) {
                        userEnteredPin = pin;
                      },
                      errorMessage: errorText,
                      footerNoteText:
                          // ignore: lines_longer_than_80_chars
                          'Don’t have Aadhaar registered mobile number? Proceed without Aadhaar',
                      onSubmitTap: () {
                        setState(() {
                          if (userEnteredPin == cpin) {
                            errorText = '';
                          } else {
                            errorText = 'Incorrect OTP. 2 attempts left.';
                          }
                        });
                      },
                      onFooterNoteTap: () {
                        setState(
                          () {},
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
}
