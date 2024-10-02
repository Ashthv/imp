import 'package:flutter/material.dart';
import 'package:tcs_dff_types/platform.dart';

import '../viewmodel/factory_person_vm.dart';

class FactoryExampleView extends StatelessWidget {
  const FactoryExampleView({super.key});

  @override
  Widget build(final BuildContext context) {
    final modalInfo = dff.di.get<FactoryPersonVM>();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'The value of name is ${modalInfo.getNameFromVM()}',
            style: const TextStyle(
              fontSize: 25,
              color: Colors.black,
            ),
          ),
          Text(
            'The value of id is ${modalInfo.getIdFromVM()}',
            style: const TextStyle(
              fontSize: 25,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
