// import 'package:flutter/material.dart';
// import 'package:tcs_dff_design_system/theme/theme.dart';
// import 'package:tcs_dff_design_system/uikit/container/dropdown/dropdown_widget.dart';
// import 'package:tcs_dff_design_system/uikit/container/dropdown/dropdown_widget_underline.dart';
// import 'package:tcs_dff_design_system/utils/sizer/app_sizer.dart';

// class DropDownWidgetScreen extends StatelessWidget {
//   const DropDownWidgetScreen({super.key});

//   @override
//   Widget build(final BuildContext context) {
//     final size = context.theme.appSize;
//     final dropdownDataList = <String>[
//       'Mr',
//       'Mrs',
//       'Miss',
//       'Ms',
//       'Dr',
//     ];
//     return Scaffold(
//       body: Container(
//         margin: EdgeInsets.only(left: size.size10.dp),
//         width: context.theme.appSize.size80.dp,
//         child: Column(
//           children: [
//             DropDownWidget(
//               optionList: dropdownDataList,
//               onOptionSelect: (final selectedOption) {},
//             ),
//             SizedBox(
//               height: size.size100.dp,
//             ),
//             DropDownWidgetUnderLine(
//               optionList: dropdownDataList,
//               onOptionSelect: (final selectedOption) {},
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
