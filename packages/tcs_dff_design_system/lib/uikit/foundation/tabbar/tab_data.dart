import 'package:flutter/material.dart';

class TabData {
  TabData({
    required this.title,
    this.imagePath,
    this.count,
    this.imagePackage,
    required this.body,
  });
  String title;
  String? imagePath;
  int? count;
  String? imagePackage;
  Widget body;
}
