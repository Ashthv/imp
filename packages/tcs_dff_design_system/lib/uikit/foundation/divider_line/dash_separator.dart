import 'package:flutter/material.dart';

class DashSeparator extends StatelessWidget {
  final double dashHeight;
  final double dashWith;
  final Color dashColor;
  final double fillRate; // [0, 1] totalDashSpace/totalSpace
  final Axis direction;

  DashSeparator({
    this.dashHeight = 1,
    this.dashWith = 8,
    this.dashColor = Colors.black,
    this.fillRate = 0.5,
    this.direction = Axis.horizontal,
  });

  @override
  Widget build(final BuildContext context) => LayoutBuilder(
        builder:
            (final BuildContext context, final BoxConstraints constraints) {
          final boxSize = direction == Axis.horizontal
              ? constraints.constrainWidth()
              : constraints.constrainHeight();
          final dCount = (boxSize * fillRate / dashWith).floor();
          return Flex(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: direction,
            children: List.generate(
              dCount,
              (final _) => SizedBox(
                width: direction == Axis.horizontal ? dashWith : dashHeight,
                height: direction == Axis.horizontal ? dashHeight : dashWith,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: dashColor),
                ),
              ),
            ),
          );
        },
      );
}
