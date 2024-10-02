import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';

class RecommenededCardWidget extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? cardImagePath;
  final String? headingText;
  final String? descriptionText;
  // final button;

  RecommenededCardWidget({
    super.key,
    this.title,
    this.subtitle,
    this.cardImagePath,
    this.headingText,
    this.descriptionText,
    // this.button,
  });

  @override
  Widget build(final BuildContext context) {
    final color = context.theme.appColor;
    final size = context.theme.appSize;
    //final textStyle = context.theme.appTextStyles;

    // return Card(
    void onPress() {}

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: color.clrPrimaryBlue),
        borderRadius: BorderRadius.circular(size.size10.dp),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: CheckboxWidget(),
                    ),
                    if (cardImagePath != null)
                      ImageWidget(
                        imageType: ImageType.assetImage,
                        path: cardImagePath!,
                        package: 'uikit',
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: onPress,
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(),
                            ),
                          ),
                          child: Container(
                            child: const Row(
                              children: [
                                Text(
                                  'Mastercard',
                                  style: TextStyle(),
                                ),
                                IconWidget(
                                  iconName:
                                      'packages/tcs_dff_design_system/assets/images/keyboard_arrow_down.png',
                                  iconSize: IconSize.small,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(subtitle!),
                    HyperlinkButton(caption: 'Know More', onPressed: () {}),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: NormalButton(
              buttonType: ButtonVariants.fourColumn,
              caption: 'Apply Now',
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
