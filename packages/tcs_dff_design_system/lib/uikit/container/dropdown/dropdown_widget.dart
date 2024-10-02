// import 'package:flutter/material.dart';
// import '../../../theme/theme.dart';
// import '../../../utils/sizer/app_sizer.dart';

// class DropDownWidget extends StatefulWidget {
//   final List<String> optionList;
//   final Function(String selectedOption) onOptionSelect;
//   final bool? isDisabled;
//   const DropDownWidget({
//     super.key,
//     required this.optionList,
//     required this.onOptionSelect,
//     this.isDisabled = false,
//   });

//   @override
//   State<DropDownWidget> createState() => _DropDownWidgetState();
// }

// class _DropDownWidgetState extends State<DropDownWidget>
//     with TickerProviderStateMixin {
//   OverlayEntry? _overlayEntry;
//   GlobalKey globalKey = GlobalKey();
//   final LayerLink _layerLink = LayerLink();
//   late String selectedItem;
//   OverlayState? overlayState;
//   bool dropDownIsOpen = false;
//   bool isFocused = false;

//   @override
//   void initState() {
//     super.initState();
//     overlayState = Overlay.of(context);

//     setState(() {
//       selectedItem = widget.optionList[0];
//     });
//   }

//   OverlayEntry _createOverlay() {
//     final color = context.theme.appColor;
//     final size = context.theme.appSize;
//     final renderBox = context.findRenderObject() as RenderBox;
//     final rendorSize = renderBox.size;
//     return OverlayEntry(
//       builder: (final context) => Positioned(
//         width: rendorSize.width,
//         child: CompositedTransformFollower(
//           link: _layerLink,
//           showWhenUnlinked: false,
//           offset: Offset(size.size1.dp, rendorSize.height + size.size7.dp),
//           child: Material(
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(size.size6.dp),
//                 ),
//                 border: Border.all(color: color.greyLighterGrey70),
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   Wrap(
//                     children: [
//                       ListView.builder(
//                         shrinkWrap: true,
//                         padding: EdgeInsets.only(
//                           bottom: size.size3.dp,
//                         ),
//                         itemCount: widget.optionList.length,
//                         itemBuilder: (final context, final index) => 
// ListTile(
//                           title: Text(widget.optionList[index]),
//                           onTap: () {
//                             setState(() {
//                               dropDownIsOpen = !dropDownIsOpen;
//                               selectedItem = widget.optionList[index];
//                             });
//                             _overlayEntry!.remove();
//                             widget.onOptionSelect(selectedItem);
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(final BuildContext context) {
//     final color = context.theme.appColor;
//     final size = context.theme.appSize;
//     final textStyle = context.theme.appTextStyles;

//     return Flexible(
//       child: CompositedTransformTarget(
//         link: _layerLink,
//         child: InkWell(
//           splashColor: color.transparent,
//           highlightColor: color.transparent,
//           onTap: () {
//             if (dropDownIsOpen == false) {
//               _overlayEntry = _createOverlay();
//               overlayState!.insert(_overlayEntry!);
//               setState(() {
//                 dropDownIsOpen = !dropDownIsOpen;
//               });
//             } else {
//               _overlayEntry!.remove();
//               setState(() {
//                 dropDownIsOpen = !dropDownIsOpen;
//               });
//             }
//           },
//           child: Container(
//             padding: EdgeInsets.only(
//               top: size.size15.dp,
//               left: size.size12.dp,
//               bottom: size.size14.dp,
//             ),
//             decoration: BoxDecoration(
//               border: Border.all(
//                 color: dropDownIsOpen
//                     ? color.clrPrimaryPurple
//                     : color.greyLighterGrey70,
//                 width: size.size2.dp,
//               ),
//               borderRadius: BorderRadius.circular(size.size6.dp),
//             ),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Text(
//                         selectedItem,
//                         style: textStyle.bodyCopy2Medium16SemiBold.copyWith(
//                           color: color.greyFullBlack10,
//                           fontSize: size.size16.sp,
//                         ),
//                       ),
//                       Icon(
//                         dropDownIsOpen
//                             ? Icons.keyboard_arrow_up
//                             : Icons.keyboard_arrow_down,
//                         color: color.clrPrimaryPurple,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
