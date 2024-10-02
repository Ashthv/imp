import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';

class ListGridWidgetScreen extends StatelessWidget {
  const ListGridWidgetScreen({super.key});

  @override
  Widget build(final BuildContext context) => SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: context.theme.appSize.size8.dp,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: context.theme.appSize.size8.dp,
              ),
              color: context.theme.appColor.greyOffWhite90,
              child: Column(
                children: [
                  ListGridWidget(
                    columnCount: 1,
                    childAspectRatio: 4 / 1,
                    titleSubtitleTextWidgetList: [
                      const TitleSubtitleTextWidget(
                        title: 'Address',
                        subtitle:
                            // ignore: lines_longer_than_80_chars
                            'House No 112, Street - ABC Road, Test Building, Test Colony, Test State, 410045',
                        dividerLine:
                            DividerLine(dividerType: DividerType.dashDivider),
                      ),
                    ],
                  ),
                  ListGridWidget(
                    childAspectRatio: 2.5 / 1,
                    titleSubtitleTextWidgetList: [
                      const TitleSubtitleTextWidget(
                        title: 'PAN',
                        subtitle: 'XYZ6523I',
                        dividerLine:
                            DividerLine(dividerType: DividerType.dashDivider),
                      ),
                      const TitleSubtitleTextWidget(
                        title: 'Aadhaar No',
                        subtitle: '999999999999',
                        dividerLine:
                            DividerLine(dividerType: DividerType.dashDivider),
                      ),
                      const TitleSubtitleTextWidget(
                        title: 'Mobile No',
                        subtitle: '9999999999',
                        customPattern: 'XXXXXX####',
                        dividerLine:
                            DividerLine(dividerType: DividerType.dashDivider),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: context.theme.appSize.size24.dp,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: context.theme.appSize.size8.dp,
              ),
              child: ListGridWidget(
                childAspectRatio: 10 / 1,
                columnCount: 1,
                mainAxisSpacing: context.theme.appSize.size0.dp,
                titleSubtitleTextWidgetList: [
                  const TitleSubtitleTextWidget(
                    title: 'Item 1',
                    subtitle: '1000',
                    verticalOrientation: false,
                  ),
                  const TitleSubtitleTextWidget(
                    title: 'Item 2',
                    subtitle: '2000',
                    verticalOrientation: false,
                  ),
                  const TitleSubtitleTextWidget(
                    title: 'Sub total',
                    subtitle: '2000',
                    verticalOrientation: false,
                  ),
                  const TitleSubtitleTextWidget(
                    title: 'Tax',
                    subtitle: '112',
                    verticalOrientation: false,
                    dividerLine:
                        DividerLine(dividerType: DividerType.dashDivider),
                  ),
                  TitleSubtitleTextWidget(
                    titleTextStyle: context
                        .theme.appTextStyles.bodyCopy2Large16Bold
                        .copyWith(color: context.theme.appColor.clrPrimaryBlue),
                    title: 'Total',
                    subtitle: '4112',
                    verticalOrientation: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
