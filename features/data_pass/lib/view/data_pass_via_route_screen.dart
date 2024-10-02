import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';

import '../model/customer_info.dart';

class DataPassViaRouteScreen extends StatelessWidget {
  const DataPassViaRouteScreen({super.key, this.extra});

  final CustomerInfo? extra;

  @override
  Widget build(final BuildContext context) {
    final textStyle = context.theme.appTextStyles;
    final size = context.theme.appSize;

    return Padding(
      padding: EdgeInsets.all(size.size16.dp),
      child: Column(
        children: [
          Text(extra?.name ?? 'No Name', style: textStyle. labelSmall14Medium),
          SizedBox(height: size.size8.dp),
          Text(
            extra?.mobileNo ?? 'No Mobile No',
            style: textStyle. labelSmall14Medium,
          ),
          SizedBox(height: size.size8.dp),
          Text(
            extra?.aadhaarNo ?? 'No Aadhar No',
            style: textStyle. labelSmall14Medium,
          ),
          SizedBox(height: size.size8.dp),
          Text(
            extra?.panNo ?? 'No Pan No',
            style: textStyle. labelSmall14Medium,
          ),
        ],
      ),
    );
  }
}
