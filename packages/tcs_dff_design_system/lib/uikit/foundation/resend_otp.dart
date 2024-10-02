import 'dart:async';
import 'package:flutter/material.dart';
import '../../theme/theme.dart';
import '../../utils/sizer/app_sizer.dart';
import 'button/tertiary_button.dart';

class ResendOtp extends StatefulWidget {
  final String text;
  final Duration duration;
  final int maxAttempt;
  final VoidCallback callback;

  ResendOtp({
    super.key,
    required this.text,
    required this.duration,
    required this.maxAttempt,
    required this.callback,
  });

  @override
  State<ResendOtp> createState() => _ResendOtpState();
}

class _ResendOtpState extends State<ResendOtp> {
  late Duration duration;
  bool enableResendOtp = false;
  late Timer timer;
  late int leftAttempts;

  @override
  void initState() {
    super.initState();
    leftAttempts = widget.maxAttempt;
    duration = widget.duration;
    timer = Timer.periodic(const Duration(seconds: 1), (final _) {
      if (enableResendOtp == false) {
        if (duration != const Duration()) {
          setState(() {
            duration = duration - const Duration(seconds: 1);
          });
        } else {
          setState(() {
            enableResendOtp = true;
            duration = widget.duration;
          });
        }
      }
    });
  }

  @override
  Widget build(final BuildContext context) {
    final color = context.theme.appColor;
    final textStyle = context.theme.appTextStyles;
    final size = context.theme.appSize;
    return Row(
      children: [
        TertiaryButton(
          caption: widget.text,
          isEnabled: enableResendOtp && leftAttempts > 0,
          onPressed: () {
            setState(() {
              leftAttempts -= 1;
              if (enableResendOtp) {
                widget.callback();
                _resendOtp();
              }
            });
          },
          buttonColor: color.greyFullWhite120,
          disablebuttonColor: color.greyFullWhite120.withOpacity(0.5),
        ),
        SizedBox(
          width: size.size8.dp,
        ),
        Visibility(
          visible: !enableResendOtp,
          child: Text(
            remainingDuration(duration),
            style: textStyle.h316pxsemiBold.copyWith(
              color: 
                   color.greyFullWhite120,
              fontWeight: FontWeight.w700,
              fontSize: size.size16.sp,
            ),
          ),
        ),
      ],
    );
  }

  void _resendOtp() {
    //resend otp code
    setState(() {
      enableResendOtp = false;
    });
  }

  String remainingDuration(final Duration duration) {
    final minutes = int.parse(duration.toString().substring(2, 4));
    final seconds = int.parse(duration.toString().substring(5, 7));
    var s = '';
    if (minutes > 0) {
      s = '${minutes}m:${seconds}s';
    } else {
      s = '${seconds}s';
    }
    return s;
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
