import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../colors.dart';

SliderThemeData sliderThemeData = const SliderThemeData(
  trackHeight: 6.0,
  trackShape: GradientRectSliderTrackShape(
    gradient: LinearGradient(
      colors: [
        AppColors.clrPrimaryPink,
        AppColors.clrPrimaryPurple,
      ],
    ),
  ),
  thumbShape: NewRoundSliderThumbShape(
    elevation: 2,
    enabledThumbRadius: 12.0,
  ),
  thumbColor: AppColors.clrPrimaryPurple,
  overlayColor: AppColors.greyFullWhite120,
  overlayShape: RoundSliderOverlayShape(overlayRadius: 12.0),
  valueIndicatorShape: PaddleSliderValueIndicatorShape(),
  valueIndicatorTextStyle:
      TextStyle(fontSize: 16, color: AppColors.greyFullWhite120),
  inactiveTrackColor: AppColors.clrPrimaryPurple120,
  inactiveTickMarkColor: AppColors.clrPrimaryPurple120,
  allowedInteraction: SliderInteraction.tapAndSlide,
);

class GradientRectSliderTrackShape extends SliderTrackShape
    with BaseSliderTrackShape {
  const GradientRectSliderTrackShape({
    this.gradient = const LinearGradient(
      colors: [
        AppColors.clrPrimaryPink10,
        AppColors.clrPrimaryPurple10,
      ],
    ),
    this.darkenInactive = true,
  });

  final LinearGradient gradient;
  final bool darkenInactive;

  @override
  void paint(
    final PaintingContext context,
    final Offset offset, {
    required final RenderBox parentBox,
    required final SliderThemeData sliderTheme,
    required final Animation<double> enableAnimation,
    required final Offset thumbCenter,
    final bool isDiscrete = false,
    final bool isEnabled = false,
    final Offset? secondaryOffset,
    final double additionalActiveTrackHeight = 0,
    required final TextDirection textDirection,
  }) {
    final trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final activeGradientRect = Rect.fromLTRB(
      trackRect.left,
      (textDirection == TextDirection.ltr)
          ? trackRect.top - (additionalActiveTrackHeight / 2)
          : trackRect.top,
      thumbCenter.dx,
      (textDirection == TextDirection.ltr)
          ? trackRect.bottom + (additionalActiveTrackHeight / 2)
          : trackRect.bottom,
    );

    // Assign the track segment paints, which are leading: active and
    // trailing: inactive.
    final activeTrackColorTween = ColorTween(
      begin: sliderTheme.disabledActiveTrackColor,
      end: sliderTheme.activeTrackColor,
    );
    final inactiveTrackColorTween = darkenInactive
        ? ColorTween(
            begin: sliderTheme.disabledInactiveTrackColor,
            end: sliderTheme.inactiveTrackColor,
          )
        : activeTrackColorTween;
    final activePaint = Paint()
      ..shader = gradient.createShader(activeGradientRect)
      ..color = activeTrackColorTween.evaluate(enableAnimation)!;
    final inactivePaint = Paint()
      ..color = inactiveTrackColorTween.evaluate(enableAnimation)!;
    final Paint leftTrackPaint;
    final Paint rightTrackPaint;
    switch (textDirection) {
      case TextDirection.ltr:
        leftTrackPaint = activePaint;
        rightTrackPaint = inactivePaint;
        break;
      case TextDirection.rtl:
        leftTrackPaint = inactivePaint;
        rightTrackPaint = activePaint;
        break;
    }

    final trackRadius = Radius.circular(trackRect.height / 2);
    final activeTrackRadius = Radius.circular(trackRect.height / 2 + 1);

    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        trackRect.left,
        (textDirection == TextDirection.ltr)
            ? trackRect.top - (additionalActiveTrackHeight / 2)
            : trackRect.top,
        thumbCenter.dx,
        (textDirection == TextDirection.ltr)
            ? trackRect.bottom + (additionalActiveTrackHeight / 2)
            : trackRect.bottom,
        topLeft: (textDirection == TextDirection.ltr)
            ? activeTrackRadius
            : trackRadius,
        bottomLeft: (textDirection == TextDirection.ltr)
            ? activeTrackRadius
            : trackRadius,
      ),
      leftTrackPaint,
    );
    context.canvas.drawRRect(
      RRect.fromLTRBAndCorners(
        thumbCenter.dx,
        (textDirection == TextDirection.rtl)
            ? trackRect.top - (additionalActiveTrackHeight / 2)
            : trackRect.top,
        trackRect.right,
        (textDirection == TextDirection.rtl)
            ? trackRect.bottom + (additionalActiveTrackHeight / 2)
            : trackRect.bottom,
        topRight: (textDirection == TextDirection.rtl)
            ? activeTrackRadius
            : trackRadius,
        bottomRight: (textDirection == TextDirection.rtl)
            ? activeTrackRadius
            : trackRadius,
      ),
      rightTrackPaint,
    );
  }
}

class NewRoundSliderThumbShape extends SliderComponentShape {
  /// Create a slider thumb that draws a circle.
  const NewRoundSliderThumbShape({
    this.enabledThumbRadius = 10.0,
    this.disabledThumbRadius,
    this.elevation = 1.0,
    this.pressedElevation = 6.0,
  });

  final double enabledThumbRadius;
  final double? disabledThumbRadius;
  double get _disabledThumbRadius => disabledThumbRadius ?? enabledThumbRadius;
  final double elevation;
  final double pressedElevation;

  @override
  Size getPreferredSize(final bool isEnabled, final bool isDiscrete) =>
      Size.fromRadius(
        isEnabled ? enabledThumbRadius : _disabledThumbRadius,
      );

  @override
  void paint(
    final PaintingContext context,
    final Offset center, {
    required final Animation<double> activationAnimation,
    required final Animation<double> enableAnimation,
    required final bool isDiscrete,
    required final TextPainter labelPainter,
    required final RenderBox parentBox,
    required final SliderThemeData sliderTheme,
    required final TextDirection textDirection,
    required final double value,
    required final double textScaleFactor,
    required final Size sizeWithOverflow,
  }) {
    final canvas = context.canvas;
    final radiusTween = Tween<double>(
      begin: _disabledThumbRadius,
      end: enabledThumbRadius,
    );
    final colorTween = ColorTween(
      begin: sliderTheme.disabledThumbColor,
      end: sliderTheme.thumbColor,
    );

    final color = colorTween.evaluate(enableAnimation)!;
    final radius = radiusTween.evaluate(enableAnimation);

    final elevationTween = Tween<double>(
      begin: elevation,
      end: pressedElevation,
    );

    final evaluatedElevation = elevationTween.evaluate(activationAnimation);
    final path = Path()
      ..addArc(
        Rect.fromCenter(center: center, width: 2 * radius, height: 2 * radius),
        0,
        math.pi * 2,
      );

    var paintShadows = true;
    // ignore: prefer_asserts_with_message
    assert(() {
      if (debugDisableShadows) {
        _debugDrawShadow(canvas, path, evaluatedElevation);
        paintShadows = false;
      }
      return true;
    }());

    if (paintShadows) {
      canvas.drawShadow(path, Colors.black, evaluatedElevation, true);
    }
    canvas
      ..drawCircle(
        center,
        radius,
        Paint()..color = Colors.white,
      )
      ..drawCircle(
        center,
        radius - 2,
        Paint()..color = color,
      );
  }
}

void _debugDrawShadow(
  final Canvas canvas,
  final Path path,
  final double elevation,
) {
  if (elevation > 0.0) {
    canvas.drawPath(
      path,
      Paint()
        ..color = Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = elevation * 5.0,
    );
  }
}
