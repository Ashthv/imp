import 'package:flutter/material.dart';

import '../theme/theme.dart';
import 'sizer/app_sizer.dart';

void showBottomSheetModal(
  final BuildContext context,
  final Widget content, {
  final bool isDismissible = true,
  final bool extendContentBehindAppBar = true,
  final bool enableDrag = true,
}) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    isDismissible: isDismissible,
    useRootNavigator: extendContentBehindAppBar,
    useSafeArea: extendContentBehindAppBar,
    enableDrag: enableDrag,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(context.theme.appSize.size0.dp),
      ),
    ),
    builder: (final _) => content,
  );
}
