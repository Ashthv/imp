import 'package:flutter/material.dart';
import 'package:tcs_dff_types/tcs_dff_types.dart';

import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key, required this.exception});

  final Exception exception;

  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final textStyle = context.theme.appTextStyles;
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(size.size16.dp),
        child: Column(
          children: [
            Text(
              _errorTitle(exception),
              style: textStyle.bodyCopy1Medium18Medium,
            ),
            if (_errorDescription(exception) != null) ...[
              SizedBox(height: size.size8.dp),
              Text(
                _errorDescription(exception)!,
                style: textStyle.bodyCopy2Medium16SemiBold,
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _errorTitle(final Exception exception) =>
      switch (exception.runtimeType) {
        NetworkException => (exception as NetworkException).error.title,
        _ => exception.toString(),
      };

  String? _errorDescription(final Exception exception) =>
      switch (exception.runtimeType) {
        NetworkException => (exception as NetworkException).error.description,
        _ => null,
      };
}

void showErrorDialog(final BuildContext context, final Exception exception) {
  showDialog(
    context: context,
    builder: (final context) => ErrorDialog(exception: exception),
  );
}
