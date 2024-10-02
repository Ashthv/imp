import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';
import 'package:tcs_dff_device_feature/qr_scanner.dart/qr.dart';
import 'package:tcs_dff_device_feature/qr_scanner.dart/qr_scanner.dart';
import 'package:tcs_dff_shared_library/logger/logger.dart';

class DemoQrScanner extends StatefulWidget {
  const DemoQrScanner({super.key});

  @override
  State<DemoQrScanner> createState() => _DemoQrScannerState();
}

class _DemoQrScannerState extends State<DemoQrScanner> {
  String barcode = '';
  Address? aadharInfo;

  @override
  Widget build(final BuildContext context) => SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (final context) => QrScanner(
                      detectionTimeoutMs: 200,
                      isTorchEnabled: false,
                      zoomLevel: 0.6,
                      onDetect: (final qrInfo) {
                        ConsoleLogger()
                            .log('Barcode: ${qrInfo.data.toString()}');
                        ConsoleLogger().log(
                          'Aadhar Output: ${qrInfo.aadharInfo?.uid}',
                        );
                        ConsoleLogger().log(
                          'Aadhar Output: ${qrInfo.aadharInfo?.name}',
                        );
                        ConsoleLogger().log(
                          'Aadhar Output: ${qrInfo.aadharInfo?.address}',
                        );
                        ConsoleLogger().log(
                          'Aadhar Output: ${qrInfo.aadharInfo?.gender}',
                        );
                        setState(() {
                          barcode = qrInfo.data;
                          aadharInfo = qrInfo.aadharInfo?.address;
                        });
                      },
                    ),
                  ),
                );
              },
              child: const Text('Open Qr Scanner'),
            ),
            Text('Barcode is: $barcode'),
            SizedBox(height: context.theme.appSize.size14.dp),
            Text('Aadhar Info is: $aadharInfo'),
          ],
        ),
      );
}
