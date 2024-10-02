import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class CustomSlideUpTransition extends CustomTransitionPage<void> {
  CustomSlideUpTransition({super.key, required super.child})
      : super(
          transitionDuration: const Duration(milliseconds: 700),
          transitionsBuilder: (
            final _,
            final animation,
            final secondaryAnimation,
            final child,
          ) =>
              SlideTransition(
            position: animation.drive(
              Tween(begin: const Offset(0.0, 1.0), end: Offset.zero),
            ),
            child: child,
          ),
        );
}
