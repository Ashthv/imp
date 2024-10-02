import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/uikit/foundation/footer_stepper/footer_stepper.dart';
import 'package:tcs_dff_design_system/uikit/foundation/footer_stepper/footer_stepper_variant_model.dart';
import 'package:tcs_dff_design_system/utils/footer_stepper_utils.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';

class FooterStepperVariantsScreen extends StatelessWidget {
  const FooterStepperVariantsScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final style = context.theme.appTextStyles;
    final color = context.theme.appColor;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.size20.dp,
          ),
          Padding(
            padding:
                EdgeInsets.only(left: size.size20.dp, bottom: size.size10.dp),
            child: TextWidget(
              text: '1. Default Footer Stepper',
              style: style.h414pxRegular.copyWith(
                color: color.greyBlackUi10,
              ),
            ),
          ),
          FooterStepper(
            footerStepperVariants: FooterStepperVariants.defaultFooter,
            onButtonPressed: () {},
            footerStepperTitleSubtitleModel:
                const FooterStepperTitleSubtitleModel(
              stepperTitle: 'up next',
              stepperSubitle: 'More Details',
            ),
          ),
          SizedBox(
            height: size.size20.dp,
          ),
          Padding(
            padding:
                EdgeInsets.only(left: size.size20.dp, bottom: size.size10.dp),
            child: TextWidget(
              text: '2. Footer Stepper with Back button',
              style: style.h414pxRegular.copyWith(
                color: color.greyBlackUi10,
              ),
            ),
          ),
          FooterStepper(
            footerStepperVariants: FooterStepperVariants.footerWithBack,
            onButtonPressed: () {},
            footerStepperBackButtonModel: FooterStepperBackButtonModel(
              onBackButtonPressed: () {},
            ),
            footerStepperTitleSubtitleModel:
                const FooterStepperTitleSubtitleModel(
              stepperTitle: 'up next',
              stepperSubitle: 'More Details',
            ),
          ),
          SizedBox(
            height: size.size20.dp,
          ),
          Padding(
            padding:
                EdgeInsets.only(left: size.size20.dp, bottom: size.size10.dp),
            child: TextWidget(
              text: '3. Footer Stepper with button caption',
              style: style.h414pxRegular.copyWith(
                color: color.greyBlackUi10,
              ),
            ),
          ),
          FooterStepper(
            footerStepperVariants:
                FooterStepperVariants.footerWithButtonCaption,
            onButtonPressed: () {},
            footerStepperButtonCaptionModel:
                const FooterStepperButtonCaptionModel(
              textButtonCaption: 'Button',
              textButtonRightIconPath: 'images/ic_arrow_forward_white.svg',
              backButtonIconPackage: 'uikit',
            ),
            footerStepperTitleSubtitleModel:
                const FooterStepperTitleSubtitleModel(
              stepperTitle: 'up next',
              stepperSubitle: 'More Details',
            ),
          ),
          SizedBox(
            height: size.size20.dp,
          ),
          Padding(
            padding:
                EdgeInsets.only(left: size.size20.dp, bottom: size.size10.dp),
            child: TextWidget(
              text: '4. Footer Stepper with checkbox',
              style: style.h414pxRegular.copyWith(
                color: color.greyBlackUi10,
              ),
            ),
          ),
          FooterStepper(
            footerStepperVariants: FooterStepperVariants.footerWithCheckbox,
            onButtonPressed: () {},
            footerStepperCheckboxModel: FooterStepperCheckboxModel(
              checkboxCaption: 'I have read, understood and accept',
              isCheckboxChecked: true,
              checkboxCheckValue: (final isCheckboxChecked) {
                //Delegate function to interact with checkbox check action
              },
            ),
          ),
          SizedBox(
            height: size.size20.dp,
          ),
          Padding(
            padding:
                EdgeInsets.only(left: size.size20.dp, bottom: size.size10.dp),
            child: TextWidget(
              text: '5. Footer stepper with note widget leading icon',
              style: style.h414pxRegular.copyWith(
                color: color.greyBlackUi10,
              ),
            ),
          ),
          FooterStepper(
            footerStepperVariants: FooterStepperVariants.footerWithNoteWidget,
            onButtonPressed: () {},
            footerStepperTitleSubtitleModel:
                const FooterStepperTitleSubtitleModel(
              stepperTitle: 'up next',
              stepperSubitle: 'More Details',
            ),
            footerStepperNoteWidgetModel: FooterStepperNoteWidgetModel(
              title: 'Verify Aadhaar and PAN with DigiLocker',
              package: 'uikit',
              leadingImage: 'images/keyboard_arrow_left.svg',
              onPressed: () {},
            ),
          ),
          SizedBox(
            height: size.size20.dp,
          ),
          Padding(
            padding:
                EdgeInsets.only(left: size.size20.dp, bottom: size.size10.dp),
            child: TextWidget(
              text: '6. Footer stepper with note widget trailing icon',
              style: style.h414pxRegular.copyWith(
                color: color.greyBlackUi10,
              ),
            ),
          ),
          FooterStepper(
            footerStepperVariants: FooterStepperVariants.footerWithNoteWidget,
            onButtonPressed: () {},
            footerStepperTitleSubtitleModel:
                const FooterStepperTitleSubtitleModel(
              stepperTitle: 'up next',
              stepperSubitle: 'More Details',
            ),
            footerStepperNoteWidgetModel: FooterStepperNoteWidgetModel(
              title: 'Verify Aadhaar and PAN with DigiLocker',
              package: 'uikit',
              trailingImage: 'images/arrow_rightt.svg',
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
