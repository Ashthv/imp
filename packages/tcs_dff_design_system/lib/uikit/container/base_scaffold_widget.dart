import 'package:flutter/material.dart';

class BaseScaffoldWidget extends StatefulWidget {
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? body;
  final bool? resizeToAvoidBottomInset;
  final Color? backgroundColor;
  const BaseScaffoldWidget({
    super.key,
    this.appBar,
    this.resizeToAvoidBottomInset,
    this.body,
    this.backgroundColor,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  });

  @override
  State<BaseScaffoldWidget> createState() => _BaseScaffoldWidgetState();
}

class _BaseScaffoldWidgetState extends State<BaseScaffoldWidget> {
  @override
  Widget build(final BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
        backgroundColor: widget.backgroundColor,
        floatingActionButtonLocation: widget.floatingActionButtonLocation,
        floatingActionButton: widget.floatingActionButton,
        appBar: widget.appBar,
        body: SafeArea(child: widget.body!),
      );
}
