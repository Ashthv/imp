import 'package:tcs_dff_design_system/uikit/container/dialog/error_dialog.dart';
import 'package:tcs_dff_route/tcs_dff_route.dart';
import 'package:tcs_dff_types/config.dart';

class NetworkInterceptor implements Interceptor {
  @override
  void callback(final Exception exception, final StackTrace stackTrace) {
    showErrorDialog(rootNavigatorKey.currentContext!, exception);
  }
}
