import 'package:flutter/material.dart';

import '../../../tcs_dff_design_system.dart';
import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';
import 'dashed_circle_painter.dart';
import 'vertical_dashed_line_painter.dart';

export 'stepper_config.dart';

class StepperWidget extends StatelessWidget {
  const StepperWidget({super.key, required this.configList});
  final List<StepperConfig> configList;

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final color = context.theme.appColor;
    return ListView.builder(
      itemCount: configList.length,
      itemBuilder: (final context, final index) => Container(
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      if (configList.elementAt(index).status ==
                          ProgressStatus.pending)
                        CustomPaint(
                          size: Size(size.size56.dp, size.size56.dp),
                          foregroundPainter: DashedCirclePainter(
                            completeColor: color.clrPrimaryBlue80,
                            width: size.size1.dp,
                          ),
                        ),
                      Container(
                        width: size.size56.dp,
                        height: size.size56.dp,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: configList
                              .elementAt(index)
                              .status
                              .getIconBgColor(context),
                        ),
                        child: ImageWidget(
                          imageType: ImageType.assetImage,
                          path: configList.elementAt(index).iconPath,
                          package: configList.elementAt(index).imagePackage,
                          color: configList
                              .elementAt(index)
                              .status
                              .getIconColor(context),
                        ),
                      ),
                    ],
                  ),
                  if (index != configList.length - 1)
                    if (configList.elementAt(index).status !=
                        ProgressStatus.pending)
                      Expanded(
                        child: Container(
                          constraints: BoxConstraints(
                            minHeight: size.size30.dp,
                          ),
                          width: size.size1.dp,
                          color: configList
                              .elementAt(index)
                              .status
                              .getProgressLineColor(context),
                        ),
                      )
                    else
                      Expanded(
                        child: Container(
                          constraints: BoxConstraints(
                            minHeight: size.size30.dp,
                          ),
                          child: CustomPaint(
                            size: Size(1, Size.infinite.height),
                            painter: VerticalDashedLinePainter(
                              color: color.clrPrimaryBlue80,
                              dashHeight: 5,
                              dashSpace: 3,
                            ),
                          ),
                        ),
                      ),
                ],
              ),
              SizedBox(
                width: size.size10.dp,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      configList.elementAt(index).title,
                      textAlign: TextAlign.left,
                      style: configList
                          .elementAt(index)
                          .status
                          .getTitleStyles(context),
                    ),
                    if (configList.elementAt(index).subTitle != null)
                      Text(
                        configList.elementAt(index).subTitle!,
                        textAlign: TextAlign.left,
                        style: configList
                            .elementAt(index)
                            .status
                            .getSubTitleStyles(context),
                      ),
                    if (index != configList.length - 1)
                      SizedBox(
                        height: size.size30.dp,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
