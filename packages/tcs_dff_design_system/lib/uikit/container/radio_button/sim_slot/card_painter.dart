import 'package:flutter/material.dart';
import '../../../../theme/theme_export.dart';

class CardPainter extends CustomPainter {
  final Color color;

  CardPainter({
    required this.color,
  });
  @override
  void paint(final Canvas canvas, final Size size) {
    final paint = Paint()
      ..color = AppColors.transparent
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width - AppSizes.size50, AppSizes.size0)
      ..lineTo(size.width, AppSizes.size45)
      ..lineTo(size.width, size.height - AppSizes.size12)
      ..quadraticBezierTo(
        size.width,
        size.height,
        size.width - AppSizes.size24,
        size.height,
      )
      ..lineTo(AppSizes.size20, size.height)
      ..quadraticBezierTo(
        AppSizes.size0,
        size.height,
        AppSizes.size0,
        size.height - AppSizes.size24,
      )
      ..lineTo(AppSizes.size0, AppSizes.size24)
      ..quadraticBezierTo(
        AppSizes.size0,
        AppSizes.size0,
        AppSizes.size24,
        AppSizes.size0,
      )
      ..lineTo(size.width - AppSizes.size50, AppSizes.size0)
      ..close();

    canvas.drawPath(path, paint);

    final borderPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(final CustomPainter oldDelegate) => false;
}
