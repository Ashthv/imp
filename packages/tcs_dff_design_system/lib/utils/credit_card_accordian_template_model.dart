import 'package:flutter/material.dart';

class CreditCardAccordianTemplateData {
  final String applicationNumber;
  final String appliedOnDate;
  final String status;
  final Widget cardImage;
  final String remarks;
  final String headingText;
  final String applicationNumberText;
  final String appliedOnDateText;
  final String statusText;
  final String remarksText;
  final String moreText;
  final String lessText;
  final String showText;
  final bool isOpen = false;
  CreditCardAccordianTemplateData({
    required this.applicationNumber,
    required this.appliedOnDate,
    required this.status,
    required this.cardImage,
    required this.remarks,
    required this.headingText,
    required this.applicationNumberText,
    required this.appliedOnDateText,
    required this.statusText,
    required this.remarksText,
    required this.moreText,
    required this.lessText,
    required this.showText,
  });
}
