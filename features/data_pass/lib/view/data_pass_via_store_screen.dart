import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tcs_dff_design_system/theme/theme.dart';
import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';
import 'package:tcs_dff_types/platform.dart';

import '../store/data_pass_store.dart';

late final dataPassStore =
    dff.di.get<DataPassStore>(instanceName: 'DataPassStore');

class DataPassViaStoreScreen extends StatelessWidget {
  const DataPassViaStoreScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final textStyle = context.theme.appTextStyles;
    final size = context.theme.appSize;

    return Observer(
      builder: (final _) => Padding(
        padding: EdgeInsets.all(size.size16.dp),
        child: Column(
          children: [
            Text(
              dataPassStore.customerInfo?.name ?? 'No Name',
              style: textStyle. labelSmall14Medium,
            ),
            SizedBox(height: size.size8.dp),
            Text(
              dataPassStore.customerInfo?.mobileNo ?? 'No Mobile No',
              style: textStyle. labelSmall14Medium,
            ),
            SizedBox(height: size.size8.dp),
            Text(
              dataPassStore.customerInfo?.aadhaarNo ?? 'No Aadhar No',
              style: textStyle. labelSmall14Medium,
            ),
            SizedBox(height: size.size8.dp),
            Text(
              dataPassStore.customerInfo?.panNo ?? 'No Pan No',
              style: textStyle. labelSmall14Medium,
            ),
          ],
        ),
      ),
    );
  }
}
