import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/uikit/foundation/resend_otp.dart';

class ResendOtpScreen extends StatelessWidget {
  const ResendOtpScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final color = context.theme.appColor;
    return Scaffold(
      backgroundColor: color.clrPrimaryBlue,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ResendOtp(
              text: 'RESEND OTP',
              duration: const Duration(
                seconds: 10,
              ),
              maxAttempt: 2,
              callback: () {},
            ),
          ],
        ),
      ),
    );
  }
}
