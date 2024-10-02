import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';
import 'package:tcs_dff_route/route_navigator.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

class BottomsheetTemplateScreen extends StatelessWidget {
  const BottomsheetTemplateScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final locale = context.locale;

    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(context.theme.appSize.size21.dp),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: NormalButton(
                    buttonType: ButtonVariants.normal,
                    caption: locale.txt(key: 'showTemplate'),
                    onPressed: () {
                      showBottomSheetModal(
                        context,
                        BottomsheetTemplate(
                          bottomsheetTemplateData: BottomsheetTemplateData(
                            content: Container(
                              child:
                                  TextWidget(text: locale.txt(key: 'subtitle')),
                            ),
                            primaryButtonText: locale.txt(key: 'verify'),
                            secondaryButtonText: locale.txt(key: 'close'),
                            onPrimaryButtonTap: () {},
                            onSecondaryButtonTap: () {},
                            onCloseButtonTap: () {
                              RouteNavigator.pop(context);
                            },
                            //  bannerText: 'you are send Rs 5000',
                            titleText: 'This sample OTP Screen title',
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: context.theme.appSize.size21.dp,
            ),
            Row(
              children: [
                Expanded(
                  child: NormalButton(
                    buttonType: ButtonVariants.normal,
                    caption: 'Bottomsheet without title',
                    onPressed: () {
                      showBottomSheetModal(
                        context,
                        BottomsheetTemplate(
                          bottomsheetTemplateData: BottomsheetTemplateData(
                            content: Container(
                              child:
                                  TextWidget(text: locale.txt(key: 'subtitle')),
                            ),
                            primaryButtonText: locale.txt(key: 'verify'),
                            secondaryButtonText: locale.txt(key: 'close'),
                            onPrimaryButtonTap: () {},
                            onSecondaryButtonTap: () {},
                            onCloseButtonTap: () {
                              RouteNavigator.pop(context);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: context.theme.appSize.size21.dp,
            ),
            Row(
              children: [
                Expanded(
                  child: NormalButton(
                    buttonType: ButtonVariants.normal,
                    caption: 'Bottomsheet without title & Close Button',
                    onPressed: () {
                      showBottomSheetModal(
                        context,
                        BottomsheetTemplate(
                          bottomsheetTemplateData: BottomsheetTemplateData(
                            content: Container(
                              child:
                                  TextWidget(text: locale.txt(key: 'subtitle')),
                            ),
                            primaryButtonText: locale.txt(key: 'verify'),
                            secondaryButtonText: locale.txt(key: 'close'),
                            onPrimaryButtonTap: () {},
                            onSecondaryButtonTap: () {},
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: context.theme.appSize.size21.dp,
            ),
            Row(
              children: [
                Expanded(
                  child: NormalButton(
                    buttonType: ButtonVariants.normal,
                    caption: 'Bottomsheet with content & background color',
                    onPressed: () {
                      showBottomSheetModal(
                        context,
                        BottomsheetTemplate(
                          bottomsheetTemplateData: BottomsheetTemplateData(
                            backgroundColor:
                                context.theme.appColor.clrPrimaryBlue,
                            content: Container(
                              height: 40.h,
                              child: Center(
                                child: TextWidget(
                                  text: locale.txt(key: 'subtitle'),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
