//The radiusFactor must be between 0 and 1. Axis radius is determined by
//multiplying this factor value to the minimum width or height of the widget.

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../../theme/theme.dart';
import '../../utils/sizer/app_sizer.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({
    super.key,
    required this.totalTime,
    this.timeLeftText,
    this.hourText,
    this.minuteText,
    this.lapseTime = const Duration(),
    this.radiusFactor = 0.65,
    this.circleThickness = 0.03,
    this.markerDiameter = 15,
    this.circleColor,
    this.shadowColor,
  });

  final Duration totalTime;
  final Duration? lapseTime;
  final String? timeLeftText;
  final String? hourText;
  final String? minuteText;
  final double radiusFactor;
  final double circleThickness;
  final double markerDiameter;
  final Color? circleColor;
  final Color? shadowColor;

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget>
    with TickerProviderStateMixin {
  late AnimationController controller;

  late double progress;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: widget
          .totalTime, // this is from where countdown will start in reverse
    );
    progressChange();
  }

  // Getting the time as text in hours and minutes
  String get countText {
    final count = controller.duration! * controller.value;
    final countInHours = count.inHours.toString().padLeft(2, '0');
    final countInMinutes = (count.inMinutes % 60).toString().padLeft(2, '0');
    return '$countInHours : $countInMinutes';
  }

  // PROGRESS is the percentage representation of time remaining.
  // Calculation of circular progress bar is based on PROGRESS
  void progressChange() {
    if (widget.lapseTime!.inMinutes > 0) {
      progress = widget.lapseTime!.inMinutes / widget.totalTime.inMinutes;
    } else {
      progress = 1.0;
    }

    if (controller.isAnimating) {
      controller.stop();
    } else {
      controller.reverse(
        from: controller.value == 0 ? progress : controller.value,
      );
    }

    controller.addListener(() {
      if (controller.isAnimating) {
        setState(() {
          progress = controller.value;
        });
      } else {
        progress = 1.0;
      }
    });
  }

  @override
  Widget build(final BuildContext context) {
    final color = context.theme.appColor;
    final size = context.theme.appSize;
    final textStyle = context.theme.appTextStyles;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          child: SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                showLabels: false,
                showTicks: false,
                startAngle: 270,
                endAngle: 270,
                radiusFactor: widget.radiusFactor, // radius of the circle
                axisLineStyle: AxisLineStyle(
                  thickness:
                      widget.circleThickness, // thickness of light circle
                  color: widget.shadowColor ?? color.greyOffWhite90,
                  thicknessUnit: GaugeSizeUnit.factor,
                  cornerStyle: CornerStyle.startCurve,
                ),
                pointers: <GaugePointer>[
                  RangePointer(
                    value: progress * 100,
                    width:
                        widget.circleThickness, // thickness of gradient circle
                    sizeUnit: GaugeSizeUnit.factor,
                    enableAnimation: true,
                    animationDuration: 100,
                    animationType: AnimationType.linear,
                    cornerStyle: CornerStyle.startCurve,
                    gradient: SweepGradient(
                      colors: <Color>[
                        widget.circleColor ?? color.clrPrimaryBlue,
                      ],
                    ),
                  ),
                  MarkerPointer(
                    markerHeight: widget.markerDiameter,
                    markerWidth: widget.markerDiameter,
                    value: progress * 100,
                    markerType: MarkerType.circle,
                    enableAnimation: true,
                    animationDuration: 100,
                    animationType: AnimationType.linear,
                    color: widget.circleColor ?? color.clrPrimaryBlue,
                  ),
                ],
              ),
            ],
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.timeLeftText != null)
              Text(
                widget.timeLeftText!,
                style: textStyle.detailsSmall12Regular.copyWith(
                  color: widget.circleColor ?? color.greyGrey50,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                ),
              ),
            SizedBox(
              height: size.size15.dp,
            ),
            Text(
              countText,
              style: context.theme.appTextStyles.h636pxRegular.copyWith(
                color: widget.circleColor ?? color.clrPrimaryBlue,
                fontSize: size.size48.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.hourText != null)
                  Text(
                    widget.hourText!.toUpperCase(),
                    style: textStyle.detailsSmall12Regular.copyWith(
                      color: widget.circleColor ?? color.greyDarkGrey30,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                      fontSize: size.size8.sp,
                    ),
                  ),
                SizedBox(
                  width: size.size45.dp,
                ),
                if (widget.minuteText != null)
                  Padding(
                    padding: EdgeInsets.only(
                      left: size.size10.dp,
                    ),
                    child: Text(
                      widget.minuteText!.toUpperCase(),
                      style: textStyle.detailsSmall12Regular.copyWith(
                        color: widget.circleColor ?? color.greyDarkGrey30,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        fontSize: size.size8.sp,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
