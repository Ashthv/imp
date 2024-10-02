import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomSlideLeftTransition extends CustomTransitionPage<void> {
  CustomSlideLeftTransition({super.key, required super.child})
      : super(
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (final _, final animation,
                  final secondaryAnimation, final child,) =>
              SlideTransition(
            position: Tween(
              begin: const Offset(1.0, 0.0),
              end: const Offset(0.0, 0.0),
            ).animate(
              animation,
            ),
            child: SlideTransition(
              position: Tween(
                begin: const Offset(0.0, 0.0),
                end: const Offset(-0.8, 0.0),
              ).animate(secondaryAnimation),
              child: child,
            ),
          ),
        );
}
