import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../theme/theme.dart';
import '../../../utils/sizer/app_sizer.dart';
import 'card_content_model.dart';
import 'horizontal_overlap_card.dart';


class CardCarousel extends StatefulWidget {
  const CardCarousel({
    super.key,
    required this.cardDuration,
    required this.cardData,
    this.autoScroll = true,
  });
 
  final int cardDuration;
  final List<CardModel> cardData;
  final bool autoScroll;
 
  @override
  State<CardCarousel> createState() => _CardCarouselState();
}
 
class _CardCarouselState extends State<CardCarousel> {
  late final PageController pageController;
  final ScrollController _scrollController = ScrollController();
  int cardNo = 0;
 
  Timer? carasouelTmer;
 
  Timer getTimer() {
    if (widget.autoScroll) {
      return Timer.periodic(Duration(seconds: widget.cardDuration),
          (final timer) {
        if (cardNo == widget.cardData.length) {
          cardNo = context.theme.appSize.size0.toInt();
        }
        pageController.animateToPage(
          cardNo,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOutCirc,
        );
        cardNo++;
      });
    } else {
      return Timer.periodic(Duration(days: widget.cardDuration), (final timer) {
        if (cardNo == widget.cardData.length) {
          cardNo = context.theme.appSize.size0.toInt();
        }
        pageController.animateToPage(
          cardNo,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOutCirc,
        );
        cardNo++;
      });
    }
  }
 
  @override
  void initState() {
    pageController = PageController();
    carasouelTmer = getTimer();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        showBtmAppBr = false;
        setState(() {});
      } else {
        showBtmAppBr = true;
        setState(() {});
      }
    });
    super.initState();
  }
 
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
 
  bool showBtmAppBr = true;
 
  @override
  Widget build(final BuildContext context) {
    final size = context.theme.appSize;
    final color = context.theme.appColor;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PageView.builder(
          controller: pageController,
          onPageChanged: (final index) {
            cardNo = index;
            setState(() {});
          },
          itemBuilder: (final _, final index) => AnimatedBuilder(
            animation: pageController,
            builder: (final ctx, final child) => child!,
            child: GestureDetector(
              onTap: () {
                // SPECIFIES WHAT DOES A CARD DO WHEN IT IS PRESSED
              },
              onPanDown: (final d) {
                carasouelTmer?.cancel();
                carasouelTmer = null;
              },
              onPanCancel: () {
                carasouelTmer = getTimer();
              },
              child: Center(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  margin: const EdgeInsets.only(left: 40, right: 40),
                  child: HorizontalOveralapCard(
                    cardData: widget.cardData[index],
                    // margin: EdgeInsets.symmetric(
                    //   horizontal: size.size20,
                    //   vertical: size.size0.dp,
                    // ),
                    //  boxHeight: size.size100.dp,
                  ),
                ),
              ),
            ),
          ),
          itemCount: widget.cardData.length,
        ),
        Positioned(
          child: Container(
            margin: EdgeInsets.only(bottom: 20.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(
                widget.cardData.length,
                (final index) => Container(
                  margin: EdgeInsets.all(size.size3.dp),
                  width: cardNo == index ? size.size15.dp : size.size7.dp,
                  height: size.size7.dp,
                  decoration: BoxDecoration(
                    color: cardNo == index
                        ? color.clrPrimaryPurple20
                        : color.clrPrimaryPurple70,
                    borderRadius: cardNo == index
                        ? BorderRadius.all(
                            Radius.elliptical(
                              size.size10.dp,
                              size.size10.dp,
                            ),
                          )
                        : BorderRadius.circular(size.size10.dp),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
