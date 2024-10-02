import 'package:flutter/material.dart';

class BottomsheetTemplateData {
  final String? titleText;
  final Widget content;
  final String? primaryButtonText;
  final String? secondaryButtonText;
  final VoidCallback? onPrimaryButtonTap;
  final VoidCallback? onSecondaryButtonTap;
  final VoidCallback? onCloseButtonTap;
  final String? bannerText;
  final Color? backgroundColor;

  BottomsheetTemplateData({
    this.titleText,
    required this.content,
    this.primaryButtonText,
    this.secondaryButtonText,
    this.onPrimaryButtonTap,
    this.onSecondaryButtonTap,
    this.onCloseButtonTap,
    this.bannerText,
    this.backgroundColor,
  });
}
