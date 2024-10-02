import 'package:flutter/material.dart';
import 'package:tcs_dff_route/route_navigator.dart';
import 'package:tcs_dff_types/platform.dart';

import '../model/customer_info.dart';
import '../store/data_pass_store.dart';

late final dataPassStore =
    dff.di.get<DataPassStore>(instanceName: 'DataPassStore');

class DataPassLandingScreen extends StatelessWidget {
  const DataPassLandingScreen({super.key});

  @override
  Widget build(final BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                dataPassStore.updateCustomerInfo(
                  const CustomerInfo(
                    name: 'Vikash Dubey',
                    mobileNo: '9873878311',
                    aadhaarNo: '8783 7387 3733 3873',
                    panNo: 'HY676389813',
                  ),
                );

                RouteNavigator.push(context, '/home/dataPass/store');
              },
              child: const Text('Pass Data Via Store'),
            ),
            ElevatedButton(
              onPressed: () {
                RouteNavigator.push(
                  context,
                  '/home/dataPass/route', // Pass complete/absolute path only then data pass will work
                  extra: const CustomerInfo(
                    name: 'Vikash Dubey',
                    mobileNo: '9873878311',
                    aadhaarNo: '8783 7387 3733 3873',
                    panNo: 'HY676389813',
                  ),
                );
              },
              child: const Text('Pass Data Via Route'),
            ),
          ],
        ),
      );
}
