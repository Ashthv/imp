import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/uikit/container/app_bar/default_app_bar.dart';

class LazyAppBar extends DefaultAppBar {
  const LazyAppBar({super.key, super.title = ''});

  @override
  Widget build(final BuildContext context) => DefaultAppBar(
        title: 'Dependency Injection',
        subTitle: 'Lazy Singleton',
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.refresh_outlined,
              color: Colors.purple,
            ),
          ),
        ],
      );
}
