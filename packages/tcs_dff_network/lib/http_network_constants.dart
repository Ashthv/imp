class HttpNetworkConstants {
  static String authExceptionMessage =
      '''Your session has expired. Please login again to continue using the app.''';
  static String timeoutExceptionMessage =
      '''It is taking longer than expected to process your request. Please try again''';
  static String socketExceptionMessage =
      'Please check your internet settings and try again';
  static String ioExceptionMessage =
      '''Something went wrong while performing your request. Please try again''';
  static String genericExceptionMessage =
      '''Something went wrong. Please try again''';
  static String authTokenCollectionName = 'authTokenCollection';
  static String authTokenKey = 'authTokenKey';
  static String sessionTokenCollectionName = 'sessionTokenCollection';
  static String sessionTokenCollectionKey = 'authorization';
  static String requestTimeoutMessage = 'Request timeout';

  static int statusCodeSuccess = 200;
}
