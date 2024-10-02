import 'package:flutter/material.dart';
import 'package:tcs_dff_types/platform.dart';

import '../viewmodel/lazy_singleton_person_vm.dart';

class LazySingletonExampleView extends StatefulWidget {
  const LazySingletonExampleView({super.key});

  @override
  State<LazySingletonExampleView> createState() =>
      _LazySingletonExampleViewState();
}

class _LazySingletonExampleViewState extends State<LazySingletonExampleView> {
  bool isLoading = true;
  late LazyStingletonPersonVM viewmodel;

  @override
  void initState() {
    super.initState();
    loadPerson();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : viewmodel.person != null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'The value of name is ${viewmodel.person!.name}',
                          style: const TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'The value of id is ${viewmodel.person!.id}',
                          style: const TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  )
                : const Text(
                    'Click on floating button to get data',
                    style: TextStyle(fontSize: 25),
                  ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.download),
          onPressed: () {
            setState(() {
              isLoading = true;
            });
            dff.di
                .get<LazyStingletonPersonVM>(instanceName: 'lazySingletonVM')
                .fetchPerson()
                .then(
                  (final value) => setState(
                    () {
                      viewmodel.person = value;
                      isLoading = false;
                    },
                  ),
                );
          },
        ),
      );

  Future<void> loadPerson() async {
    viewmodel =
        dff.di.get<LazyStingletonPersonVM>(instanceName: 'lazySingletonVM');
    viewmodel.person ??= await dff.di
        .get<LazyStingletonPersonVM>(instanceName: 'lazySingletonVM')
        .fetchPerson();
    setState(() {
      isLoading = false;
    });
  }
}
