import 'package:flutter/material.dart';
import 'package:tcs_dff_types/platform.dart';

import '../viewmodel/singleton_person_vm.dart';

class SingletonExampleView extends StatefulWidget {
  const SingletonExampleView({super.key});

  @override
  State<SingletonExampleView> createState() => _SingletonExampleViewState();
}

class _SingletonExampleViewState extends State<SingletonExampleView> {
  @override
  Widget build(final BuildContext context) {
    final modalInfo =
        dff.di.get<SingletonPersonVM>(instanceName: 'singletonVM');
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
