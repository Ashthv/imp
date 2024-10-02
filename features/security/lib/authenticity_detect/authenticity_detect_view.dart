
import 'package:flutter/material.dart';
import 'package:tcs_dff_security/authenticity_detect/authenticity_detect.dart';

class AuthenticityDetectView extends StatelessWidget {
  @override
  Widget build(final BuildContext context) => FutureBuilder(
        future: AuthenticityDetect().checkAppAuthenticity(),
        builder: (final _, final snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Text(
                snapshot.data!
                    ? 'App Authenticity Verified'
                    : 'App Authenticity Not Verified',
                style: const TextStyle(color: Colors.black),
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      );
}