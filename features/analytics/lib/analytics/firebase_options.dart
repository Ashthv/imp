import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:tcs_dff_analytics/analytics/firebase_default_analytics.dart';

class DefaultFirebaseOptions {
  static PluginFirebaseOptions get firebaseOptions {
    if (kIsWeb) {
      return webFirebaseOptions;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return androidFirebaseOptions;
      case TargetPlatform.iOS:
        return iOSFirebaseOptions;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const PluginFirebaseOptions webFirebaseOptions = PluginFirebaseOptions(
    apiKey: 'AIzaSyDHlCQgiH3cQV6SGFsgOEC-FODK7TgFla4',
    authDomain: 'productdemo-eac5c.firebaseapp.com',
    projectId: 'productdemo-eac5c',
    storageBucket: 'productdemo-eac5c.appspot.com',
    messagingSenderId: '564578576176',
    appId: '1:564578576176:web:0b701fe0e2fe17e8598af5',
    measurementId: 'G-TPBPD17M4M',
  );

  static const PluginFirebaseOptions androidFirebaseOptions =
      PluginFirebaseOptions(
    apiKey: 'AIzaSyB28hWBOl3ZRJp8gr-JV9ZewhZhoMCloHY',
    appId: '1:564578576176:android:30f030deec30e2b2598af5',
    messagingSenderId: '564578576176',
    projectId: 'productdemo-eac5c',
    storageBucket: 'productdemo-eac5c.appspot.com',
  );

  static const PluginFirebaseOptions iOSFirebaseOptions = PluginFirebaseOptions(
    apiKey: 'AIzaSyD05DGIe6gKSqOR-47scGpgUquNg56KOlA',
    appId: '1:564578576176:ios:7608e957c8303595598af5',
    messagingSenderId: '564578576176',
    projectId: 'productdemo-eac5c',
    storageBucket: 'productdemo-eac5c.appspot.com',
  );
}
