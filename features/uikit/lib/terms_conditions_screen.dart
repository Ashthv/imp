import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/tcs_dff_design_system.dart';

import 'package:tcs_dff_design_system/uikit/foundation/footer_stepper/footer_stepper.dart';
import 'package:tcs_dff_design_system/uikit/foundation/footer_stepper/footer_stepper_variant_model.dart';
import 'package:tcs_dff_design_system/utils/dropdown_menue_model.dart';
import 'package:tcs_dff_design_system/utils/footer_stepper_utils.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (final context) => ConsentWidget(
                      onCancel: () {
                        Navigator.pop(context);
                      },
                      onOptionSelect: (final onOptionSelect) {
                        print(onOptionSelect.title);
                      },
                      dropdownMenuList: [
                        DropdownMenuModel(
                          title: 'English',
                        ),
                        DropdownMenuModel(
                          title: 'Hindi',
                        ),
                        DropdownMenuModel(
                          title: 'Marathi',
                        ),
                        DropdownMenuModel(
                          title: 'Tamil',
                        ),
                        DropdownMenuModel(
                          title: 'Gujarati',
                        ),
                        DropdownMenuModel(
                          title: 'Oriya',
                        ),
                        DropdownMenuModel(
                          title: 'Telagu',
                        ),
                        DropdownMenuModel(
                          title: 'Bengali',
                        ),
                        DropdownMenuModel(
                          title: 'Malayalam',
                        ),
                      ],
                      url:
                          'https://lisabirch.medium.com/blueys-latest-episode-ghost-basket-is-a-bittersweet-ending-to-early-childhood-parenting-40019a10ee7d',
                      bottomWidget: FooterStepper(
                        footerStepperVariants:
                            FooterStepperVariants.footerWithNoteWidget,
                        footerStepperNoteWidgetModel:
                            const FooterStepperNoteWidgetModel(
                          title: 'Try another authentication method?',
                        ),
                        onButtonPressed: () {},
                      ),
                    ),
                  ),
                );
              },
              child: const Text('Screen View '),
            ),
            ElevatedButton(
              onPressed: () {
                showBottomSheetModal(
                  context,
                  extendContentBehindAppBar: false,
                  StatefulBuilder(
                    builder: (
                      final BuildContext context,
                      final StateSetter setState,
                    ) =>
                        ConsentWidget(
                      onCancel: () {
                        Navigator.pop(context);
                      },
                      onOptionSelect: (final onOptionSelect) {
                        print(onOptionSelect.title);
                      },
                      dropdownMenuList: [
                        DropdownMenuModel(
                          title: 'English',
                        ),
                        DropdownMenuModel(
                          title: 'Hindi',
                        ),
                        DropdownMenuModel(
                          title: 'Marathi',
                        ),
                        DropdownMenuModel(
                          title: 'Tamil',
                        ),
                        DropdownMenuModel(
                          title: 'Gujarati',
                        ),
                        DropdownMenuModel(
                          title: 'Oriya',
                        ),
                        DropdownMenuModel(
                          title: 'Telagu',
                        ),
                        DropdownMenuModel(
                          title: 'Bengali',
                        ),
                        DropdownMenuModel(
                          title: 'Malayalam',
                        ),
                      ],
                      url:
                          'https://lisabirch.medium.com/blueys-latest-episode-ghost-basket-is-a-bittersweet-ending-to-early-childhood-parenting-40019a10ee7d',
                      bottomWidget: FooterStepper(
                        footerStepperVariants:
                            FooterStepperVariants.footerWithNoteWidget,
                        footerStepperNoteWidgetModel:
                            const FooterStepperNoteWidgetModel(
                          title: 'Try another authentication method?',
                        ),
                        onButtonPressed: () {},
                      ),
                    ),
                  ),
                );
              },
              child: const Text('BottomSheet View'),
            ),
          ],
        ),
      );
}
