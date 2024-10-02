import 'package:flutter/material.dart';
import 'package:tcs_dff_design_system/uikit/container/note/note_widget.dart';
import 'package:tcs_dff_design_system/utils/note_utils.dart';
import 'package:tcs_dff_design_system/utils/snackbar_utils.dart';
import 'package:tcs_dff_shared_library/localization/app_localizations.dart';

class NoteWidgetScreen extends StatelessWidget {
  const NoteWidgetScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final locale = context.locale;
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          NoteWidget(
            heading: locale.txt(key: 'note'),
            variant: NoteVariants.floatingNote,
            description: locale.txt(key: 'noteTxt'),
          ),
          const Spacer(),
          NoteWidget(
            heading: locale.txt(key: 'note'),
            variant: NoteVariants.richNote,
            description: locale.txt(key: 'noteTxt'),
            styledTextList: [locale.txt(key: 'tAndC')],
          ),
          const Spacer(),
          NoteWidget(
            variant: NoteVariants.note,
            heading: locale.txt(key: 'note'),
            description: locale.txt(key: 'noteDescription'),
            styledTextList: [
              locale.txt(key: 'accept'),
            ],
            hyperLinkMap: {
              locale.txt(key: 'tAndC'): () {
                showSnackBar(
                  context: context,
                  snackbarType: SnackbarType.informative,
                  message: locale.txt(key: 'tAndC'),
                );
              },
            },
          ),
          const Spacer(),
          NoteWidget(
            heading: locale.txt(key: 'error'),
            variant: NoteVariants.errorNote,
            description: locale.txt(key: 'errorTxt'),
          ),
          const Spacer(),
          NoteWidget(
            heading: '',
            variant: NoteVariants.plainText,
            description: locale.txt(key: 'noteTxt'),
          ),
          const Spacer(),
          NoteWidget(
            heading: '',
            variant: NoteVariants.infoNote,
            description: locale.txt(key: 'noteTxt'),
          ),
          const Spacer(),
          NoteWidget(
            heading: locale.txt(key: 'unKnownReasonMessage'),
            variant: NoteVariants.errorInfoNote,
            description: '',
          ),
          const Spacer(),
          NoteWidget(
            heading: locale.txt(key: 'unKnownReasonMessage'),
            variant: NoteVariants.warningInfoNote,
            description: '',
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
