import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/uikit/container/overlapping_card/card_carousel.dart';
import 'package:tcs_dff_design_system/uikit/container/overlapping_card/card_content_model.dart';

class OverlappingCardsScreen extends StatelessWidget {
  OverlappingCardsScreen({super.key});
  final List<CardModel> cardDummyData = [
    CardModel(
      title: 'Banking & Payments',
      description: 'Making everyday transactions a breeze',
    ),
    CardModel(
      title: 'Insurance & Investments',
      description: 'Securing your tomorrow, growing your wealth',
    ),
    CardModel(
      title: 'Loan & Credit',
      description: 'Taking care of all your financial needs',
    ),
    CardModel(
      title: 'Shopping & More',
      description: 'Convenience at your fingertips. ',
    ),
  ];

  @override
  Widget build(final BuildContext context) => Center(
        child: CardCarousel(
          cardDuration: 2,
          cardData: cardDummyData,
        ),
        //YOU CAN CHANGE DURATION OF HOW MUCH THE CARD STAYS USING CARD DURATION
      );
}
