import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/uikit/container/stepper/stepper_widget.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';

class StepperScreen extends StatelessWidget {
  const StepperScreen({super.key});

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Container(
          margin:
              EdgeInsets.symmetric(horizontal: context.theme.appSize.size20.dp),
          child: StepperWidget(
            configList: [
              StepperConfig(
                iconPath: 'images/check_circle.svg',
                imagePackage: 'uikit',
                title: 'Verify Aadhaar and PAN',
                subTitle: 'Required to confirm your identity',
                status: ProgressStatus.completed,
              ),
              StepperConfig(
                iconPath: 'images/profile_icon.svg',
                imagePackage: 'uikit',
                title: 'Share your details',
                subTitle:
                    'Help us know you better and how to communicate with you',
                status: ProgressStatus.inProgress,
              ),
              StepperConfig(
                iconPath: 'images/profile_icon.svg',
                imagePackage: 'uikit',
                title: 'Choose your banking experience',
                subTitle:
                    'Pick your branch location, account type and debit cards',
                status: ProgressStatus.pending,
              ),
              StepperConfig(
                iconPath: 'images/profile_icon.svg',
                imagePackage: 'uikit',
                title: 'Complete your KYC',
                subTitle: 'Perform easy KYC through video call or branch visit',
                status: ProgressStatus.pending,
              ),
            ],
          ),
        ),
      );
}
