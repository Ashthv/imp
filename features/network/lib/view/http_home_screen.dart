import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/http_viewmodel.dart';
import 'http_methods_screen.dart';

class HttpHomeScreen extends StatefulWidget {
  const HttpHomeScreen({super.key});

  @override
  State<HttpHomeScreen> createState() => _HttpHomeScreenState();
}

class _HttpHomeScreenState extends State<HttpHomeScreen> {
  @override
  Widget build(final BuildContext context) => ChangeNotifierProvider(
        create: (final context) => HTTPViewModel(),
        child: HttpMethodsScreen(),
      );
}
