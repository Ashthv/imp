import 'package:flutter/material.dart';
import 'create_profile_screen.dart';
import 'shared_prefernce_screen.dart';

class StorageType extends StatelessWidget {
  const StorageType({super.key});

  @override
  Widget build(final BuildContext context) => SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              runSpacing: 10,
              spacing: 10,
              children: [
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (final context) => const CreateProfileScreen(),
                      ),
                    );
                    // RouteNavigator.push(
                    //     context, '/home/storage/view/create_profile_screen');
                  },
                  child: const Text('storage', style: TextStyle(fontSize: 18)),
                ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  onPressed: () {
                    // RouteNavigator.push(context,
                    //     '/home/storage/shared_prefernce/shared_prefernce_screen');
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (final context) =>
                            const SharedPrefernceScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'SharedPreferences',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
