import 'dart:math';
import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class DottedBorder extends CustomPainter {
  final double numberOfStories;
  final double spaceLength;
  final BuildContext context;
  double startOfArcInDegree = 0;

  DottedBorder({
    required this.numberOfStories,
    this.spaceLength = 10,
    required this.context,
  });

  double inRads(final double degree) => (degree * pi) / 180;

  @override
  bool shouldRepaint(final DottedBorder oldDelegate) => true;

  @override
  void paint(final Canvas canvas, final Size size) {
    var arcLength = (360 - (numberOfStories * spaceLength)) / numberOfStories;

    if (arcLength <= 0) {
      arcLength = 360 / spaceLength - 1;
    }

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    for (var i = 0; i < numberOfStories; i++) {
      canvas.drawArc(
        rect,
        inRads(startOfArcInDegree),
        inRads(arcLength),
        false,
        Paint()
          ..color = context.theme.appColor.greyLightestGrey80
          ..strokeWidth = 2.0
          ..style = PaintingStyle.stroke,
      );

      startOfArcInDegree += arcLength + spaceLength;
    }
  }
}
