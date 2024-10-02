import 'package:flutter/material.dart';

class RangeSliderWidget extends StatefulWidget {
  const RangeSliderWidget({
    super.key,
    required this.minValue,
    required this.maxValue,
    required this.division,
    required this.selectedSliderValue,
    this.initialSliderValue = 0,
  });
  final ValueChanged<int> selectedSliderValue;
  final double maxValue;
  final double minValue;
  final int division;
  final double initialSliderValue;

  @override
  State<RangeSliderWidget> createState() => _RangeSliderWidgetState();
}

class _RangeSliderWidgetState extends State<RangeSliderWidget> {
  // late double _sliderValue;

  @override
  void initState() {
    // setState(() {
    //   _sliderValue = widget.initialSliderValue;
    // });
    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    final siderValue = (widget.initialSliderValue < widget.minValue
        ? widget.minValue
        : widget.initialSliderValue);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Slider(
          min: widget.minValue,
          max: widget.maxValue,
          value: siderValue,
          divisions: widget.division,
          // label: '${_sliderValue.round()}',
          onChanged: (final value) {
            setState(() {
              // _sliderValue = value.roundToDouble();
              widget.selectedSliderValue(value.round());
            });
          },
        ),
      ],
    );
  }
}
