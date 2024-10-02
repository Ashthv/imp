import 'package:flutter/material.dart';

class CardConfig {
  final Color? backgroundColor;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final double? elevation;
  final ShapeBorder? shapeBorder;

  CardConfig({
    this.shapeBorder,
    this.margin,
    this.elevation,
    this.backgroundColor,
    this.height,
    this.width,
  });
}
