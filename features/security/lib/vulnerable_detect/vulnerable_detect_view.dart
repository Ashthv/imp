import 'package:flutter/material.dart';
import 'package:tcs_dff_security/vulnerable_detect/vulnerable_detect.dart';

class VulnerableDetectView extends StatelessWidget {
  @override
  Widget build(final BuildContext context) => FutureBuilder(
        future:
            VulnerableDetect().checkVulnerableApps(),
        builder: (final _, final snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Text(
                snapshot.data!
                    ? 'Vulnerable Apps Found'
                    : 'No Vulnerable Apps Found',
                style: const TextStyle(color: Colors.black),
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      );
}
