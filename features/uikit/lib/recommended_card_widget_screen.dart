import 'package:flutter/material.dart';

import 'recommended_card_widget.dart';

class RecommendedCardWidgetScreen extends StatelessWidget {
  const RecommendedCardWidgetScreen({super.key});

  @override
  Widget build(final BuildContext context) => Center(
        child: RecommenededCardWidget(
          title: 'Simply Click MasterCard SBI Card, Click MasterCard SBI Card',
          subtitle:
              '5x Reward points on online spends, Click MasterCard SBI Card',
          descriptionText: 'ncksnk',
          cardImagePath: 'images/card_recommended.png',
          headingText: 'hvsbhjc',
        ),
      );
}
