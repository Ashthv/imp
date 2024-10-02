import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';

import 'package:tcs_dff_design_system/uikit/foundation/mpin.dart';

class DemoLayout extends StatelessWidget {
  const DemoLayout({super.key});

  Widget _buildResendText(final BuildContext context) => Container(
        margin: EdgeInsets.only(
          top: context.theme.appSize.size4,
          bottom: context.theme.appSize.size4,
        ),
        alignment: Alignment.centerRight,
        child: Text(
          'Resend OTP',
          style: context.theme.appTextStyles.bodyCopy1Large18Bold
              .copyWith(color: context.theme.appColor.greyFullBlack10),
          textAlign: TextAlign.right,
        ),
      );

  Widget _buildOtpText(final BuildContext context) => Container(
        margin: EdgeInsets.only(
          top: context.theme.appSize.size20,
          bottom: context.theme.appSize.size4,
        ),
        alignment: Alignment.centerLeft,
        child: RichText(
          text: TextSpan(
            text: 'OTP',
            style: context.theme.appTextStyles.bodyCopy1Large18Bold
                .copyWith(color: context.theme.appColor.greyFullBlack10),
            children: [
              TextSpan(
                text: ' *',
                style: context.theme.appTextStyles.bodyCopy1Large18Bold
                    .copyWith(color: context.theme.appColor.greyWhiteUi100),
              ),
            ],
          ),
          textAlign: TextAlign.right,
        ),
      );

  Widget _buildOtpInputText(final BuildContext context) => MPin(
        mpinLength: 6,
        mpinCallBack: (final textPin) {},
      );

  @override
  Widget build(final BuildContext context) => SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            _buildOtpText(context),
            _buildOtpInputText(context),
            _buildResendText(context),
          ],
        ),
      );
}
