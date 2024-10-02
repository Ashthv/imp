import 'package:flutter/material.dart';
//import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tcs_dff_types/exceptions.dart';
import 'package:xml/xml.dart';
import '../permission/device_permission_manager.dart';
import '../permission/permission_types.dart';
import '../utils/string_constants.dart';
import 'qr.dart';

class QrScanner extends StatefulWidget {
  final Function(QrInfo) onDetect;
  final bool isTorchEnabled;
  final int detectionTimeoutMs;
  final double zoomLevel;
  final Widget? overlay;

  QrScanner({
    required this.onDetect,
    required this.isTorchEnabled,
    required this.detectionTimeoutMs,
    this.zoomLevel = 0.0,
    this.overlay,
  });

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  late DevicePermissionManager devicePermissionManager;
  //late MobileScannerController controller;
  late bool permissionGranted = false;

  @override
  void initState() {
    super.initState();
    devicePermissionManager = DevicePermissionManager();
    // controller = MobileScannerController(
    //   detectionTimeoutMs: widget.detectionTimeoutMs,
    //   torchEnabled: widget.isTorchEnabled,
    // );
    getPermission();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Container(
            // child: MobileScanner(
            //   controller: controller,
            //   onDetect: _onQrDetect,
            //   overlay: widget.overlay,
            //   onScannerStarted: (final _) =>
            //       controller.setZoomScale(widget.zoomLevel),
            // ),
            ),
      );

  Future<void> getPermission() async {
    final status = await devicePermissionManager.checkAndRequestPermission(
      DevicePermission.camera,
    );
    if (status.isGranted) {
      setState(() {
        permissionGranted = true;
      });
    } else {
      throw DevicePermissionException(
        error: Error(
          title: permissionDenyMessage,
          description: status.toString(),
        ),
      );
    }
  }

  bool isXml(final String inputStr) {
    var flag = false;
    try {
      XmlDocument.parse(inputStr);
      flag = true;
    } on XmlException catch (e) {
      NativeException(
        error: Error(
          description: e.toString(),
          title: xmlException,
        ),
      );
      flag = false;
    }
    return flag;
  }

  // Future<void> _onQrDetect(final BarcodeCapture barcode) async {
  //   final rawBarcode = barcode.barcodes.first.rawValue;
  //   final qrInfo = QrInfo(data: rawBarcode!);

  //   if (isXml(rawBarcode) == true) {
  //     final document = XmlDocument.parse(rawBarcode);

  //     final aadharInfo = document.findAllElements('PrintLetterBarcodeData');

  //     qrInfo.aadharInfo = AadharInfo.fromXml(aadharInfo);
  //   }
  //   widget.onDetect(qrInfo);
  //   Navigator.pop(
  //     context,
  //   );
  // }
}
