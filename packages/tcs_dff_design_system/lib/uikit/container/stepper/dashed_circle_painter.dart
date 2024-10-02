import 'dart:math';

import 'package:flutter/material.dart';

class DashedCirclePainter extends CustomPainter {
  Color lineColor = Colors.transparent;
  final Color completeColor;
  final double width;
  DashedCirclePainter({
    required this.completeColor,
    required this.width,
  });
  @override
  void paint(final Canvas canvas, final Size size) {
    final complete = Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;

    final center = Offset(size.width / 2, size.height / 2);
    final double radius = min(size.width / 2, size.height / 2);
    // tinker with below denominator to tinker with dash
    final percent = (size.width * 0.001) / 3;

    final arcAngle = 2 * pi * percent;

    // tinker with below termination count to tinker with dash
    for (var i = 0; i < 24; i++) {
      // tinker with below denominator of i to tinker with dash
      final init = (-pi / 2) * (i / 6);

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        init,
        arcAngle,
        false,
        complete,
      );
    }
  }

  @override
  bool shouldRepaint(final CustomPainter oldDelegate) => true;
}
