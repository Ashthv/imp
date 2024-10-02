// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:tcs_dff_widgetbook/widgetbook_usecase/bottomsheet_usecase.dart'
    as _i3;
import 'package:tcs_dff_widgetbook/widgetbook_usecase/button_usecase.dart'
    as _i4;
import 'package:tcs_dff_widgetbook/widgetbook_usecase/title_subtitle_text_usecase.dart'
    as _i2;
import 'package:widgetbook/widgetbook.dart' as _i1;

final directories = <_i1.WidgetbookNode>[
  _i1.WidgetbookFolder(
    name: 'uikit',
    children: [
      _i1.WidgetbookFolder(
        name: 'container',
        children: [
          _i1.WidgetbookLeafComponent(
            name: 'TitleSubtitleTextWidget',
            useCase: _i1.WidgetbookUseCase(
              name: 'description text',
              builder: _i2.titleSubtitleTextUseCase,
            ),
          ),
          _i1.WidgetbookFolder(
            name: 'bottomsheet',
            children: [
              _i1.WidgetbookLeafComponent(
                name: 'BottomsheetTemplate',
                useCase: _i1.WidgetbookUseCase(
                  name: 'Bottomsheet Template',
                  builder: _i3.primaryNormalButtonUseCase,
                ),
              )
            ],
          ),
        ],
      ),
      _i1.WidgetbookFolder(
        name: 'foundation',
        children: [
          _i1.WidgetbookFolder(
            name: 'button',
            children: [
              _i1.WidgetbookComponent(
                name: 'BorderlinedButton',
                useCases: [
                  _i1.WidgetbookUseCase(
                    name: 'primary borderlined button',
                    builder: _i4.primaryNormalButtonUseCase,
                  ),
                  _i1.WidgetbookUseCase(
                    name: 'primary two column borderlined button',
                    builder: _i4.primaryTwoColumnButtonUseCase,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    ],
  )
];
