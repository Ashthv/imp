import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/uikit/container/footer_note_widget.dart';

class FooterNotewidgetScreen extends StatelessWidget {
  const FooterNotewidgetScreen({super.key});

  @override
  Widget build(final BuildContext context) =>  Scaffold(
        // appBar: ,
        body: Column(
          children: [
            const SizedBox(height: 10,),
            FooterNoteWidget(
              title: 'Verify Aadhaar and PAN with DigiLocker',
             onpressed: () {},
              package: 'uikit',
             leadingImage: 'images/keyboard_arrow_left.svg',
             // trailingImage: 'images/arrow_rightt.svg',
            ),
          ],
        ),
      );
}
