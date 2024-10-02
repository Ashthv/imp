import 'package:flutter/material.dart';

class PageTabIndicator extends Decoration {
  final double radius;

  final Color color;

  final double indicatorHeight;

  final Color unselectedTabColor;

  final Color selectedTabColor;

  final bool showBottomCurve;

  const PageTabIndicator({
    this.radius = 8,
    this.indicatorHeight = 4,
    this.color = Colors.blue,
    this.unselectedTabColor = Colors.blue,
    this.selectedTabColor = Colors.blue,
    this.showBottomCurve = false,
  });

  @override
  CustomPageTabIndicator createBoxPainter([final VoidCallback? onChanged]) =>
      CustomPageTabIndicator(
        this,
        onChanged,
        radius,
        color,
        indicatorHeight,
        unselectedTabColor,
        selectedTabColor,
        showBottomCurve,
      );
}

class CustomPageTabIndicator extends BoxPainter {
  final PageTabIndicator decoration;
  final double radius;
  final Color color;
  final double indicatorHeight;
  final Color unselectedTabColor;
  final Color selectedTabColor;
  final bool showBottomCurve;

  CustomPageTabIndicator(
    this.decoration,
    final VoidCallback? onChanged,
    this.radius,
    this.color,
    this.indicatorHeight,
    this.unselectedTabColor,
    this.selectedTabColor,
    this.showBottomCurve,
  ) : super(onChanged);

  @override
  void paint(
    final Canvas canvas,
    final Offset offset,
    final ImageConfiguration configuration,
  ) {
    final paint = Paint();
    final xAxisPos = offset.dx + configuration.size!.width / 2;
    final yAxisPos =
        offset.dy + configuration.size!.height - indicatorHeight / 2;
    paint.color = color;

    if (showBottomCurve) {
      final linePaint = Paint()..color = selectedTabColor;
      final lineRect = RRect.fromRectAndCorners(
        Rect.fromCenter(
          center: Offset(xAxisPos, yAxisPos + 1),
          width: configuration.size!.width * 1.2,
          height: indicatorHeight + 1,
        ),
        topLeft: Radius.circular(radius),
        topRight: Radius.circular(radius),
        bottomLeft: Radius.circular(radius),
        bottomRight: Radius.circular(radius),
      );
      canvas.drawRRect(lineRect, linePaint);

      final paintLeft = Paint()..color = unselectedTabColor;
      final leftRect = RRect.fromRectAndCorners(
        Rect.fromPoints(
          Offset(offset.dx - 15, offset.dy - 15),
          Offset(offset.dx, offset.dy + 2),
        ),
        bottomRight: Radius.circular(radius),
      );
      canvas.drawRRect(leftRect, paintLeft);

      final paintRight = Paint()..color = unselectedTabColor;
      final rightRect = RRect.fromRectAndCorners(
        Rect.fromPoints(
          Offset(configuration.size!.width + offset.dx, offset.dy - 15),
          Offset(configuration.size!.width + offset.dx + 15, offset.dy + 2),
        ),
        bottomLeft: Radius.circular(radius),
      );
      canvas.drawRRect(rightRect, paintRight);
    }

    final indicatorRect = RRect.fromRectAndCorners(
      Rect.fromCenter(
        center: Offset(xAxisPos, yAxisPos),
        width: configuration.size!.width / 5,
        height: indicatorHeight,
      ),
      topLeft: Radius.circular(radius),
      topRight: Radius.circular(radius),
      bottomLeft: Radius.circular(radius),
      bottomRight: Radius.circular(radius),
    );

    canvas.drawRRect(indicatorRect, paint);
  }
}
