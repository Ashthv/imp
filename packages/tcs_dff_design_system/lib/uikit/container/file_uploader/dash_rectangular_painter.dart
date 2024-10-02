import 'dart:math' as math;

import 'package:flutter/material.dart';

class DashRectangularPainter extends CustomPainter {
  double strokeWidth;
  Color color;
  int gap;

  DashRectangularPainter({
    this.strokeWidth = 5.0,
    required this.color,
    this.gap = 5,
  });

  @override
  void paint(final Canvas canvas, final Size size) {
    final dashedPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final width = size.width;
    final height = size.height;

    final topPath = getDashedPath(
      point1: const math.Point(0, 0),
      point2: math.Point(width, 0),
      gap: gap,
    );

    final rightPath = getDashedPath(
      point1: math.Point(width, 0),
      point2: math.Point(width, height),
      gap: gap,
    );

    final bottomPath = getDashedPath(
      point1: math.Point(0, height),
      point2: math.Point(width, height),
      gap: gap,
    );

    final leftPath = getDashedPath(
      point1: const math.Point(0, 0),
      point2: math.Point(0.001, height),
      gap: gap,
    );

    canvas
      ..drawPath(topPath, dashedPaint)
      ..drawPath(rightPath, dashedPaint)
      ..drawPath(bottomPath, dashedPaint)
      ..drawPath(leftPath, dashedPaint);
  }

  Path getDashedPath({
    required final math.Point<double> point1,
    required final math.Point<double> point2,
    required final int gap,
  }) {
    final size = Size(point2.x - point1.x, point2.y - point1.y);
    final path = Path();
    var shouldDraw = true;
    var currentPoint = math.Point(point1.x, point1.y);
    path.moveTo(point1.x, point1.y);

    final radians = math.atan(size.height / size.width);

    final xOffset = math.cos(radians) * gap < 0
        ? math.cos(radians) * gap * -1
        : math.cos(radians) * gap;

    final yOffset = math.sin(radians) * gap < 0
        ? math.sin(radians) * gap * -1
        : math.sin(radians) * gap;

    while (currentPoint.x <= point2.x && currentPoint.y <= point2.y) {
      shouldDraw
          ? path.lineTo(currentPoint.x.toDouble(), currentPoint.y.toDouble())
          : path.moveTo(currentPoint.x.toDouble(), currentPoint.y.toDouble());
      shouldDraw = !shouldDraw;
      currentPoint = math.Point(
        currentPoint.x + xOffset,
        currentPoint.y + yOffset,
      );
    }
    return path;
  }

  @override
  bool shouldRepaint(final CustomPainter oldDelegate) => false;
}
