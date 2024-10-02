import 'package:flutter/material.dart';
 
import '../../theme/theme.dart';
import '../../utils/sizer/app_sizer.dart';
import '../foundation/text_widget.dart';
 
class AlphabeticalOrder extends StatefulWidget {
  final String selectedAlphabet;
  final Function(String) onAlphabetSelect;
  AlphabeticalOrder({
    super.key,
    this.selectedAlphabet = '',
    required this.onAlphabetSelect,
  });
 
  @override
  State<AlphabeticalOrder> createState() => _AlphabeticalOrderState();
}
 
class _AlphabeticalOrderState extends State<AlphabeticalOrder> {
  final alphabets =
      List.generate(26, (final index) => String.fromCharCode(index + 65))
        ..insert(0, '#');
 
  late String _selectedAlphabet;
 
  @override
  void initState() {
    super.initState();
    _selectedAlphabet = widget.selectedAlphabet;
  }
 
  @override
  void didUpdateWidget(covariant final AlphabeticalOrder oldWidget) {
    super.didUpdateWidget(oldWidget);
    _selectedAlphabet = widget.selectedAlphabet;
  }
 
  @override
  Widget build(final BuildContext context) => SingleChildScrollView(
        child: Column(
          children: alphabets
              .map(
                (final alphabet) => GestureDetector(
                  onTapDown: (final _) {
                    if (alphabet != '#' && _selectedAlphabet != alphabet) {
                      _selectedAlphabet = alphabet;
                      setState(() {});
                      widget.onAlphabetSelect(_selectedAlphabet);
                    }
                  },
                  child: Container(
                    decoration: _selectedAlphabet == alphabet
                        ? BoxDecoration(
                            color: context.theme.appColor.clrPrimaryPurple,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.dp),
                              bottomLeft: Radius.circular(16.dp),
                            ),
                          )
                        : null,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: context.theme.appSize.size2.dp,
                        horizontal: context.theme.appSize.size16.dp,
                      ),
                      child: TextWidget(
                        text: alphabet,
                        style: _selectedAlphabet == alphabet
                            ? context
                                .theme.appTextStyles.bodyCopy3Small14Regular
                                .copyWith(
                                color: context.theme.appColor.greyFullWhite120,
                                fontWeight: FontWeight.w600,
                              )
                            : context
                                .theme.appTextStyles.bodyCopy3Small14Regular
                                .copyWith(
                                fontWeight: FontWeight.w600,
                                color:
                                    context.theme.appColor.clrPrimaryPurple70,
                              ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      );
}
 