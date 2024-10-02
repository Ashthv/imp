// import 'dart:io';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';

// class ScannerOverlay extends CustomPainter {
//   ScannerOverlay(this.scanWindow);

//   final Rect scanWindow;

//   @override
//   void paint(final Canvas canvas, final Size size) {
//     final backgroundPath = Path()..addRect(Rect.largest);
//     final cutoutPath = Path()..addRect(scanWindow);

//     final backgroundPaint = Paint()
//       ..color = Colors.black.withOpacity(0.5)
//       ..style = PaintingStyle.fill
//       ..blendMode = BlendMode.dstOut;

//     final backgroundWithCutout = Path.combine(
//       PathOperation.difference,
//       backgroundPath,
//       cutoutPath,
//     );
//     canvas.drawPath(backgroundWithCutout, backgroundPaint);
//   }

//   @override
//   bool shouldRepaint(covariant final CustomPainter oldDelegate) => false;
// }

// class BarcodeOverlay extends CustomPainter {
//   BarcodeOverlay({
//     required this.barcode,
//     required this.arguments,
//     required this.boxFit,
//     required this.capture,
//   });

//   final BarcodeCapture capture;
//   final Barcode barcode;
//   final MobileScannerArguments arguments;
//   final BoxFit boxFit;

//   @override
//   void paint(final Canvas canvas, final Size size) {
//     if (barcode.corners.isEmpty) {
//       return;
//     }

//     final adjustedSize = applyBoxFit(boxFit, arguments.size, size);

//     var verticalPadding = size.height - adjustedSize.destination.height;
//     var horizontalPadding = size.width - adjustedSize.destination.width;
//     if (verticalPadding > 0) {
//       verticalPadding = verticalPadding / 2;
//     } else {
//       verticalPadding = 0;
//     }

//     if (horizontalPadding > 0) {
//       horizontalPadding = horizontalPadding / 2;
//     } else {
//       horizontalPadding = 0;
//     }

//     final double ratioWidth;
//     final double ratioHeight;

//     if (!kIsWeb && Platform.isIOS) {
//       ratioWidth = capture.size.width / adjustedSize.destination.width;
//       ratioHeight = capture.size.height / adjustedSize.destination.height;
//     } else {
//       ratioWidth = arguments.size.width / adjustedSize.destination.width;
//       ratioHeight = arguments.size.height / adjustedSize.destination.height;
//     }

//     final adjustedOffset = <Offset>[];
//     for (final offset in barcode.corners) {
//       adjustedOffset.add(
//         Offset(
//           offset.dx / ratioWidth + horizontalPadding,
//           offset.dy / ratioHeight + verticalPadding,
//         ),
//       );
//     }
//     final cutoutPath = Path()..addPolygon(adjustedOffset, true);

//     final backgroundPaint = Paint()
//       ..color = Colors.red.withOpacity(0.3)
//       ..style = PaintingStyle.fill
//       ..blendMode = BlendMode.dstOut;

//     canvas.drawPath(cutoutPath, backgroundPaint);
//   }

//   @override
//   bool shouldRepaint(covariant final CustomPainter oldDelegate) => false;
// }
