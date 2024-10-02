
import 'package:flutter/material.dart';

class SlideUpAnimation extends StatefulWidget {
  final Widget child;

  SlideUpAnimation({required this.child});

  @override
  SlideUpAnimationState createState() => SlideUpAnimationState();
}

class SlideUpAnimationState extends State<SlideUpAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _controller.forward();
  }

  @override
  Widget build(final BuildContext context) => SlideTransition(
        position: _animation,
        child: widget.child,
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
